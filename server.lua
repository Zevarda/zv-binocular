local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem('binoculars', function(source)
    TriggerClientEvent('binoculars:use', source)
end)
