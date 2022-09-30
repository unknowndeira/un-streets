local QBCore = exports["qb-core"]:GetCoreObject()
local spawnedVehicles = {}
--QBCore.Debug

function spawnVehicle(coords,vehicle,properties,polyZone)
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        SetEntityHeading(veh, coords.w)
        SetVehicleSteeringAngle(veh, math.random(-300,300) / 10)
        SetEntityAsMissionEntity(veh, true, true)
        --SetVehicleDirtLevel(veh,0.0)
        SetVehicleDoorsLocked(veh,2)
        --print(vehicle)
        if vehicle == 'POLICE' then
            SetVehicleSiren(veh,true)
        end
        if properties then
            QBCore.Functions.SetVehicleProperties(veh, json.decode(properties))
        end
        SetVehicleNumberPlateText(veh, 'JUDEIRAS')
        table.insert(spawnedVehicles,veh)
        --return veh
    end, coords, true)
end

CreateThread(
    function()
        for k, v in pairs(Config.Locations) do
            polyZone = PolyZone:Create(v.zoneLocation,{
                name="carSpawns",
                --minZ=51.0,
                --maxZ=62.0,
                debugPoly=true,
                --gridDivisions=25
            })
            polyZone:onPlayerInOut(function(inZone)
                if inZone then
                    for ks, vs in pairs(v.vehicles) do
                        local vehicle = spawnVehicle(vs.location,ks,vs.properties or nil,polyZone)
                    end
                else
                    deleteThem()
                end
            end)
        end
    end
)

function deleteThem()
    for k,v in pairs(spawnedVehicles) do 
        DeleteEntity(v)
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        deleteThem()
        spawnedVehicles = {}
    end
end)