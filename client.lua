print("Ce script est prêt pour utilisation")

--Create Zone Interactif
local playerPed = PlayerPedId()
local startPos = GetEntityCoords(playerPed)

CreateThread(function()
    local currentlyPos = 0
    local alreadyInzone = false
    while true do
        currentlyPos = math.floor(#(GetEntityCoords(playerPed) - startPos))

        if currentlyPos < 10 and alreadyInzone == false then
            TriggerEvent('chat:addMessage', {args = {'Zone : ', 'Entrée dans la zone!'}})
            alreadyInzone = true
        elseif currentlyPos > 10 and alreadyInzone == true then
            TriggerEvent('chat:addMessage', {args = {'Zone : ', 'Sortie de la zone'}})
            print("You're leave the zone !")
            alreadyInzone = false
        end

        print(currentlyPos)
    Wait(1000)
    end
end)