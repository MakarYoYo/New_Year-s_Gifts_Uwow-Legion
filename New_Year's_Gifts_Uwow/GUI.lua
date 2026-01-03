-- New_Year's_Gifts_Uwow/GUI.lua

-- Создаем глобальную таблицу для GUI
NYGiftsUwowGUI = NYGiftsUwowGUI or {}

-- Функция получения профиля
local function GetProfile()
    if not NYGiftsUwow or not NYGiftsUwow.DB then
        return {}
    end
    
    local playerName = UnitName("player")
    if not playerName then return {} end
    
    if string.find(playerName, "-") then
        playerName = string.sub(playerName, 1, string.find(playerName, "-") - 1)
    end
    
    if not NYGiftsUwow.DB.profiles[playerName] then
        NYGiftsUwow.DB.profiles[playerName] = {}
    end
    
    return NYGiftsUwow.DB.profiles[playerName]
end

-- Основная функция создания окна
function NYGiftsUwowGUI.CreateWindow()
    -- Если окно уже существует
    if NYGiftsUwowGUI.Frame and NYGiftsUwowGUI.Frame:IsShown() then
        NYGiftsUwowGUI.Frame:Hide()
        return
    end
    
    -- Создаем основное окно
    NYGiftsUwowGUI.Frame = CreateFrame("Frame", "NYGiftsUwowFrame", UIParent, "BasicFrameTemplate")
    NYGiftsUwowGUI.Frame:SetSize(450, 350)
    NYGiftsUwowGUI.Frame:SetPoint("CENTER")
    NYGiftsUwowGUI.Frame:SetFrameStrata("HIGH")
    NYGiftsUwowGUI.Frame:SetMovable(true)
    NYGiftsUwowGUI.Frame:EnableMouse(true)
    NYGiftsUwowGUI.Frame:RegisterForDrag("LeftButton")
    NYGiftsUwowGUI.Frame:SetScript("OnDragStart", function(self) 
        self:StartMoving() 
    end)
    NYGiftsUwowGUI.Frame:SetScript("OnDragStop", function(self) 
        self:StopMovingOrSizing() 
    end)
    
    -- Заголовок
    NYGiftsUwowGUI.Frame.title = NYGiftsUwowGUI.Frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    NYGiftsUwowGUI.Frame.title:SetPoint("TOP", 0, -5)
    NYGiftsUwowGUI.Frame.title:SetText("|cffFF9900New Year's Gifts Uwow|r")
    
    -- Кнопка закрытия
    local closeButton = CreateFrame("Button", nil, NYGiftsUwowGUI.Frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", -5, -5)
    closeButton:SetScript("OnClick", function()
        NYGiftsUwowGUI.Frame:Hide()
    end)
    
    -- Контент
    local content = CreateFrame("Frame", nil, NYGiftsUwowGUI.Frame)
    content:SetPoint("TOP", 0, -30)
    content:SetPoint("LEFT", 10, 0)
    content:SetPoint("RIGHT", -10, 0)
    content:SetPoint("BOTTOM", 0, 40)
    
    -- Заголовок статистики
    local header = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    header:SetPoint("TOP", 0, -10)
    header:SetText("|cffFF9900Статистика подарков|r")
    
    -- Текст статистики
    local statsText = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    statsText:SetPoint("TOP", header, "BOTTOM", 0, -20)
    statsText:SetJustifyH("CENTER")
    
    -- Обновление статистики
    local function UpdateStats()
        local profile = GetProfile()
        local total = 0
        local collected = 0
        
        if NYGiftsUwow_MapIdTables and NYGiftsUwow_MapIdTables.locationData then
            for zoneKey, zoneData in pairs(NYGiftsUwow_MapIdTables.locationData) do
                total = total + 1
                if profile[zoneKey] then
                    collected = collected + 1
                end
            end
        end
        
        local percent = total > 0 and math.floor((collected / total) * 100) or 0
        
        statsText:SetText(string.format(
            "|cffFF9900Общая статистика|r\n\n" ..
            "Собрано подарков: |cff00ff00%d|r/|cffff9900%d|r\n" ..
            "Прогресс: |cffffff00%d%%|r\n\n" ..
            "--------------------------------\n" ..
            "|cffFF9900Собранные:|r\n" ..
            "|cff00ff00✓ %d локаций|r\n\n" ..
            "|cffFF9900Несобранные:|r\n" ..
            "|cffff0000✗ %d локаций|r",
            collected, total, percent, collected, total - collected
        ))
    end
    
    -- Кнопка для расширенного интерфейса
    local advancedBtn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    advancedBtn:SetSize(180, 25)
    advancedBtn:SetPoint("BOTTOM", 0, 10)
    advancedBtn:SetText("Расширенный интерфейс")
    advancedBtn:SetScript("OnClick", function()
        NYGiftsUwowGUI.ShowAdvancedInterface()
    end)
    
    -- Обновляем статистику
    UpdateStats()
    
    -- Показываем окно
    NYGiftsUwowGUI.Frame:Show()
end

-- Расширенный интерфейс с чекбоксами
function NYGiftsUwowGUI.ShowAdvancedInterface()
    -- Если окно уже существует
    if NYGiftsUwowGUI.AdvancedFrame and NYGiftsUwowGUI.AdvancedFrame:IsShown() then
        NYGiftsUwowGUI.AdvancedFrame:Hide()
        return
    end
    
    -- Создаем окно
    NYGiftsUwowGUI.AdvancedFrame = CreateFrame("Frame", "NYGiftsUwowAdvancedFrame", UIParent, "BasicFrameTemplate")
    NYGiftsUwowGUI.AdvancedFrame:SetSize(600, 500)
    NYGiftsUwowGUI.AdvancedFrame:SetPoint("CENTER")
    NYGiftsUwowGUI.AdvancedFrame:SetFrameStrata("HIGH")
    NYGiftsUwowGUI.AdvancedFrame:SetMovable(true)
    NYGiftsUwowGUI.AdvancedFrame:EnableMouse(true)
    NYGiftsUwowGUI.AdvancedFrame:RegisterForDrag("LeftButton")
    NYGiftsUwowGUI.AdvancedFrame:SetScript("OnDragStart", function(self) 
        self:StartMoving() 
    end)
    NYGiftsUwowGUI.AdvancedFrame:SetScript("OnDragStop", function(self) 
        self:StopMovingOrSizing() 
    end)
    
    -- Заголовок
    NYGiftsUwowGUI.AdvancedFrame.title = NYGiftsUwowGUI.AdvancedFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    NYGiftsUwowGUI.AdvancedFrame.title:SetPoint("TOP", 0, -5)
    NYGiftsUwowGUI.AdvancedFrame.title:SetText("|cffFF9900New Year's Gifts Uwow - Все локации|r")
    
    -- Кнопка закрытия
    local closeButton = CreateFrame("Button", nil, NYGiftsUwowGUI.AdvancedFrame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", -5, -5)
    closeButton:SetScript("OnClick", function()
        NYGiftsUwowGUI.AdvancedFrame:Hide()
    end)
    
    -- ScrollFrame для контента
    local scrollFrame = CreateFrame("ScrollFrame", nil, NYGiftsUwowGUI.AdvancedFrame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 10, -30)
    scrollFrame:SetPoint("BOTTOMRIGHT", -30, 40)
    
    local scrollChild = CreateFrame("Frame")
    scrollChild:SetWidth(scrollFrame:GetWidth() - 20)
    scrollChild:SetHeight(1000)
    
    scrollFrame:SetScrollChild(scrollChild)
    
    -- Загружаем данные
    local profile = GetProfile()
    local categories = {
        {name = "Легион", key = "legion"},
        {name = "Дренор", key = "draenor"},
        {name = "Калимдор", key = "kalimdor"},
        {name = "Восточные королевства", key = "eastern_kingdoms"},
        {name = "Нордскол", key = "northrend"},
        {name = "Запределье", key = "outland"},
        {name = "Пандария", key = "pandaria"}
    }
    
    local yOffset = -10
    local checkboxes = {}
    
    -- Создаем чекбоксы для каждой категории
    for _, category in ipairs(categories) do
        -- Заголовок категории
        local catHeader = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        catHeader:SetPoint("TOPLEFT", 10, yOffset)
        catHeader:SetText("|cffFF9900" .. category.name .. "|r")
        catHeader:SetJustifyH("LEFT")
        yOffset = yOffset - 25
        
        -- Получаем зоны для категории
        local zones = NYGiftsUwow_MapIdTables and NYGiftsUwow_MapIdTables.GetZonesByCategory(category.key)
        
        if zones then
            for zoneKey, zoneData in pairs(zones) do
                local isCollected = profile[zoneKey] or false
                
                -- Фрейм для строки
                local rowFrame = CreateFrame("Frame", nil, scrollChild)
                rowFrame:SetSize(scrollChild:GetWidth() - 20, 25)
                rowFrame:SetPoint("TOPLEFT", 30, yOffset)
                
                -- Чекбокс
                local checkbox = CreateFrame("CheckButton", nil, rowFrame, "UICheckButtonTemplate")
                checkbox:SetSize(20, 20)
                checkbox:SetPoint("LEFT", 0, 0)
                checkbox:SetChecked(isCollected)
                checkbox.zoneKey = zoneKey
                
                checkbox:SetScript("OnClick", function(self)
                    local checked = self:GetChecked()
                    local profile = GetProfile()
                    profile[self.zoneKey] = checked
                    
                    -- Обновляем стрелку
                    if NYGiftsUwow_AutoEnableArrow then
                        NYGiftsUwow_AutoEnableArrow()
                    end
                    
                    -- Обновляем маркеры
                    if NYGiftsUwow_UpdateMarkers then
                        NYGiftsUwow_UpdateMarkers()
                    end
                end)
                
                -- Иконка статуса
                local statusIcon = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                statusIcon:SetPoint("LEFT", 25, 0)
                statusIcon:SetText(isCollected and "|cff00ff00✓|r" or "|cffff0000✗|r")
                
                -- Текст локации
                local zoneText = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                zoneText:SetPoint("LEFT", 45, 0)
                zoneText:SetText(zoneData.name)
                zoneText:SetTextColor(isCollected and 0 or 1, isCollected and 1 or 0.8, 0, 1)
                
                -- Координаты
                local coordText = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                coordText:SetPoint("RIGHT", rowFrame, "RIGHT", -10, 0)
                coordText:SetText(string.format("(%d, %d)", zoneData.x, zoneData.y))
                coordText:SetTextColor(0.7, 0.7, 0.7, 1)
                
                table.insert(checkboxes, checkbox)
                yOffset = yOffset - 25
            end
        end
        
        yOffset = yOffset - 10 -- Отступ между категориями
    end
    
    -- Настраиваем высоту контента
    scrollChild:SetHeight(math.abs(yOffset) + 20)
    
    -- Кнопки управления
    local buttonFrame = CreateFrame("Frame", nil, NYGiftsUwowGUI.AdvancedFrame)
    buttonFrame:SetSize(580, 30)
    buttonFrame:SetPoint("BOTTOM", 0, 10)
    
    -- Кнопка отметить все
    local markAllBtn = CreateFrame("Button", nil, buttonFrame, "UIPanelButtonTemplate")
    markAllBtn:SetSize(120, 25)
    markAllBtn:SetPoint("LEFT", 20, 0)
    markAllBtn:SetText("Отметить все")
    markAllBtn:SetScript("OnClick", function()
        local profile = GetProfile()
        for _, category in ipairs(categories) do
            local zones = NYGiftsUwow_MapIdTables and NYGiftsUwow_MapIdTables.GetZonesByCategory(category.key)
            if zones then
                for zoneKey, _ in pairs(zones) do
                    profile[zoneKey] = true
                end
            end
        end
        
        -- Обновляем чекбоксы
        for _, checkbox in ipairs(checkboxes) do
            checkbox:SetChecked(true)
        end
        
        -- Обновляем стрелку
        if NYGiftsUwow_AutoEnableArrow then
            NYGiftsUwow_AutoEnableArrow()
        end
        
        -- Обновляем маркеры
        if NYGiftsUwow_UpdateMarkers then
            NYGiftsUwow_UpdateMarkers()
        end
    end)
    
    -- Кнопка снять все
    local unmarkAllBtn = CreateFrame("Button", nil, buttonFrame, "UIPanelButtonTemplate")
    unmarkAllBtn:SetSize(120, 25)
    unmarkAllBtn:SetPoint("LEFT", markAllBtn, "RIGHT", 10, 0)
    unmarkAllBtn:SetText("Снять все")
    unmarkAllBtn:SetScript("OnClick", function()
        local profile = GetProfile()
        for _, category in ipairs(categories) do
            local zones = NYGiftsUwow_MapIdTables and NYGiftsUwow_MapIdTables.GetZonesByCategory(category.key)
            if zones then
                for zoneKey, _ in pairs(zones) do
                    profile[zoneKey] = false
                end
            end
        end
        
        -- Обновляем чекбоксы
        for _, checkbox in ipairs(checkboxes) do
            checkbox:SetChecked(false)
        end
        
        -- Обновляем стрелку
        if NYGiftsUwow_AutoEnableArrow then
            NYGiftsUwow_AutoEnableArrow()
        end
        
        -- Обновляем маркеры
        if NYGiftsUwow_UpdateMarkers then
            NYGiftsUwow_UpdateMarkers()
        end
    end)
    
    -- Кнопка закрыть
    local closeBtn = CreateFrame("Button", nil, buttonFrame, "UIPanelButtonTemplate")
    closeBtn:SetSize(120, 25)
    closeBtn:SetPoint("RIGHT", -20, 0)
    closeBtn:SetText("Закрыть")
    closeBtn:SetScript("OnClick", function()
        NYGiftsUwowGUI.AdvancedFrame:Hide()
    end)
    
    -- Показываем окно
    NYGiftsUwowGUI.AdvancedFrame:Show()
end

-- Функция переключения окна
function NYGiftsUwowGUI.Toggle()
    if not NYGiftsUwowGUI.Frame then
        NYGiftsUwowGUI.CreateWindow()
    elseif NYGiftsUwowGUI.Frame:IsShown() then
        NYGiftsUwowGUI.Frame:Hide()
    else
        NYGiftsUwowGUI.Frame:Show()
    end
end

-- Сообщение о загрузке
print("|cffFF9900[New Year's Gifts Uwow]:|r GUI модуль загружен")