fx_version 'cerulean'
games { 'gta5' }

author 'Ray\'s'
description 'This script allows you to call functions to create peds more easily and compactly which will allow you to save time and make your code more beautiful'

exports {
    "CreateBasicPed",
    "CreatePedWithInteraction"
}

client_script 'cl_creator.lua'
client_script 'exemple.lua'
shared_script 'config.lua'