print("Ce script est prêt pour utilisation")

--Create Zone Interactif
local playerPed = PlayerPedId()
local playerPos = GetEntityCoords(playerPed)
local vehicle = nil

CreateThread(function()
    local currentlyPos = 0
    local alreadyInzone = false
    while true do
        currentlyPos = math.floor(#(GetEntityCoords(playerPed) - playerPos))

        --Create a perimeter of 10 unities : Check if the player are inside or NOT 
        if currentlyPos < 10 and alreadyInzone == false then
            TriggerEvent('chat:addMessage', {args = {'Zone', 'Entrée dans la zone!'}})
            alreadyInzone = true
        elseif currentlyPos > 10 and alreadyInzone == true then
            TriggerEvent('chat:addMessage', {args = {'Zone', 'Sortie de la zone'}})
            alreadyInzone = false
        end   

            --Display the distance from the target and the player IN the zone
            if alreadyInzone == true then
                 TriggerEvent('chat:addMessage', {args = {'Cible', 'Vous êtes à ' .. currentlyPos .. " métres de votre cible"}})
            end
    Wait(1000)
    end
end)

-- Create command for spawn vehicle 
RegisterCommand("spawncar", function(_, arg)
    local modelCarAskByClient= arg[1]
         --Check if the Model of the vehicle exists in CD image
        if not IsModelInCdimage(modelCarAskByClient) or not IsModelAVehicle(modelCarAskByClient) then
            TriggerEvent('chat:addMessage', {
                args = {"Erreur", "Le modèle "..modelCarAskByClient.." n'existe pas !"}
            })
            return
        end
    RequestModel(modelCarAskByClient)
    while not HasModelLoaded(modelCarAskByClient) do
        Wait(100)
    end

    vehicle = CreateVehicle(modelCarAskByClient, playerPos.x, playerPos.y, playerPos.z, GetEntityHeading(playerPed), true, false)

    SetPedIntoVehicle(playerPed, vehicle, -1)

    SetModelAsNoLongerNeeded(modelCarAskByClient)
end, false)

-- Command for delete de last car loaded
RegisterCommand("dv", function()
    DeleteVehicle(vehicle)
end, false)

