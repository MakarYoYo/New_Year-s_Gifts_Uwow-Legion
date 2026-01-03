-- New_Year's_Gifts_Uwow/Core.lua

-- Простая инициализация
local function Initialize()
    print("|cffFF9900[New Year's Gifts Uwow]:|r Ядро аддона загружено {rt1}")
    return true
end

-- Экспортируем функцию
NYGiftsUwow_Core = {
    Initialize = Initialize
}