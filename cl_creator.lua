/* Copyright (C) 2021 EasyPedCreator - All Rights Reserved
 * Create by Ray's
 */


BasicPedTable = {}
InteractionPedTable = {}

local ID = 1

--Basic

-- Allows to create a pnj easily
--- @param { String } model (https://docs.fivem.net/docs/game-references/ped-models/)
--- @param { int } pedx
--- @param { int } pedy
--- @param { int } pedz
--- @param { int } pedh
--- @param { table } pedtbl (BlockingTemporaryEvents, Freeze, Invicible)
--- @param { table } bliptbl (Visible (default: false), x, y, z, Sprite (default: 1), Color (default: 1), Text (default: "Unknown"))
--- @public
function CreateBasicPed(model, pedx, pedy, pedz, pedh, pedtbl, bliptbl)
    if model ~= nil or pedx ~= nil or pedy ~= nil or pedz ~= nil or pedh ~= nil then
        local Data = {
            model = model,
            pedx = pedx,
            pedy = pedy,
            pedz = pedz,
            pedh = pedh,
            pedtbl = {
                BlockingTemporaryEvents = pedtbl.BlockingTemporaryEvents or false,
                Freeze = pedtbl.Freeze or false,
                Invicible = pedtbl.Invicible or false,
            },
            bliptbl = {
                Visible = bliptbl.Visible or false,
                x = bliptbl.x or pedx,
                y = bliptbl.y or pedy,
                z = bliptbl.z or pedz,
                Sprite = bliptbl.Sprite or 1,
                Color = bliptbl.Color or 1,
                Text = bliptbl.Text or "Unknown",
            },
        }

        ID = ID + 1
        BasicPedTable[ID] = Data
    else
        print("[Error] : It needs values that are impossible to create the ped")
    end
end

Citizen.CreateThread(function()
    for k, v in pairs(BasicPedTable) do

        local BlipVisible = v.bliptbl.Visible
        local Blipx = v.bliptbl.x
        local Blipy = v.bliptbl.y
        local Blipz = v.bliptbl.z
        local Sprite = v.bliptbl.Sprite
        local Color = v.bliptbl.Color
        local BlipText = v.bliptbl.Text
        
        local Model = GetHashKey(v.model)
        
        RequestModel(v.model) 
        while not HasModelLoaded(v.model) do Citizen.Wait(10) end

        local Ped = CreatePed(4, v.model, v.pedx, v.pedy, v.pedz, v.pedh, false, true)
        
        if v.pedtbl.BlockingTemporaryEvents then
            SetBlockingOfNonTemporaryEvents(Ped, v.pedtbl.BlockingTemporaryEvents)
        end

        if v.pedtbl.Freeze then
            FreezeEntityPosition(Ped, v.pedtbl.Freeze)
        end

        if v.pedtbl.Invicible then
            SetEntityInvincible(Ped, v.pedtbl.Invicible)
        end

        if BlipVisible == true then
            CreateBlip(Blipx, Blipy, Blipz, Sprite, Color, BlipText)
        end

    end

end)

-- Interaction

local msec = 1000

-- Allows to create a pnj easily with interaction
--- @param { String } model (https://docs.fivem.net/docs/game-references/ped-models/)
--- @param { int } pedx
--- @param { int } pedy
--- @param { int } pedz
--- @param { int } pedh
--- @param { table } pedtbl (BlockingTemporaryEvents, Freeze, Invicible)
--- @param { table } bliptbl (Visible (default: false), x, y, z, Sprite (default: 1), Color (default: 1), Text (default: "Unknown"))
--- @param { table } markertbl (Visible (default: true), Postion (default: The position of ped z-1), Type (default: 25), r (default: 0), g (default: 0), b (default: 0), a (default : 250))
--- @param { String } helptext (default: none)
--- @param { functions } functions (OnActive, OnInteract)
--- @public
function CreatePedWithInteraction(model, pedx, pedy, pedz, pedh, pedtbl, bliptbl, markertbl, helptext, functions)
    if model ~= nil or pedx ~= nil or pedy ~= nil or pedz ~= nil or pedh ~= nil then
        local Data = {
            model = model,
            pedx = pedx,
            pedy = pedy,
            pedz = pedz,
            pedh = pedh,
            pedtbl = {
                BlockingTemporaryEvents = pedtbl.BlockingTemporaryEvents or false,
                Freeze = pedtbl.Freeze or false,
                Invicible = pedtbl.Invicible or false,
            },
            bliptbl = {
                Visible = bliptbl.Visible,
                x = bliptbl.x or pedx,
                y = bliptbl.y or pedy,
                z = bliptbl.z or pedz,
                Sprite = bliptbl.Sprite or 1,
                Color = bliptbl.Color or 1,
                Text = bliptbl.Text or "Unknown",
            },
            Marker = {
                Visible = markertbl.Visible or true,
                Position = markertbl.Position or vector3(pedx, pedy, pedz),
                Type = markertbl.Type or 25,
                r = markertbl.r or 0,
                g = markertbl.g or 0,
                b = markertbl.b or 0,
                a = markertbl.a or 255,
            },
            HelpText = helptext or nil,
            functions = functions or nil
        }

        ID = ID + 1
        InteractionPedTable[ID] = Data
    else
        print("[Error] : It needs values that are impossible to create the ped")
    end
end

Citizen.CreateThread(function()
    for k, v in pairs(InteractionPedTable) do
        
        local Model = GetHashKey(v.model)

        local BlipVisible = v.bliptbl.Visible
        local Blipx = v.bliptbl.x
        local Blipy = v.bliptbl.y
        local Blipz = v.bliptbl.z
        local Sprite = v.bliptbl.Sprite
        local Color = v.bliptbl.Color
        local BlipText = v.bliptbl.Text
        
        RequestModel(v.model) 
        while not HasModelLoaded(v.model) do Citizen.Wait(10) end

        local Ped = CreatePed(4, v.model, v.pedx, v.pedy, v.pedz, v.pedh, false, true)

        if v.pedtbl.BlockingTemporaryEvents then
            SetBlockingOfNonTemporaryEvents(Ped, v.pedtbl.BlockingTemporaryEvents)
        end

        if v.pedtbl.Freeze then
            FreezeEntityPosition(Ped, v.pedtbl.Freeze)
        end

        if v.pedtbl.Invicible then
            SetEntityInvincible(Ped, v.pedtbl.Invicible)
        end

        if BlipVisible == true then
            CreateBlip(Blipx, Blipy, Blipz, Sprite, Color, BlipText)
        end

    end

end)

Citizen.CreateThread(function ()
    while true do

        local position = GetEntityCoords(PlayerPedId(-1))

        for k, v in pairs(InteractionPedTable) do
            
            local Markertype = v.Marker.Type
            local MarkerPostion = v.Marker.Position
            
            local Visible = v.Marker.Visible or true
            local red = v.Marker.r
            local green = v.Marker.g
            local blue = v.Marker.b
            local alpha = v.Marker.a

            local HelpText = v.HelpText

            local functions = v.functions

            local distance = GetDistanceBetweenCoords(position, MarkerPostion, true)

            if distance > 10 then
                msec = 200
            else
                msec = 1
                functions.onActive(InteractionPedTable[k])
            end
            
            if Visible == true then
                DrawMarker(Markertype, MarkerPostion, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, red, green, blue, alpha, false, true, 2, nil, nil, false)
            end

            if distance < 2 then
                
                if HelpText ~= nil then
                    AddTextEntry("HELP", HelpText)
                    DisplayHelpTextThisFrame("HELP", false)
                end
                
                if functions ~= nil then
                    if IsControlJustPressed(1, 51) then
                        functions.onInteract(InteractionPedTable[k])
                    end
                end
    
            end



        end

        Citizen.Wait(msec)
    end

end)

-- Create a blip on the map
--- @param { int } x
--- @param { int } y
--- @param { int } z
--- @param { int } sprite
--- @param { int } color
--- @param { int } text
--- @public
function CreateBlip(x, y, z, sprite, color, text)
    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite (blip, sprite)
	SetBlipColour (blip, color)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandSetBlipName(blip)
end
