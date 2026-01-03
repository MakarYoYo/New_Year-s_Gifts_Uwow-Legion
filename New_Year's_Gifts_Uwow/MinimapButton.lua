-- New_Year's_Gifts_Uwow/MinimapButton.lua

-- Создаем кнопку у миникарты
local button = CreateFrame("Button", "NYGiftsUwowMinimapButton", Minimap)
button:SetSize(32, 32)
button:SetFrameStrata("MEDIUM")
button:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -20, -20) -- Фиксированная позиция

-- Иконка
local icon = button:CreateTexture(nil, "BACKGROUND")
icon:SetAllPoints()
icon:SetTexture("Interface\\Icons\\INV_Misc_Gift_01")

-- Обработчики событий
button:SetScript("OnClick", function(self, buttonClicked)
    if buttonClicked == "LeftButton" then
        -- Открываем GUI
        if NYGiftsUwowGUI and type(NYGiftsUwowGUI.Toggle) == "function" then
            NYGiftsUwowGUI.Toggle()
        else
            print("|cffFF9900[New Year's Gifts Uwow]:|r GUI еще не загружен. Попробуйте через секунду.")
            C_Timer.After(1, function()
                if NYGiftsUwowGUI and type(NYGiftsUwowGUI.Toggle) == "function" then
                    NYGiftsUwowGUI.Toggle()
                end
            end)
        end
    elseif buttonClicked == "RightButton" then
        -- Показываем справку
        if SlashCmdList["NEWYEARSUWOW"] then
            SlashCmdList["NEWYEARSUWOW"]("help")
        end
    end
end)

button:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText("|cffFF9900New Year's Gifts Uwow|r")
    GameTooltip:AddLine("|cffffff00ЛКМ|r - Открыть статистику")
    GameTooltip:AddLine("|cffffff00ПКМ|r - Показать справку")
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine("|cffaaaaaaНовогодние подарки|r")
    GameTooltip:AddLine("|cffaaaaaaЛегион 7.3.5|r")
    GameTooltip:Show()
end)

button:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

-- Делаем кнопку перемещаемой
button:SetMovable(true)
button:RegisterForDrag("LeftButton")
button:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)

button:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local xpos, ypos = GetCursorPosition()
    local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom()
    xpos = xmin - xpos / UIParent:GetScale() + 70
    ypos = ypos / UIParent:GetScale() - ymin - 70
    button:SetPoint("TOPLEFT", Minimap, "TOPLEFT", xpos, -ypos)
end)

print("|cffFF9900[New Year's Gifts Uwow]:|r Кнопка миникарты создана")