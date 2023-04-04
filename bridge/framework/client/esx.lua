if not ESX then return end
PlayerData = ESX.GetPlayerData()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(playerData) 
	PlayerData = playerData 
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

GetInventoryItems = function(name)
    local PlayerData = ESX.GetPlayerData()
    local data = {}
    local itemdata = {}
    for _, item in pairs(PlayerData.inventory) do
        for k,v in pairs(items) do
            if v == item.name then
                if not itemdata[item.name] then 
                    itemdata[item.name] = item 
                else
                    itemdata[item.name].count += item.count
                end
                table.insert(data,itemdata)
            end
        end
    end
    return data
end