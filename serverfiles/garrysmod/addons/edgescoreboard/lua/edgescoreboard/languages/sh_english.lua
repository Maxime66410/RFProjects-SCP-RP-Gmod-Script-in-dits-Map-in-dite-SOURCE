--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeScoreboard.RegisterLanguage({
	Name = "English",
	Author = "Jompe",
	CompatibleVersion = "1.9.1",
})

--[[-------------------------------------------------------------------------
Left Sidebar
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_PLAYERS", "Players")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SERVERS", "Servers")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WEBSITE", "Website")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_DONATE", "Donate")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_UTILITIES", "Utilities")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WORKSHOP", "Workshop")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_REQUESTSTAFF", "Request Staff")

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SEARCHFIELD", "Search")

EdgeScoreboard.AddPhrase(LANG,"WEBSITE_URL_COPIED", "The URL has been copied to your clipboard.")

--[[-------------------------------------------------------------------------
Statistics
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_SERVER", "Server Statistics")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLYCOUNT", "Player Count")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_STAFF", "Staff Online")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_UPTIME", "Uptime")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_AVGPING", "Average Ping")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_GAME", "Game Statistics")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLAYTIME", "Playtime")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_SESSION", "Session")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PING", "Ping")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT", "Player Count")
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT_SUFFIX", "3h") -- Stands for 3 hours
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_LOWEST", "Lowest")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_HIGHEST", "Highest")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_AVERAGE", "Average")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_CURRENT", "Current")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD", "K/D") -- Stands for Kills (Divided by) Deaths 
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD_SUFFIX", "1h") -- Stands for 1 hour
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_KILLS", "Kills")
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_DEATHS", "Deaths")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS", "FPS") -- Stands for "Frames Per Second"
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS_SUFFIX", "30m") -- Stands for 30 minutes
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_KILLS", "FPS")
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_DEATHS", "Avg. FPS") -- Stands for "Average FPS"

--[[-------------------------------------------------------------------------
Server Browser
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SERVERS_MAP_PREFIX", "Map")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_GM_PREFIX", "Gamemode")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_PS_PREFIX", "Player Slots")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_IP_PREFIX", "IP Address")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD", "No Additional Servers")
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD_SUBTIT", "It seems like the manager of this community haven't added any additional servers.")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_CONNECT", "Connect")

-- TAGS: %S = Server Name or IP
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_VERIFY_CONNECT", "Are you sure that you would like to connect to %S?")

--[[-------------------------------------------------------------------------
Player Row
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PING", "Ping")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_DEATHS", "Deaths")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KILLS", "Kills")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_SCORE", "Score")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KARMA", "Karma")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PLAYTIME", "Playtime")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_NAME", "Name")

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_RANK", "Rank")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_JOB", "Job")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_LEVEL", "Level")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_WALLET", "Money")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_STATUS", "Status")

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_WANTED", "Wanted")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ARRESTED", "Arrested")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ALIVE", "Alive")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_DEAD", "Dead")

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_MURDER_JOINTEAM", "Join")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_COPIED", "Information has been copied to your clipboard.")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAM", "Visit Steam profile")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_MUTE", "Mute Player")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_UNMUTE", "Unmute Player")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_INFO", "Information")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_USERNAME", "Copy Username")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_GROUP", "Copy Usergroup")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TEAM", "Copy Team Name")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID", "Copy SteamID")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID64", "Copy SteamID64")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TRANSFER", "Transfer Player")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP", "Enter IP")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP_LONG", "Enter the IP address and port of the server that you want to connect this player to.")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_INVALIDIP", "The IP address you entered is not a valid IP address.")

-- Tags: %N = Server Name
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_VERIFY", "Are you sure that you want to transfer this player to %N?")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_RANK_NONE", "None")

-- Tags: %M = Number (Money)
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_THOUSAND", "%MK")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_MILLION", "%MM")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_BILLION", "%MB")

--[[-------------------------------------------------------------------------
Admin Player Actions
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOTO", "Go To")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BRING", "Bring Here")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_RETURN", "Return")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETTEAM", "Set Team")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGFREEZE", "Toggle Freeze")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_FREEZE", "Freeze")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNFREEZE", "Unfreeze")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BAN", "Ban")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_KICK", "Kick")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGJAIL", "Toggle Jail")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_JAIL", "Jail")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNJAIL", "Unjail")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCHATMUTE", "Toggle Chat Mute")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATMUTE", "Chat Mute")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATUNMUTE", "Chat Unmute")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGVOICEMUTE", "Toggle Voice Mute")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEMUTE", "Voice Mute")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEUNMUTE", "Voice Unmute")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SPECTATE", "Spectate")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_STRIP", "Strip Weapons")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETHP", "Set Health")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGGOD", "Toggle Godmode")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOD", "Enable Godmode")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNGOD", "Disable Godmode")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAY", "Slay")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGIGNITE", "Toggle Ignite")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAP", "Slap")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCLOAK", "Cloak")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_REASON", "Enter a reason for performing this action.")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SECONDS", "For how many seconds would you like this action to apply?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_MINUTES", "For how many minutes would you like this action to apply?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_HOURS", "For how many hours would you like this action to apply?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CONFIRM", "Are you sure that you want to perform this action?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_NUMBER", "Enter the number value associated with this command.")

--[[-------------------------------------------------------------------------
Utilities
---------------------------------------------------------------------------]]

-- Tags: // = Put this between the two words that are closest to the center of the text.
EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL", "Personal//Actions")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD", "Scoreboard//Actions")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER", "Server//Actions")

EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL_DESC", "Use this menu to easily perform different actions on your player without having to type long commands.")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD_DESC", "Use this menu to hide yourself from the scoreboard and to control your fake identity on the scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_DESC", "Use this menu to easily change server settings or to perform actions on the server.")

EdgeScoreboard.AddPhrase(LANG,"UTIL_GOBACK", "Return to Utilities")

EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_NOPERMISSION", "You don't have permission for any actions in this category.")

--[[-------------------------------------------------------------------------
Personal Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY", "Slay Yourself")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME", "Change RP Name")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY", "Drop Money")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE", "Create Cheque")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS", "Sell All Doors")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM", "Join Opposite Team")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS", "Remove All Props")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY_DESC", "Kills your character.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME_DESC", "Changes your roleplay name.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY_DESC", "Drops money on the ground in front of you.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE_DESC", "Creates a money cheque on the ground in front of you.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS_DESC", "Sells all the doors that you currently own.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM_DESC", "Move between Players and Spectators.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS_DESC", "Removes all your personal props.")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SLAY", "Are you sure that you want to slay your player?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RPNAME", "What do you want to name your character?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_DROPMONEY", "How much money would you like to drop?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_CHEQUE", "Who should be able to pick up the money?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SELLALLDOORS", "Are you sure that you want to sell all your currently owned doors?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_REMOVEALLPROPS", "Are you sure that you want to remove all your props?")

--[[-------------------------------------------------------------------------
Scoreboard Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET", "Reset Identity")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW", "Show Yourself")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE", "Hide Yourself")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME", "Spoof Username")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR", "Spoof Avatar")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SPOOF", "Spoof Rank")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE", "Hide Rank")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW", "Show Rank")

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET_DESC", "Resets your fake identity.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW_DESC", "Shows you on the scoreboard again.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE_DESC", "Removes you from the scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME_DESC", "Fakes your username on the scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR_DESC", "Fakes your avatar on the scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_FAKE_DESC", "Fakes your rank on the scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE_DESC", "Hides your rank on the scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW_DESC", "Shows your rank on the scoreboard.")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RESET", "Are you sure that you want to set your fake identity to default?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_VISIBILITY", "Are you sure that you want to change your scoreboard visibility?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_USERNAME", "Enter the username that you would like to impersonate or nothing to reset.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_AVATAR", "Enter the SteamID of a Steam User to use their Steam avatar or nothing to reset.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANK", "Enter the rank that you would like to impersonate or nothing to reset.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANKVISIBILITY", "Are you sure that you want to change your rank visibility?")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_INVALIDSTEAMID", "You entered an invalid SteamID format.")

--[[-------------------------------------------------------------------------
Server Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP", "Restart Map")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS", "Remove All Props")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT", "Server Announcement")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG", "EdgeScoreboard Config")

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP_DESC", "Restarts the map and makes all players reconnect.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS_DESC", "Removes everyones props on the server.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT_DESC", "Shows an announcement on all players' screen.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG_DESC", "Opens the EdgeScoreboard configuration.")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_FADMIN_DESC", "An FAdmin setting/action.")

-- %Q = Math Question (2+2, 1+2, etc)
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHQUESTION", "Please enter the answer of %Q to perform this action.")

EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHWRONG", "Please answer the math question correctly to perform this action.")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_TITLE", "What title should the server announcement have?")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_MESSAGE", "What message should the server announcement have?")

-- Tags: %N = Name of player.
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_REMOVEDPROPS", "%N removed everyones' props.")

--[[-------------------------------------------------------------------------
Misc
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"UNCATEGORIZED", "Uncategorized Teams")

EdgeScoreboard.AddPhrase(LANG,"LOADING_WEBSITE", "Loading website...")
EdgeScoreboard.AddPhrase(LANG,"HOME_WEBSITE", "Return Home")

EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CONFIRM", "Confirm")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CANCEL", "Cancel")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_AFFIRM", "Understood")

-- Tags: %S = Server Name or IP.
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_NOTIFY", "You will be transferred to %S in 10 seconds as ordered by a member of staff.")
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_ADMINNOTIFY", "The player will be transferred to %S momentarily.")

EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RESET", "Your fake identity has been reset.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_HIDDEN", "You have been made hidden from the scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_VISIBLE", "You has been made visible on the scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_NAME", "Your username has been visually changed.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_AVATAR", "Your avatar has been visually changed.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RANK", "Your rank has been visually changed.")

EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_NOTSUPPORTED", "The addon used for administration is not supported by EdgeScoreboard. Open a support ticket to have it supported!")
EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_CANNOTDO", "You cannot do this right now! Contact the server manager!")

EdgeScoreboard.AddPhrase(LANG,"REQUESTSTAFF_QUERY", "Enter the message that you would like to send to the staff members.")

--[[-------------------------------------------------------------------------
Formatted Time
---------------------------------------------------------------------------]]

-- Tags: %H = Hours, %M = Minutes
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_HM", "%Hh & %Mm")
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_H", "%Hh")

-- Tags: %M = Minutes, %S = Seconds
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_MS", "%Mm & %Ss")
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_M", "%Mm")

-- Tags: %S = Seconds
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_S", "%Ss")