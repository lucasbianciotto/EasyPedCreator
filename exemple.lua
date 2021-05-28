local hasBmx = false

CreatePedWithInteraction("a_m_m_malibu_01", -265.88, -961.57, 30.22, 22.34, {BlockingTemporaryEvents = true, Freeze = true, Invicible = true}, {Visible = true, Sprite = 164, Color = 3}, {Invisible = true}, "Press ~INPUT_CONTEXT~ to pick up bike.", {
    onInteract = function(this)
        if hasBmx == false then
            local position = GetEntityCoords(PlayerPedId(-1))
            
            local model = GetHashKey("bmx")
            
            RequestModel(model)
            while not HasModelLoaded(model) do
                    Citizen.Wait(10) 
            end

            local bmx = CreateVehicle(model, position, 90.00, true, false)
            TaskWarpPedIntoVehicle(PlayerPedId(), bmx, -1)

            hasBmx = true
        end
    end,

    onActive = function (this)
        if hasBmx == true then
            this.Marker.r = 255
            this.Marker.b = 0
            this.Marker.g = 0
            this.Marker.Type = 1
        else
            this.Marker.r = 0
            this.Marker.b = 0
            this.Marker.g = 255
        end
    end
})