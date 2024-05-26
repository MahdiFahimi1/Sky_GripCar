if Config.Base == 'oldesx' then
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.Base == 'newesx' then
	ESX = exports["es_extended"]:getSharedObject()
end

RegisterServerEvent('Sky_GripCar:removelsdinventory')
AddEventHandler('Sky_GripCar:removelsdinventory', function(itemName, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        local playerInventory = xPlayer.inventory
        local hasLSD = false
        for _, item in pairs(playerInventory) do
            if item.name == "lsd" then 
                hasLSD = true
                break
            end
        end

        if not hasLSD then
            TriggerClientEvent('chatMessage', _source, '^3Sky_GripCar : ^0Shoma LSD nadarid')
                
        else
            xPlayer.removeInventoryItem(itemName, amount)
        end
    end
end)



ESX.RegisterUsableItem('gripcar', function(source)
    local player = source
    local itemName = 'gripcar'

    local playerInventory = ESX.GetPlayerFromId(player).getInventoryItem(itemName)

    if Config.Use2 then

    if playerInventory and playerInventory.count > 0 then
        TriggerClientEvent("disable_shooting", source, false)
    else
        TriggerClientEvent('chatMessage', player, Config.SystemMessage .. '^0dar inventory shoma grip mashin nis', 'Dar inventory shoma grip mashin nist')
    end
end

end)