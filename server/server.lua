ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function AddClothestoInventory(current,data)
    
    for k,v in pairs(data) do
        
        --if current['inventory'] == nil then current['inventory'] = {} 
        if current[v.name] == nil then
            --current[v.NameHash] = {}
            current[v.name] = {compo = k, draw = v.draw, texture = v.texture, count = 1}
            
        end
    end
    
    return current
end

function SaveClothes(clothename,clothe,xPlayer,data)
    local result = SqlFunc(Config.Mysql,'fetchAll','SELECT * FROM renzu_clothes WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier})
    if result[1] == nil then -- save new wardrobe to db
        local wardrobe = {}
        wardrobe[clothename] = clothe
        SqlFunc(Config.Mysql,'execute','INSERT INTO renzu_clothes (identifier, wardrobe, inventory) VALUES (@identifier, @wardrobe, @inventory)', {
            ['@identifier']   = xPlayer.identifier,
            ['@wardrobe']   = json.encode(wardrobe),
            ['@inventory'] = json.encode(AddClothestoInventory({},data))
        })
    elseif result[1] then -- replace existing or save new
        
        local wardrobe = json.decode(result[1].wardrobe) or {}
        local inventory = json.decode(result[1].inventory) or {}
        local clothes = {}
        if data then
            clothes = AddClothestoInventory(inventory,data)
            
        end
        
        wardrobe[clothename] = clothe
        SqlFunc(Config.Mysql,'execute','UPDATE renzu_clothes SET wardrobe = @wardrobe, inventory = @inventory WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier,
            ['@wardrobe'] = json.encode(wardrobe),
            ['@inventory'] = json.encode(clothes)
        })
    end
    -- save skin
    SqlFunc(Config.Mysql,'execute','UPDATE users SET skin = @skin WHERE identifier = @identifier', {
		['@skin'] = json.encode(clothe),
		['@identifier'] = xPlayer.identifier
	})
end

ESX.RegisterServerCallback('renzu_clothes:save',function(source, cb, clothe)
    local source = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    SqlFunc(Config.Mysql,'execute','UPDATE users SET skin = @skin WHERE identifier = @identifier', {
		['@skin'] = json.encode(clothe),
		['@identifier'] = xPlayer.identifier
	})
    
end)

ESX.RegisterServerCallback('renzu_clothes:delclothe',function(source, cb, name)
    local source = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local result = SqlFunc(Config.Mysql,'fetchAll','SELECT * FROM renzu_clothes WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier})
    if result[1] ~= nil then
        local data = result[1]
        local wardrobe = json.decode(data['wardrobe'])
        wardrobe[name] = nil
        SqlFunc(Config.Mysql,'execute','UPDATE renzu_clothes SET wardrobe = @wardrobe WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier,
            ['@wardrobe'] = json.encode(wardrobe)
        })
        cb(true)
    end
    cb(false)
end)

ESX.RegisterServerCallback('renzu_clothes:buyclothe',function(source, cb, compo, draw, texture, dlc, bill)
    local source = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getMoney() >= bill then
        xPlayer.removeMoney(bill)
    local result = SqlFunc(Config.Mysql,'fetchAll','SELECT * FROM renzu_clothes WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier})
    if result[1] == nil then -- save new wardrobe to db
        local data = {}
        data['inventory'] = {}
        data['inventory'][dlc] = {compo = compo, draw = draw, texture = texture, count = 1}
        SqlFunc(Config.Mysql,'execute','INSERT INTO renzu_clothes (identifier, wardrobe) VALUES (@identifier, @wardrobe)', {
            ['@identifier']   = xPlayer.identifier,
            ['@wardrobe']   = '[]',
            ['@inventory']   = json.encode(data['inventory']),
        })
    elseif result[1] then -- replace existing or save new
        local data = {}
        if result[1]['inventory'] == nil then
            result[1]['inventory'] = {}
        end
        -- if result[1]['wardrobe'] == nil then
        --     result[1]['wardrobe'] = {}
        -- end
        
        data['inventory'] = json.decode(result[1]['inventory'])
        
        if data['inventory'][dlc] ~= nil then
            
            data['inventory'][dlc].count = tonumber(data['inventory'][dlc].count) + 1
        else
            
            
            data['inventory'][dlc] = {compo = compo, draw = draw, texture = texture, count = 1}
        end
        SqlFunc(Config.Mysql,'execute','UPDATE renzu_clothes SET inventory = @inventory WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier,
            ['@inventory'] = json.encode(data['inventory'])
        })
    end
    Config.Notify('success','Job', dlc..' has been added to your clothing inventory',xPlayer.source)
    else
        Config.Notify('success','Job', dlc..' cannot not afford',xPlayer.source)
        cb(false)
    end
end)

ESX.RegisterServerCallback('renzu_clothes:selectclothe',function(source, cb, skin)
    local source = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    SqlFunc(Config.Mysql,'execute','UPDATE users SET skin = @skin WHERE identifier = @identifier', {
        ['@skin'] = json.encode(skin),
        ['@identifier'] = xPlayer.identifier
    })
end)

ESX.RegisterServerCallback('renzu_clothes:saveclothes', function(source, cb, name, data, inwardrobe, bill, clothedata, payment, currentshop)
    local xPlayer    = ESX.GetPlayerFromId(source)
    if payment then -- Payment exists when opening cashier.
        if bill == 0 then
            Config.Notify('error', 'Clothing', 'You do not have a bill to settle with the cashier.', source)
            cb("ignore")
        elseif name == '' then
            Config.Notify('error', 'Clothing', 'You will need to give a name for your outfit.', source)
            cb("nosave")
	elseif payment == 'cash' then
            if xPlayer.getMoney() >= bill then
            	xPlayer.removeMoney(bill)
                if Config.renzujobs then
                    exports.renzu_jobs:addMoney(tonumber(bill),Config.Shop[currentshop].job,source,'money',true)
                end
                Config.Notify('success', 'Clothing', 'Purchased clothes successfully.', source)
        	SaveClothes(name,data,xPlayer,clothedata)
                cb("save")
            else
                Config.Notify('error', 'Clothing', 'Not enough money on hand to make purchase.', source)
                cb("nosave")
            end
    	elseif payment == 'bank' then
            if xPlayer.getAccount('bank').money >= bill then
        		xPlayer.removeAccountMoney('bank', bill)
                if Config.renzujobs then
                    exports.renzu_jobs:addMoney(tonumber(bill),Config.Shop[currentshop].job,source,'money',true)
                end
                Config.Notify('success', 'Clothing', 'Purchased clothes successfully.', source)
        	SaveClothes(name,data,xPlayer,clothedata)
                cb("save")
            else
                Config.Notify('error', 'Clothing', 'Not enough money in bank to make purchase.', source)
                cb("nosave")
            end
        end
    else -- Payment is nil when opening the wardrobe.
	if name == '' then
            Config.Notify('error', 'Clothing', 'You will need to give a name for your outfit.', source)
            cb("nosave")
	else
            Config.Notify('success','Clothing', 'Outfit successfully saved.', source)
            SaveClothes(name,data,xPlayer,clothedata)
            cb("save")
	end
    end
end)

ESX.RegisterServerCallback('renzu_clothes:getPlayerWardrobe', function(source, cb, inventory, data)
    
    local xPlayer    = ESX.GetPlayerFromId(source)
    local result = SqlFunc(Config.Mysql,'fetchAll','SELECT * FROM renzu_clothes WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier})
    local wardrobe = {}
    local inventory = {}
    
    if result[1] then
        wardrobe = json.decode(result[1].wardrobe) or {}
        inventory = json.decode(result[1].inventory) or {}
    else
        SqlFunc(Config.Mysql,'execute','INSERT INTO renzu_clothes (identifier, wardrobe, inventory) VALUES (@identifier, @wardrobe, @inventory)', {
            ['@identifier']   = xPlayer.identifier,
            ['@wardrobe']   = '[]',
            ['@inventory'] = json.encode(AddClothestoInventory({},data))
        })
        wardrobe = {}
        inventory = AddClothestoInventory({},data) or {}
    end
    cb({inventory = inventory, wardrobe = wardrobe})
end)

function SqlFunc(plugin,type,query,var)
	local wait = promise.new()
    if type == 'fetchAll' and plugin == 'mysql-async' then
		MySQL.Async.fetchAll(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'execute' and plugin == 'mysql-async' then
        MySQL.Async.execute(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'execute' and plugin == 'ghmattisql' then
        exports['ghmattimysql']:execute(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'fetchAll' and plugin == 'ghmattisql' then
        exports.ghmattimysql:execute(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'execute' and plugin == 'oxmysql' then
        exports.oxmysql:execute(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'fetchAll' and plugin == 'oxmysql' then
		exports['oxmysql']:fetch(query, var, function(result)
			wait:resolve(result)
		end)
    end
	return Citizen.Await(wait)
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    
end)  
