-- New_Year's_Gifts_Uwow/MapIdTables.lua

local MapIdTables = {}

-- ID предмета подарка
MapIdTables.GIFT_ITEM_ID = 290045

-- Таблица с локациями, координатами и ID зон
MapIdTables.locationData = {
    -- Legion Zones
    ["Azsuna"] = {
        x = 61.0, y = 67.9, 
        name = "Азсуна",
        zoneId = 1015
    },
    ["Valsharah"] = {
        x = 54.3, y = 81.8, 
        name = "Вал'шара",
        zoneId = 1018
    },
    ["Highmountain"] = {
        x = 59.7, y = 47.8, 
        name = "Крутогорье",
        zoneId = 1024
    },
    ["Stormheim"] = {
        x = 82.6, y = 9.1, 
        name = "Штормхейм",
        zoneId = 1017
    },
    ["Suramar"] = {
        x = 42.6, y = 67.0, 
        name = "Сурамар",
        zoneId = 1033
    },
    ["BrokenShore"] = {
        x = 61.4, y = 33.4, 
        name = "Расколотый берег",
        zoneId = 1021
    },
    -- Draenor Zones
    ["ShadowmoonValleyDR"] = {
        x = 61.4, y = 88.6, 
        name = "Долина призрачной Луны (Дренор)",
        zoneId = 539
    },
    ["SpiresOfArak"] = {
        x = 56.8, y = 89.7, 
        name = "Пики Арака",
        zoneId = 542
    },
    ["Talador"] = {
        x = 33.8, y = 47.0, 
        name = "Таладор",
        zoneId = 535
    },
    ["NagrandDraenor"] = {
        x = 39.0, y = 33.4, 
        name = "Награнд (Дренор)",
        zoneId = 550
    },
    ["FrostfireRidge"] = {
        x = 54.4, y = 66.1, 
        name = "Хребет Ледяного Огня",
        zoneId = 525
    },
    ["TanaanJungle"] = {
        x = 41.2, y = 75.0, 
        name = "Танаанские джунгли",
        zoneId = 534
    },
    ["Gorgrond"] = {
        x = 51.1, y = 33.3, 
        name = "Горгронд",
        zoneId = 543
    },
    -- Kalimdor
    ["Durotar"] = {
        x = 35, y = 51, 
        name = "Дуротар",
        zoneId = 1411
    },
    ["Winterspring"] = {
        x = 49, y = 37, 
        name = "Зимние Ключи",
        zoneId = 618
    },
    ["Tanaris"] = {
        x = 74, y = 45, 
        name = "Танарис",
        zoneId = 1446
    },
    ["ThousandNeedles"] = {
        x = 74, y = 49, 
        name = "Тысяча Игл",
        zoneId = 1441
    },
    ["Barrens"] = {
        x = 61, y = 49, 
        name = "Северные Степи",
        zoneId = 1413
    },
    ["Feralas"] = {
        x = 61, y = 30, 
        name = "Фералас",
        zoneId = 1444
    },
    ["Darkshore"] = {
        x = 39, y = 62, 
        name = "Темный берег",
        zoneId = 1439
    },
    ["UngoroCrater"] = {
        x = 49, y = 48, 
        name = "Кратер Ун'Горо",
        zoneId = 1449
    },
    ["Silithus"] = {
        x = 37, y = 75, 
        name = "Силитус",
        zoneId = 1451
    },
    ["Felwood"] = {
        x = 44, y = 70, 
        name = "Оскверненный лес",
        zoneId = 1448
    },
    ["Desolace"] = {
        x = 36, y = 30, 
        name = "Пустоши",
        zoneId = 1443
    },
    ["Ashenvale"] = {
        x = 49, y = 50, 
        name = "Ясеневый лес",
        zoneId = 1440
    },
    ["Moonglade"] = {
        x = 55, y = 65, 
        name = "Лунная поляна",
        zoneId = 1450
    },
    ["Mulgore"] = {
        x = 56, y = 30, 
        name = "Мулгор",
        zoneId = 1412
    },
    ["Uldum"] = {
        x = 64, y = 20, 
        name = "Ульдум",
        zoneId = 1527
    },
    ["Hyjal"] = {
        x = 18, y = 35, 
        name = "Хиджал",
        zoneId = 616
    },
    ["Aszhara"] = {
        x = 55, y = 46, 
        name = "Азшара",
        zoneId = 1447
    },
    ["SouthernBarrens"] = {
        x = 45, y = 35, 
        name = "Южные степи",
        zoneId = 1419
    },
    ["Dustwallow"] = {
        x = 47, y = 50, 
        name = "Пылевые топи",
        zoneId = 1445
    },
    ["Teldrassil"] = {
        x = 45, y = 22, 
        name = "Тельдрассил",
        zoneId = 1438
    },
    ["StonetalonMountains"] = {
        x = 38, y = 63, 
        name = "Когтистые горы",
        zoneId = 1442
    },
    -- Eastern Kingdoms
    ["BloodmystIsle"] = {
        x = 67, y = 71, 
        name = "Остров Кровавой Дымки",
        zoneId = 1453
    },
    ["AzuremystIsle"] = {
        x = 36, y = 60, 
        name = "Остров Лазурной Дымки",
        zoneId = 1454
    },
    ["TheCapeOfStranglethorn"] = {
        x = 54, y = 31, 
        name = "Тернистая долина",
        zoneId = 1434
    },
    ["BurningSteppes"] = {
        x = 44, y = 40, 
        name = "Пылающие степи",
        zoneId = 1428
    },
    ["Duskwood"] = {
        x = 25, y = 34, 
        name = "Сумеречный лес",
        zoneId = 1431
    },
    ["BlastedLands"] = {
        x = 39, y = 60, 
        name = "Выжженные земли",
        zoneId = 1418
    },
    ["DeadwindPass"] = {
        x = 48, y = 68, 
        name = "Перевал Мертвого Ветра",
        zoneId = 1430
    },
    ["Westfall"] = {
        x = 26, y = 17, 
        name = "Западный Край",
        zoneId = 1436
    },
    ["SwampOfSorrows"] = {
        x = 32, y = 50, 
        name = "Болото Печали",
        zoneId = 1435
    },
    ["Elwynn"] = {
        x = 71, y = 81, 
        name = "Элвинн",
        zoneId = 1429
    },
    ["Redridge"] = {
        x = 40, y = 35, 
        name = "Красногорье",
        zoneId = 1433
    },
    ["Badlands"] = {
        x = 44, y = 49, 
        name = "Бесплодные земли",
        zoneId = 1417
    },
    ["Wetlands"] = {
        x = 44, y = 25, 
        name = "Болотина",
        zoneId = 1437
    },
    ["SearingGorge"] = {
        x = 42, y = 37, 
        name = "Тлеющее ущелье",
        zoneId = 1427
    },
    ["LochModan"] = {
        x = 47, y = 45, 
        name = "Лок Модан",
        zoneId = 1432
    },
    ["DunMorogh"] = {
        x = 77, y = 57, 
        name = "Дун Морог",
        zoneId = 1426
    },
    ["TwilightHighlands"] = {
        x = 63, y = 77, 
        name = "Сумеречное нагорье",
        zoneId = 1613
    },
    ["Arathi"] = {
        x = 56, y = 33, 
        name = "Арати",
        zoneId = 1416
    },
    ["Hinterlands"] = {
        x = 86, y = 59, 
        name = "Внутренние земли",
        zoneId = 1425
    },
    ["HillsbradFoothills"] = {
        x = 33, y = 34, 
        name = "Предгорья Хилсбрада",
        zoneId = 1424
    },
    ["Silverpine"] = {
        x = 63, y = 63, 
        name = "Серебряный бор",
        zoneId = 1421
    },
    ["Tirisfal"] = {
        x = 50, y = 29, 
        name = "Тирисфальские леса",
        zoneId = 1420
    },
    ["WesternPlaguelands"] = {
        x = 63, y = 60, 
        name = "Западные Чумные земли",
        zoneId = 1422
    },
    ["EasternPlaguelands"] = {
        x = 37, y = 45, 
        name = "Восточные Чумные земли",
        zoneId = 1423
    },
    ["Ghostlands"] = {
        x = 59, y = 13, 
        name = "Призрачные земли",
        zoneId = 1942
    },
    ["Sunwell"] = {
        x = 43, y = 39, 
        name = "Солнечный Колодец",
        zoneId = 1945
    },
    ["EversongWoods"] = {
        x = 68, y = 51, 
        name = "Леса Вечной Песни",
        zoneId = 1941
    },
    ["VashjirDepths"] = {
        x = 69, y = 28, 
        name = "Глубины Вайш'ир",
        zoneId = 5145
    },
    -- Northrend
    ["CrystalsongForest"] = {
        x = 19, y = 16, 
        name = "Лес Хрустальной Песни",
        zoneId = 2817
    },
    ["IcecrownGlacier"] = {
        x = 64, y = 22, 
        name = "Ледяная Корона",
        zoneId = 210
    },
    ["SholazarBasin"] = {
        x = 44, y = 78, 
        name = "Низина Шолазар",
        zoneId = 3711
    },
    ["BoreanTundra"] = {
        x = 85, y = 29, 
        name = "Борейская тундра",
        zoneId = 3537
    },
    ["Dragonblight"] = {
        x = 57, y = 35, 
        name = "Драконий Погост",
        zoneId = 65
    },
    ["TheStormPeaks"] = {
        x = 43, y = 82, 
        name = "Грозовая гряда",
        zoneId = 67
    },
    ["ZulDrak"] = {
        x = 28, y = 46, 
        name = "Зул'Драк",
        zoneId = 66
    },
    ["GrizzlyHills"] = {
        x = 62, y = 42, 
        name = "Седые холмы",
        zoneId = 394
    },
    ["HowlingFjord"] = {
        x = 31, y = 26, 
        name = "Ревущий фьорд",
        zoneId = 495
    },
    -- Outland
    ["Zangarmarsh"] = {
        x = 69, y = 44, 
        name = "Зангартопь",
        zoneId = 3521
    },
    ["Nagrand"] = {
        x = 59, y = 23, 
        name = "Награнд",
        zoneId = 3518
    },
    ["ShadowmoonValley"] = {
        x = 40, y = 23, 
        name = "Долина Призрачной Луны",
        zoneId = 3520
    },
    ["Hellfire"] = {
        x = 45, y = 50, 
        name = "Полуостров Адского Пламени",
        zoneId = 3483
    },
    ["TerokkarForest"] = {
        x = 71.5, y = 37.1, 
        name = "Лес Тероккар",
        zoneId = 3519
    },
    ["BladesEdgeMountains"] = {
        x = 41, y = 18, 
        name = "Острогорье",
        zoneId = 3522
    },
    ["Netherstorm"] = {
        x = 58, y = 42, 
        name = "Пустоверть",
        zoneId = 3523
    },
    -- Pandaria
    ["TownlongWastes"] = {
        x = 71, y = 56, 
        name = "Танлунские степи",
        zoneId = 6006
    },
    ["KunLaiSummit"] = {
        x = 76, y = 9, 
        name = "Вершина Кунь-Лай",
        zoneId = 5841
    },
    ["ValeofEternalBlossoms"] = {
        x = 21, y = 69, 
        name = "Вечноцветущий дол",
        zoneId = 5840
    },
    ["DreadWastes"] = {
        x = 39, y = 23, 
        name = "Жуткие пустоши",
        zoneId = 6134
    },
    ["Krasarang"] = {
        x = 76, y = 8, 
        name = "Красарангские джунгли",
        zoneId = 6138
    },
    ["TimelessIsle"] = {
        x = 21, y = 58, 
        name = "Вневременной остров",
        zoneId = 5545
    },
    ["ValleyoftheFourWinds"] = {
        x = 76, y = 26, 
        name = "Долина Четырех Ветров",
        zoneId = 5805
    },
    ["TheJadeForest"] = {
        x = 35, y = 30, 
        name = "Нефритовый лес",
        zoneId = 5785
    },
}

-- Функция для получения данных о локации по имени зоны
function MapIdTables.GetLocationData(zoneName)
    return MapIdTables.locationData[zoneName]
end

-- Функция для получения ID зоны по имени
function MapIdTables.GetZoneId(zoneName)
    local data = MapIdTables.locationData[zoneName]
    return data and data.zoneId or nil
end

-- Функция для получения всех зон
function MapIdTables.GetAllZones()
    return MapIdTables.locationData
end

-- Функция для получения количества зон
function MapIdTables.GetZoneCount()
    local count = 0
    for _ in pairs(MapIdTables.locationData) do
        count = count + 1
    end
    return count
end

-- Функция для получения зон по континенту/группе
function MapIdTables.GetZonesByCategory(category)
    local categories = {
        legion = {"Azsuna", "Valsharah", "Highmountain", "Stormheim", "Suramar", "BrokenShore"},
        draenor = {"ShadowmoonValleyDR", "SpiresOfArak", "Talador", "NagrandDraenor", "FrostfireRidge", "TanaanJungle", "Gorgrond"},
        kalimdor = {"Durotar", "Winterspring", "Tanaris", "ThousandNeedles", "Barrens", "Feralas", "Darkshore", "UngoroCrater", 
                   "Silithus", "Felwood", "Desolace", "Ashenvale", "Moonglade", "Mulgore", "Uldum", "Hyjal", "Aszhara", 
                   "SouthernBarrens", "Dustwallow", "Teldrassil", "StonetalonMountains"},
        eastern_kingdoms = {"BloodmystIsle", "AzuremystIsle", "TheCapeOfStranglethorn", "BurningSteppes", "Duskwood", 
                           "BlastedLands", "DeadwindPass", "Westfall", "SwampOfSorrows", "Elwynn", "Redridge", "Badlands", 
                           "Wetlands", "SearingGorge", "LochModan", "DunMorogh", "TwilightHighlands", "Arathi", "Hinterlands", 
                           "HillsbradFoothills", "Silverpine", "Tirisfal", "WesternPlaguelands", "EasternPlaguelands", 
                           "Ghostlands", "Sunwell", "EversongWoods", "VashjirDepths"},
        northrend = {"CrystalsongForest", "IcecrownGlacier", "SholazarBasin", "BoreanTundra", "Dragonblight", 
                    "TheStormPeaks", "ZulDrak", "GrizzlyHills", "HowlingFjord"},
        outland = {"Zangarmarsh", "Nagrand", "ShadowmoonValley", "Hellfire", "TerokkarForest", "BladesEdgeMountains", "Netherstorm"},
        pandaria = {"TownlongWastes", "KunLaiSummit", "ValeofEternalBlossoms", "DreadWastes", "Krasarang", 
                   "TimelessIsle", "ValleyoftheFourWinds", "TheJadeForest"}
    }
    
    if categories[category] then
        local result = {}
        for _, zoneKey in ipairs(categories[category]) do
            if MapIdTables.locationData[zoneKey] then
                result[zoneKey] = MapIdTables.locationData[zoneKey]
            end
        end
        return result
    end
    return nil
end

-- Экспортируем таблицу
NYGiftsUwow_MapIdTables = MapIdTables