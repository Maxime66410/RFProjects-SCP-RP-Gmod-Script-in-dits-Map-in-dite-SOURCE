--[[--------------------------------------------------------------------------
Setup
----------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeHUD.RegisterLanguage ({
	Name = "Ukranian",
	Author = "TheDenVx",
	CompatibleVersion = "1.7.3",
})

--[[--------------------------------------------------------------------------
Phrases - Lower Left
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "IDENTITY", "Ім'я")
EdgeHUD.AddPhrase (LANG, "JOB", "Професія")

--[[--------------------------------------------------------------------------
Phrases - Lower Right
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "SPEEDOMETER_KPH", "КМ/г")
EdgeHUD.AddPhrase (LANG, "SPEEDOMETER_MPH", "МИЛЬ/г")

--TAGS:  %P = Amount of props.
EdgeHUD.AddPhrase (LANG, "PROPLIMIT", "%P пропів")

EdgeHUD.AddPhrase (LANG, "GUNLICENSE", "Ліцензія")

--[[--------------------------------------------------------------------------
Phrases - Top Left
----------------------------------------------------------------------------]]

--TAGS: %V = Number of votes
EdgeHUD.AddPhrase(LANG,"VOTE_QUEUE",nil) --ENGLISH: There are %V items in queue!

EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_VOTE",nil) --ENGLISH: VOTING
EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_QUESTION",nil) --ENGLISH: QUESTION

--TAGS: %T = Time until expiration.
EdgeHUD.AddPhrase(LANG,"VOTE_EXPIRE",nil) --ENGLISH: Expires in %T

EdgeHUD.AddPhrase (LANG, "VOTE_YES", "Так")
EdgeHUD.AddPhrase (LANG, "VOTE_NO", "Ні")

EdgeHUD.AddPhrase(LANG,"VOTE_PENDING",nil) --ENGLISH: [EdgeHUD] You have a new vote/question pending. Take away your tool gun to vote.

--[[--------------------------------------------------------------------------
Phrases - Top right
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "TOPRIGHT_LOCKDOWN_TITLE", "КОМЕНДАНТСЬКА ГОДИНА")
EdgeHUD.AddPhrase (LANG, "TOPRIGHT_LOCKDOWN", "Мер ініціював протокол комендантської години, повертайтеся додому!")

EdgeHUD.AddPhrase (LANG, "TOPRIGHT_WANTED_TITLE", "РОЗШУК")
EdgeHUD.AddPhrase (LANG, "TOPRIGHT_WANTED", "Ви в розшуку! Вас розшукує поліція!")

EdgeHUD.AddPhrase (LANG, "TOPRIGHT_ARRESTED_TITLE", "ЗААРЕШТОВАНО")

--TAGS:  %T = Time until release.
EdgeHUD.AddPhrase (LANG, "TOPRIGHT_ARRESTED", "Ви будете випущені через  %T.")

EdgeHUD.AddPhrase (LANG, "TOPRIGHT_AGENDAHELP", "Введіть /agenda <повідомлення> в чат для редагування завдань.")

--[[--------------------------------------------------------------------------
Phrases - Time
----------------------------------------------------------------------------]]

--TAGS:  %H = Hours,  %M = Minutes
EdgeHUD.AddPhrase (LANG, "TIME_HOUR_MIN", "%H годин і  %M хвилин")

--TAGS:  %M = Minutes,  %S = Seconds
EdgeHUD.AddPhrase (LANG, "TIME_MIN_SEC", "%M хвилин і  %S секунд")

--TAGS:  %S = Seconds
EdgeHUD.AddPhrase (LANG, "TIME_SEC", "%S секунд")

--[[--------------------------------------------------------------------------
Phrases - Arrested
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "ARRESTED", "ЗААРЕШТОВАНО")

--TAGS:  %C = Criminal Name,  %T = Time
EdgeHUD.AddPhrase (LANG, "ARRESTED_COP", "Ви заарештували  %C на  %T.")

--TAGS:  %P = Officer Name,  %T = Time
EdgeHUD.AddPhrase (LANG, "ARRESTED_SUSPECT", "Вас заарештовав  %P на  %T.")
EdgeHUD.AddPhrase (LANG, "ARRESTED_SUSPECT2", "Ви були арештовані на  %T.")

--[[--------------------------------------------------------------------------
Phrases - Released
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "RELEASED", "ВИПУЩЕНИЙ")

--TAGS:  %C = Criminal Name
EdgeHUD.AddPhrase (LANG, "RELEASED_COP", "Ви випустили  %C з в'язниці.")

EdgeHUD.AddPhrase (LANG, "RELEASED_SUSPECT", "Ви були звільнені з в'язниці.")

--[[--------------------------------------------------------------------------
Phrases - Wanted
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "WANTED", "РОЗШУК")

--TAGS:  %C = Criminal Name,  %R = Reason
EdgeHUD.AddPhrase (LANG, "WANTED_COP", "Ви подали  %C в розшук за  %R.")

--TAGS:  %P = Police Name,  %R = Reason
EdgeHUD.AddPhrase (LANG, "WANTED_SUSPECT", "Вас розсшукує  %P за  %R.")
EdgeHUD.AddPhrase (LANG, "WANTED_SUSPECT2", "Ви розушукуєтесь за  %R.")
--[[-------------------------------------------------------------------------
Phrases - Unwanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWANTED", "ЗНЯТ С РОЗШУКУ")
--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase (LANG, "UNWANTED_COP", "Ви зняли статус розшуку з %S.")

EdgeHUD.AddPhrase (LANG, "UNWANTED_SUSPECT", "Ви паче не розшукує поліція.")

--[[--------------------------------------------------------------------------
Phrases - Warranted
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "WARRANTED", "ОРДЕР")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase (LANG, "WARRANTED_COP", "Вам був видаті ордер на %S для обшуку його помешкання.")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase (LANG, "WARRANTED_SUSPECT", "%P отримав ордер на вас за %R.")
EdgeHUD.AddPhrase (LANG, "WARRANTED_SUSPECT2", "На вас був виданий ордер за %R.")

--[[--------------------------------------------------------------------------
Phrases - Unwarranted
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "UNWARRANTED", "ОРДЕР МИНУВ")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase (LANG, "UNWARRANTED_COP", "Ордер на %S закінчився")

EdgeHUD.AddPhrase (LANG, "UNWARRANTED_SUSPECT", "Ваш ордер закінчився.")

--[[--------------------------------------------------------------------------
Phrases - Vehicle Display
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "VEHICLE", "Автомобіль")

--TAGS: %N = Name of owner
EdgeHUD.AddPhrase (LANG, "VEHICLE_OWNER", "Власник: %N")

--TAGS: %G = Groupname
EdgeHUD.AddPhrase (LANG, "VEHICLE_ACCESS_GROUP", "Доступ: %G")

--TAGS: %J = Number of jobs
EdgeHUD.AddPhrase (LANG, "VEHICLE_ACCESS_JOBS", "Доступ: %J профессій")

EdgeHUD.AddPhrase (LANG, "VEHICLE_OWNER_UNKNOWN", "Власник: Невідомо")

EdgeHUD.AddPhrase (LANG, "VEHICLE_NOTOWNABLE", "Неможливо отримати доступ")

EdgeHUD.AddPhrase (LANG, "VEHICLE_UNOWNED", "Нічийний")

EdgeHUD.AddPhrase (LANG, "VEHICLE_COOWNERS", "Співвласники:")

EdgeHUD.AddPhrase (LANG, "VEHICLE_ALLOWED_COOWNERS", "Дозволені Співвласники:")

--[[--------------------------------------------------------------------------
Phrases - Door Display
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "DOOR_SOLD", "Продати двері")
EdgeHUD.AddPhrase (LANG, "DOOR_FORSALE", "Продається")
EdgeHUD.AddPhrase (LANG, "DOOR_F2PURCHASE", "Натисніть F2 для покупки двері")

EdgeHUD.AddPhrase (LANG, "DOOR_COOWNERS", "Співвласники:")
EdgeHUD.AddPhrase (LANG, "DOOR_ALLOWED_COOWNERS", "Дозволені Співвласники:")

--TAGS: %G = Name of group.
EdgeHUD.AddPhrase (LANG, "DOOR_GROUP_TITLE", "Групові двері")
EdgeHUD.AddPhrase (LANG, "DOOR_ACCESS_GROUP", "Доступ: %G")

--TAGS: %J = Number of jobs.
EdgeHUD.AddPhrase (LANG, "DOOR_TEAM_TITLE", "Двері Команди")
EdgeHUD.AddPhrase (LANG, "DOOR_ACCESS_TEAM", "Доступ: %J роботи")

--TAGS: %N = Name of owner.
EdgeHUD.AddPhrase (LANG, "DOOR_OWNER", "Власник: %N")

EdgeHUD.AddPhrase (LANG, "DOOR_OWNER_UNKNOWN", "Власник: Невідомо")

--[[--------------------------------------------------------------------------
Phrases - Situations
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "LOCKDOWN", "Комендантська година")

EdgeHUD.AddPhrase (LANG, "LOCKDOWN_INITIATED", "Мер ініціював протокол комендантської години, повертайтеся додому!")
--[[-------------------------------------------------------------------------
Phrases - Door Menu
---------------------------------------------------------------------------]]
EdgeHUD.AddPhrase (LANG, "DOORMENU_BUY_DOOR", "Купити двері")
EdgeHUD.AddPhrase (LANG, "DOORMENU_BUY_VEHICLE", "Купити транспорт")

EdgeHUD.AddPhrase (LANG, "DOORMENU_SELL_DOOR", "Продати двері")
EdgeHUD.AddPhrase (LANG, "DOORMENU_SELL_VEHICLE", "Продати транспорт")

EdgeHUD.AddPhrase (LANG, "DOORMENU_ADDOWNER", "Додати власника")
EdgeHUD.AddPhrase (LANG, "DOORMENU_REMOVEOWNER", "Видалити власника")

EdgeHUD.AddPhrase (LANG, "DOORMENU_ALLOWOWNERSHIP", "Дозволити володіння")
EdgeHUD.AddPhrase (LANG, "DOORMENU_DISALLOWOWNERSHIP", "Заборонити володіння")

EdgeHUD.AddPhrase (LANG, "DOORMENU_SETTITLE_DOOR", "Встановити титулку на двері")
EdgeHUD.AddPhrase (LANG, "DOORMENU_SETTITLE_VEHICLE", "Встановити титулку на транспорт")

EdgeHUD.AddPhrase (LANG, "DOORMENU_EDITGROUPS", "Редагувати дступ групи")

--[[--------------------------------------------------------------------------
Phrases - Crash Screen
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "CRASHSCREEN_TITLE", "З'єднання втрачено")
EdgeHUD.AddPhrase (LANG, "CRASHSCREEN_TEXT1", "Схоже, з'єднання з сервером було перервано.")
EdgeHUD.AddPhrase (LANG, "CRASHSCREEN_TEXT2", "Будь ласка, зачекайте, поки ми намагаємося встановити нове з'єднання.")

EdgeHUD.AddPhrase (LANG, "CRASHSCREEN_RECONNECT", "Перепідключитися")
EdgeHUD.AddPhrase (LANG, "CRASHSCREEN_LEAVE", "Вихід")

--[[--------------------------------------------------------------------------
Phrases - Gesture Menu
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "GESTURE_BOW", "Лук")
EdgeHUD.AddPhrase (LANG, "GESTURE_SEXYDANCE", "Сексуальний танець")
EdgeHUD.AddPhrase (LANG, "GESTURE_FOLLOWME", "За мною")
EdgeHUD.AddPhrase (LANG, "GESTURE_LAUGH", "Сміх")
EdgeHUD.AddPhrase (LANG, "GESTURE_LIONPOSE", "Поза лева")
EdgeHUD.AddPhrase (LANG, "GESTURE_NONVERBALNO", "НІ!")
EdgeHUD.AddPhrase (LANG, "GESTURE_THUMBSUP", "Ні-ні")
EdgeHUD.AddPhrase (LANG, "GESTURE_WAVE", "Хвиля")
EdgeHUD.AddPhrase (LANG, "GESTURE_DANCE", "Танець")

--[[--------------------------------------------------------------------------
Phrases - Vehicle warnings HUD.
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "VEHICLE_DMG_EXTERIORLIGHT", "[Транспорт]: Фара була розбита. Перевірте фари перед тим як почати рух.")
EdgeHUD.AddPhrase (LANG, "VEHICLE_DMG_EXHAUST", "[Транспорт]: Вихлопна система була пошкоджена. Відвідайте механіка.")
EdgeHUD.AddPhrase (LANG, "VEHICLE_DMG_ENGINE", "[Транспорт]: Двигун був пошкоджений. Відвідайте механіка для запобігання загоряння.")

EdgeHUD.AddPhrase (LANG, "VEHICLE_DMG_TIRE_FRONTLEFT", "Переднє ліве")
EdgeHUD.AddPhrase (LANG, "VEHICLE_DMG_TIRE_FRONTRIGHT", "Переднє праве")
EdgeHUD.AddPhrase (LANG, "VEHICLE_DMG_TIRE_BACKLEFT", "Заднє ліве")
EdgeHUD.AddPhrase (LANG, "VEHICLE_DMG_TIRE_BACKRIGHT", "Заднє праве")

--TAGS:%T = Damaged tires.
EdgeHUD.AddPhrase (LANG, "VEHICLE_DMG_TIRES", "[Транспорт]: Було спущено (%T) колесо.")

--[[--------------------------------------------------------------------------
Phrases - Battery Notifications.
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "CHARGER_CONNECTED", "Зарядний пристрій підключено")
EdgeHUD.AddPhrase (LANG, "CHARGER_DISCONNECTED", "Зарядний пристрій відключено")
EdgeHUD.AddPhrase (LANG, "BATTERY_STATUS", "Статус заряду")

EdgeHUD.AddPhrase (LANG, "CHARGING_STARTED", "Ваш ноутбук заряджається.")
EdgeHUD.AddPhrase (LANG, "CHARGING_ABORTED", "Ваш ноутбук паче не аряжается.")

--TAGS:%B = Battery precentage left.
EdgeHUD.AddPhrase (LANG, "BATTERY_NOTICE", "Ваш заряд батареї в даний момент %B%. Підключіть зарядний пристрій, щоб продовжити гру.")

--[[--------------------------------------------------------------------------
Phrases - Level bar
----------------------------------------------------------------------------]]

--TAGS:%L = Current Level,%P = Percentage to next level
EdgeHUD.AddPhrase (LANG, "LEVELBAR", "Рівень %L - %P%")

--[[--------------------------------------------------------------------------
Phrases - AdminTell
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "ADMINTELL_TITLE", "АДМИН ПОВІДОМЛЕННЯ")
EdgeHUD.AddPhrase (LANG, "ADMINTELL_NOMSG", "Ні повідомлень")


--[[--------------------------------------------------------------------------
Phrases - General
----------------------------------------------------------------------------]]

EdgeHUD.AddPhrase (LANG, "CLOSE", "Закрити")