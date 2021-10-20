ESX = nil
local PlayerData = {}
local playerLoaded = false
local tid = 0
local confirm = false
currentshop = nil
clothingopen = false
local setjob = false
local lastSkin, cam, isCameraActive
local firstSpawn, zoomOffset, camOffset, heading, skinLoaded = true, 0.0, 0.0, 90.0, false
local clothes = {}
local clothesdata = {}
local clothestemp = {}
local inventory = false
local bill = 0
local unpaid = {}
local oldskin = nil
local havecart = false
local incart = {}
local exporting = false
local maxcolor = {}
local variantcache = {}
local clothecache = {}
local defaultclothes = {}
local currentblacklist = {}
local showall = false
MathRound = function(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

Citizen.CreateThread(function()
    Wait(1000)
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end

	while PlayerData.job == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		PlayerData = ESX.GetPlayerData()
		Citizen.Wait(111)
	end
	PlayerData = ESX.GetPlayerData()
end)

function GetClotheData(componentid,drawableid,textureid,prop,name)
    local ret = {}
    if prop then 
        ret = Components.Props[GetEntityModel(PlayerPedId())][tostring(componentid)][tostring(drawableid)][tostring(textureid)]
        if name then
            ret.Price = ret.Price * Config.Data[name].multiplier
        end
        return ret
    elseif not prop then
        ret = Components.ComponentVariations[GetEntityModel(PlayerPedId())][tostring(componentid)][tostring(drawableid)][tostring(textureid)]
        if name then
            ret.Price = ret.Price * Config.Data[name].multiplier
        end
    end
    return ret
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    playerloaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	playerjob = PlayerData.job.name
end)

local drawtext = false
local indist = false

function tostringplate(plate)
    if plate ~= nil then
        if not Config.PlateSpace then
            return string.gsub(tostring(plate), '^%s*(.-)%s*$', '%1')
        else
            return tostring(plate)
        end
    else
        return 123454
    end
end

local neargarage = false

function ShowFloatingHelpNotification(msg, coords, disablemarker, i)
    AddTextEntry('FloatingHelpNotificationsc'..i, msg)
    SetFloatingHelpTextWorldPosition(1, coords+vector3(0,0,0.3))
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('FloatingHelpNotificationsc'..i)
    EndTextCommandDisplayHelp(2,1, 0, 1)
end

local inmall = false
currentmall = nil

local markers = {}
local drawsleep = 1
function DrawZuckerburg(i,v,reqdist,msg,event,server,var,disablemarker,wardrobe)
    local i = i
    if not markers[i] and i ~= nil then
        --
        Citizen.CreateThread(function()
            markers[i] = true
            --local reqdist = reqdist[2]
            local coord = v
            local dist = #(GetEntityCoords(PlayerPedId()) - coord)
            --
            while dist < reqdist[2] do
                drawsleep = 1
                if clothingopen then drawsleep = 2000 end
                dist = #(GetEntityCoords(PlayerPedId()) - coord)
                if not disablemarker and not clothingopen then
                    DrawMarker(27, coord.x,coord.y,coord.z-0.8, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, 200, 255, 255, 255, 0, 0, 1, 1, 0, 0, 0)
                end
                --
                if dist < reqdist[1] then ShowFloatingHelpNotification(msg, coord, disablemarker , i) end
                if dist < reqdist[1] and IsControlJustReleased(1, 51) then
                    ShowFloatingHelpNotification(msg, coord, disablemarker , i)
                    if not server and not wardrobe then
                        TriggerEvent(event,i,var)
                    elseif server and not wardrobe then
                        TriggerServerEvent(event,i,var)
                    elseif wardrobe then
                        OpenClotheInventory()
                    end
                    Wait(1000)
                end
                Wait(drawsleep)
            end
            --ClearAllHelpMessages()
            markers[i] = false
        end)
    end
end

local shop_ped = nil
CreateThread(function()
    Wait(1000)
    for k,v in pairs(Config.Shop) do
        local vec = v.coord
        local name = v.name
        local blip = AddBlipForCoord(v.coord.x, v.coord.y, v.coord.z)
        SetBlipSprite (blip, v.blips.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.8)
        SetBlipColour (blip, v.blips.coord)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(""..v.name.."")
        EndTextCommandSetBlipName(blip)
    end
    while true do
        local mycoord = GetEntityCoords(PlayerPedId())
        local inveh = IsPedInAnyVehicle(PlayerPedId())
        local vec = {}
        local v = nil
        local closestdist = -1
        local req_dis = 3
        local displays = {}
        nowardrobe = true
        for k,v2 in pairs(Config.Shop) do
            vec = v2.coord
            local req_dis = 15
            local dist = #(vec - mycoord)
            if closestdist == -1 and dist < 30 or dist < closestdist and dist < 30 then
                v = v2
                currentshop = k
                closestdist = dist
                if v.clothesdisplay then
                    displays = v.clothesdisplay
                end
            end
        end
        --
        if currentshop and closestdist < 30 and v ~= nil then -- shop radius
            if not shop_ped and v.cashier_ped then
                shop_ped = CreateEntity(GetHashKey('s_f_y_shop_mid'), v.cashier_ped)
            end
            vec = v.coord
            if v.wardrobe and #(GetEntityCoords(PlayerPedId()) - v.wardrobe) < 7 and not v.showall then
                DrawZuckerburg('wardrobe',v.wardrobe,{3,8}, 'Press [E] Wardrobe','OpenClotheInventory',false, false,false,true)
            end
            if closestdist < 3 and v.showall then
                nowardrobe = false
                showall = v.showall or false
                DrawZuckerburg(currentshop,v.coord,{2,8}, 'Press [E] Clothing Shop','renzu_clothes:openwardrobe',false, v.showallindexes or false)
            end
            if displays[1] and closestdist < 15 and not v.showall then
                for k2,v2 in ipairs(displays) do
                    local dist = #(GetEntityCoords(PlayerPedId()) - v2.coord)
                    if dist < 8 then
                        nowardrobe = true
                        if dist < 2 then
                            currentblacklist = v2.blacklist
                        end
                        DrawZuckerburg(k2,v2.coord,{1.5,8}, 'Press [E] '..v2.label,'renzu_clothes:openwardrobe',false,v2.indexes,false)
                    end
                end
                --
                if v.cashier and #(GetEntityCoords(PlayerPedId()) - v.cashier) < 8 then
                    DrawZuckerburg(69,v.cashier,{1,8}, 'Press [E] Cashier','renzu_clothes:cashier',false,false,false)
                end
            end
        elseif havecart and currentshop and closestdist == -1 then
            for k,v in pairs(incart) do
                if v.incart then
                    if string.find(v.skin, "arms") and lastSkin['arms'] and defaultclothes[k] then
                        lastSkin['arms'] = defaultclothes[k].draw
                    elseif defaultclothes[k] then
                        
                        lastSkin[k..'_1'] = defaultclothes[v.compo].draw
                        lastSkin[k..'_2'] = defaultclothes[v.compo].texture
                    end
                end
            end
            TriggerEvent('skinchanger:loadSkin', lastSkin)
            closestdist = -1
            havecart = false
            
            defaultclothes = {}
            unpaid = {}
            incart = {}
            currentshop = nil
            showall = false
            ClearAllHelpMessages()
            defaultclothes = {}
            bill = 0
            clothingopen = false
            exporting = false
            DeleteEntity(shop_ped)
            shop_ped = nil
        elseif currentshop and closestdist == -1 then
            closestdist = -1
            havecart = false
            showall = false
            defaultclothes = {}
            unpaid = {}
            incart = {}
            currentshop = nil
            bill = 0
            clothingopen = false
            exporting = false
            ClearAllHelpMessages()
            DeleteEntity(shop_ped)
            shop_ped = nil
        end
        Wait(1000)
    end
end)

function CreateEntity(hash, coords, headings)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(5)
    end
    local x,y,z = table.unpack(coords)
    local ped = CreatePed(4, hash, x,y,z, false, false)
    Wait(10)
    NetworkFadeInEntity(ped,true)
    if tonumber(headings) then
        SetEntityHeading(ped, headings)
    else
        TaskTurnPedToFaceEntity(ped,PlayerPedId(),-1)
    end
    SetEntityAsMissionEntity(ped, true, true)
    Wait(1500)
    --FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
	SetEntityInvincible(ped, true)
    ResetEntityAlpha(ped)
    return ped
end

RegisterNetEvent('renzu_clothes:cashier')
AddEventHandler('renzu_clothes:cashier', function()
    ESX.TriggerServerCallback("renzu_clothes:getPlayerWardrobe",function(data)
        SendNUIMessage({
            type = 'Cashier',
            content = {wardrobe = data.wardrobe}
        })
        SetNuiFocus(true,true)
        SetPedTalk(shop_ped)
        PlayPedAmbientSpeechNative(shop_ped,'GENERIC_HI', 'SPEECH_PARAMS_FORCE')
    end,false,GetPlayerClothes())
end)

local indexcache = {}
RegisterNetEvent('renzu_clothes:openwardrobe')
AddEventHandler('renzu_clothes:openwardrobe', function(i,indexes)
    local default = nill
    if indexes ~= nil and indexes ~= false then
        default = indexes
        --
    end
    indexcache = default
	OpenClotheMenu(default)
end)

function OpenClotheMenu(restrict, nocamera, export)
    exporting = export
    local restrict = restrict
    if restrict == nil then
        restrict = {}
        for k,v in pairs(Config.Data) do
            table.insert(restrict, k)
        end
        indexcache = restrict
    end
    print(restrict)
    if not nocamera then
        CreateSkinCam()
    else
        if clothingopen then
            clothingopen = false
            if not confirm then
                TriggerEvent('skinchanger:loadSkin', lastSkin)
            end
        end
    end
    clothingopen = true
    local playerPed = PlayerPedId()
    confirm = false
    if not havecart then
        
        TriggerEvent('skinchanger:getSkin', function(skin) lastSkin = skin end)
    end
    ESX.TriggerServerCallback("renzu_clothes:getPlayerWardrobe",function(data)
        TriggerEvent('skinchanger:getData', function(components, maxVals)
            local elements = {}
            local _components = {}

            -- Restrict menu
            if restrict == nil then
                for i=1, #components, 1 do
                    _components[i] = components[i]
                end
            else
                for i=1, #components, 1 do
                    local found = false

                    for j=1, #restrict, 1 do
                        if components[i].name == restrict[j] then
                            found = true
                        end
                    end

                    if found then
                        table.insert(_components, components[i])
                    end
                end
            end
            -- Insert elements
            local datas = {}
            for i=1, #_components, 1 do
                local value = _components[i].value
                local componentId = _components[i].componentId

                if componentId == 0 then
                    value = GetPedPropIndex(playerPed, _components[i].componentId)
                end

                local data = {
                    label = _components[i].label,
                    name = _components[i].name,
                    value = value,
                    min = _components[i].min,
                    textureof = _components[i].textureof,
                    zoomOffset= _components[i].zoomOffset,
                    camOffset = _components[i].camOffset,
                    type = 'slider'
                }
                variantcache[_components[i].name] = data
                local texture = GetPedTextureVariation(PlayerPedId(),Config.Data[_components[i].name].componentid)
                local draw = GetPedDrawableVariation(PlayerPedId(),Config.Data[_components[i].name].componentid)
                local props = false
                if Config.Data[_components[i].name] ~= nil and Config.Data[_components[i].name].type == 'Props' then
                    texture = GetPedPropTextureIndex(PlayerPedId(),Config.Data[_components[i].name].componentid)
                    draw = GetPedPropIndex(PlayerPedId(),Config.Data[_components[i].name].componentid)
                end
                --
                if defaultclothes[Config.Data[_components[i].name].componentid] == nil then
                    defaultclothes[Config.Data[_components[i].name].componentid] = {}
                    defaultclothes[Config.Data[_components[i].name].componentid].draw = draw
                    defaultclothes[Config.Data[_components[i].name].componentid].texture = texture
                    
                end
                
                local n = _components[i].name:gsub("_1","")
                n = n:gsub("_2","")
                --
                datas[n] = Components[Config.Data[_components[i].name].type][GetEntityModel(playerPed)][tostring(Config.Data[_components[i].name].componentid)]
                --
                for k,v in pairs(maxVals) do
                    maxcolor[k] = v
                    if k == _components[i].name then
                        data.max = v
                        break
                    end
                end

                table.insert(elements, data)
            end

            zoomOffset = _components[1].zoomOffset
            camOffset = _components[1].camOffset
            clothes = data.wardrobe
            SendNUIMessage({
                type = 'Clothes',
                content = {blacklist = currentblacklist or {}, wardrobe = data.wardrobe, clothe = elements , maxcolor = maxcolor, nowardrobe = nowardrobe, datas = datas, shopname = Config.Shop[currentshop] ~= nil and Config.Shop[currentshop].name or 'My Clothing', export = exporting or false, showall = showall or false}
            })
            for k,v in pairs(variantcache) do
                clothecache[v.name] = v.value
            end
            SetNuiFocus(true,true)
            SetNuiFocusKeepInput(true)
        end)
    end,false,GetPlayerClothes())
end

local oldindex = -1
local pricecache = {}
function SelectClothes(data)
    if data.name == nil then return end
    local name = data.name:gsub("_id", "")
    name = name:gsub("arms_1", "arms")
    name = name:gsub("arms_2", "arms")
    
    --
    if data.drawableid then
        local re = name:gsub("_2", "_1")
        re = re:gsub("_1", "")
        re = re..'_1'
        if string.find(re, "arms") then
            re = 'arms'
        end
        TriggerEvent('skinchanger:change', tostring(re), tonumber(data.drawableid))
        if string.find(re, "arms") then
            re = 'arms'
            data.value = data.drawableid
            name = re
        end
        Wait(200)
    end
    if data.texture and not string.find(name, "arms") then
        local re = name:gsub("_2", "_1")
        re = re:gsub("_1", "")
        re = re..'_2'
        TriggerEvent('skinchanger:change', tostring(re), tonumber(data.texture))
        Wait(200)
        camOffset = variantcache[tostring(re)].camOffset
        zoomOffset = variantcache[tostring(re)].zoomOffset
        return
    end

    TriggerEvent('skinchanger:change', tostring(name), tonumber(data.value))
    
    Wait(10)
    local changetexture = false
    if string.find(name, "_1") then
        local re = name:gsub("_1", "_2")
        local maxVals = 0
        Wait(0)
        TriggerEvent('skinchanger:getData', function(comp, max)
            components, maxVals = comp, max
            if oldindex == -1 or oldindex ~= re then
                TriggerEvent('skinchanger:change', tostring(re), 0)
                oldindex = re
            end
            SendNUIMessage({
                type  = 'updateclothe',
                clothe = {name = re, max = maxVals[re]}
            })
        end)
        changetexture = true
    end
    
    clothecache[name] = tonumber(data.value)
    local re = name:gsub("_1", "")
    re = re:gsub("_2", "")
    --
    local texture = not changetexture and GetPedTextureVariation(PlayerPedId(),Config.Data[name].componentid) or changetexture and 0
    
    local draw = GetPedDrawableVariation(PlayerPedId(),Config.Data[name].componentid)
    local props = false
    if Config.Data[name].type == 'Props' then
        texture = not changetexture and GetPedPropTextureIndex(PlayerPedId(),Config.Data[name].componentid) or changetexture and 0
        draw = GetPedPropIndex(PlayerPedId(),Config.Data[name].componentid)
        props = true
    end
    if changetexture then
        if not props then
            SetPedComponentVariation(PlayerPedId(),Config.Data[name].componentid,draw,0,2)
        else
            SetPedPropIndex(PlayerPedId(),Config.Data[name].componentid,draw,0,2)
        end
    end
    --
    if Config.Data[name].componentid ~= nil and defaultclothes[Config.Data[name].componentid] and defaultclothes[Config.Data[name].componentid].draw ~= draw 
        or Config.Data[name].componentid ~= nil and defaultclothes[Config.Data[name].componentid] and defaultclothes[Config.Data[name].componentid].texture ~= texture then
        local price = defaultclothes[Config.Data[name].componentid].value ~= nil and defaultclothes[Config.Data[name].componentid].value or 0
        
        bill = bill + GetClotheData(Config.Data[name].componentid,draw,texture,props,name).Price - price
        defaultclothes[Config.Data[name].componentid].value = GetClotheData(Config.Data[name].componentid,draw,texture,props,name).Price
        
        unpaid[re] = {incart = showall or false, skin = re, compo = Config.Data[name].componentid,draw = draw, texture = texture, price = defaultclothes[Config.Data[name].componentid].value, label = GetClotheData(Config.Data[name].componentid,draw,texture,props).label or GetClotheData(Config.Data[name].componentid,draw,texture,props).NameHash, namehash = GetClotheData(Config.Data[name].componentid,draw,texture,props).NameHash}
    end
    if showall then
        incart = deepcopy(unpaid)
        havecart = true
    end
    --
    --
    --local re = name:gsub("_1", "_2")
    name = name:gsub("arms_2", "arms")
    --
    camOffset = variantcache[tostring(name)] ~= nil and variantcache[tostring(name)].camOffset ~= nil and variantcache[tostring(name)].camOffset or 0.5
    zoomOffset = variantcache[tostring(name)] ~= nil and variantcache[tostring(name)].zoomOffset ~= nil and variantcache[tostring(name)].zoomOffset or 0.5
end

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

RegisterNUICallback('addtocart', function(data, cb)
    for k,v in pairs(unpaid) do
        unpaid[k].incart = true
    end
    incart = deepcopy(unpaid)
    havecart = true
    Config.Notify( 'success', 'Clothing',' All Selected Clothes is now added to your cart')
    cb(true)
end)

RegisterNUICallback('viewcart', function(data, cb)
    cb(incart)
end)

RegisterNUICallback('removeitem', function(data, cb)
    for k,v in pairs(Config.Data) do
        
        if tonumber(data.compo) == tonumber(v.componentid) and defaultclothes[tonumber(data.compo)] then
            local re = k:gsub('_1','')
            re = re:gsub('_2','')
            TriggerEvent('skinchanger:change', re..'_1', tonumber(defaultclothes[tonumber(data.compo)].draw))
            TriggerEvent('skinchanger:change', re..'_2', tonumber(defaultclothes[tonumber(data.compo)].texture))
            
        end
    end
    --
    -- for k,v in pairs(incart) do
    --     --
    --     if v.incart and v.skin == data.name then
    --         
    --         if unpaid[k] then unpaid[k] = nil v = nil end
    --         if incart[k] then incart[k] = nil v = nil end
    --     end
    -- end
    
    unpaid[data.name].incart = false
    incart[data.name].incart = false
    for k,v in pairs(incart) do
        if not v.incart then
            if string.find(v.skin, "arms") then
                lastSkin['arms'] = defaultclothes[k].draw
            else
                
                lastSkin[k..'_1'] = defaultclothes[v.compo].draw
                lastSkin[k..'_2'] = defaultclothes[v.compo].texture
            end
        end
    end
    
    TriggerEvent('skinchanger:loadSkin', lastSkin)
    
    incart = deepcopy(unpaid)
    havecart = false
    for k,v in pairs(incart) do
        if v.incart then
            havecart = true
            
        end
    end
    Config.Notify( 'success', 'Clothing',' Selected Clothes is now removed from cart')
    cb(true)
end)

function GetPLayerModel()
    local model = "male"
    local hash = GetEntityModel(PlayerPedId())
    if hash == GetHashKey("mp_f_freemode_01") then
        model = "female"
    end
    return model
end

local selecting = {}
RegisterNUICallback('changeclothes', function(data, cb)
    
    Wait(math.random(1,10))
    if selecting.name and data.slider then selecting = data return end
    selecting = data
    if not data.slider then
        SelectClothes(data)
    end
    local select = -1
    --selecting = {}
    cb(true)
end)

RegisterNUICallback('removeclothe', function(data, cb)
    local model = GetPLayerModel()
    local ped = PlayerPedId()
    for k, v in pairs(Config.Data) do
        
        if v and v.type == "ComponentVariations" then
            if model == 'male' then
                TriggerEvent('skinchanger:change', k, v.m_default or 0)
                --SetPedComponentVariation(ped, v.componentid, v.m_default or 0, 0, 0) 
            else
                TriggerEvent('skinchanger:change', k, v.m_default or 0)
                --SetPedComponentVariation(ped, v.componentid, v.f_default or 0, 0, 0) 
            end
        elseif v and v.type == "Props" then
            if model == 'male' then
                TriggerEvent('skinchanger:change', k, v.m_default or 0)
                --SetPedPropIndex(ped, v.componentid, v.m_default, 0) 
            else
                TriggerEvent('skinchanger:change', k, v.m_default or 0)
                --SetPedPropIndex(ped, v.componentid, v.f_default, 0) 
            end
        end
    end
    unpaid = {}
    incart = {}
    bill = 0
    defaultclothes = {}
    TriggerEvent('skinchanger:getSkin', function(skin) 
        lastSkin = skin
        if oldskin == nil then
            oldskin = skin
        end
    end)
    cb(true)
end)

RegisterNUICallback('get_total', function(data, cb)
    local bills = 0
    for k,v in pairs(unpaid) do
        if v.incart then
            bills = bills + v.price
        end
    end
    cb(bills)
end)

RegisterNUICallback('mouseup', function(data, cb)
    Wait(100)
    
    SelectClothes(selecting)
    selecting = {}
end)


RegisterNUICallback('refresh', function(data, cb)
    Wait(500)
    if not inventory then
        OpenClotheMenu(indexcache,true,exporting)
    else
        OpenClotheInventory(true)
    end
end)

function GetPlayerClothes()
    local result = {}
    for k,v in pairs(Config.Data) do
        local texture = GetPedTextureVariation(PlayerPedId(),v.componentid)
        local draw = GetPedDrawableVariation(PlayerPedId(),v.componentid)
        local props = false
        if v ~= nil and v.type == 'Props' then
            texture = GetPedPropTextureIndex(PlayerPedId(),v.componentid)
            draw = GetPedPropIndex(PlayerPedId(),v.componentid)
            props = true
        end
        local name = k:gsub('_1','')
        name = name:gsub('_2','')
        --
        if draw ~= -1 and texture ~= -1 then
            local data = GetClotheData(v.componentid,draw,texture,props)
            result[name] = {label = data ~= nil and data.label or name..'_'..draw..'_'..texture, name = data ~= nil and data.NameHash or 'NULL',draw = draw,texture = texture,props = props}
        end
    end
    return result
end

RegisterNUICallback('saveclothes', function(data, cb)
    local clothename = data.newclothe or data.overwriteold or data.add
    local currentskin = {}
    TriggerEvent('skinchanger:getSkin', function(getSkin) currentskin = getSkin end)
    Wait(500)
    ESX.TriggerServerCallback("renzu_clothes:saveclothes",function(a)
        confirm = a
        if a then
            unpaid = {}
            incart = {}
            bill = 0
            havecart = false
        end
        cb(a)
    end,clothename,currentskin,nowardrobe or showall,bill,GetPlayerClothes(),data.payment,currentshop)
    
    SetNuiFocus(false,false)
    SetNuiFocusKeepInput(false)
    cb(true)
end)

RegisterNUICallback('buyitem', function(data, cb)
    local compo = data.componentid..'_1'
    if compo == 'arms_2' then
        compo = 'arms'
    end
    if compo == 'arms_1' then
        compo = compo:gsub("_1", "")
    end
    
    ESX.TriggerServerCallback("renzu_clothes:buyclothe",function(a)
        confirm = a
        cb(a)
    end,data.componentid,data.drawableid,data.textureid,GetClotheData(Config.Data[compo].componentid,data.drawableid,data.textureid).NameHash)
    cb(true)
end)

RegisterNUICallback('selectclothes', function(data, cb)
    if clothes[data.name] ~= nil and data.name ~= 'noclothe' then
        confirm = true
        TriggerEvent('skinchanger:loadSkin', clothes[data.name])
        ESX.TriggerServerCallback("renzu_clothes:selectclothe",function(a)
        end,clothes[data.name])
        cb(true)
    elseif data.name == 'noclothe' then
        local model = GetPLayerModel()
        local ped = PlayerPedId()
        for k, v in pairs(Config.Data) do
            
            if v and v.type == "ComponentVariations" then
                if model == 'male' then
                    TriggerEvent('skinchanger:change', k, v.m_default or 0)
                    --SetPedComponentVariation(ped, v.componentid, v.m_default or 0, 0, 0) 
                else
                    TriggerEvent('skinchanger:change', k, v.m_default or 0)
                    --SetPedComponentVariation(ped, v.componentid, v.f_default or 0, 0, 0) 
                end
            elseif v and v.type == "Props" then
                if model == 'male' then
                    TriggerEvent('skinchanger:change', k, v.m_default or 0)
                    --SetPedPropIndex(ped, v.componentid, v.m_default, 0) 
                else
                    TriggerEvent('skinchanger:change', k, v.m_default or 0)
                    --SetPedPropIndex(ped, v.componentid, v.f_default, 0) 
                end
            end
        end
        unpaid = {}
        incart = {}
        bill = 0
        defaultclothes = {}
        TriggerEvent('skinchanger:getSkin', function(skin) 
            lastSkin = skin
            if oldskin == nil then
                oldskin = skin
            end
        end)
    end
end)

function CreateSkinCam()
    if not DoesCamExist(cam) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    end

    local playerPed = PlayerPedId()

    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, false, false)

    isCameraActive = true
    SetCamCoord(cam, GetEntityCoords(playerPed))
    SetCamRot(cam, 0.0, 0.0, 270.0, true)
    SetEntityHeading(playerPed, 0.0)

    Citizen.CreateThread(function()
        while isCameraActive do
            DisableControlAction(0, 45, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 157, true)
            DisableControlAction(0, 158, true)
            DisableControlAction(0, 160, true)
            DisableControlAction(0, 164, true)
            DisableControlAction(0, 165, true)
            DisableControlAction(2, 30, true)
            DisableControlAction(2, 31, true)
            DisableControlAction(2, 32, true)
            DisableControlAction(2, 33, true)
            DisableControlAction(2, 34, true)
            DisableControlAction(2, 35, true)
            DisableControlAction(0, 25, true) -- Input Aim
            DisableControlAction(0, 24, true) -- Input Attack
            DisableControlAction(0, 177, true) -- ESC
            DisableControlAction(0, 200, true) -- ESC
            DisableControlAction(0, 245, true) -- T
            BlockWeaponWheelThisFrame()
            DisablePlayerFiring(PlayerId(),true)
            --ESX.ShowHelpNotification('use ~INPUT_VEH_FLY_ROLL_LEFT_ONLY~ and ~INPUT_VEH_FLY_ROLL_RIGHT_ONLY~ to rotate the view.')
            Wait(0)
        end
        return
    end)
    local sleep = 100
    Citizen.CreateThread(function()
        Citizen.CreateThread(function()
            local sound = true
            while isCameraActive do
                ESX.ShowHelpNotification('use ~INPUT_VEH_FLY_ROLL_LEFT_ONLY~ and ~INPUT_VEH_FLY_ROLL_RIGHT_ONLY~ to rotate the view.',false,sound,5000)
                Wait(5000)
                sound = false
            end
            return
        end)
        local playerPed = PlayerPedId()
        while isCameraActive do
            if isCameraActive then
                local coords    = GetEntityCoords(playerPed)
    
                local angle = heading * math.pi / 180.0
                local theta = {
                    x = math.cos(angle),
                    y = math.sin(angle)
                }
    
                local pos = {
                    x = coords.x + (zoomOffset * theta.x),
                    y = coords.y + (zoomOffset * theta.y)
                }
    
                local angleToLook = heading - 140.0
                if angleToLook > 360 then
                    angleToLook = angleToLook - 360
                elseif angleToLook < 0 then
                    angleToLook = angleToLook + 360
                end
    
                angleToLook = angleToLook * math.pi / 180.0
                local thetaToLook = {
                    x = math.cos(angleToLook),
                    y = math.sin(angleToLook)
                }
    
                local posToLook = {
                    x = coords.x + (zoomOffset * thetaToLook.x),
                    y = coords.y + (zoomOffset * thetaToLook.y)
                }
    
                SetCamCoord(cam, pos.x, pos.y, coords.z + camOffset)
                PointCamAtCoord(cam, posToLook.x, posToLook.y, coords.z + camOffset)
            end
            Citizen.Wait(sleep)
        end
        return
    end)
    
    Citizen.CreateThread(function()
        local angle = 90
    
        while isCameraActive do
            sleep = 100
            if IsControlPressed(0, 108) then
                angle = angle - 1
                sleep = 4
            elseif IsControlPressed(0, 109) then
                sleep = 4
                angle = angle + 1
            end

            if angle > 360 then
                angle = angle - 360
            elseif angle < 0 then
                angle = angle + 360
            end
    
                heading = angle + 0.0
            Citizen.Wait(sleep)
        end
        return
    end)
end

function DeleteSkinCam()
    isCameraActive = false
    SetCamActive(cam, false)
    RenderScriptCams(false, true, 500, true, true)
    DestroyCam(cam,true)
end

RegisterNUICallback('close', function(data, cb)
    Wait(500)
    SetNuiFocus(false,false)
    SetNuiFocusKeepInput(false)
    open = not open
    cancel = true
    if showall and havecart then
        for k,v in pairs(incart) do
            incart[k].incart = false
        end
        bill = 0
    end
    if clothingopen and not inventory then
        clothingopen = false
        if not confirm then
            if havecart then
                for k,v in pairs(incart) do
                    if v.incart then
                        
                        draw = v.draw
                        texture = v.texture
                        if string.find(v.skin, "arms") and lastSkin['arms'] then
                            lastSkin['arms'] = draw
                        elseif lastSkin[k..'_1'] and lastSkin[k..'_2'] then
                            lastSkin[k..'_1'] = draw
                            lastSkin[k..'_2'] = texture
                        end
                    else
                        if string.find(v.skin, "arms") and defaultclothes[k] and lastSkin['arms'] then
                            lastSkin['arms'] = defaultclothes[k].draw
                        elseif defaultclothes[v.compo] and lastSkin[k..'_1'] and lastSkin[k..'_2'] then
                            
                            lastSkin[k..'_1'] = defaultclothes[v.compo].draw
                            lastSkin[k..'_2'] = defaultclothes[v.compo].texture
                        end
                    end
                end
            end
            
            TriggerEvent('skinchanger:loadSkin', lastSkin)
        end
    elseif inventory then
        unpaid = {}
        incart = {}
        bill = 0
        clothingopen = false
    end
    DeleteSkinCam()
    --havecart = false
    if inventory or showall and bill == 0 then
        defaultclothes = {}
        unpaid = {}
        incart = {}
        bill = 0
        clothingopen = false
        TriggerEvent('skinchanger:getSkin', function(skin) 
            lastSkin = skin
            if oldskin == nil then
                oldskin = skin
            end
            ESX.TriggerServerCallback("renzu_clothes:save",function(a)end,lastSkin)
        end)
    end
    inventory = false
    for k,v in pairs(unpaid) do
        if not v.incart then
            unpaid[k] = nil
        end
    end
    exporting = false
    cb(true)
end)

RegisterCommand('wardrobe', function(source, args, rawCommand)
    OpenClotheInventory()
end)

function OpenClotheInventory(nocamera)
    if havecart then Config.Notify( 'error', 'Clothing',' You need to remove items from cart to use wardrobe') return end
    inventory = true
    local restrict = {
		'tshirt_1', 'tshirt_2',
		'torso_1', 'torso_2',
		'decals_1', 'decals_2',
		'arms',
		'pants_1', 'pants_2',
		'shoes_1', 'shoes_2',
        'bags_1', 'bags_2',
		'chain_1', 'chain_2',
		'helmet_1', 'helmet_2',
		'glasses_1', 'glasses_2',
        'ears_1', 'ears_2',
        'watches_1', 'watches_2',
        'bracelets_1', 'bracelets_2',
        'mask_1', 'mask_2',
	}
    if not nocamera then
        CreateSkinCam()
    end
    clothingopen = true
    local playerPed = PlayerPedId()
    confirm = false
    TriggerEvent('skinchanger:getSkin', function(skin) 
        lastSkin = skin
        if oldskin == nil then
            oldskin = skin
        end
    end)
    ESX.TriggerServerCallback("renzu_clothes:getPlayerWardrobe",function(data)
        TriggerEvent('skinchanger:getData', function(components, maxVals)
            local elements = {}
            local _components = {}

            -- Restrict menu
            if restrict == nil then
                for i=1, #components, 1 do
                    _components[i] = components[i]
                    
                end
            else
                for i=1, #components, 1 do
                    local found = false

                    for j=1, #restrict, 1 do
                        if components[i].name == restrict[j] then
                            found = true
                            
                        end
                    end

                    if found then
                        table.insert(_components, components[i])
                    end
                end
            end
            -- Insert elements
            local datas = {}
            for i=1, #_components, 1 do
                local value = _components[i].value
                local componentId = _components[i].componentId

                if componentId == 0 then
                    value = GetPedPropIndex(playerPed, _components[i].componentId)
                end

                local data = {
                    label = _components[i].label,
                    name = _components[i].name,
                    value = value,
                    min = _components[i].min,
                    textureof = _components[i].textureof,
                    zoomOffset= _components[i].zoomOffset,
                    camOffset = _components[i].camOffset,
                    type = 'slider'
                }
                variantcache[_components[i].name] = data
                local n = _components[i].name:gsub("_1","")
                n = n:gsub("_2","")
                --
                datas[n] = Components[Config.Data[_components[i].name].type][GetEntityModel(playerPed)][tostring(Config.Data[_components[i].name].componentid)]
                --
                for k,v in pairs(maxVals) do
                    maxcolor[k] = v
                    if k == _components[i].name then
                        data.max = v
                        break
                    end
                end
                local texture = GetPedTextureVariation(PlayerPedId(),Config.Data[_components[i].name].componentid)
                local draw = GetPedDrawableVariation(PlayerPedId(),Config.Data[_components[i].name].componentid)
                if Config.Data[_components[i].name] ~= nil and Config.Data[_components[i].name].type == 'Props' then
                    texture = GetPedPropTextureIndex(PlayerPedId(),Config.Data[_components[i].name].componentid)
                    draw = GetPedPropIndex(PlayerPedId(),Config.Data[_components[i].name].componentid)
                end
                --
                if defaultclothes[Config.Data[_components[i].name].componentid] == nil then
                    defaultclothes[Config.Data[_components[i].name].componentid] = {}
                    defaultclothes[Config.Data[_components[i].name].componentid].draw = draw
                    defaultclothes[Config.Data[_components[i].name].componentid].texture = texture
                end

                table.insert(elements, data)
            end
            zoomOffset = _components[1].zoomOffset
            camOffset = _components[1].camOffset
            clothes = data.wardrobe
            SendNUIMessage({
                type = 'Clothes',
                content = {inventory = data.inventory, wardrobe = data.wardrobe, clothe = elements , maxcolor = maxcolor, nowardrobe = nowardrobe, datas = datas, type = 'inventory'}
            })
            for k,v in pairs(variantcache) do
                clothecache[v.name] = v.value
            end
            SetNuiFocus(true,true)
            SetNuiFocusKeepInput(true)
        end)
    end,true, GetPlayerClothes())
end


exports('OpenClotheInventory', function(nocam)
    return OpenClotheInventory(nocam)
end)

exports('OpenClotheMenu', function(restrict, nocamera, export)
    return OpenClotheMenu(restrict, nocamera, export or true)
end)