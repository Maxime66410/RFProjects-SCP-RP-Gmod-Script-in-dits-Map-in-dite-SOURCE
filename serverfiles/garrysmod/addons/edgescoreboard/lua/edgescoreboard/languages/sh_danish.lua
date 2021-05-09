--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeScoreboard.RegisterLanguage({
	Name = "Danish",
	Author = "JL33T",
	CompatibleVersion = "1.3.3",
})

--[[-------------------------------------------------------------------------
Left Sidebar
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_PLAYERS", "Spillere")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SERVERS", "Servere")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WEBSITE", "Hjemmeside")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_DONATE", "Donere")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_UTILITIES", "Værktøjer")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WORKSHOP", "Workshop")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_REQUESTSTAFF", "Anmod om personale")

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SEARCHFIELD", "Søg")

EdgeScoreboard.AddPhrase(LANG,"WEBSITE_URL_COPIED", "URL-adressen er blevet kopieret til udklipsholder.")

--[[-------------------------------------------------------------------------
Statistics
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_SERVER", "Server Statistikker")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLYCOUNT", "Antal Spillere")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_STAFF", "Personale Online")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_UPTIME", "Driftstid")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_AVGPING", "Gennemsnitlig Ping")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_GAME", "Spil Statistik")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLAYTIME", "Tid spillet")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_SESSION", "Session")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PING", "Ping")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT", "Antal Spillere")
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT_SUFFIX", "3t") -- Stands for 3 hours
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_LOWEST", "Laveste")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_HIGHEST", "Højeste")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_AVERAGE", "Gennemsnit")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_CURRENT", "Aktuel")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD", "D/O") -- Stands for Kills (Divided by) Deaths 
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD_SUFFIX", "1t") -- Stands for 1 hour
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_KILLS", "Dræbt")
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_DEATHS", "Omkommet")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS", "FPS") -- Stands for "Frames Per Second"
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS_SUFFIX", "30m") -- Stands for 30 minutes
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_KILLS", "FPS")
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_DEATHS", "Gns. FPS") -- Stands for "Average FPS"

--[[-------------------------------------------------------------------------
Server Browser
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SERVERS_MAP_PREFIX", "Map")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_GM_PREFIX", "Spiltype")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_PS_PREFIX", "Spiller Pladser")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_IP_PREFIX", "IP Addresse")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD", "Ingen ekstra servere")
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD_SUBTIT", "Det ser ud til ejeren af serveren ikke har tilføjet andre servere.")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_CONNECT", "Tilslut")

-- TAGS: %S = Server Name or IP
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_VERIFY_CONNECT", "Er du sikker på du vil tilslutte til %S?")

--[[-------------------------------------------------------------------------
Player Row
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PING", "Ping")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_DEATHS", "Omkommet")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KILLS", "Dræbt")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_SCORE", "Score")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KARMA", "Karma")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PLAYTIME", "Tid spillet")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_NAME", "Navn")

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_RANK", "Stilling")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_JOB", nil) -- English: Job
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_LEVEL", nil) -- English: Level
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_WALLET", nil) -- English: Money
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_STATUS", nil) -- English: Status

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_WANTED", nil) -- English: Wanted
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ARRESTED", nil) -- English: Arrested
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ALIVE", nil) -- English: Alive 
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_DEAD", nil) -- English: Dead

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_MURDER_JOINTEAM", "Tilslut")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_COPIED", "Oplysninger er blevet kopieret til udklipsholder.")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAM", "Besøg Steam Profil")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_MUTE", "Mute Spiller")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_UNMUTE", "Unmute Spiller")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_INFO", "Oplysninger")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_USERNAME", "Kopier Navn")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_GROUP", "Kopier Gruppe")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TEAM", "Kopier Job Navn")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID", "Kopier SteamID")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID64", "Kopier SteamID64")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TRANSFER", "Forflyt Spiller")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP", "Skriv IP")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP_LONG", "Skriv Ip adresse og port på den server spilleren skal forflyttes til.")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_INVALIDIP", "Den IP addresse du har indtastet er en ugyldig IP address.")

-- Tags: %N = Server Name
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_VERIFY", "Er du sikker du vil forflytte denne spiller til %N?")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_RANK_NONE", "Ingen")

-- Tags: %M = Number (Money)
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_THOUSAND", nil) -- English: %MK
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_MILLION", nil) -- English: %MM
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_BILLION", nil) -- English: %MB

--[[-------------------------------------------------------------------------
Admin Player Actions
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOTO", "Gå Til")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BRING", "Hent Her")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_RETURN", "Retunere")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETTEAM", nil) -- English: Set Team
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGFREEZE", "Aktiver Frys")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_FREEZE", "Frys")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNFREEZE", "Frigør")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BAN", "Udeluk")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_KICK", "Smid Ud")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGJAIL", "Aktiver Fængsel")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_JAIL", "Fængsle")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNJAIL", "Løslad")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCHATMUTE", "Aktiver Chat Mute")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATMUTE", "Chat Mute")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATUNMUTE", "Chat Unmute")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGVOICEMUTE", "Aktivere Mundkurv")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEMUTE", "Giv Mundkurv")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEUNMUTE", "Fjern Mundkurv")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SPECTATE", "Spectate")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_STRIP", "Fjern Våben")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETHP", "Sæt Liv")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGGOD", "Aktiver Godmode")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOD", "Aktiver Godmode")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNGOD", "Deaktiver Godmode")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAY", "Dræb")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGIGNITE", "Aktiver Ild")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAP", "Smæk")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCLOAK", "Usynlighed")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_REASON", "Skriv grunden til denne handling.")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SECONDS", "I hvor mange sekunder ønsker du, at denne handling skal anvendes?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_MINUTES", "I hvor mange minutter ønsker du, at denne handling skal anvendes?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_HOURS", nil) -- English: For how many hours would you like this action to apply?
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CONFIRM", "Er du sikker på, at du vil udføre denne handling?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_NUMBER", "Indtast den værdi, der er knyttet til denne kommando.")

--[[-------------------------------------------------------------------------
Utilities
---------------------------------------------------------------------------]]

-- Tags: // = Put this between the two words that are closest to the center of the text.
EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL", "Personlige//Handlinger")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD", "Scoreboard//Handlinger")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER", "Server//Handlinger")

EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL_DESC", "Brug denne menu til let at udføre forskellige handlinger på dine spillere, uden at skulle skrive lange kommandoer.")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD_DESC", "Brug denne menu til at skjule dig selv for scoreboardet og til at kontrollere din falske identitet på scoreboardet.")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_DESC", "Brug denne menu til let at ændre serverindstillinger eller til at udføre handlinger på serveren.")

EdgeScoreboard.AddPhrase(LANG,"UTIL_GOBACK", "Tilbage til Værktøjer")

EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_NOPERMISSION", "Du har ikke tilladelse til noget her!")

--[[-------------------------------------------------------------------------
Personal Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY", "Dræb din karakter")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME", "Skift Rollespils Navn")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY", "Smid Penge")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE", nil) -- English: Create Cheque
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS", "Sælg ALLE Døre")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM", "Tilslut modstanderens hold")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS", "Fjerner ALLE Props")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY_DESC", "Dræber din karakter.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME_DESC", "Skifter dit rollespils navn.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY_DESC", "Smider penge på jorden foran dig.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE_DESC", nil) -- English: Creates a money cheque on the ground in front of you.
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS_DESC", "Sælger alle de døre du ejer.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM_DESC", "Skift mellem spiller og tilskuer.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS_DESC", "Fjerner alle dine personlige props.")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SLAY", "Er du sikker du vil dræbe din spiller?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RPNAME", "Hvad vil du kalde din karakter?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_DROPMONEY", "Hvor mange penge vil du smide?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_CHEQUE", nil) -- English: Who should be able to pick up the money?
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SELLALLDOORS", "Er du sikker du vil sælge alle dine døre?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_REMOVEALLPROPS", "Er du sikker du vil fjerne alle props?")

--[[-------------------------------------------------------------------------
Scoreboard Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET", "Nulstil Identitiet")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW", "Synliggør Mig")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE", "Skjul Mig")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME", "Falsk Navn")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR", "Falsk Avatar")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SPOOF", "Falsk Stilling")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE", "Skjul Stilling")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW", "Vis Stilling")

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET_DESC", "Nulstiller din falske identitiet.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW_DESC", "Synliggør dig på scoreboardet igen.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE_DESC", "Skjuler dig fra scoreboardet.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME_DESC", "Forfalsker dit navn på scoreboardet.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR_DESC", "Forfalsker dit avatar på scoreboardet.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_FAKE_DESC", "Forfalsker din stilling på scoreboardet.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE_DESC", "Skjuler din stilling på scoreboardet.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW_DESC", "Viser din stilling på scoreboardet.")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RESET", "Er du sikker på du vil nulstille din identitiet til standard?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_VISIBILITY", "Are you sure that you want to change your scoreboard visibility?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_USERNAME", "Skriv et navn på en du vil efterligne, eller intet for at nulstille.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_AVATAR", "Skriv et SteamID på den spiller du vil efterligne avatar, eller intet for at nulstille.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANK", "Skriv den stilling du vil repræsenter, eller intet for at nulstille.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANKVISIBILITY", "Er du sikker du vil skifte din stillings synlighed?")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_INVALIDSTEAMID", "Ugyldig SteamID format.")

--[[-------------------------------------------------------------------------
Server Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP", "Genstart Map")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS", "Fjern Alle Props")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT", "Server Annonce")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG", nil) -- English: EdgeScoreboard Config

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP_DESC", "Genstarter mappet og tilslutter spillere igen.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS_DESC", "Fjerner alle spillerenes props.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT_DESC", "Viser en annonce på alle spilleres skærme.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG_DESC", nil) -- English: Opens the EdgeScoreboard configuration.
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_FADMIN_DESC", "An FAdmin setting/action.")

-- %Q = Math Question (2+2, 1+2, etc)
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHQUESTION", "Skriv svaret på %Q for at udføre denne handling.")

EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHWRONG", "Svar venligst rigtigt på dette matematik spørgsmål.")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_TITLE", "Hvilken titel skal server annoncen have?")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_MESSAGE", "Hvilken besked skal server annonce have?")

-- Tags: %N = Name of player.
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_REMOVEDPROPS", "%N fjernede alle's props.")

--[[-------------------------------------------------------------------------
Misc
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"UNCATEGORIZED", "Ukategoriserede Team")

EdgeScoreboard.AddPhrase(LANG,"LOADING_WEBSITE", "Indlæser hjemmeside...")
EdgeScoreboard.AddPhrase(LANG,"HOME_WEBSITE", "Tilbage til start")

EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CONFIRM", "Bekræft")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CANCEL", "Afbryd")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_AFFIRM", "Forstået")

-- Tags: %S = Server Name or IP.
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_NOTIFY", "Du vil blive forflyttet til %S om 10 sekunder. Beordret af staff.")
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_ADMINNOTIFY", "Spilleren bliver forflyttet til %S om et øjeblik.")

EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RESET", "Din falske identitiet er blevet nulstillet.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_HIDDEN", "Du er blevet gjort usynlig på scoreboardet.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_VISIBLE", "Du er blevet gjort synlig på scoreboardet.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_NAME", "Dit navn er blevet visuelt ændret.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_AVATAR", "Dit avatar er blevet visuelt ændret.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RANK", "Din stilling er blevet visuelt ændret.")

EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_NOTSUPPORTED", "Det Admin Addon du bruger er ikke understøttet, åben en ticket på gmodstore!")
EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_CANNOTDO", "Dette kan du ikke, Kontakt Ejeren!")

EdgeScoreboard.AddPhrase(LANG,"REQUESTSTAFF_QUERY", "Skriv venligst en kort beskrivelse af dit problem, så kan vi bedst hjælpe.")

--[[-------------------------------------------------------------------------
Formatted Time
---------------------------------------------------------------------------]]

-- Tags: %H = Hours, %M = Minutes
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_HM", "%Tt & %Mm")
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_H", "%Tt")

-- Tags: %M = Minutes, %S = Seconds
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_MS", "%Mm & %Ss")
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_M", "%Mm")

-- Tags: %S = Seconds
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_S", "%Ss")