-- New_Year's_Gifts_Uwow/main.lua

local addonName = "New_Year's_Gifts_Uwow"

-- Режим отладки
local DEBUG_MODE = false

-- Глобальные переменные
NYGiftsUwow = NYGiftsUwow or {}
NYGiftsUwow.DB = NYGiftsUwow.DB or { profiles = {} }

-- Загружаем таблицы зон
local locationData = nil
local GIFT_ITEM_ID = nil

-- Таблица для хранения маркеров
local activeMarkers = {}
local markerFrame = CreateFrame("Frame", "NYGiftsUwowMarkersFrame", WorldMapButton)
markerFrame:SetAllPoints()

-- Получение профиля
local function GetProfile()
    local playerName = UnitName("player")
    if not playerName then return {} end
    
    -- Убираем имя сервера
    if string.find(playerName, "-") then
        playerName = string.sub(playerName, 1, string.find(playerName, "-") - 1)
    end
    
    if not NYGiftsUwow.DB.profiles[playerName] then
        NYGiftsUwow.DB.profiles[playerName] = {}
    end
    
    return NYGiftsUwow.DB.profiles[playerName]
end

-- Инициализация данных
local function InitializeData()
    if NYGiftsUwow_MapIdTables then
        locationData = NYGiftsUwow_MapIdTables.locationData
        GIFT_ITEM_ID = NYGiftsUwow_MapIdTables.GIFT_ITEM_ID
        if DEBUG_MODE then
            print("NYGiftsUwow Debug: Данные зон загружены")
        end
        return true
    end
    return false
end

-- Стрелка направления
local arrowFrame = CreateFrame("Button", "NYGiftsUwowArrowFrame", UIParent)
arrowFrame:SetWidth(56)
arrowFrame:SetHeight(42)
arrowFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
arrowFrame:EnableMouse(true)
arrowFrame:SetMovable(true)
arrowFrame:Hide()

local arrowTexture = arrowFrame:CreateTexture("OVERLAY")
arrowTexture:SetAllPoints()
arrowTexture:SetTexture("Interface\\AddOns\\New_Year's_Gifts_Uwow\\arrow_image")

local titleText = arrowFrame:CreateFontString("OVERLAY", nil, "GameFontNormalSmall")
local distanceText = arrowFrame:CreateFontString("OVERLAY", nil, "GameFontNormalSmall")
titleText:SetPoint("TOP", arrowFrame, "BOTTOM", 0, 0)
distanceText:SetPoint("TOP", titleText, "BOTTOM", 0, 0)

local currentTarget = nil
local lastUpdate = 0
local showDownArrow = false

-- Функции стрелки
local function CalculateDistance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

local function UpdateArrow()
    if not currentTarget or not locationData or not locationData[currentTarget] then
        arrowFrame:Hide()
        return
    end
    
    local px, py = GetPlayerMapPosition("player")
    if not px or not py or px == 0 and py == 0 then
        arrowFrame:Hide()
        return
    end
    
    local target = locationData[currentTarget]
    local tx, ty = target.x / 100, target.y / 100
    local distance = CalculateDistance(px, py, tx, ty) * 1000
    local currentZone = GetMapInfo()
    
    if currentZone == currentTarget then
        arrowFrame:Show()
        titleText:SetText(locationData[currentTarget].name or currentTarget)
        
        if distance < 10 then
            distanceText:SetText("Прибыли! Подарок где-то рядом!")
            if not showDownArrow then
                showDownArrow = true
                arrowTexture:SetTexture("Interface\\AddOns\\New_Year's_Gifts_Uwow\\arrow_image_down")
                arrowFrame:SetHeight(70)
                arrowFrame:SetWidth(53)
            end
            
            local cell = math.floor(math.fmod(GetTime() * 20, 55))
            local column = cell % 9
            local row = math.floor(cell / 9)
            local xstart = (column * 53) / 512
            local ystart = (row * 70) / 512
            local xend = ((column + 1) * 53) / 512
            local yend = ((row + 1) * 70) / 512
            arrowTexture:SetTexCoord(xstart, xend, ystart, yend)
            arrowTexture:SetVertexColor(0, 1, 0)
        else
            distanceText:SetFormattedText("%.0f ярдов", distance)
            if showDownArrow then
                showDownArrow = false
                arrowTexture:SetTexture("Interface\\AddOns\\New_Year's_Gifts_Uwow\\arrow_image")
                arrowFrame:SetHeight(42)
                arrowFrame:SetWidth(56)
            end
            
            local angleToTarget = math.atan2(px - tx, -1*(ty - py))
            local relativeAngle = angleToTarget - GetPlayerFacing()
            while relativeAngle > math.pi do relativeAngle = relativeAngle - 2*math.pi end
            while relativeAngle < -math.pi do relativeAngle = relativeAngle + 2*math.pi end
            
            local cell = math.floor(relativeAngle / (math.pi * 2) * 108 + 0.5) % 108
            local column = cell % 9
            local row = math.floor(cell / 9)
            local xstart = (column * 56) / 512
            local ystart = (row * 42) / 512
            local xend = ((column + 1) * 56) / 512
            local yend = ((row + 1) * 42) / 512
            arrowTexture:SetTexCoord(xstart, xend, ystart, yend)
            
            if distance < 50 then
                arrowTexture:SetVertexColor(0, 1, 0)
            elseif distance < 100 then
                arrowTexture:SetVertexColor(1, 1, 0)
            else
                arrowTexture:SetVertexColor(1, 0, 0)
            end
        end
    else
        arrowFrame:Hide()
    end
end

arrowFrame:SetScript("OnUpdate", function(self, elapsed)
    lastUpdate = lastUpdate + elapsed
    if lastUpdate > 0.1 then
        UpdateArrow()
        lastUpdate = 0
    end
end)

arrowFrame:RegisterForDrag("LeftButton")
arrowFrame:SetScript("OnDragStart", function() arrowFrame:StartMoving() end)
arrowFrame:SetScript("OnDragStop", function() arrowFrame:StopMovingOrSizing() end)

-- Функция авто-включения стрелки
function NYGiftsUwow_AutoEnableArrow()
    if not locationData then return end
    
    local currentZone = GetMapInfo()
    if locationData[currentZone] then
        local profile = GetProfile()
        if profile and profile[currentZone] then
            currentTarget = nil
            arrowFrame:Hide()
            if DEBUG_MODE then
                print("NYGiftsUwow Debug: Подарок уже собран в " .. currentZone)
            end
            return
        end
        
        currentTarget = currentZone
        UpdateArrow()
        if DEBUG_MODE then
            print("NYGiftsUwow Debug: Стрелка активирована для " .. currentZone)
        end
    else
        currentTarget = nil
        arrowFrame:Hide()
        if DEBUG_MODE then
            print("NYGiftsUwow Debug: Нет подарка в текущей зоне")
        end
    end
end

-- Функция для отображения маркеров на карте
function NYGiftsUwow_UpdateMarkers()
    if not locationData then 
        if DEBUG_MODE then
            print("NYGiftsUwow Debug: Данные зон не загружены для маркеров")
        end
        return 
    end
    
    -- Получаем текущую зону
    local currentZone = GetMapInfo()
    
    if DEBUG_MODE then
        print("NYGiftsUwow Debug: Обновление маркеров для зоны: " .. (currentZone or "nil"))
    end
    
    -- Очищаем старые маркеры
    for key, marker in pairs(activeMarkers) do
        if marker then
            marker:Hide()
        end
        activeMarkers[key] = nil
    end
    
    -- Если нет карты мира, выходим
    if not WorldMapButton or not WorldMapButton:IsVisible() then
        return
    end
    
    -- Размеры карты
    local mapWidth = WorldMapButton:GetWidth()
    local mapHeight = WorldMapButton:GetHeight()
    
    if mapWidth <= 0 or mapHeight <= 0 then
        return
    end
    
    -- Проверяем текущую зону
    if locationData[currentZone] then
        local coords = locationData[currentZone]
        local profile = GetProfile()
        local giftCollected = profile and profile[currentZone] or false
        
        if giftCollected then
            -- Маркер для собранного подарка
            local collectedMarker = CreateFrame("Frame", nil, markerFrame)
            collectedMarker:SetWidth(24)
            collectedMarker:SetHeight(24)
            collectedMarker:SetFrameStrata("DIALOG")
            collectedMarker:SetFrameLevel(999)
            
            local checkIcon = collectedMarker:CreateTexture("OVERLAY")
            checkIcon:SetAllPoints()
            checkIcon:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
            checkIcon:SetVertexColor(0, 1, 0, 0.9)
            
            -- Позиция
            local normalizedX = coords.x / 100
            local normalizedY = coords.y / 100
            local posX = normalizedX * mapWidth
            local posY = (1 - normalizedY) * mapHeight
            
            collectedMarker:SetPoint("CENTER", WorldMapButton, "BOTTOMLEFT", posX, posY)
            collectedMarker:Show()
            
            -- Подсказка
            collectedMarker:SetScript("OnEnter", function()
                GameTooltip:SetOwner(collectedMarker, "ANCHOR_RIGHT")
                GameTooltip:SetText(coords.name .. "\n|cff00ff00Подарок собран!|r", 1, 1, 1)
                GameTooltip:Show()
            end)
            
            collectedMarker:SetScript("OnLeave", function()
                GameTooltip:Hide()
            end)
            
            activeMarkers[currentZone .. "_collected"] = collectedMarker
            
        else
            -- Маркер для несобранного подарка
            local marker = CreateFrame("Frame", nil, markerFrame)
            marker:SetWidth(20)
            marker:SetHeight(20)
            marker:SetFrameStrata("DIALOG")
            marker:SetFrameLevel(1000)
            
            local markerIcon = marker:CreateTexture("OVERLAY")
            markerIcon:SetAllPoints()
            markerIcon:SetTexture("Interface\\Icons\\INV_Misc_Gift_01")
            markerIcon:SetVertexColor(1, 0.8, 0, 1)
            
            -- Позиция
            local normalizedX = coords.x / 100
            local normalizedY = coords.y / 100
            local posX = normalizedX * mapWidth
            local posY = (1 - normalizedY) * mapHeight
            
            marker:SetPoint("CENTER", WorldMapButton, "BOTTOMLEFT", posX, posY)
            marker:Show()
            
            -- Стрелка на карте
            local mapArrow = marker:CreateTexture("OVERLAY")
            mapArrow:SetWidth(30)
            mapArrow:SetHeight(30)
            mapArrow:SetPoint("CENTER", marker, "CENTER", 0, 20)
            mapArrow:SetTexture("Interface\\AddOns\\New_Year's_Gifts_Uwow\\arrow_image_down")
            mapArrow:SetVertexColor(0, 1, 0, 0.8)
            
            -- Анимация
            local function animateMapArrow()
                local cell = math.floor(math.fmod(GetTime() * 20, 55))
                local column = cell % 9
                local row = math.floor(cell / 9)
                local xstart = (column * 53) / 512
                local ystart = (row * 70) / 512
                local xend = ((column + 1) * 53) / 512
                local yend = ((row + 1) * 70) / 512
                mapArrow:SetTexCoord(xstart, xend, ystart, yend)
            end
            
            marker:SetScript("OnUpdate", function(self, elapsed)
                animateMapArrow()
            end)
            
            -- Подсказка
            marker:SetScript("OnEnter", function()
                GameTooltip:SetOwner(marker, "ANCHOR_RIGHT")
                GameTooltip:SetText(coords.name .. "\nКоординаты: " .. coords.x .. ", " .. coords.y .. "\n|cff00ff00Подарок еще не собран|r", 1, 1, 1)
                GameTooltip:Show()
            end)
            
            marker:SetScript("OnLeave", function()
                GameTooltip:Hide()
            end)
            
            activeMarkers[currentZone] = marker
        end
    end
end

-- Функция проверки статуса подарков
local function CheckGiftStatus()
    if not locationData then
        print("|cffFF9900[New Year's Gifts Uwow]:|r Данные зон не загружены")
        return
    end
    
    local totalLocations = 0
    local collectedGifts = 0
    local profile = GetProfile()
    
    print("|cffFF9900========================================|r")
    print("|cffFF9900   New Year's Gifts Uwow - Статус     |r")
    print("|cffFF9900========================================|r")
    
    local categories = {
        {name = "|cff00ffffЛегион:|r", zones = NYGiftsUwow_MapIdTables.GetZonesByCategory("legion")},
        {name = "|cff00ff00Дренор:|r", zones = NYGiftsUwow_MapIdTables.GetZonesByCategory("draenor")},
        {name = "|cffff9900Калимдор:|r", zones = NYGiftsUwow_MapIdTables.GetZonesByCategory("kalimdor")},
        {name = "|cff9999ffВосточные королевства:|r", zones = NYGiftsUwow_MapIdTables.GetZonesByCategory("eastern_kingdoms")},
        {name = "|cff99ccffНордскол:|r", zones = NYGiftsUwow_MapIdTables.GetZonesByCategory("northrend")},
        {name = "|cffcc99ffЗапределье:|r", zones = NYGiftsUwow_MapIdTables.GetZonesByCategory("outland")},
        {name = "|cffff99ccПандария:|r", zones = NYGiftsUwow_MapIdTables.GetZonesByCategory("pandaria")}
    }
    
    for _, category in ipairs(categories) do
        if category.zones then
            print(category.name)
            for zoneKey, zoneData in pairs(category.zones) do
                totalLocations = totalLocations + 1
                local giftReceived = profile and profile[zoneKey] or false
                if giftReceived then
                    collectedGifts = collectedGifts + 1
                    print("  |cff00ff00✓ " .. zoneData.name .. " - ПОДАРОК ПОЛУЧЕН!|r")
                else
                    print("  |cffff0000✗ " .. zoneData.name .. " - ПОДАРОК ЕЩЕ НЕ ПОЛУЧЕН!|r")
                end
            end
        end
    end
    
    print("|cffFF9900========================================|r")
    print(string.format("|cffffff00Всего подарков собрано: %d/%d (%.0f%%)|r", collectedGifts, totalLocations, (collectedGifts/totalLocations)*100))
    print(string.format("|cffffff00Осталось локаций: %d|r", (totalLocations - collectedGifts)))
    print("|cffFF9900========================================|r")
    
    if collectedGifts == totalLocations then
        print("|cff00ff00ПОЗДРАВЛЯЕМ! ВЫ СОБРАЛИ ВСЕ ПОДАРКИ!|r")
        print("|cffFF9900========================================|r")
    end
end

-- Функция для обработки получения подарка
local function OnGiftReceived()
    if not locationData then return end
    
    local currentZone = GetMapInfo()
    if currentZone and locationData[currentZone] then
        local profile = GetProfile()
        if profile and not profile[currentZone] then
            profile[currentZone] = true
            
            -- Скрываем стрелку
            currentTarget = nil
            arrowFrame:Hide()
            
            -- Обновляем маркеры
            NYGiftsUwow_UpdateMarkers()
            
            -- Сообщение
            print("|cffFF9900========================================|r")
            print("|cff00ff00НОВОГОДНИЙ ПОДАРОК ПОЛУЧЕН!|r")
            print("|cffFF9900========================================|r")
            print("|cffffff00Локация:|r " .. locationData[currentZone].name)
            print("|cffffff00Стрелка и маркер скрыты|r")
            
            -- Статистика
            local total = 0
            local collected = 0
            for zone, _ in pairs(locationData) do
                total = total + 1
                if profile[zone] then
                    collected = collected + 1
                end
            end
            
            local progressPercent = (collected/total)*100
            print(string.format("|cffffff00Прогресс: %d/%d (%.0f%%)|r", collected, total, progressPercent))
            
            if collected == total then
                print("|cff00ff00ВЫ СОБРАЛИ ВСЕ ПОДАРКИ! ПОЗДРАВЛЯЕМ!|r")
            elseif progressPercent >= 75 then
                print("|cffff9900Отличный результат! Осталось совсем немного!|r")
            elseif progressPercent >= 50 then
                print("|cffff9900Половина пути пройдена! Продолжайте в том же духе!|r")
            elseif progressPercent >= 25 then
                print("|cffff9900Хорошее начало! Еще много интересного впереди!|r")
            else
                print("|cffff9900Удачи в поисках новогодних подарков!|r")
            end
            
            print("|cffFF9900========================================|r")
            
            if DEBUG_MODE then
                print("NYGiftsUwow Debug: Подарок в " .. currentZone .. " отмечен как собранный")
            end
        else
            if DEBUG_MODE then
                print("NYGiftsUwow Debug: Подарок в " .. currentZone .. " уже был отмечен как собранный")
            end
        end
    end
end

-- Обработчик событий лута
local function SetupLootHandler()
    local lootFrame = CreateFrame("Frame")
    lootFrame:RegisterEvent("CHAT_MSG_LOOT")
    lootFrame:RegisterEvent("BAG_UPDATE_DELAYED")
    lootFrame:RegisterEvent("LOOT_OPENED")
    
    lootFrame:SetScript("OnEvent", function(self, event, ...)
        if event == "CHAT_MSG_LOOT" then
            local message = ...
            if string.find(message, "Подарок") or string.find(message, "подарок") or 
               string.find(message, "Gift") or string.find(message, "gift") then
                C_Timer.After(0.5, OnGiftReceived)
            end
        elseif event == "BAG_UPDATE_DELAYED" then
            for bag = 0, 4 do
                for slot = 1, GetContainerNumSlots(bag) do
                    local itemLink = GetContainerItemLink(bag, slot)
                    if itemLink then
                        local itemID = GetItemInfoInstant(itemLink)
                        if itemID == GIFT_ITEM_ID then
                            C_Timer.After(1, OnGiftReceived)
                            return
                        end
                    end
                end
            end
        elseif event == "LOOT_OPENED" then
            local numLootItems = GetNumLootItems()
            for i = 1, numLootItems do
                local lootIcon, lootName = GetLootSlotInfo(i)
                if lootName and (string.find(lootName, "Подарок") or string.find(lootName, "подарок") or 
                                string.find(lootName, "Gift") or string.find(lootName, "gift")) then
                    C_Timer.After(0.5, OnGiftReceived)
                    break
                end
            end
        end
    end)
end

-- Основная функция загрузки
local function InitializeAddon()
    -- Инициализируем данные
    if not InitializeData() then
        print("|cffFF9900[New Year's Gifts Uwow]:|r Ошибка загрузки данных зон")
        return
    end
    
    -- Запускаем Core
    if NYGiftsUwow_Core then
        NYGiftsUwow_Core.Initialize()
    end
    
    -- Настраиваем обработчик лута
    SetupLootHandler()
    
    -- Запускаем стрелку
    NYGiftsUwow_AutoEnableArrow()
    
    -- Хук для обновления маркеров при показе карты
    WorldMapFrame:HookScript("OnShow", NYGiftsUwow_UpdateMarkers)
    
    -- События для обновления стрелки и маркеров
    local eventFrame = CreateFrame("Frame")
    eventFrame:RegisterEvent("WORLD_MAP_UPDATE")
    eventFrame:RegisterEvent("ZONE_CHANGED")
    eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    eventFrame:SetScript("OnEvent", function()
        NYGiftsUwow_UpdateMarkers()
        NYGiftsUwow_AutoEnableArrow()
    end)
    
    -- Сообщение о загрузке
    C_Timer.After(1, function()
        print("|cffFF9900========================================|r")
        print("|cffFF9900    New Year's Gifts Uwow v1.0        |r")
        print("|cffFF9900========================================|r")
        print("|cffFF9900Аддон успешно загружен!")
        print("|cffFF9900На карте отмечены все новогодние подарки")
        print("|cffFF99003D стрелка направления включена автоматически")
        print("|cffFF9900Для открытия статистики введите |cffffff00/nygifts gui|r")
        print("|cffFF9900или нажмите на иконку у миникарты")
        print("|cffFF9900========================================|r")
        
        -- Текущий прогресс
        local profile = GetProfile()
        if profile and locationData then
            local total = 0
            local collected = 0
            for zone, _ in pairs(locationData) do
                total = total + 1
                if profile[zone] then
                    collected = collected + 1
                end
            end
            
            if collected > 0 then
                local progressPercent = (collected/total)*100
                print(string.format("|cffFF9900Ваш прогресс: %d/%d (%.0f%%)|r", collected, total, progressPercent))
                
                if collected == total then
                    print("|cff00ff00ВЫ СОБРАЛИ ВСЕ ПОДАРКИ! ПОЗДРАВЛЯЕМ!|r")
                elseif progressPercent >= 75 then
                    print("|cffff9900Отличный результат! Осталось совсем немного!|r")
                elseif progressPercent >= 50 then
                    print("|cffff9900Половина пути пройдена! Продолжайте в том же духе!|r")
                elseif progressPercent >= 25 then
                    print("|cffff9900Хорошее начало! Удачи в поисках!|r")
                else
                    print("|cffff9900Удачи в поисках новогодних подарков!|r")
                end
            else
                print("|cffFF9900У вас пока нет собранных подарков")
                print("|cffff9900Удачи в поисках новогодних подарков!|r")
            end
        end
        print("|cffFF9900========================================|r")
        
        -- Автор и контакты
        print("|cffffff00Создатель: |cffFF9900Makar_YoYo|r")
        print("|cffffff00Игровой ник: |cffFF9900Макарёё, Makaryoyo, UWOW.BIZ Legion x100|r")
        print("|cffFF9900========================================|r")
    end)
end

-- Обработчик событий загрузки аддона
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        InitializeAddon()
        self:UnregisterEvent("ADDON_LOADED")
    end
end)

-- Slash команды
SLASH_NEWYEARSUWOW1 = "/nygifts"
SLASH_NEWYEARSUWOW2 = "/nyguwow"
SLASH_NEWYEARSUWOW3 = "/новогодние"
SlashCmdList["NEWYEARSUWOW"] = function(msg)
    local cmd = string.lower(msg or "")
    
    if cmd == "gui" or cmd == "меню" or cmd == "окно" then
        -- Пытаемся открыть GUI
        if NYGiftsUwowGUI and type(NYGiftsUwowGUI.Toggle) == "function" then
            NYGiftsUwowGUI.Toggle()
        else
            print("|cffFF9900[New Year's Gifts Uwow]:|r GUI еще не загружен. Попробуйте через секунду.")
            C_Timer.After(1, function()
                if NYGiftsUwowGUI and type(NYGiftsUwowGUI.Toggle) == "function" then
                    NYGiftsUwowGUI.Toggle()
                else
                    print("|cffFF9900[New Year's Gifts Uwow]:|r Не удалось загрузить GUI. Попробуйте /reload")
                end
            end)
        end
    elseif cmd == "hide" or cmd == "скрыть" then
        currentTarget = nil
        arrowFrame:Hide()
        print("|cffFF9900[New Year's Gifts Uwow]:|r Стрелка скрыта")
    elseif cmd == "show" or cmd == "показать" then
        NYGiftsUwow_AutoEnableArrow()
        print("|cffFF9900[New Year's Gifts Uwow]:|r Стрелка показана")
    elseif cmd == "check" or cmd == "проверить" then
        CheckGiftStatus()
    elseif cmd == "status" or cmd == "статус" then
        local profile = GetProfile()
        if profile and locationData then
            local total = 0
            local collected = 0
            for zone, _ in pairs(locationData) do
                total = total + 1
                if profile[zone] then
                    collected = collected + 1
                end
            end
            
            print("|cffFF9900========================================|r")
            print("|cffFF9900   New Year's Gifts Uwow - Прогресс   |r")
            print("|cffFF9900========================================|r")
            print(string.format("|cffffff00Собрано подарков: %d/%d|r", collected, total))
            print(string.format("|cffffff00Прогресс: %.0f%%|r", total > 0 and (collected/total)*100 or 0))
            
            if collected == total then
                print("|cff00ff00ВЫ СОБРАЛИ ВСЕ ПОДАРКИ!|r")
            elseif collected > 0 then
                print("|cffff9900Продолжайте в том же духе!|r")
            else
                print("|cffff9900Удачи в поисках подарков!|r")
            end
            print("|cffFF9900========================================|r")
        end
    elseif cmd == "reset" or cmd == "сброс" then
        local profile = GetProfile()
        if profile then
            wipe(profile)
            print("|cffFF9900[New Year's Gifts Uwow]:|r Статус всех подарков сброшен!")
            NYGiftsUwow_UpdateMarkers()
            NYGiftsUwow_AutoEnableArrow()
        end
    elseif cmd == "debug" or cmd == "отладка" then
        DEBUG_MODE = not DEBUG_MODE
        if DEBUG_MODE then
            print("|cffFF9900[New Year's Gifts Uwow]:|r Режим отладки ВКЛЮЧЕН")
        else
            print("|cffFF9900[New Year's Gifts Uwow]:|r Режим отладки ВЫКЛЮЧЕН")
        end
    elseif cmd == "help" or cmd == "помощь" or cmd == "" then
        print("|cffFF9900========================================|r")
        print("|cffFF9900    New Year's Gifts Uwow - Помощь     |r")
        print("|cffFF9900========================================|r")
        print("|cffffff00Основные команды:|r")
        print("|cffffff00/nygifts gui|r - открыть окно статистики")
        print("|cffffff00/nygifts help|r - показать эту справку")
        print("|cffffff00/nygifts check|r - детальная проверка всех подарков")
        print("|cffffff00/nygifts status|r - краткий статус прогресса")
        print("|cffffff00/nygifts hide|r - скрыть стрелку направления")
        print("|cffffff00/nygifts show|r - показать стрелку")
        print("|cffffff00/nygifts reset|r - сбросить статус всех подарков")
        print("|cffffff00/nygifts debug|r - режим отладки")
        print("|cffFF9900========================================|r")
        print("|cffffff00Альтернативные команды:|r")
        print("|cffffff00/nyguwow|r - то же что /nygifts")
        print("|cffffff00/новогодние|r - то же что /nygifts")
        print("|cffFF9900========================================|r")
        print("|cffffff00Особенности:|r")
        print("|cffffff00• Стрелка появляется автоматически|r")
        print("|cffffff00• Маркеры скрываются после сбора|r")
        print("|cffffff00• Прогресс сохраняется для персонажа|r")
        print("|cffffff00• GUI окно с полной статистикой|r")
        print("|cffFF9900========================================|r")
        print("|cffffff00Создатель: |cffFF9900Makar_YoYo|r")
        print("|cffffff00Версия: |cffFF99001.0|r")
        print("|cffFF9900========================================|r")
    else
        print("|cffFF9900[New Year's Gifts Uwow]:|r Неизвестная команда")
        print("|cffffff00Используйте |cffFF9900/nygifts help|r для справки")
    end
end