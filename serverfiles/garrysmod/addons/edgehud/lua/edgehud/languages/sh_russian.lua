--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeHUD.RegisterLanguage({
	Name = "Russian",
	Author = "TheDenVx & Jeremyarcher50",
	CompatibleVersion = "1.7.3",
})

--[[-------------------------------------------------------------------------
Phrases - Lower Left
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"IDENTITY", "Имя")
EdgeHUD.AddPhrase(LANG,"JOB", "Профессия")

--[[-------------------------------------------------------------------------
Phrases - Lower Right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_KPH","КМ/ч")
EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_MPH","МИЛЬ/ч")

--TAGS: %P = Amount of props.
EdgeHUD.AddPhrase(LANG,"PROPLIMIT","Пропы: %P")

EdgeHUD.AddPhrase(LANG,"GUNLICENSE","Лицензия")

--[[-------------------------------------------------------------------------
Phrases - Top Left
---------------------------------------------------------------------------]]

--TAGS: %V = Number of votes
EdgeHUD.AddPhrase(LANG,"VOTE_QUEUE","В очереди %V голосований!")

EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_VOTE",nil) --ENGLISH: VOTING
EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_QUESTION",nil) --ENGLISH: QUESTION

--TAGS: %T = Time until expiration.
EdgeHUD.AddPhrase(LANG,"VOTE_EXPIRE","Истекает через %T")

EdgeHUD.AddPhrase(LANG,"VOTE_YES","Да")
EdgeHUD.AddPhrase(LANG,"VOTE_NO","Нет")

EdgeHUD.AddPhrase(LANG,"VOTE_PENDING",nil) --ENGLISH: [EdgeHUD] You have a new vote/question pending. Take away your tool gun to vote.

--[[-------------------------------------------------------------------------
Phrases - Top right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN_TITLE","КОМЕНДАНТСКИЙ ЧАС")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN","Мэр инициировал протокол комендантского часа, возвращайтесь домой!")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED_TITLE","РОЗЫСК")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED","Вы в розыске! Вас разыскивает полиция!")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED_TITLE","АРЕСТОВАН")

--TAGS: %T = Time until release.
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED","Вы будете выпущены через %T.")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_AGENDAHELP","Введите /agenda <сообщение> в чат для редактирования заданий.")

--[[-------------------------------------------------------------------------
Phrases - Time
---------------------------------------------------------------------------]]

--TAGS: %H = Hours, %M = Minutes
EdgeHUD.AddPhrase(LANG,"TIME_HOUR_MIN","%H часов и %M минут")

--TAGS: %M = Minutes, %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_MIN_SEC","%M минут и %S секунд")

--TAGS: %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_SEC","%S секунд")

--[[-------------------------------------------------------------------------
Phrases - Arrested
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ARRESTED", "АРЕСТОВАН")

--TAGS: %C = Criminal Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_COP", "Вы арестовали %C на %T.")

--TAGS: %P = Officer Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT", "Вы были арестованы %P на %T.")
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT2", "Вы были арестованы на %T.")

--[[-------------------------------------------------------------------------
Phrases - Released
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"RELEASED", "ВЫПУЩЕН")

--TAGS: %C = Criminal Name
EdgeHUD.AddPhrase(LANG,"RELEASED_COP", "Вы выпустили %C из тюрьмы.")

EdgeHUD.AddPhrase(LANG,"RELEASED_SUSPECT", "Вы были освобождены из тюрьмы.")

--[[-------------------------------------------------------------------------
Phrases - Wanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WANTED", "РОЗЫСК")

--TAGS: %C = Criminal Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_COP", "Вы подали %C в розыск за %R.")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT", "Вы розыскиваетесь %P за %R.")
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT2", "Вы разыскиваетесь за %R.")

--[[-------------------------------------------------------------------------
Phrases - Unwanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWANTED", "СНЯТ С РОЗЫСКА")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWANTED_COP", "Вы сняли статус розыска с %S.")

EdgeHUD.AddPhrase(LANG,"UNWANTED_SUSPECT", "Вы более не разыскиваетесь полицией.")

--[[-------------------------------------------------------------------------
Phrases - Warranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WARRANTED", "ОРДЕР")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"WARRANTED_COP", "Вам был выдат ордер на %S для обыска его помещения.")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT", "%P получил ордер на вас за %R.")
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT2", "На вас был выдан ордер за %R.")

--[[-------------------------------------------------------------------------
Phrases - Unwarranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWARRANTED", "ОРДЕР ИСТЕК")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWARRANTED_COP", "Ордер на %S истек")

EdgeHUD.AddPhrase(LANG,"UNWARRANTED_SUSPECT", "Ваш ордер истек.")

--[[-------------------------------------------------------------------------
Phrases - Vehicle Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE", "Автомобиль")

--TAGS: %N = Name of owner
EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER", "Владелец: %N")

--TAGS: %G = Groupname
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_GROUP", "Доступ: %G")

--TAGS: %J = Number of jobs
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_JOBS", "Доступ: %J профессий")

EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER_UNKNOWN", "Владелец: Неизвестно")

EdgeHUD.AddPhrase(LANG,"VEHICLE_NOTOWNABLE", "Нет доступа")

EdgeHUD.AddPhrase(LANG,"VEHICLE_UNOWNED", "Бесхозный")

EdgeHUD.AddPhrase(LANG,"VEHICLE_COOWNERS", "Совладельцы:")

EdgeHUD.AddPhrase(LANG,"VEHICLE_ALLOWED_COOWNERS", "Разрешенные Совладельцы:")

--[[-------------------------------------------------------------------------
Phrases - Door Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOOR_SOLD", "Продать дверь")
EdgeHUD.AddPhrase(LANG,"DOOR_FORSALE", "Продается")
EdgeHUD.AddPhrase(LANG,"DOOR_F2PURCHASE", "F2 чтобы купить")

EdgeHUD.AddPhrase(LANG,"DOOR_COOWNERS", "Совладельцы:")
EdgeHUD.AddPhrase(LANG,"DOOR_ALLOWED_COOWNERS", "Разрешенные Совладельцы:")

--TAGS: %G = Name of group.
EdgeHUD.AddPhrase(LANG,"DOOR_GROUP_TITLE", "Группа")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_GROUP", "Доступ: %G")

--TAGS: %J = Number of jobs.
EdgeHUD.AddPhrase(LANG,"DOOR_TEAM_TITLE", "Профессии")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_TEAM", "Доступ: %J работы")

--TAGS: %N = Name of owner.
EdgeHUD.AddPhrase(LANG,"DOOR_OWNER", "Владелец: %N")

EdgeHUD.AddPhrase(LANG,"DOOR_OWNER_UNKNOWN", "Владелец: Неизветсно")

--[[-------------------------------------------------------------------------
Phrases - Situations
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"LOCKDOWN", "КОМЕНДАНТСКИЙ ЧАС")

EdgeHUD.AddPhrase(LANG,"LOCKDOWN_INITIATED", "Мэр инициировал протокол комендантского часа, возвращайтесь домой!")

--[[-------------------------------------------------------------------------
Phrases - Door Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_DOOR", "Купить дверь")
EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_VEHICLE", "Купить транспорт")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_DOOR", "Продать дверь")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_VEHICLE", "Продать транспорт")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ADDOWNER", "Добавить владельца")
EdgeHUD.AddPhrase(LANG,"DOORMENU_REMOVEOWNER", "Удалить владельца")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ALLOWOWNERSHIP", "Разрешить владение")
EdgeHUD.AddPhrase(LANG,"DOORMENU_DISALLOWOWNERSHIP", "Запретить владение")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_DOOR", "Установить название")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_VEHICLE", "Установить название")

EdgeHUD.AddPhrase(LANG,"DOORMENU_EDITGROUPS", "Доступ группы")

--[[-------------------------------------------------------------------------
Phrases - Crash Screen
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TITLE", "Соединение потеряно")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT1", "Похоже, соединение с сервером было прервано.")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT2", "Пожалуйста, подождите, пока мы пытаемся установить новое соединение.")

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_RECONNECT", "Переподключится")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_LEAVE", "Выход")

--[[-------------------------------------------------------------------------
Phrases - Gesture Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"GESTURE_BOW", "Лук")
EdgeHUD.AddPhrase(LANG,"GESTURE_SEXYDANCE", "Сексуальный танец")
EdgeHUD.AddPhrase(LANG,"GESTURE_FOLLOWME", "За мной")
EdgeHUD.AddPhrase(LANG,"GESTURE_LAUGH", "Смех")
EdgeHUD.AddPhrase(LANG,"GESTURE_LIONPOSE", "Поза льва")
EdgeHUD.AddPhrase(LANG,"GESTURE_NONVERBALNO", "НЕТ!")
EdgeHUD.AddPhrase(LANG,"GESTURE_THUMBSUP", "Не-а")
EdgeHUD.AddPhrase(LANG,"GESTURE_WAVE", "Волна")
EdgeHUD.AddPhrase(LANG,"GESTURE_DANCE", "Танец")

--[[-------------------------------------------------------------------------
Phrases - Vehicle warnings HUD.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXTERIORLIGHT", "[Транспорт] : Фара была разбита. Проверьте фары перед тем как начать движение.")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXHAUST", "[Транспорт] : Выхлопная система была повреждена. Посетите механика.")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_ENGINE", "[Транспорт] : Двигатель был поврежден. Посетите механика для предотвращения возгорания.")

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTLEFT", "Переднее левое")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTRIGHT", "Переднее правое")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKLEFT", "Заднее левое")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKRIGHT", "Заднее правое")

--TAGS: %T = Damaged tires.
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRES", "[Транспорт] : Было спущено (%T) колесо.")

--[[-------------------------------------------------------------------------
Phrases - Battery Notifications.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CHARGER_CONNECTED", "Зарядное устройство подключено")
EdgeHUD.AddPhrase(LANG,"CHARGER_DISCONNECTED", "Зарядное устройство отключено")
EdgeHUD.AddPhrase(LANG,"BATTERY_STATUS", "Статус заряда")

EdgeHUD.AddPhrase(LANG,"CHARGING_STARTED", "Ваш ноутбук заряжается.")
EdgeHUD.AddPhrase(LANG,"CHARGING_ABORTED", "Ваш ноутбук более не аряжается.")

--TAGS: %B = Battery precentage left.
EdgeHUD.AddPhrase(LANG,"BATTERY_NOTICE", "Ваш заряд батареи в данный момент %B%. Подключите зарядное устройство, чтобы продолжить игру.")

--[[-------------------------------------------------------------------------
Phrases - Level bar
---------------------------------------------------------------------------]]

--TAGS: %L = Current Level, %P = Percentage to next level
EdgeHUD.AddPhrase(LANG,"LEVELBAR", "Уровень %L - %P%")

--[[-------------------------------------------------------------------------
Phrases - AdminTell
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ADMINTELL_TITLE", "АДМИН УВЕДОМЛЕНИЕ")
EdgeHUD.AddPhrase(LANG,"ADMINTELL_NOMSG", "Нет сообщений")


--[[-------------------------------------------------------------------------
Phrases - General
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CLOSE","Закрыть")