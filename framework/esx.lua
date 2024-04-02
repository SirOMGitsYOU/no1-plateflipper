if GetResourceState('es_extended') ~= "started" then return end

local ESX = exports['es_extended']:getSharedObject()

VEHICLE_TABLE = 'owned_vehicles'
VEHICLE_COLUMN = 'vehicles'

if IsDuplicityVersion() then
    function GetPlayerJob(playerId) 
        return ESX.GetPlayerFromId(playerId).job.name or 'unemployed'
    end

    function RegisterUseableItem(itemName, cb)
        ESX.RegisterUseableItem(itemName, cb)
    end

    function IsVehicleOwned(plate)
        local isOwned = MySQL.scalar.await('SELECT 1 FROM owned_vehicles WHERE plate = ?', { plate })
        return isOwned and true or false
    end
else
    function GetPlayerJob()
        return ESX.GetPlayerData().job.name or 'unemployed'
    end

    function GetClosestVehicle()
        return ESX.Game.GetClosestVehicle()
    end
end