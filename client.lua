if Config.Base == 'oldesx' then
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.Base == 'newesx' then
	ESX = exports["es_extended"]:getSharedObject()
end




local drivershoot = true


Citizen.CreateThread(function()
	while true do
		Wait(500)
if drivershoot then
		playerPed = GetPlayerPed(-1)
		car = GetVehiclePedIsIn(playerPed, false)
		if car then
			if GetPedInVehicleSeat(car, -1) == playerPed then
				SetPlayerCanDoDriveBy(PlayerId(), false)
			elseif passengerDriveBy then
				SetPlayerCanDoDriveBy(PlayerId(), true)
			else
				SetPlayerCanDoDriveBy(PlayerId(), false)
			end
		end
	end
end
end)


local isShooting = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)

        if drivershoot == false then
        local player = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(player, false)

        if DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == player then
            if IsControlJustPressed(0, 24) or IsControlJustPressed(0, 25) then
                if not isShooting then
                    SetPlayerCanDoDriveBy(
                        PlayerId(), 
                        isShooting
                    )
                    isShooting = true
                end
            elseif IsControlJustReleased(0, 24) or IsControlJustReleased(0, 25) then
                if isShooting then
                    SetPlayerCanDoDriveBy(
                        PlayerId(), 
                        isShooting
                    )
                end
            end
        end
    end
    end
end)

local faalhast = true

RegisterNetEvent("disable_shooting", function(newSetting)
	local TimeCD = Config.Time2 * 1000
	if Config.Use2 then
	if faalhast then
    TriggerServerEvent('Sky_GripCar:removelsdinventory', 'gripcar', 1)
	TriggerEvent("chatMessage", Config.SystemMessage, {255, 0, 0}, Config.Timetext2)
    drivershoot = newSetting
	faalhast = false
	Wait(TimeCD)
	drivershoot = true
	faalhast = true
	TriggerEvent("chatMessage", Config.SystemMessage, {255, 0, 0}, Config.EndGrip)
	else
		TriggerEvent("chatMessage", Config.SystemMessage, {255, 0, 0}, Config.BTime2)
	end
end
end)



local passengerDriveBy = true
Citizen.CreateThread(function()
    while true do
        Wait(10)
		if drivershoot == true then

        playerPed = GetPlayerPed(-1)
        car = GetVehiclePedIsIn(playerPed, false)
        if car then
            if GetPedInVehicleSeat(car, -1) == playerPed then
                SetPlayerCanDoDriveBy(PlayerId(), false)
            elseif passengerDriveBy then
                SetPlayerCanDoDriveBy(PlayerId(), true)
            else
                SetPlayerCanDoDriveBy(PlayerId(), false)
            end
        end
    end
end
end)
