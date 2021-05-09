--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeScoreboard.RegisterLanguage({
	Name = "Polish",
	Author = "Mulven",
	CompatibleVersion = "1.5.2",
})

--[[-------------------------------------------------------------------------
Left Sidebar
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_PLAYERS", "Gracze")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SERVERS", "Serwery")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WEBSITE", "Strona")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_DONATE", "Darowizna")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_UTILITIES", "Narzędzia")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WORKSHOP", "Warsztat")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_REQUESTSTAFF", "Zapytaj Adminów")

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SEARCHFIELD", "Szukaj")

EdgeScoreboard.AddPhrase(LANG,"WEBSITE_URL_COPIED", "Link ULR został skopiowany do twojego schowku.")

--[[-------------------------------------------------------------------------
Statistics
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_SERVER", "Statystyki Serwera")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLYCOUNT", "Liczba Graczy")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_STAFF", "Admini Online")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_UPTIME", "Czas Pracy")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_AVGPING", "Średni Ping")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_GAME", "Statystyki Gry")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLAYTIME", "Czas Gry")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_SESSION", "Sesja")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PING", "Ping")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT", "Liczba Graczy")
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT_SUFFIX", "3h") -- Stands for 3 hours
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_LOWEST", "Niski")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_HIGHEST", "Wysoki")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_AVERAGE", "Średni")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_CURRENT", "Aktualny")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD", "K/D") -- Stands for Kills (Divided by) Deaths 
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD_SUFFIX", "1h") -- Stands for 1 hour
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_KILLS", "Zabójstwa")
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_DEATHS", "Śmierci")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS", "FPS") -- Stands for "Frames Per Second"
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS_SUFFIX", "30m") -- Stands for 30 minutes
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_KILLS", "FPS")
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_DEATHS", "Średnie FPS") -- Stands for "Average FPS"

--[[-------------------------------------------------------------------------
Server Browser
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SERVERS_MAP_PREFIX", "Mapa")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_GM_PREFIX", "Tryb Gry")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_PS_PREFIX", "Max Graczy")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_IP_PREFIX", "Adres IP")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD", "Brak dodatkowych serwerów")
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD_SUBTIT", "Wygląda na to że menadżer społeczności nie dodał żadnych dodatkowych serwerów.")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_CONNECT", "Połącz")

-- TAGS: %S = Server Name or IP
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_VERIFY_CONNECT", "Czy jesteś pewny połączenia się z %S?")

--[[-------------------------------------------------------------------------
Player Row
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PING", "Ping")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_DEATHS", "Śmierci")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KILLS", "Zabójstw")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_SCORE", "Wynik")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KARMA", "Karma")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PLAYTIME", "Czas Gry")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_NAME", "Tożsamość")

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_RANK", "Ranga")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_JOB", nil) -- English: Job
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_LEVEL", nil) -- English: Level
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_WALLET", nil) -- English: Money
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_STATUS", nil) -- English: Status

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_WANTED", nil) -- English: Wanted
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ARRESTED", nil) -- English: Arrested
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ALIVE", nil) -- English: Alive 
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_DEAD", nil) -- English: Dead

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_MURDER_JOINTEAM", "Dołącz")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_COPIED", "Informacja została skopiowana do twojego schowka.")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAM", "Odwiedź Profil Steam")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_MUTE", "Wycisz Gracza")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_UNMUTE", "Odcisz Gracza")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_INFO", "Informacja")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_USERNAME", "Skopiuj Tożsamość")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_GROUP", "Skopiuj Grupę")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TEAM", "Skopiuj Nazwę Drużyny")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID", "Skopiuj SteamID")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID64", "Skopiuj SteamID64")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TRANSFER", "Przenieś Gracza")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP", "Podaj IP")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP_LONG", "Podaj adres IP z Portem serwera z którym chcesz aby gracz się połączył.")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_INVALIDIP", "The IP address you entered is not a valid IP address.")

-- Tags: %N = Server Name
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_VERIFY", "Czy jesteś pewny przeniesienia do tego gracza %N?")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_RANK_NONE", "Brak")

-- Tags: %M = Number (Money)
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_THOUSAND", nil) -- English: %MK
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_MILLION", nil) -- English: %MM
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_BILLION", nil) -- English: %MB

--[[-------------------------------------------------------------------------
Admin Player Actions
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOTO", "Idź Do")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BRING", "Przynieś Tu")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_RETURN", "Cofnij")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETTEAM", nil) -- English: Set Team
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGFREEZE", "Przełącz Zamrożenie")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_FREEZE", "Zamroź")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNFREEZE", "Odmroź")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BAN", "Zbanuj")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_KICK", "Wyrzuć")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGJAIL", "Przełącz Więzienie")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_JAIL", "Wsadź do Więzienia")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNJAIL", "Wyciągnij z Więzienia")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCHATMUTE", "Przełącz Wyciszenie Czatu")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATMUTE", "Wycisz na Czacie")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATUNMUTE", "Odcisz na Czacie")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGVOICEMUTE", "Przełącz Wyciszenie Głosu")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEMUTE", "Wyciszenie Głosu")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEUNMUTE", "Odciszenie Głosu")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SPECTATE", "Oglądaj")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_STRIP", "Zabierz Bronie")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETHP", "Ustaw Zdrowie")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGGOD", "Przełącz Tryb Boga")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOD", "Włącz Tryb Boga")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNGOD", "Wyłącz Tryb Boga")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAY", "Zabij")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGIGNITE", "Przełącz Podpalenie")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAP", "Uderzaj")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCLOAK", "Niewidzialność")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_REASON", "Podaj powód tej czynności.")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SECONDS", "Na ile sekund chcesz nałożyć tą czynność?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_MINUTES", "Na ile minut chcesz nałożyć tą czynność?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_HOURS", "Na ile godzin chcesz nalozyc ta czynnosc?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CONFIRM", "Czy jesteś pewny wykonania tej czynności?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_NUMBER", "Wpisz wartość dla tej czynności.")

--[[-------------------------------------------------------------------------
Utilities
---------------------------------------------------------------------------]]

-- Tags: // = Put this between the two words that are closest to the center of the text.
EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL", "Osobiste//Akcje")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD", "Lista Graczy//Akcje")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER", "Serwer//Akcje")

EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL_DESC", "Użyj tego menu aby użyć długich komend bez wpisywania ich.")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD_DESC", "Użyj tego menu aby się ukryć na liście graczy i kontrolować swoją fałszywą tożsamość.")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_DESC", "Użyj tego menu aby łatwo zmienić ustawienia serwera i wykonać czynności na serwerze.")

EdgeScoreboard.AddPhrase(LANG,"UTIL_GOBACK", "Powrót do Narzędzi")

EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_NOPERMISSION", "Nie masz uprawnień do żadnych czynności w tej kategorii.")

--[[-------------------------------------------------------------------------
Personal Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY", "Zabij Się")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME", "Zmień Tożsamość RP")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY", "Wyrzuć Pieniądze")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE", nil) -- English: Create Cheque
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS", "Sprzedaj Wszystkie Drzwi")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM", "Dołącz do Przeciwnej Drużyny")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS", "Usuń Wszystkie Propy")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY_DESC", "Zabij twoją postać.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME_DESC", "Zmień tożsamość roleplay.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY_DESC", "Wyrzuca pieniądze na wprost Ciebie.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE_DESC", nil) -- English: Creates a money cheque on the ground in front of you.
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS_DESC", "Sprzedaje wszystkie drzwi które aktualnie posiadasz.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM_DESC", "Przenieś pomiędzy Graczami a Widzami.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS_DESC", "Usuwe wszystkie twoje propy.")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SLAY", "Jesteś pewny zabicia swojego gracza?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RPNAME", "Jak chcesz aby nazywała się twoja postać?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_DROPMONEY", "Ile chcesz wyrzucić pieniędzy?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_CHEQUE", nil) -- English: Who should be able to pick up the money?
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SELLALLDOORS", "Czy jesteś pewny sprzedania wszystkich swoich drzwi?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_REMOVEALLPROPS", "Czy jesteś pewny usunięcia wszystkich swoich propów?")

--[[-------------------------------------------------------------------------
Scoreboard Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET", "Resetuj Tożsamość")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW", "Pokaż Się")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE", "Ukryj Się")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME", "Sfałszuj Tożsamość")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR", "Sfałszuj Avatar")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SPOOF", "Sfałszuj Rangę")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE", "Ukryj Rangę")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW", "Pokaż Rangę")

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET_DESC", "Resetuj swoją fałszywom tożsamość.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW_DESC", "Pokazuje Cię na liście graczy ponownie.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE_DESC", "Usuwa Cię z listy graczy.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME_DESC", "Fałszuje twoją tożsamość na liście graczy.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR_DESC", "Fałszuje twój avatar na liście graczy.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_FAKE_DESC", "Fałszuj swoją rangę na liście graczy.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE_DESC", "Ukryj swoją rangę na liście graczy.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW_DESC", "Pokaż swoją rangę na liście graczy.")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RESET", "Czy jesteś pewny ustawienia twojej fałszywej tożsamości na domyślną?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_VISIBILITY", "Czy jesteś pewny zmiany twojej widoczności na liście graczy?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_USERNAME", "Podaj tożsamość jaką chcesz ustawić albo nic aby resetować.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_AVATAR", "Podaj SteamID Użytkownika Steam aby użyj jego avataru Steam albo nic aby resetować.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANK", "Podaj rangę jaką chcesz ustawić albo nic aby resetować.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANKVISIBILITY", "Czy jesteś pewny zmiany widzialności twojej rangi?")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_INVALIDSTEAMID", "Podaj poprawne SteamID.")

--[[-------------------------------------------------------------------------
Server Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP", "Zrestartuj Mape")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS", "Usuń Wszystkie Propy")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT", "Ogłoszenia Serwerowe")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG", nil) -- English: EdgeScoreboard Config

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP_DESC", "Zrestartuj mape i połącz graczy na nowo.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS_DESC", "Usuń wszystkich propy z serwera.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT_DESC", "Pokaż ogłoszenie wszystkim na ekranie.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG_DESC", nil) -- English: Opens the EdgeScoreboard configuration.
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_FADMIN_DESC", "Ustawienia/czynności FAdmina.")

-- %Q = Math Question (2+2, 1+2, etc)
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHQUESTION", "Proszę podać odpowiedź %Q aby wykonać tą akcję.")

EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHWRONG", "Proszę odpowiedz odpowiedzieć poprawnie na pytanie matematyczne aby wykonać tę akcję.")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_TITLE", "Jaki chcesz ustawić tytuł ogłoszenia?")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_MESSAGE", "Jaką chcesz ogłosić wiadomość?")

-- Tags: %N = Name of player.
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_REMOVEDPROPS", "%N usunął wszystkich propy.")

--[[-------------------------------------------------------------------------
Misc
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"UNCATEGORIZED", "Drużyny bez Kategorii")

EdgeScoreboard.AddPhrase(LANG,"LOADING_WEBSITE", "Ładowanie strony...")
EdgeScoreboard.AddPhrase(LANG,"HOME_WEBSITE", "Powrót na Stronę Główną")

EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CONFIRM", "Potwierdź")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CANCEL", "Anuluj")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_AFFIRM", "Rozumiem")

-- Tags: %S = Server Name or IP.
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_NOTIFY", "Powinieneś być przeniesiony do %S w ciągu 10 sekund 10 seconds zgodnie z prośbą admina.")
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_ADMINNOTIFY", "Ten gracz został przeniesiony do %S.")

EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RESET", "Twoja fałszywa tożsamość została zresetowana.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_HIDDEN", "Zostałeś ukryty na liście graczy.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_VISIBLE", "Widać Cię na liście graczy ponownie.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_NAME", "Twoja tożsamość została wizualnie zmieniona.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_AVATAR", "Twój avatar został wizualnie zmieniony.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RANK", "Twoja ranga została wizualnie zmieniona.")

EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_NOTSUPPORTED", "Addon używan przez administrację nie jest wspierany przez EdgeScoreboard. Otwórz zgłoszenie aby był wspierany!")
EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_CANNOTDO", "Nie możesz tego teraz zrobić! Skontaktuj się z menadżerem serwera!")

EdgeScoreboard.AddPhrase(LANG,"REQUESTSTAFF_QUERY", "Podaj wiadomość która chcesz wysłac do administracji.")

--[[-------------------------------------------------------------------------
Formatted Time
---------------------------------------------------------------------------]]

-- Tags: %H = Hours, %M = Minutes
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_HM", "%Hh i %Mm")
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_H", "%Hh")

-- Tags: %M = Minutes, %S = Seconds
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_MS", "%Mm i %Ss")
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_M", "%Mm")

-- Tags: %S = Seconds
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_S", "%Ss")