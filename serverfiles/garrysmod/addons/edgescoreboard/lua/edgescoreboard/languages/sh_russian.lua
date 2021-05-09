--[[-------------------------------------------------------------------------
Настройки
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeScoreboard.RegisterLanguage({
	Name = "Russian",
	Author = "RaCc0oN",
	CompatibleVersion = "1.5.2",
})

--[[-------------------------------------------------------------------------
Левая Панель
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_PLAYERS", "Игроки")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SERVERS", "Сервера")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WEBSITE", "Веб-сайт")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_DONATE", "Донат")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_UTILITIES", "Доп. Возможности")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WORKSHOP", "Контент")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_REQUESTSTAFF", "Вызвать Админа")

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SEARCHFIELD", "Поиск")

EdgeScoreboard.AddPhrase(LANG,"WEBSITE_URL_COPIED", "Ссылка была скопирована в ваш буфер обмена.")

--[[-------------------------------------------------------------------------
Статистика
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_SERVER", "Статистика Сервера")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLYCOUNT", "Количество Игроков")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_STAFF", "Админов Онлайн")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_UPTIME", "Провел")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_AVGPING", "Средний пинг")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_GAME", "Игровая Статистика")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLAYTIME", "Отыгранное время")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_SESSION", "Сессия")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PING", "Пинг")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT", "Количество Игроков")
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT_SUFFIX", "3ч") -- Stands for 3 hours
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_LOWEST", "Минимум")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_HIGHEST", "Максимум")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_AVERAGE", "Средний")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_CURRENT", "Сейчас")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD", "У/С") -- Соотношение убийств и смертей 
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD_SUFFIX", "1ч") -- Стоит на 1 час
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_KILLS", "Убийств")
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_DEATHS", "Смерти")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS", "FPS") -- Стоит для (FPS) "Frames Per Second"
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS_SUFFIX", "30м") -- Стоит 30 минут
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_KILLS", "FPS")
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_DEATHS", "Сред. FPS") -- Стоит для "Среднего FPS"

--[[-------------------------------------------------------------------------
Вкладка Сервера
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SERVERS_MAP_PREFIX", "Карта")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_GM_PREFIX", "Режим")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_PS_PREFIX", "Количество Игроков")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_IP_PREFIX", "IP адрес")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD", "Нет дополнительных серверов")
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD_SUBTIT", "Кажется, что разработчик этого сервера не добавил никаких дополнительных серверов.")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_CONNECT", "Подключиться")

-- TAGS: %S = Имя сервера или IP
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_VERIFY_CONNECT", "Вы уверены, что хотите подключиться к %S?")

--[[-------------------------------------------------------------------------
Вкладка Игрока
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PING", "Пинг")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_DEATHS", "Смертей")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KILLS", "Убийств")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_SCORE", "Счет")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KARMA", "Карма")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PLAYTIME", "Отыгранное время")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_NAME", "Имя")

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_RANK", "Ранг")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_JOB", nil) -- English: Job
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_LEVEL", nil) -- English: Level
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_WALLET", nil) -- English: Money
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_STATUS", nil) -- English: Status

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_WANTED", nil) -- English: Wanted
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ARRESTED", nil) -- English: Arrested
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ALIVE", nil) -- English: Alive 
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_DEAD", nil) -- English: Dead

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_MURDER_JOINTEAM", "Подключиться")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_COPIED", "Информация была скопирована в ваш буфер обмена.")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAM", "Зайти в профиль")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_MUTE", "Запретить писать в чат")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_UNMUTE", "Разрешить писать в чат")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_INFO", "Информация")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_USERNAME", "Скопировать Имя")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_GROUP", "Скопировать Ранг")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TEAM", "Скопировать Профессию")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID", "Скопировать SteamID")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID64", "Скопировать SteamID64")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TRANSFER", "Перенаправить игрока")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP", "Введите IP")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP_LONG", "Введите IP-адрес и порт сервера, к которому вы хотите подключить этого игрока.")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_INVALIDIP", "Введенный вами IP-адрес не является действительным.")

-- Tags: %N = Имя сервера
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_VERIFY", "Вы уверены, что хотите перенаправить этого игрока на %N?")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_RANK_NONE", "Никто")

-- Tags: %M = Number (Money)
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_THOUSAND", nil) -- English: %MK
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_MILLION", nil) -- English: %MM
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_BILLION", nil) -- English: %MB

--[[-------------------------------------------------------------------------
Специальные возможности администратора
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOTO", "К нему")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BRING", "К себе")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_RETURN", "Вернуть")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETTEAM", "Выдать профессию")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGFREEZE", "Заморозить")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_FREEZE", "Заморозить")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNFREEZE", "Разморозить")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BAN", "Бан")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_KICK", "Кик")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGJAIL", "Посадить в тюрьму")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_JAIL", "Посадить в тюрьму")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNJAIL", "Вытащить из тюрьмы")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCHATMUTE", "Заблокировать чат")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATMUTE", "Заблокировать чат")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATUNMUTE", "Разблокировать чат")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGVOICEMUTE", "Toggle Voice Mute")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEMUTE", "Заблокировать глс.чат")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEUNMUTE", "Разблокировать глс.чат")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SPECTATE", "Следить")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_STRIP", "Отобрать оружие")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETHP", "Выдать здоровье")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGGOD", "Включить режим бога")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOD", "Включить режим бога")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNGOD", "Выключить режим бога")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAY", "Убить")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGIGNITE", "Поджечь")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAP", "Пнуть")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCLOAK", "Невидимость")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_REASON", "Введите причину для выполнения этого наказания.")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SECONDS", "На сколько секунд вы хотели бы применить это наказание?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_MINUTES", "На сколько минут вы хотели бы применить это наказание?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_HOURS", "На сколько часов вы хотели бы применить это наказание?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CONFIRM", "Вы уверенны, что хотите выдать данное наказание?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_NUMBER", "Введите числовое значение, связанное с этой командой.")

--[[-------------------------------------------------------------------------
Дополнительные возможности
---------------------------------------------------------------------------]]

-- Tags: // = Поместите это между двумя словами, которые находятся ближе всего к центру текста.
EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL", "Админ//Возможности")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD", "Таб-меню//Возможности")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER", "Серверные//Возможности")

EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL_DESC", "Используйте это меню, чтобы легко выполнять различные действия на вашем сервере без необходимости вводить команды.")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD_DESC", "Используйте это меню, чтобы скрыть себя из Таб-меню и создать фальшивую личность себя в Таб-меню.")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_DESC", "Используйте это меню для простого изменения настроек сервера.")

EdgeScoreboard.AddPhrase(LANG,"UTIL_GOBACK", "Вернуться обратно")

EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_NOPERMISSION", "У вас нет доступа к возможностям данной вкладки.")

--[[-------------------------------------------------------------------------
Возможности Админов
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY", "Убить себя")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME", "Сменить имя")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY", "Выкинуть деньги")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE", nil) -- English: Create Cheque
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS", "Продать все двери")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM", "Присоединиться к противникам")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS", "Удалить все пропы")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY_DESC", "Убить своего персонажа.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME_DESC", "Сменить игровое имя.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY_DESC", "Выкинуть деньги перед собой.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE_DESC", nil) -- English: Creates a money cheque on the ground in front of you.
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS_DESC", "Продать все двери, которыми владеете.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM_DESC", "Перемещение между игроками и зрителями.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS_DESC", "Удалить свои пропы.")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SLAY", "Вы уверенны, что хотите убить этого игрока?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RPNAME", "Какое вы хотите имя для персонажа?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_DROPMONEY", "Сколько вы хотите выкинуть денег?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_CHEQUE", nil) -- English: Who should be able to pick up the money?
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SELLALLDOORS", "Вы уверенны, что хотите продать все свои двери?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_REMOVEALLPROPS", "Вы уверенны, что хотите удалить все свои пропы?")

--[[-------------------------------------------------------------------------
Возможности Таб-меню
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET", "Сброс")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW", "Показать себя")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE", "Скрыть себя")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME", "Поддельное имя")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR", "Поддельное аватарка")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SPOOF", "Поддельный ранг")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE", "Скрыть ранг")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW", "Показать ранг")

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET_DESC", "Сброс фальшивых данных.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW_DESC", "Показывать вас в Таб-Меню.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE_DESC", "Удалить из Таб-меню.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME_DESC", "Изменить никнейм на другой в Таб-меню.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR_DESC", "Изменить аватар на другой в Таб-меню.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_FAKE_DESC", "Изменить ранг на другой в Таб-меню.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE_DESC", "Скрыть ранг в Таб-меню.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW_DESC", "Показать ранг в Таб-меню.")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RESET", "Вы уверены, что хотите установить фальшивую личность по умолчанию?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_VISIBILITY", "Вы уверены, что хотите изменить свою видимость в Таб-меню?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_USERNAME", "Введите имя пользователя, которого вы хотели бы выдать за себя или ничего для сброса.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_AVATAR", "Введите SteamID пользователя Steam, чтобы использовать его аватар Steam или ничего для сброса.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANK", "Введите ранг, который вы хотели бы выдать за себя или ничего для сброса.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANKVISIBILITY", "Вы уверены, что хотите изменить видимость своего ранга?")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_INVALIDSTEAMID", "Вы ввели неверный SteamID.")

--[[-------------------------------------------------------------------------
Server Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP", "Перезагрузить Карту")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS", "Удалить все пропы")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT", "Объявление Сервера")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG", "EdgeScoreboard Настройки")

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP_DESC", "Перезапуск карты заставить игроков переподключиться на игроков.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS_DESC", "Удалить пропы игроков на сервере.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT_DESC", "Показать объявление на экранах игроках.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG_DESC", "Открыть настройки EdgeScoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_FADMIN_DESC", "Настройки/Возможности FAdmin")

-- %Q = Математический вопрос (2+2, 1+2, т.д.)
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHQUESTION", "Пожалуйста введите ответ на %Q что бы выполнить это действие.")

EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHWRONG", "Пожалуйста, ответьте на математический вопрос правильно, чтобы выполнить это действие.")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_TITLE", "Какой заголовок должен иметь объявление сервера?")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_MESSAGE", "Какое сообщение должна иметь объявление сервера?")

-- Tags: %N = Name of player.
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_REMOVEDPROPS", "%N удалил все пропы игроков.")

--[[-------------------------------------------------------------------------
Разное
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"UNCATEGORIZED", "Без команды")

EdgeScoreboard.AddPhrase(LANG,"LOADING_WEBSITE", "Загрузка страницы...")
EdgeScoreboard.AddPhrase(LANG,"HOME_WEBSITE", "Вернуться на домашнюю страницу")

EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CONFIRM", "Подтвердить")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CANCEL", "Отменить")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_AFFIRM", "Принять")

-- Tags: %S = Название сервера or IP.
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_NOTIFY", "Вы будете телепортированы к %S через 10 секунд по заказу админа.")
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_ADMINNOTIFY", "Игрок будет телепортирован  к %S моментально.")

EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RESET", "Ваша фальшивая личность была сброшена.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_HIDDEN", "Вы скрыли себя из Таб-меню.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_VISIBLE", "Вы показываете себя в Таб-меню.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_NAME", "Ваш никнейм был визуально изменен.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_AVATAR", "Ваша аватарка была визуально изменена.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RANK", "Ваш ранг был визуально изменен.")

EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_NOTSUPPORTED", "Аддон, используемый для администрирования, не поддерживается EdgeScoreboard?Тогда откройте заявку в службу поддержки аддона, чтобы она разработчик исправил это!")
EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_CANNOTDO", "Вы не можете сделать это прямо сейчас! Свяжитесь с администратором сервера!")

EdgeScoreboard.AddPhrase(LANG,"REQUESTSTAFF_QUERY", "Введите сообщение, которое вы хотели бы отправить администраторам.")

--[[-------------------------------------------------------------------------
Время
---------------------------------------------------------------------------]]

-- Tags: %H = часы, %M = минуты
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_HM", "%Hч & %Mм")
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_H", "%Hч")

-- Tags: %M = Минуты, %S = секунды
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_MS", "%Mм & %Sс")
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_M", "%Mм")

-- Tags: %S = секунды
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_S", "%Sс")