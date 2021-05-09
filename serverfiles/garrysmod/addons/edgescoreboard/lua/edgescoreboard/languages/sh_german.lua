--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeScoreboard.RegisterLanguage({
	Name = "German",
	Author = "TOJU",
	CompatibleVersion = "1.9.1",
})

--[[-------------------------------------------------------------------------
Left Sidebar
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_PLAYERS", "Spieler")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SERVERS", "Server")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WEBSITE", "Webseite")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_DONATE", "Spenden")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_UTILITIES", "Werkzeuge")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WORKSHOP", "Workshop")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_REQUESTSTAFF", "Support")

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SEARCHFIELD", "Suche")

EdgeScoreboard.AddPhrase(LANG,"WEBSITE_URL_COPIED", "Die URL wurde in deine Zwischenablage kopiert.")

--[[-------------------------------------------------------------------------
Statistics
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_SERVER", "Serverstatistiken")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLYCOUNT", "Spieleranzahl")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_STAFF", "TM Online")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_UPTIME", "Laufzeit")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_AVGPING", "Durchschn. Ping")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_GAME", "Eigene Statistiken")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLAYTIME", "Spielzeit")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_SESSION", "Sitzung")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PING", "Ping")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT", "Spieleranzahl")
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT_SUFFIX", "3 Std.") -- Stands for 3 hours
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_LOWEST", "Niedrigste")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_HIGHEST", "Höchste")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_AVERAGE", "Durchschn.")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_CURRENT", "Aktuell")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD", "K/D") -- Stands for Kills (Divided by) Deaths 
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD_SUFFIX", "1h") -- Stands for 1 hour
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_KILLS", "Kills")
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_DEATHS", "Tode")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS", "FPS") -- Stands for "Frames Per Second"
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS_SUFFIX", "30 min.") -- Stands for 30 minutes
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_KILLS", "FPS")
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_DEATHS", "Durchschn. FPS") -- Stands for "Average FPS"

--[[-------------------------------------------------------------------------
Server Browser
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SERVERS_MAP_PREFIX", "Karte")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_GM_PREFIX", "Spielmodus")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_PS_PREFIX", "Slots")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_IP_PREFIX", "IP Addresse")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD", "Keine weiteren Server")
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD_SUBTIT", "Der Besitzer dieser Community hat keine weiteren Server hinzugefügt.")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_CONNECT", "Verbinden")

-- TAGS: %S = Server Name or IP
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_VERIFY_CONNECT", "Bist du sicher, dass du dich mit %S verbinden willst?")

--[[-------------------------------------------------------------------------
Player Row
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PING", "Ping")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_DEATHS", "Tode")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KILLS", "Kills")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_SCORE", "Score")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KARMA", "Karma")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PLAYTIME", "Spielzeit")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_NAME", "Name")

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_RANK", "Rang")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_JOB", "Beruf")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_LEVEL", "Level")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_WALLET", "Geld")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_STATUS", "Status")

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_WANTED", "Gesucht")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ARRESTED", "Inhaftiert")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ALIVE", "Lebendig")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_DEAD", "Tot")

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_MURDER_JOINTEAM", "Beitreten")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_COPIED", "Die Informationen wurden in deine Zwischenablage kopiert.")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAM", "Steamprofil öffnen")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_MUTE", "Spieler stummschalten")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_UNMUTE", "Spieler unmuten")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_INFO", "Informationen")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_USERNAME", "Namen kopieren")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_GROUP", "Rang kopieren")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TEAM", "Job kopieren")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID", "SteamID kopieren")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID64", "SteamID64 kopieren")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TRANSFER", "Spieler übertragen")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP", "Gebe die IP ein")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP_LONG", "Gib die IP-Adresse und den Port des Servers ein, mit dem du diesen Spieler verbinden möchten.")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_INVALIDIP", "Diese IP-Adresse ist ungültig.")

-- Tags: %N = Server Name
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_VERIFY", "Bist du sicher, dass du diesen Spieler auf %N übertragen möchtest?")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_RANK_NONE", "Keiner")

-- Tags: %M = Number (Money)
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_THOUSAND", "%MK")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_MILLION", "%MM")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_BILLION", "%MB")

--[[-------------------------------------------------------------------------
Admin Player Actions
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOTO", "Gehe zu")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BRING", "Herbringen")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_RETURN", "Zurückbringen")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETTEAM", "Setze Beruf")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGFREEZE", "Einfrieren (Toggle)")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_FREEZE", "Einfrieren")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNFREEZE", "Auftauen")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BAN", "Bannen")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_KICK", "Kicken")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGJAIL", "Gefängnis (Toggle)")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_JAIL", "Einsperren")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNJAIL", "Freilassen")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCHATMUTE", "Chat Stummschalten (Toggle)")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATMUTE", "Chat stummschalten")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATUNMUTE", "Chat unmute")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGVOICEMUTE", "Stimme Stummschalten (toggle)")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEMUTE", "Stimme stummschalten")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEUNMUTE", "Stimme unmuten")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SPECTATE", "Beobachten")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_STRIP", "Waffen entfernen")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETHP", "HP setzen")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGGOD", "Godmode (Toggle)")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOD", "Godmode aktivieren")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNGOD", "Godmode deaktivieren")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAY", "Töten")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGIGNITE", "Verbrennen")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAP", "Schlagen")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCLOAK", "Cloaken")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_REASON", "Gib einen Grund für diese Aktion ein.")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SECONDS", "Wie viele Sekunden soll diese Aktion andauern?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_MINUTES", "Wie viele Minuten soll diese Aktion andauern?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_HOURS", "Wie viele Stunden soll diese Aktion andauern?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CONFIRM", "Bist du sicher, dass du diese Aktion durchführen möchtest?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_NUMBER", "Gib den diesem Befehl zugeordneten Zahlenwert ein.")

--[[-------------------------------------------------------------------------
Utilities
---------------------------------------------------------------------------]]

-- Tags: // = Put this between the two words that are closest to the center of the text.
EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL", "Persönliche//Aktionen")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD", "Scoreboard//Aktionen")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER", "Server//Aktionen")

EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL_DESC", "Verwende dieses Menü, um auf einfache Weise Aktionen für den Spieler durchzuführen, ohne lange Befehle eingeben zu müssen.")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD_DESC", "Verwende dieses Menü, um dich auf dem Scoreboard unsichtbar zu machen und deine falsche Identität zu kontrollieren.")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_DESC", "Verwende dieses Menü, um Servereinstellungen zu ändern oder serverseitige Aktionen durchzuführen.")

EdgeScoreboard.AddPhrase(LANG,"UTIL_GOBACK", "Zurück zu den Werkzeugen")

EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_NOPERMISSION", "Du hast keine Berechtigung für Aktionen dieser Kategorie.")

--[[-------------------------------------------------------------------------
Personal Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY", "Begehe Selbstmord")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME", "Ändere RP-Name")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY", "Geld fallenlassen")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE", "Scheck ausstellen")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS", "Verkaufe alle Türen")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM", "Trete dem gegnerischen Team bei")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS", "Entferne alle Props")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY_DESC", "Lässt dich Selbstmord begehen.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME_DESC", "Ändert deinen RP-Namen.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY_DESC", "Wirft Geld vor dich auf den Boden.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE_DESC", "Erzeugt einen Scheck vor dir auf den Boden.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS_DESC", "Verkauft alle deine Türen, die du derzeit besitzt.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM_DESC", "Wechsle zwischen Spielern und Zuschauern.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS_DESC", "Entfernt alle deine Props.")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SLAY", "Bist du dir sicher, dass du Selbstmord begehen möchtest?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RPNAME", "Wie möchtest du dich nennen?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_DROPMONEY", "Wie viel Geld möchtest du auf den Boden werfen?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_CHEQUE", "Wer darf diesen Scheck einlösen?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SELLALLDOORS", "Bist du dir sicher, dass du alle Türen, die du derzeit besitzt, verkaufen möchtest?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_REMOVEALLPROPS", "Bist du dir sicher, dass du alle deine Props entfernen möchtest?")

--[[-------------------------------------------------------------------------
Scoreboard Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET", "Setze Identität zurück")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW", "Zeige dich")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE", "Verstecke dich")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME", "Täusche anderen Namen vor")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR", "Täusche anderes Avatar vor")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SPOOF", "Täusche anderen Rang vor")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE", "Verstecke Rang")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW", "Zeige Rang ")

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET_DESC", "Setzt deine gefälschte Identität zurück.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW_DESC", "Zeigt dich wieder auf dem Scoreboard an.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE_DESC", "Entfernt dich vom Scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME_DESC", "Täuscht einen anderen Namen auf dem Scoreboard vor.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR_DESC", "Täuscht ein anderes Avatar auf dem Scoreboard vor.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_FAKE_DESC", "Täuscht einen anderen Rang vor.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE_DESC", "Versteckt deinen Rang auf dem Scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW_DESC", "Zeigt deinen Rang auf dem Scoreboard.")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RESET", "Bist du dir sicher, dass du deine gefälschte Identität zurücksetzen möchtest?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_VISIBILITY", "Bist du dir sicher, dass du die Sichtbarkeit des Scoreboards ändern möchtest?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_USERNAME", "Gib den Namen ein für den du dich ausgeben willst oder nichts, um ihn zurücksetzen.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_AVATAR", "Gib die SteamID eines Steamnutzers ein, um sein Avatar zu benutzen oder nichts, um es zurücksetzen.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANK", "Gib den Rang ein, dessen Besitz du vortäuschen möchtest oder nichts, um ihn zurücksetzen.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANKVISIBILITY", "Bist du dir sicher, dass du die Sichtbarkeit deines Ranges ändern willst?")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_INVALIDSTEAMID", "Du hast eine ungültige SteamID eingeben.")

--[[-------------------------------------------------------------------------
Server Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP", "Starte die Map neu")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS", "Entferne alle Props")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT", "Server Ankündigung")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG", "EdgeScoreboard Konfiguration")

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP_DESC", "Starte die Map neu und lasse alle Spieler sich neu verbinden.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS_DESC", "Entfernt die Props aller Leute auf dem Server.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT_DESC", "Zeigt eine Ankündigung auf dem Bildschirm jedes Spielers an.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG_DESC", "Öffnet die EdgeScoreboard Konfiguration.")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_FADMIN_DESC", "Eine FAdmin-Einstellung/Aktion.")

-- %Q = Math Question (2+2, 1+2, etc)
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHQUESTION", "Gib das Ergebnis dieser Rechenaufgabe ein. %Q")

EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHWRONG", "Bitte gib das richtige Ergebnis der Rechenaufgabe ein, um diese Aktion durchzuführen.")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_TITLE", "Welchen Titel soll die Ankündigung haben?")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_MESSAGE", "Was soll in der Ankündigung stehen?")

-- Tags: %N = Name of player.
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_REMOVEDPROPS", "%N hat die Props aller Spieler entfernt.")

--[[-------------------------------------------------------------------------
Misc
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"UNCATEGORIZED", "Unkategorisierte Teams")

EdgeScoreboard.AddPhrase(LANG,"LOADING_WEBSITE", "Lade Webseite...")
EdgeScoreboard.AddPhrase(LANG,"HOME_WEBSITE", "Zurück zur Hauptwebseite")

EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CONFIRM", "Bestätigen")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CANCEL", "Abbrechen")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_AFFIRM", "Verstanden")

-- Tags: %S = Server Name or IP.
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_NOTIFY", "Du wirst in 10 Sekunden zu %S verbunden. Dies geschieht auf Anweisung eines Teammitglieds.")
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_ADMINNOTIFY", "Der Spieler wird vorübergehend auf %S übertragen.")

EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RESET", "Deine falsche Identität wurde zurückgesetzt.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_HIDDEN", "Du wurdest auf dem Scoreboard unsichtbar gemacht.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_VISIBLE", "Du wurdest auf dem Scoreboard sichtbar gemacht.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_NAME", "Dein Name wurde visuell geändert.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_AVATAR", "Dein Avatar wurde visuell geändert.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RANK", "Dein Rang wurde visuell geändert.")

EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_NOTSUPPORTED", "Das verwendete Adminsystem wird nicht von EdgeScoreboard unterstützt. Eröffne ein Support-Ticket, um es unterstützen zu lassen.")
EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_CANNOTDO", "Du kannst das momentan nicht tun!")

EdgeScoreboard.AddPhrase(LANG,"REQUESTSTAFF_QUERY", "Gib die Nachricht ein, die du an ein Teammitglied senden möchtest.")

--[[-------------------------------------------------------------------------
Formatted Time
---------------------------------------------------------------------------]]

-- Tags: %H = Hours, %M = Minutes
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_HM", "%H Std. & %M min.")
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_H", "%Hh")

-- Tags: %M = Minutes, %S = Seconds
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_MS", "%M min. & %S s.")
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_M", "%M min.")

-- Tags: %S = Seconds
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_S", "%Ss")