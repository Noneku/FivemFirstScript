print("Ce script est prêt pour utilisation")

--Create Zone Interactif
local playerPed = PlayerPedId()
local startPos = GetEntityCoords(playerPed)

CreateThread(function()
    local currentlyPos = 0
    local alreadyInzone = false
    while true do
        currentlyPos = math.floor(#(GetEntityCoords(playerPed) - startPos))

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