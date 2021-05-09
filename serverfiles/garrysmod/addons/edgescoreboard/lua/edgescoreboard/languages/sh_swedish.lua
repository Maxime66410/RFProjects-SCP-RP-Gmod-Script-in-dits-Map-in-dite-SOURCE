--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeScoreboard.RegisterLanguage({
	Name = "Swedish",
	Author = "Jompe",
	CompatibleVersion = "1.9.1",
})

--[[-------------------------------------------------------------------------
Left Sidebar
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_PLAYERS", "Spelare")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SERVERS", "Serverar")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WEBSITE", "Hemsida")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_DONATE", "Donera")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_UTILITIES", "Verktyg")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WORKSHOP", "Workshop")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_REQUESTSTAFF", "Begär Admin")

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SEARCHFIELD", "Sök")

EdgeScoreboard.AddPhrase(LANG,"WEBSITE_URL_COPIED", "Länken har kopierats till ditt urklipp.")

--[[-------------------------------------------------------------------------
Statistics
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_SERVER", "Serverstatistik")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLYCOUNT", "Antal Spelare")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_STAFF", "Admin Online")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_UPTIME", "Drifttid")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_AVGPING", "Latensgenomsnitt")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_GAME", "Spelstatistik")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLAYTIME", "Tot. speltid")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_SESSION", "Session")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PING", "Latens")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT", "Spelargraf")
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT_SUFFIX", "3t") -- Stands for 3 hours
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_LOWEST", "Lägsta")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_HIGHEST", "Högsta")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_AVERAGE", "Genomsnitt")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_CURRENT", "Nuvarande")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD", "K/D") -- Stands for Kills (Divided by) Deaths 
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD_SUFFIX", "1t") -- Stands for 1 hour
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_KILLS", "Dödade")
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_DEATHS", "Dödsfall")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS", "FPS") -- Stands for "Frames Per Second"
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS_SUFFIX", "30m") -- Stands for 30 minutes
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_KILLS", "FPS")
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_DEATHS", "Ca FPS") -- Stands for "Average FPS"

--[[-------------------------------------------------------------------------
Server Browser
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SERVERS_MAP_PREFIX", "Karta")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_GM_PREFIX", "Spelarläge")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_PS_PREFIX", "Spelarplatser")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_IP_PREFIX", "IP Adress")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD", "Inga Yttligare Serverar")
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD_SUBTIT", "Det verkar som att ledaren över denna server inte har lagt till några yttligare serverar.")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_CONNECT", "Anslut")

-- TAGS: %S = Server Name or IP
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_VERIFY_CONNECT", "Är du säker på att du vill ansluta till %S?")

--[[-------------------------------------------------------------------------
Player Row
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PING", "Latens")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_DEATHS", "Dödsfall")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KILLS", "Dödade")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_SCORE", "Poäng")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KARMA", "Karma")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PLAYTIME", "Speltid")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_NAME", "Namn")

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_RANK", "Rang")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_JOB", "Jobb")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_LEVEL", "Level")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_WALLET", "Pengar")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_STATUS", "Status")

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_WANTED", "Efterlyst")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ARRESTED", "Arresterad")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ALIVE", "Levande")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_DEAD", "Död")

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_MURDER_JOINTEAM", "Delta")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_COPIED", "Informationen har blivit kopierad till ditt urklipp.")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAM", "Besök Steam profil")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_MUTE", "Tysta Spelare")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_UNMUTE", "Hör Spelare")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_INFO", "Information")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_USERNAME", "Kopiera Användarnamn")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_GROUP", "Kopiera Rank")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TEAM", "Kopiera Lagnamn")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID", "Kopiera SteamID")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID64", "Kopiera SteamID64")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TRANSFER", "Överför Spelare")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP", "Ange IP")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP_LONG", "Ange IP adressen och porten till den server du vill att denna spelare ska anluta till.")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_INVALIDIP", "IP adressen du angav är inte en giltig IP adress.")

-- Tags: %N = Server Name
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_VERIFY", "Är du säker på att du vill överföra denna spelare till %N?")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_RANK_NONE", "Ingen")

-- Tags: %M = Number (Money)
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_THOUSAND", "%MK")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_MILLION", "%MM")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_BILLION", "%MB")

--[[-------------------------------------------------------------------------
Admin Player Actions
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOTO", "Gå Till")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BRING", "Ta Hit")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_RETURN", "Skicka tillbaka")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETTEAM", "Ändra lag")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGFREEZE", "Växla Frysning")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_FREEZE", "Frys")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNFREEZE", "Ångra Frysning")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BAN", "Bannlys")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_KICK", "Sparka Ut")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGJAIL", "Växla Fängelse")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_JAIL", "Fängsla")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNJAIL", "Släpp Fri")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCHATMUTE", "Växla Chatt-Tystnad")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATMUTE", "Tysta Chatt")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATUNMUTE", "Tillåt Chatt")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGVOICEMUTE", "Växla Röst-Tystnad")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEMUTE", "Tysta Röst")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEUNMUTE", "Tillåt Röst")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SPECTATE", "Åskåda")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_STRIP", "Ta Vapen")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETHP", "Ändra Hälsa")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGGOD", "Växla Gudläge")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOD", "Aktivera Gudläge")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNGOD", "Avaktivera Gudläge")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAY", "Avliva")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGIGNITE", "Växla Eld")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAP", "Smäll Till")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCLOAK", "Växla Osynlighet")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_REASON", "Ange en anledning för att utföra denna åtgärd.")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SECONDS", "I hur många sekunder vill du att denna åtgärd ska gälla?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_MINUTES", "I hur många minuter vill du att denna åtgärd ska gälla?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_HOURS", "I hur många timmar vill du att denna åtgärd ska gälla?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CONFIRM", "Är du säker att du vill utföra denna åtgärd?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_NUMBER", "Ange nummervärdet som är assosierat med denna åtgärd.")

--[[-------------------------------------------------------------------------
Utilities
---------------------------------------------------------------------------]]

-- Tags: // = Put this between the two words that are closest to the center of the text.
EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL", "Personliga//Handlingar")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD", "Scoreboard//Handlingar")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER", "Server//Handlingar")

EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL_DESC", "Använd denna meny för att enkelt utföra vissa åtgärder på din spelare utan att behöva skriva långa kommandon.")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD_DESC", "Använd denna meny för att gömma dig från spelarlistan och förfalska din identitet på spelarlistan.")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_DESC", "Använd denna meny för att enkelt ändra inställningar eller utföra åtgärder på servern.")

EdgeScoreboard.AddPhrase(LANG,"UTIL_GOBACK", "Återgå till Verktyg")

EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_NOPERMISSION", "Du har inte tillåtelse till några åtgärder i denna kategori.")

--[[-------------------------------------------------------------------------
Personal Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY", "Avliva dig själv")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME", "Ändra spelarnamn")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY", "Släpp pengar")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE", "Skapa Check")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS", "Sälj alla dörrar")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM", "Delta motståndarlaget")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS", "Ta bort alla föremål")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY_DESC", "Avlivar din karaktär.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME_DESC", "Ändrar ditt spelarnamn.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY_DESC", "Släpper pengar på marken framför dig.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE_DESC", "Skapar en check som bara en specificerad person kan plocka upp.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS_DESC", "Säljer alla dörrar som du äger.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM_DESC", "Ändra mellan Seplare och Åskådare.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS_DESC", "Tar bort alla dina framtagna föremål.")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SLAY", "Är du säker på att du vill avliva din spelare?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RPNAME", "Vad vill du ge din karaktär för namn")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_DROPMONEY", "Hur mycket pengar vill du släppa?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_CHEQUE", "Vem ska kunna plocka upp pengarna?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SELLALLDOORS", "Är du säker på att du vill sälja alla dina ägda dörrar?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_REMOVEALLPROPS", "Är du säker på att du vill ta bort alla dina framtagna föremål?")

--[[-------------------------------------------------------------------------
Scoreboard Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET", "Återställ Identitet")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW", "Visa dig själv")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE", "Göm dig själv")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME", "Förfalska användarnamn")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR", "Förfalska profilbild")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SPOOF", "Förfalska rank")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE", "Göm rank")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW", "Visa rank")

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET_DESC", "Återställer din förfalskade identitet.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW_DESC", "Visar dig på spelarlistan igen.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE_DESC", "Tar bort dig från spelarlistan.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME_DESC", "Förfalskar ditt användernamn på spelarlistan.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR_DESC", "Förfalskar din profilbild på spelarlistan.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_FAKE_DESC", "Förfalskar din rank på spelarlistan.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE_DESC", "Gömmer din rank från spelarlistan.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW_DESC", "Visar din rank på spelarlistan.")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RESET", "Är du säker på att du vill återställa din förfalskade identitet?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_VISIBILITY", "Är du säker på att du vill ändra din synlighet på spelarlistan?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_USERNAME", "Ange användarnamnet som du vill använda, eller ingenting för att återställa.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_AVATAR", "Ange SteamID för en Steam Användare för att använda dennes profilbild, eller ingenting för att återställa.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANK", "Ange den ranken som du vill utge dig för att vara, eller ingenting för att återställa.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANKVISIBILITY", "Är du säker på att du vill ändra din ranks synlighet?")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_INVALIDSTEAMID", "Du angav inte ett giltigt SteamID.")

--[[-------------------------------------------------------------------------
Server Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP", "Starta om karta")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS", "Ta bort alla föremål")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT", "Servermeddelande")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG", "EdgeScoreboard Konfiguration")

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP_DESC", "Startar om kartan och gör så att alla spelare återansluter.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS_DESC", "Tar bort allas föremål på servern.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT_DESC", "Visar ett meddelande på alla spelares skärm.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG_DESC", "Öppnar EdgeScoreboard konfigurationen.")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_FADMIN_DESC", "En FAdmin inställning/åtgärd.")

-- %Q = Math Question (2+2, 1+2, etc)
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHQUESTION", "Skriv svaret till %Q för att utföra denna åtgärd.")

EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHWRONG", "Ange rätt svar på matteproblemet för att utföra denna åtgärd.")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_TITLE", "Vad ska titeln vara för servermeddelandet?")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_MESSAGE", "Vad ska texten vara för servermeddelandet?")

-- Tags: %N = Name of player.
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_REMOVEDPROPS", "%N tog bort allas föremål.")

--[[-------------------------------------------------------------------------
Misc
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"UNCATEGORIZED", "Okategoriserade")

EdgeScoreboard.AddPhrase(LANG,"LOADING_WEBSITE", "Laddar Webbplatsen...")
EdgeScoreboard.AddPhrase(LANG,"HOME_WEBSITE", "Återgå Hem")

EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CONFIRM", "Bekräfta")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CANCEL", "Avbryt")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_AFFIRM", "Okej")

-- Tags: %S = Server Name or IP.
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_NOTIFY", "Du kommer att bli överförd till %S om 10 sekunder, som beordrat av en administratör.")
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_ADMINNOTIFY", "Spelaren kommer att överföras till %S om ett ögonblick.")

EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RESET", "Din förfalskade identitet har återställts.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_HIDDEN", "Du har blivit gömd från spelarlistan.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_VISIBLE", "Du har blivit synlig på spelarlistan.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_NAME", "Ditt användarnamn har blivit ändrat visuellt.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_AVATAR", "Din profilbild har blivit ändrad visuellt.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RANK", "Din rank har blivit ändrad visuellt.")

EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_NOTSUPPORTED", "Skriptet som används för administering stöds inte av EdgeScoreboard. Öppna ett nytt support-mål på Gmodstore för att få det kompatibelt.")
EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_CANNOTDO", "Du kan inte göra detta just nu! Kontakta ledaren av servern!")

EdgeScoreboard.AddPhrase(LANG,"REQUESTSTAFF_QUERY", "Ange meddelandet som du vill skicka ut till serverns administratörer.")

--[[-------------------------------------------------------------------------
Formatted Time
---------------------------------------------------------------------------]]

-- Tags: %H = Hours, %M = Minutes
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_HM", "%Ht & %Mm")
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_H", "%Ht")

-- Tags: %M = Minutes, %S = Seconds
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_MS", "%Mm & %Ss")
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_M", "%Mm")

-- Tags: %S = Seconds
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_S", "%Ss")