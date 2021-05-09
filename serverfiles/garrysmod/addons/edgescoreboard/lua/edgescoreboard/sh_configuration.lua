--[[-------------------------------------------------------------------------
DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND EDGESCOREBOARD_CONFIG


DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND EDGESCOREBOARD_CONFIG


DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND EDGESCOREBOARD_CONFIG


DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND EDGESCOREBOARD_CONFIG


DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND EDGESCOREBOARD_CONFIG

DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND EDGESCOREBOARD_CONFIG

---------------------------------------------------------------------------]]

-- Create some shared enums used for creating configtypes.
EDGESCOREBOARD_CONFIG_BOOL = 1
EDGESCOREBOARD_CONFIG_STRING = 2
EDGESCOREBOARD_CONFIG_NUMBER = 3
EDGESCOREBOARD_CONFIG_TABLE = 4
EDGESCOREBOARD_CONFIG_COLOR = 5

-- Create a shared workspace table for the config values.
EdgeScoreboard.ConfigValues = {
	Config = {},
	Usergroups = {}
}

-- Create a shared workspace table for the configuration.
EdgeScoreboard.Configuration = EdgeScoreboard.Configuration or {
	Config = {},
	Usergroups = {}
}

--[[-------------------------------------------------------------------------
Functions used to add config-options.
---------------------------------------------------------------------------]]

-- Create function to add new configoptions.
function EdgeScoreboard.AddConfig( ID, tbl )

	-- Get the order.
	tbl.Order = table.Count(EdgeScoreboard.ConfigValues.Config)

	-- Add the configtype to the configtable
	EdgeScoreboard.ConfigValues.Config[ID] = tbl

end

-- Create function to add new configoptions for specific usergroups.
function EdgeScoreboard.AddUserconfig( ID, tbl )

	-- Get the order.
	tbl.Order = table.Count(EdgeScoreboard.ConfigValues.Usergroups)

	-- Add the configtype to the configtable
	EdgeScoreboard.ConfigValues.Usergroups[ID] = tbl

end

--[[-------------------------------------------------------------------------
Config functions
---------------------------------------------------------------------------]]

-- Create function used to get the configurations.
function EdgeScoreboard.GetConfigValue( ID )

	-- Check so the ID is valid.
	if !EdgeScoreboard.Configuration.Config[ID] then return false end

	-- Return value.
	return EdgeScoreboard.Configuration.Config[ID]

end

--[[-------------------------------------------------------------------------
Access functions.
---------------------------------------------------------------------------]]

-- Create function to check if a player has access to something.
function EdgeScoreboard.GetUsergroupConfigValue( ply, ID )

	-- Check so the usergroup exist.
	if !EdgeScoreboard.Configuration.Usergroups[ply:GetUserGroup()] then return false end

	-- Check so the ID was valid.
	if !EdgeScoreboard.Configuration.Usergroups[ply:GetUserGroup()][ID] then return false end

	-- Return the value.
	return EdgeScoreboard.Configuration.Usergroups[ply:GetUserGroup()][ID]

end

--[[-------------------------------------------------------------------------
ADDING CONFIG-OPTIONS BELOW
---------------------------------------------------------------------------]]

EdgeScoreboard.AddConfig( "Language", {
	Title = "[General] Language",
	Description = "What language should be used for the parts that are visible to the user?",
	TypeEnum = EDGESCOREBOARD_CONFIG_TABLE,
	Default = "English",
	AllowedValues = table.GetKeys(EdgeScoreboard.RegistredLanguages),
	SortItems = true
} )

EdgeScoreboard.AddConfig( "ContentDownload", {
	Title = "[General] Content Download",
	Description = "How should the content for the scoreboard be downloaded? (Not recommended to change) (Requires server restart)",
	TypeEnum = EDGESCOREBOARD_CONFIG_TABLE,
	Default = "Login Download + Workshop (Recommended)",
	AllowedValues = {"Login Download + Workshop (Recommended)","Login Download", "Workshop"},
	SortItems = false,
} )

EdgeScoreboard.AddConfig( "ScoreboardTitle", {
	Title = "[Scoreboard] Community Name",
	Description = "What is the name of your community? This text will be shown in the top left of the scoreboard.",
	TypeEnum = EDGESCOREBOARD_CONFIG_STRING,
	Default = "My Community",
	maxLength = 30,
	exampleImage = "header",
} )

EdgeScoreboard.AddConfig( "ScoreboardDesc", {
	Title = "[Scoreboard] Community Description",
	Description = "What should be shown below the community name in the top left of the scoreboard?",
	TypeEnum = EDGESCOREBOARD_CONFIG_STRING,
	Default = "Welcome to our community, enjoy your stay!",
	maxLength = 65,
	exampleImage = "header",
} )

EdgeScoreboard.AddConfig( "NameType", {
	Title = "[Scoreboard] Name Type",
	Description = "What name type should be shown on the scoreboard?",
	TypeEnum = EDGESCOREBOARD_CONFIG_TABLE,
	Default = "In-Game Name",
	AllowedValues = {"In-Game Name", "Steam Name"},
	SortItems = false
} )

EdgeScoreboard.AddConfig( "CenterFieldType", {
	Title = "[Scoreboard] Center Data Field Type",
	Description = "What type of data should be shown in the center field on each player row?",
	TypeEnum = EDGESCOREBOARD_CONFIG_TABLE,
	Default = "Rank",
	AllowedValues = {"Rank", "Job", "DarkRP Level", "DarkRP Wallet", "DarkRP Status"},
	SortItems = false
} )

EdgeScoreboard.AddConfig( "CenterFieldType_Hover", {
	Title = "[Scoreboard] Center Data Field Type (On-Hover)",
	Description = "What type of data should be shown in the center field on each player row when the row is hovered with the cursor?",
	TypeEnum = EDGESCOREBOARD_CONFIG_TABLE,
	Default = "Disabled",
	AllowedValues = {"Rank", "Job", "DarkRP Level", "DarkRP Wallet", "DarkRP Status", "Disabled"},
	SortItems = false
} )

EdgeScoreboard.AddConfig( "HideHUD", {
	Title = "[Scoreboard] Hide EdgeHUD",
	Description = "Should EdgeHUD be temporarily hidden while having the scoreboard open for a more sleek look?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
	exampleImage = "edgehud",
} )

EdgeScoreboard.AddConfig( "HideCategories", {
	Title = "[Scoreboard] Hide Teams",
	Description = "Should the teams that categorize the players be hidden on the scoreboard?",
	TypeEnum = EDGESCOREBOARD_CONFIG_TABLE,
	Default = "Auto",
	AllowedValues = {"Auto", "Visible", "Hidden"},
	SortItems = false,
	exampleImage = "layout",
} )

EdgeScoreboard.AddConfig( "CopyTeamname", {
	Title = "[Scoreboard] Copy Teamname",
	Description = "Should you be able to copy someones' teamname by clicking their name on the scoreboard?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddConfig( "CategoryType", {
	Title = "[Scoreboard] Category Type",
	Description = "What type of job categories should be used in the player list?",
	TypeEnum = EDGESCOREBOARD_CONFIG_TABLE,
	Default = "Job Name",
	AllowedValues = {"Job Name", "Job Category"},
	SortItems = false
} )

EdgeScoreboard.AddConfig( "RowSorting", {
	Title = "[Scoreboard] Row Sorting",
	Description = "How should the player rows be sorted within the scoreboard?",
	TypeEnum = EDGESCOREBOARD_CONFIG_TABLE,
	Default = "Username",
	AllowedValues = {"Username", "Usergroup"},
	SortItems = false
} )

EdgeScoreboard.AddConfig( "HiddenCategoryColor", {
	Title = "[Scoreboard] Default Team Color",
	Description = "What color should the player data prefixes be when the team categories are hidden? (Linked to configuration option above)",
	TypeEnum = EDGESCOREBOARD_CONFIG_TABLE,
	Default = "Blue",
	AllowedValues = {"Blue", "Gray", "Green", "Red", "Yellow", "Purple", "Pink"},
	SortItems = true
} )

EdgeScoreboard.AddConfig( "ShowFriends", {
	Title = "[Scoreboard] Highlight Friends",
	Description = "Should Steam friends be highlighted with a blue transparent pulsating color?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddConfig( "HighlightDead", {
	Title = "[Scoreboard] Highlight Dead",
	Description = "Should dead players be highlighted with a red background color? (Inactive in TTT)",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddConfig( "TTTGroups", {
	Title = "[Scoreboard] Highlight TTT Groups",
	Description = "Should traitors/detectives be highlighted when playing Trouble in Terrorist Town?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddConfig( "DEATHRUN_Dead", {
	Title = "[Scoreboard] Deathrun Dead Team",
	Description = "Should dead players be placed in their own team when running the Deathrun gamemode?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddConfig( "ShowKillsDeaths", {
	Title = "[Scoreboard] Show Kills & Deaths",
	Description = "Should the kills and deaths be visible on players' rows? (Disabled on some gamemodes)",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddConfig( "Graph02_Type", {
	Title = "[Scoreboard] Graph #02 - Type",
	Description = "What should be shown in the bottom graph to the right on the scoreboard?",
	TypeEnum = EDGESCOREBOARD_CONFIG_TABLE,
	Default = "FPS",
	AllowedValues = {"FPS", "K/D"},
	SortItems = false,
	exampleImage = "graphs",
} )

EdgeScoreboard.AddConfig( "CommunityURL", {
	Title = "[Info] Community URL",
	Description = "What web page should the 'Website' button in the scoreboard direct to?",
	TypeEnum = EDGESCOREBOARD_CONFIG_STRING,
	Default = "http://www.gmodstore.com/teams/1753/addons",
	maxLength = 500,
	exampleImage = "sidebarButtons",
} )

EdgeScoreboard.AddConfig( "DonationURL", {
	Title = "[Info] Donation URL",
	Description = "What web page should the 'Donate' button in the scoreboard direct to?",
	TypeEnum = EDGESCOREBOARD_CONFIG_STRING,
	Default = "http://www.gmodstore.com/teams/1753/addons",
	maxLength = 500,
	exampleImage = "sidebarButtons",
} )

EdgeScoreboard.AddConfig( "WorkshopURL", {
	Title = "[Info] Workshop URL",
	Description = "What web page should the 'Workshop' button in the scoreboard direct to?",
	TypeEnum = EDGESCOREBOARD_CONFIG_STRING,
	Default = "http://www.gmodstore.com/teams/1753/addons",
	maxLength = 500,
	exampleImage = "sidebarButtons",
} )

EdgeScoreboard.AddConfig( "CommunityURL_OpenType", {
	Title = "[Internal] Community URL - Browser",
	Description = "How should the URL for the Website button to the left be opened?",
	TypeEnum = EDGESCOREBOARD_CONFIG_TABLE,
	Default = "Scoreboard Integration",
	AllowedValues = {"Scoreboard Integration", "Steam Overlay"},
	SortItems = false
} )

EdgeScoreboard.AddConfig( "DonateURL_OpenType", {
	Title = "[Internal] Donate URL - Browser",
	Description = "How should the URL for the Donate button to the left be opened?",
	TypeEnum = EDGESCOREBOARD_CONFIG_TABLE,
	Default = "Scoreboard Integration",
	AllowedValues = {"Scoreboard Integration", "Steam Overlay"},
	SortItems = false
} )

EdgeScoreboard.AddConfig( "StaffRequestAddon", {
	Title = "[Internal] Staff Request",
	Description = "What addon should be used for requesting a staff member through the scoreboard?",
	TypeEnum = EDGESCOREBOARD_CONFIG_TABLE,
	Default = "ULX",
	AllowedValues = {"FAdmin", "ULX", "xAdmin 2", "SAM"},
	SortItems = true
} )

EdgeScoreboard.AddConfig( "DefaultRank", {
	Title = "[Internal] Default Rank",
	Description = "What is the default rank that staff should be shown as when hiding their staff rank?",
	TypeEnum = EDGESCOREBOARD_CONFIG_STRING,
	Default = "user",
	maxLength = 20,
} )

EdgeScoreboard.AddConfig( "FAKEONHUD", {
	Title = "[Scoreboard] Staff disguise on HUD",
	Description = "Should any staff disguises made through EdgeScoreboard be visible on EdgeHUD?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
	exampleImage = "overhead",
} )

EdgeScoreboard.AddConfig( "FAdminPlayerActions", {
	Title = "[Utilities] FAdmin - Player Actions",
	Description = "Should the FAdmin player actions be visible when clicking on a player in the player list?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
	exampleImage = "quickActions",
} )

EdgeScoreboard.AddConfig( "ULXPlayerActions", {
	Title = "[Utilities] ULX - Player Actions",
	Description = "Should the ULX player actions be visible when clicking on a player in the player list?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
	exampleImage = "quickActions",
} )

EdgeScoreboard.AddConfig( "SERVERGUARDPlayerActions", {
	Title = "[Utilities] Serverguard - Player Actions",
	Description = "Should the ServerGuard player actions be visible when clicking on a player in the player list?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
	exampleImage = "quickActions",
} )

EdgeScoreboard.AddConfig( "SAMPlayerActions", {
	Title = "[Utilities] SAM - Player Actions",
	Description = "Should the SAM player actions be visible when clicking on a player in the player list?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
	exampleImage = "quickActions",
} )


EdgeScoreboard.AddConfig( "XADMINPlayerActions", {
	Title = "[Utilities] xAdmin 2 - Player Actions",
	Description = "Should the xAdmin 2 player actions be visible when clicking on a player in the player list?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
	exampleImage = "quickActions",
} )

EdgeScoreboard.AddConfig( "FAdminServerActions", {
	Title = "[Utilities] FAdmin - Server Actions",
	Description = "Should the FAdmin server actions be visible under the server actions tab?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddConfig( "ClickSound", {
	Title = "[Scoreboard] Click Sounds",
	Description = "Should EdgeScoreboard play a short clicking sound when hovering over UI buttons on the scoreboard?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddConfig( "UTimePlayerRow", {
	Title = "[Scoreboard] UTime Field",
	Description = "Should the UTime of each player be shown on their player row.",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = false,
	exampleImage = "dataFields"
} )


EdgeScoreboard.AddConfig( "ColorLightening", {
	Title = "[Experimental] Lighten Dark Colors",
	Description = "Should EdgeScoreboard attempt to lighten colors that may appear too dark for the scoreboard? (Note: It is recommended that you select fitting team colors yourself through the DarkRP configuration.)",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = false,
} )

EdgeScoreboard.AddConfig( "Hide_Header", {
	Title = "[Scoreboard] Show Header",
	Description = "Should the header at the top be visible?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddConfig( "Hide_Leftbar", {
	Title = "[Scoreboard] Show Navigation",
	Description = "Should the navigation buttons to the left be visible?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddConfig( "Hide_Rightbar", {
	Title = "[Scoreboard] Show Statistics",
	Description = "Should the statistics sidebar to the right be visible?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )


EdgeScoreboard.AddConfig( "Sidebar_Servers", {
	Title = "[Scoreboard] Show Servers Tab",
	Description = "Should the Servers tab on the left sidebar be visible?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
	exampleImage = "sidebarButtons"
} )

EdgeScoreboard.AddConfig( "Sidebar_Website", {
	Title = "[Scoreboard] Show Website Tab",
	Description = "Should the Website tab on the left sidebar be visible?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
	exampleImage = "sidebarButtons"
} )

EdgeScoreboard.AddConfig( "Sidebar_Donate", {
	Title = "[Scoreboard] Show Donate Tab",
	Description = "Should the Donate tab on the left sidebar be visible?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
	exampleImage = "sidebarButtons"
} )

EdgeScoreboard.AddConfig( "Sidebar_Utilities", {
	Title = "[Scoreboard] Show Utilities Tab",
	Description = "Should the Utilities tab on the left sidebar be visible?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
	exampleImage = "sidebarButtons"
} )

EdgeScoreboard.AddConfig( "Sidebar_Workshop", {
	Title = "[Scoreboard] Show Workshop Tab",
	Description = "Should the Workshop tab on the left sidebar be visible?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
	exampleImage = "sidebarButtons"
} )

EdgeScoreboard.AddConfig( "Sidebar_StaffRequest", {
	Title = "[Scoreboard] Show Request Staff Tab",
	Description = "Should the Request Staff tab on the left sidebar be visible?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
	exampleImage = "sidebarButtons"
} )


--[[-------------------------------------------------------------------------
Usergroups Configs
---------------------------------------------------------------------------]]

EdgeScoreboard.AddUserconfig( "ConfigurationAccess", {
	Title = "[General] Config Access",
	Description = "Should users with this rank be allowed to access the EdgeScoreboard configuration?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddUserconfig( "IsStaff", {
	Title = "[General] Is Staff",
	Description = "Should users with this rank be counted as staff in the statistics sidebar?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddUserconfig( "UsergroupZIndex", {
	Title = "[General] Usergroup Sorting Priority",
	Description = "How high should users with this rank be sorted on the scoreboard? (Higher = Lower down) (-1 = disabled)",
	TypeEnum = EDGESCOREBOARD_CONFIG_NUMBER,
	Default = -1,
	minNum = -1,
	maxNum = 500,
} )

EdgeScoreboard.AddUserconfig( "CustomDisplayName", {
	Title = "[General] Display Name",
	Description = "Should this usergroup have a custom display name on the scoreboard? (Leave empty for none)",
	TypeEnum = EDGESCOREBOARD_CONFIG_STRING,
	Default = "",
	maxLength = 20,
} )

EdgeScoreboard.AddUserconfig( "CustomDisplayColor_Enabled", {
	Title = "[General] Display Color Enabled",
	Description = "Should this usergroup have a custom display color on the scoreboard? (Change color below)",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = false,
} )

EdgeScoreboard.AddUserconfig( "CustomDisplayColor", {
	Title = "[General] Display Color",
	Description = "What should the custom color for this usergroup be? (Enable using configuration option above)",
	TypeEnum = EDGESCOREBOARD_CONFIG_COLOR,
	Default = Color(255, 255, 255, 255),
} )

EdgeScoreboard.AddUserconfig( "CanSeeHiddenTeams", {
	Title = "[General] See Hidden Teams",
	Description = "Should users with this rank be allowed to see teams that have been set to be hidden?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddUserconfig( "MuteImmunity", {
	Title = "[General] Mute Immunity",
	Description = "Should users with this rank be immune to being muted by other players?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = false,
} )

EdgeScoreboard.AddUserconfig( "TransferPlayer", {
	Title = "[Server Transfer] Transfer Player",
	Description = "Should users with this rank be allowed transfer players to other servers by clicking their name on the scoreboard?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddUserconfig( "TransferToUnlisted", {
	Title = "[Server Transfer] Transfer To Unlisted Server",
	Description = "Should users with this rank be allowed transfer players to servers that aren't on the additional servers list?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = false,
} )

EdgeScoreboard.AddUserconfig( "TransferImmunity", {
	Title = "[Server Transfer] Transfer Immunity",
	Description = "Should users with this rank be immune to be transferred to other servers?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = false,
} )

EdgeScoreboard.AddUserconfig( "RestartMap", {
	Title = "[Server Actions] Restart Map",
	Description = "Should users with this rank be able to restart the map and make all players reconnect?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = false,
} )

EdgeScoreboard.AddUserconfig( "CleanUpProps", {
	Title = "[Server Actions] Remove All Props",
	Description = "Should users with this rank be able to remove everyones' props on the server?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = false,
} )

EdgeScoreboard.AddUserconfig( "Announcement", {
	Title = "[Server Actions] Announcement",
	Description = "Should users with this rank able to show an announcement on all players' screen?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = false,
} )

EdgeScoreboard.AddUserconfig( "FakeIdentity:Hide", {
	Title = "[Staff disguise] Hide from scoreboard",
	Description = "Should users with this rank be allowed to hide themselves from the scoreboard?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddUserconfig( "FakeIdentity:SpoofUsername", {
	Title = "[Staff disguise] Spoof Username",
	Description = "Should users with this rank be allowed to fake their username to whatever they want?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddUserconfig( "FakeIdentity:SpoofAvatar", {
	Title = "[Staff disguise] Spoof Avatar",
	Description = "Should users with this rank be allowed to fake their profile picture to whatever they want?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddUserconfig( "FakeIdentity:SpoofRank", {
	Title = "[Staff disguise] Spoof Rank",
	Description = "Should users with this rank be allowed to visually appear as a certain rank?",
	TypeEnum = EDGESCOREBOARD_CONFIG_TABLE,
	Default = "Hide Rank",
	AllowedValues = {"Custom Rank", "Hide Rank", "Not Allowed"},
	SortItems = false,
} )

EdgeScoreboard.AddUserconfig( "FakeIdentity:SeeHidden", {
	Title = "[Staff disguise] See Hidden",
	Description = "Should users with this rank be allowed to see other hidden players?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )

EdgeScoreboard.AddUserconfig( "FakeIdentity:SeeOriginal", {
	Title = "[Staff disguise] See Original",
	Description = "Should users with this rank be allowed to see other players' original names if they are spoofed?",
	TypeEnum = EDGESCOREBOARD_CONFIG_BOOL,
	Default = true,
} )