if Config.old then return end

if not lib then warn('ox_lib is required in this version') return end

lib.callback.register('renzu_clothes:Pay', function(src,total,appearance)
    local xPlayer = GetPlayerFromId(src)
    local money = xPlayer.getAccount('money').money
    if money >= total then
        xPlayer.removeMoney(total)
        SaveAppearance(xPlayer,appearance)
        return true
    end
    return false
end)

SaveOutfit = function(xPlayer,name,appearance)
    local str = 'SELECT %s FROM %s WHERE %s = ?'
    local query = MySQL.query.await(str:format('outfits','renzu_clothes_outfits','identifier'),{xPlayer.identifier})
    if query[1] then
        local outfits = json.decode(query[1].outfits)
        outfits[name] = appearance
        return MySQL.update.await('UPDATE renzu_clothes_outfits SET outfits = ? WHERE identifier = ?',{json.encode(outfits), xPlayer.identifier})
    else
        outfits = {[name] = appearance}
        return MySQL.insert.await('INSERT INTO renzu_clothes_outfits (identifier, outfits) VALUES(?, ?)',{xPlayer.identifier,json.encode(outfits)})
    end
    return false
end

lib.callback.register('renzu_clothes:SaveOutfit', function(src,data)
    local xPlayer = GetPlayerFromId(src)
    local appearance = data.appearance
    local name = data.name
    return SaveOutfit(xPlayer,name,appearance)
end)

lib.callback.register('renzu_clothes:RemoveOutfit', function(src,name)
    local xPlayer = GetPlayerFromId(src)
    return SaveOutfit(xPlayer,name,nil)
end)

local charset = {}  do -- [0-9a-zA-Z]
    for c = 48, 57  do table.insert(charset, string.char(c)) end
    for c = 65, 90  do table.insert(charset, string.char(c)) end
    for c = 97, 122 do table.insert(charset, string.char(c)) end
end

local function randomString(length)
    if not length or length <= 0 then return '' end
    return randomString(length - 1) .. charset[math.random(1, #charset)]
end

local sharedcode_cache = {}
lib.callback.register('renzu_clothes:GenerateCode', function(src,appearance)
    local generatedcode = randomString(8):upper()
    sharedcode_cache[generatedcode] = appearance
    return generatedcode
end)

lib.callback.register('renzu_clothes:AddCode', function(src, data)
    if not data then return end
    if not sharedcode_cache[data[1]] then return end
    local xPlayer = GetPlayerFromId(src)
    return SaveOutfit(xPlayer,data[2],sharedcode_cache[data[1]])
end)


lib.callback.register('renzu_clothes:getOutfits', function(src,data)
    local xPlayer = GetPlayerFromId(src)
    local outfits = {}
    local str = 'SELECT %s FROM %s WHERE %s = ?'
    local query = MySQL.query.await(str:format('outfits','renzu_clothes_outfits','identifier'),{xPlayer.identifier})
    local outfits = query[1] and json.decode(query[1].outfits)
    return outfits or {}
end)

SaveAppearance = function(xPlayer,skin)
	if ESX then
		MySQL.query.await('UPDATE users SET skin = ? WHERE identifier = ?', {json.encode(skin), xPlayer.identifier})
	else
		if skin.model ~= nil and skin ~= nil then
			-- TODO: Update primary key to be citizenid so this can be an insert on duplicate update query
			MySQL.query('DELETE FROM playerskins WHERE citizenid = ?', { xPlayer.PlayerData.citizenid }, function()
				MySQL.insert('INSERT INTO playerskins (citizenid, model, skin, active) VALUES (?, ?, ?, ?)', {
					xPlayer.PlayerData.citizenid,
					skin.model,
					json.encode(skin),
					1
				})
			end)
		end
	end
	return true
end

Citizen.CreateThreadNow(function()
    local success, result = pcall(MySQL.scalar.await, 'SELECT 1 FROM renzu_clothes_outfits')
    if not success then
        MySQL.query.await([[CREATE TABLE `renzu_clothes_outfits` (
            `id` int NOT NULL AUTO_INCREMENT KEY,
            `identifier` varchar(64) DEFAULT NULL,
            `outfits` longtext DEFAULT NULL
        )]])
        print("^2SQL INSTALL SUCCESSFULLY ^0")
    end
end)