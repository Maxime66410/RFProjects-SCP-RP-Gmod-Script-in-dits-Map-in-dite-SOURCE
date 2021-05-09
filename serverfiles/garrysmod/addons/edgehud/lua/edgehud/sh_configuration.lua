--[[-------------------------------------------------------------------------
DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND EDGEHUD_CONFIG


DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND EDGEHUD_CONFIG


DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND EDGEHUD_CONFIG


DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND EDGEHUD_CONFIG


DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND EDGEHUD_CONFIG

DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND EDGEHUD_CONFIG

---------------------------------------------------------------------------]]

--Create a table for the config.
EdgeHUD.Configuration = {
	Config = {},
	ConfigOptions = {},
}

--Create some shared enums used for creating configtypes.
EDGEHUD_CONFIG_BOOL = 1
EDGEHUD_CONFIG_STRING = 2
EDGEHUD_CONFIG_NUMBER = 3
EDGEHUD_CONFIG_TABLE = 4

--[[-------------------------------------------------------------------------
Functions
---------------------------------------------------------------------------]]

--Serverside functions
if SERVER then

	--Pool network messages.
	util.AddNetworkString("EdgeHUD:UpdatePlayerConfig")
	util.AddNetworkString("EdgeHUD:SaveConfiguration")
	util.AddNetworkString("EdgeHUD:ConfigurationSaved")
	util.AddNetworkString("EdgeHUD:RequestConfig")

	--Create a function to save the configuration.
	function EdgeHUD.Configuration.SaveConfiguration( configTbl )

		--Convert the table into JSON.
		local JSON = util.TableToJSON(configTbl,true)

		--Write the config.
		file.Write("edgehud/config.txt",JSON)

	end

	--Create a function to load the configuration.
	function EdgeHUD.Configuration.LoadConfig(  )

		--Load the file.
		local configFile = util.JSONToTable(file.Read("edgehud/config.txt","DATA"))

		--Create a var that holds if any changes were made.
		local changesMade = false

		--Create a local function to reset a value to default.
		local function resetToDefault( id )

			--Set the value to its default value.
			configFile[id] = EdgeHUD.Configuration.ConfigOptions[id].Default

			--Set changesMade to true.
			changesMade = true

		end

		--Loop through EdgeHUD.Configuration.ConfigOptions to check for missing or invalid values.
		for k,v in pairs(EdgeHUD.Configuration.ConfigOptions) do

			--Check if the value is missing.
			if configFile[k] == nil then

				--Reset the value.
				resetToDefault(k)

				--Print to the console.
				print("[EdgeHUD] : [" .. EdgeHUD.Version .. "] : Added missing configuration-option. (" .. k .. ")")

			elseif v.TypeEnum == EDGEHUD_CONFIG_BOOL then

				--Check so the value is allowed.
				if !isbool(configFile[k]) then

					--Reset the value.
					resetToDefault(k)

					--Print to the console.
					print("[EdgeHUD] : [" .. EdgeHUD.Version .. "] : Reset invalid configuration-option. (" .. k .. ")")

				end

			elseif v.TypeEnum == EDGEHUD_CONFIG_STRING then

				--Check so the value is allowed.
				if !isstring(configFile[k]) or #configFile[k] > EdgeHUD.Configuration.ConfigOptions[k].maxLength then

					--Reset the value.
					resetToDefault(k)

					--Print to the console.
					print("[EdgeHUD] : [" .. EdgeHUD.Version .. "] : Reset invalid configuration-option. (" .. k .. ")")

				end

			elseif v.TypeEnum == EDGEHUD_CONFIG_NUMBER then

				--Check so it's allowed.
				if !isnumber(configFile[k]) or configFile[k] > EdgeHUD.Configuration.ConfigOptions[k].maxNum or configFile[k] < EdgeHUD.Configuration.ConfigOptions[k].minNum then

					--Reset the value.
					resetToDefault(k)

					--Print to the console.
					print("[EdgeHUD] : [" .. EdgeHUD.Version .. "] : Reset invalid configuration-option. (" .. k .. ")")

				end

			elseif v.TypeEnum == EDGEHUD_CONFIG_TABLE then

				--Check so it's a string and that the value is in the list of allowed values.
				if !isstring(configFile[k]) or !table.HasValue(EdgeHUD.Configuration.ConfigOptions[k].AllowedValues,configFile[k]) then

					--Reset the value.
					resetToDefault(k)

					--Print to the console.
					print("[EdgeHUD] : [" .. EdgeHUD.Version .. "] : Reset invalid configuration-option. (" .. k .. ")")

				end

			end

		end

		--Loop through configFile to check for unused values.
		for k,v in pairs(configFile) do

			--Check if the value is not used anymore.
			if !EdgeHUD.Configuration.ConfigOptions[k] then

				--Remove the value.
				configFile[k] = nil

				--Set changesMade to true.
				changesMade = true

				--Print to the console.
				print("[EdgeHUD] : [" .. EdgeHUD.Version .. "] : Removed unused configuration-option. (" .. k .. ")")

			end

		end

		--Save the config if changes were made.
		if changesMade == true then
			EdgeHUD.Configuration.SaveConfiguration(configFile)
		end

		--Load the configuration.
		EdgeHUD.Configuration.Config = configFile

	end

	--Create a function to update all players of the configuration.
	function EdgeHUD.Configuration.UpdatePlayers( recipientFilter )

		--Start the newMsg.
		net.Start("EdgeHUD:UpdatePlayerConfig")
			net.WriteTable(EdgeHUD.Configuration.Config)
			net.WriteString(EdgeHUD.LatestVersion)
		net.Send(recipientFilter)

	end

end

--Create a function to add a new config-option
function EdgeHUD.Configuration.AddConfigOption( ID, tbl )

	--Add the order-variable.
	tbl.Order = table.Count(EdgeHUD.Configuration.ConfigOptions) + 1

	--Add the configuration-option.
	EdgeHUD.Configuration.ConfigOptions[ID] = tbl

end

--Create a function to get a config-value.
function EdgeHUD.Configuration.GetConfigValue( ID )

	--REturn the value from the config
	return EdgeHUD.Configuration.Config[ID]

end

--[[-------------------------------------------------------------------------
Configuration Options
---------------------------------------------------------------------------]]

EdgeHUD.Configuration.AddConfigOption( "Language", {
	Title = "[General] Language",
	Description = "What language should be used for the parts that are visible to the user.",
	TypeEnum = EDGEHUD_CONFIG_TABLE,
	Default = "English",
	AllowedValues = table.GetKeys(EdgeHUD.RegistredLanguages),
	SortItems = true,
	ExampleImage = "",
} )

EdgeHUD.Configuration.AddConfigOption( "ConfigAccess", {
	Title = "[General] Config Access",
	Description = "What usergroups should be allowed to access this configuration menu. (Separate multiple ranks using a ;)",
	TypeEnum = EDGEHUD_CONFIG_STRING,
	Default = "superadmin;owner",
	maxLength = 100,
	ExampleImage = "",
} )

EdgeHUD.Configuration.AddConfigOption( "TopLeft", {
	Title = "[Top Left] Enabled",
	Description = "Should the top left of the HUD be enabled. To show wallet, salary and vote widgets.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "topleft",
} )

EdgeHUD.Configuration.AddConfigOption( "VoteHUD", {
	Title = "[Top Left] Vote/Question Popups",
	Description = "Should EdgeHUD override the default DarkRP vote popups and questions.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "voting",
} )

EdgeHUD.Configuration.AddConfigOption( "LowerLeft", {
	Title = "[Lower Left] Enabled",
	Description = "Should the lower left of the HUD be enabled. To show Health, Armor, Hunger, Identity and Job.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "lowerleft",
} )

EdgeHUD.Configuration.AddConfigOption( "Lowerleft_IdentityType", {
	Title = "[Misc] Identity Type",
	Description = "Should EdgeHUD show the identity in the lower left as the player's Steam name or ingame name.",
	TypeEnum = EDGEHUD_CONFIG_TABLE,
	Default = "Ingame Name",
	AllowedValues = {"Ingame Name","Steam Name"},
	SortItems = false,
	ExampleImage = "",
} )

EdgeHUD.Configuration.AddConfigOption( "LowerLeft_AlwaysShow", {
	Title = "[Lower Left] Always show percentage & bars",
	Description = "Should the percentage and bars that render the health, armor and hunger always be visible.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = false,
	ExampleImage = "alwayspercentage",
} )

EdgeHUD.Configuration.AddConfigOption( "TopRight", {
	Title = "[Top Right] Enabled",
	Description = "Should the top right of the HUD be enabled. To show Agenda and Lockdown, Wanted, Arrest-information.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "topright",
} )

EdgeHUD.Configuration.AddConfigOption( "AlwaysShowAgenda", {
	Title = "[Top Right] Always Show Agenda",
	Description = "Should the agenda in the top right always be shown when available.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = false,
	ExampleImage = "",
} )

EdgeHUD.Configuration.AddConfigOption( "LowerRight", {
	Title = "[Lower Right] Enabled",
	Description = "Should the lower right of the HUD be enabled. To show Ammo, Car Info, License info, Proplimit, Ammo, etc.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "lowerright",
} )

EdgeHUD.Configuration.AddConfigOption( "VehicleStatusWidgets", {
	Title = "[Lower Right] Vehicle Widgets",
	Description = "Should the vehicle widgets, in the lower right, showing the vehicle speed, HP and Fuel be enabled.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "vehicle_status",
} )

EdgeHUD.Configuration.AddConfigOption( "MGang2Widget", {
	Title = "[Lower Right] MGang2 Name",
	Description = "Should the MGang2 name be shown in the lower right. (Requires MGang2)",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "mgang2",
} )

EdgeHUD.Configuration.AddConfigOption( "Speedometer", {
	Title = "[Lower Right] Speedometer Measurement",
	Description = "How should the speedometer measure the speed of vehicles.",
	TypeEnum = EDGEHUD_CONFIG_TABLE,
	Default = "MPH",
	AllowedValues = {"MPH","KPH"},
	SortItems = false,
	ExampleImage = "speedometer",
} )

EdgeHUD.Configuration.AddConfigOption( "HideWhenSpawnmenu", {
	Title = "[Misc] Hide HUD while spawnmenu is open",
	Description = "Should EdgeHUD be hidden when you open the spawn menu?",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = false,
	ExampleImage = "",
} )

EdgeHUD.Configuration.AddConfigOption( "PlayerOverhead", {
	Title = "[Misc] Player Overhead HUD",
	Description = "Should EdgeHUD render information about each player above their head.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "playeroverhead",
} )

EdgeHUD.Configuration.AddConfigOption( "OverheadJob", {
	Title = "[Misc] Player Overhead Team",
	Description = "How should the team above the player's head be shown.",
	TypeEnum = EDGEHUD_CONFIG_TABLE,
	Default = "Job Name",
	AllowedValues = {"Job Name","Job Category","Hidden"},
	SortItems = false,
	ExampleImage = "playeroverhead",
} )

EdgeHUD.Configuration.AddConfigOption( "VehicleDisplay", {
	Title = "[Misc] Vehicle Display",
	Description = "Should EdgeHUD render information about each vehicle when you look at it.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "vehicle_display",
} )

EdgeHUD.Configuration.AddConfigOption( "DoorDisplay", {
	Title = "[Misc] Door Display",
	Description = "Should EdgeHUD render information about each door when close to it.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "doordisplay",
} )

EdgeHUD.Configuration.AddConfigOption( "DoorMenu", {
	Title = "[Misc] Doormenu",
	Description = "Should EdgeHUD override the default DarkRP door menu.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "doormenu",
} )

EdgeHUD.Configuration.AddConfigOption( "CrashScreen", {
	Title = "[Misc] Crash Screen",
	Description = "Should the EdgeHUD crash screen be shown to players when they lose their server connection.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "crashscreen",
} )

EdgeHUD.Configuration.AddConfigOption( "CrashScreen_ReconnectTimer", {
	Title = "[Misc] Crash Screen - Reconnect Timer",
	Description = "How long should EdgeHUD wait before reconnecting to the server.",
	TypeEnum = EDGEHUD_CONFIG_NUMBER,
	Default = 45,
	maxNum = 300,
	minNum = 30,
	ExampleImage = "",
} )

EdgeHUD.Configuration.AddConfigOption( "NotificationSystem", {
	Title = "[Misc] Notification System",
	Description = "Should EdgeHUD override the default Garry's Mod notification design. (Other notification addons will override this)",
	TypeEnum = EDGEHUD_CONFIG_TABLE,
	Default = "EdgeHUD Design",
	AllowedValues = {"EdgeHUD Design","Default Design", "Other Design"},
	SortItems = false,
	ExampleImage = "notifications",
} )

EdgeHUD.Configuration.AddConfigOption( "Vehicle_DamageIndicators", {
	Title = "[Misc] Damage Indicators (VCMod)",
	Description = "Should the indicators that show if a vehicle has damage be shown.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "vehicle_indicators",
} )

EdgeHUD.Configuration.AddConfigOption( "DisableVCMod", {
	Title = "[Misc] VCMod HUD",
	Description = "Should EdgeHUD hide the VCMod HUD.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "vcmod_hud",
} )

EdgeHUD.Configuration.AddConfigOption( "BatteryAlerts", {
	Title = "[Misc] Laptop Battery Alerts",
	Description = "Should EdgeHUD show battery alerts in the middle of the screen to laptop users.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "batterynotifications",
} )

EdgeHUD.Configuration.AddConfigOption( "LegalPopups", {
	Title = "[Misc] Legal Popups",
	Description = "Should EdgeHUD show popups in the middle of the player's screen when receiving a warrant, being arrested, etc.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "legalpopups",
} )

EdgeHUD.Configuration.AddConfigOption( "LockdownPopup", {
	Title = "[Misc] Lockdown Popups",
	Description = "Should a popup message be shown in the middle of the screen when a lockdown is initiated.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "lockdown",
} )

EdgeHUD.Configuration.AddConfigOption( "HideDefaultVoiceIcons", {
	Title = "[Misc] Disable Default Voice Icons",
	Description = "Should EdgeHUD hide the default orange voice icons above peoples head to be replaced with better ones.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "voiceoverhead",
} )

EdgeHUD.Configuration.AddConfigOption( "DisableReceiversHUD", {
	Title = "[Misc] Disable Receivers HUD",
	Description = "Should EdgeHUD hide the default HUD above the chat saying who can hear you while talking.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "receivers",
} )

EdgeHUD.Configuration.AddConfigOption( "DarkRPLevelSystem", {
	Title = "[Misc] DarkRP Level System HUD",
	Description = "Should EdgeHUD show the level bar at the middle top of the screen. (Requires https://github.com/vrondakis/Leveling-System)",
	TypeEnum = EDGEHUD_CONFIG_TABLE,
	Default = "Show on change",
	AllowedValues = {"Disabled","Show on change","Always show"},
	SortItems = false,
	ExampleImage = "levelbar",
} )

EdgeHUD.Configuration.AddConfigOption( "EnableDarkRPTellAll", {
	Title = "[Misc] DarkRP AdminTell",
	Description = "Should EdgeHUD override the default DarkRP AdminTell notification.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "admintell",
} )

EdgeHUD.Configuration.AddConfigOption( "EnableVoiceIcon", {
	Title = "[Misc] Enable Speaker Icon",
	Description = "Should a speaker icon be shown in the bottom right when the player is speaking.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "speaker_lowerright",
} )

EdgeHUD.Configuration.AddConfigOption( "VoiceVisualizers", {
	Title = "[Misc] Voice Visualizers",
	Description = "How should the voice visualizers look like in the lower right.",
	TypeEnum = EDGEHUD_CONFIG_TABLE,
	Default = "EdgeHUD Design",
	AllowedValues = {"EdgeHUD Design","Default Design","Disabled"},
	SortItems = false,
	ExampleImage = "visualizer",
} )

EdgeHUD.Configuration.AddConfigOption( "GestureMenu", {
	Title = "[Misc] Gesture Menu",
	Description = "Should EdgeHUD override the default DarkRP gesture menu.",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = true,
	ExampleImage = "gesture",
} )


EdgeHUD.Configuration.AddConfigOption( "ItemPickups", {
	Title = "[Misc] Item Pickup HUD",
	Description = "How should the Item Pickup HUD in the upper right be drawn.",
	TypeEnum = EDGEHUD_CONFIG_TABLE,
	Default = "EdgeHUD Design",
	AllowedValues = {"EdgeHUD Design","Default Design","Disabled"},
	SortItems = false,
	ExampleImage = "itempickups",
} )

EdgeHUD.Configuration.AddConfigOption( "ContentDownload", {
	Title = "[Other] Content Download",
	Description = "How should the content for the HUD be downloaded? (Not recommended to change) (Requires server restart)",
	TypeEnum = EDGEHUD_CONFIG_TABLE,
	Default = "Login Download + Workshop (Recommended)",
	AllowedValues = {"Login Download + Workshop (Recommended)","Login Download", "Workshop"},
	SortItems = false,
	ExampleImage = "",
} )

EdgeHUD.Configuration.AddConfigOption( "EnableKillfeed", {
	Title = "[Misc] Enable Kill Feed",
	Description = "Should EdgeHUD show the default Garry's Mod Kill Feed. (Requires re-connection)",
	TypeEnum = EDGEHUD_CONFIG_BOOL,
	Default = false,
	ExampleImage = "",
} )

EdgeHUD.Configuration.AddConfigOption( "Offset_Type", {
	Title = "[Screen Offset] Offset Measurement Unit",
	Description = "What measurement unit should the screen offset be based on? (Select the one that seem to match the best with the addon that the HUD is overlapping)",
	TypeEnum = EDGEHUD_CONFIG_TABLE,
	Default = "Pixels",
	AllowedValues = {"Pixels","Screen Height Percentage", "Screen Width Percentage", "Screen Height/Width Percentage Respectively"},
	SortItems = false,
	ExampleImage = "",
} )

EdgeHUD.Configuration.AddConfigOption( "Offset_Left", {
	Title = "[Screen Offset] Left Edge",
	Description = "How much should the offset be from the left edge of the screen? (See the \"Offset Measurement Unit\" config) (0 = Default)",
	TypeEnum = EDGEHUD_CONFIG_NUMBER,
	Default = 0,
	maxNum = 1000,
	minNum = 0,
	ExampleImage = "",
} )

EdgeHUD.Configuration.AddConfigOption( "Offset_Top", {
	Title = "[Screen Offset] Top Edge",
	Description = "How much should the offset be from the right edge of the screen? (See the\"Offset Measurement Unit\" config) (0 = Default)",
	TypeEnum = EDGEHUD_CONFIG_NUMBER,
	Default = 0,
	maxNum = 1000,
	minNum = 0,
	ExampleImage = "",
} )

EdgeHUD.Configuration.AddConfigOption( "Offset_Right", {
	Title = "[Screen Offset] Right Edge",
	Description = "How much should the offset be from the right edge of the screen? (See the\"Offset Measurement Unit\" config) (0 = Default)",
	TypeEnum = EDGEHUD_CONFIG_NUMBER,
	Default = 0,
	maxNum = 1000,
	minNum = 0,
	ExampleImage = "",
} )

EdgeHUD.Configuration.AddConfigOption( "Offset_Bottom", {
	Title = "[Screen Offset] Bottom Edge",
	Description = "How much should the offset be from the bottom edge of the screen? (See the \"Offset Measurement Unit\" config) (0 = Default)",
	TypeEnum = EDGEHUD_CONFIG_NUMBER,
	Default = 0,
	maxNum = 1000,
	minNum = 0,
	ExampleImage = "",
} )

EdgeHUD.Configuration.AddConfigOption( "Offset_Levelbar", {
	Title = "[Screen Offset] Level Bar Top",
	Description = "How much should the offset for the level bar be from the top edge of the screen? (See the \"Offset Measurement Unit\" config) (0 = Default)",
	TypeEnum = EDGEHUD_CONFIG_NUMBER,
	Default = 0,
	maxNum = 1000,
	minNum = 0,
	ExampleImage = "",
} )

--[[-------------------------------------------------------------------------
Misc
---------------------------------------------------------------------------]]

--Check if we are running serverside.
if SERVER then

	--Make sure that the edgehud folder exists.
	if !file.Exists("edgehud","DATA") then

		--Create the folder.
		file.CreateDir("edgehud")

	end

	--Check if we have any configuration.
	if !file.Exists("edgehud/config.txt","DATA") then

		--Create a table that will be turned into JSON.
		local toWriteTbl = {}

		--Loop through the EdgeHUD.Configuration.ConfigOptions table.
		for k,v in pairs(EdgeHUD.Configuration.ConfigOptions) do

			toWriteTbl[k] = v.Default

		end

		--Save the config.
		EdgeHUD.Configuration.SaveConfiguration( toWriteTbl )

	end

	--Load the configuration.
	EdgeHUD.Configuration.LoadConfig()

	--Create a 1 second timer.
	timer.Simple(1,function(  )

		--Create a new recipientFilter.
		local rf = RecipientFilter()

		--Add all players.
		rf:AddAllPlayers()

		--Update all players of the configuration.
		EdgeHUD.Configuration.UpdatePlayers( rf )

	end)

	--Add a receiver for EdgeHUD:RequestConfig.
	net.Receive("EdgeHUD:RequestConfig", function( _, ply )

		if ply.EdgeHUDConfig != nil then return end

		--Create a new recipientFilter.
		local rf2 = RecipientFilter()

		--Add the player.
		rf2:AddPlayer(ply)

		--Update the player of the configuration.
		EdgeHUD.Configuration.UpdatePlayers( rf2 )

		--Set ply.EdgeHUDConfig to true.
		ply.EdgeHUDConfig = true

	end)

	--Add a receiver for EdgeHUD:SaveConfiguration.
	net.Receive("EdgeHUD:SaveConfiguration",function( _, ply )

		local configTxt = EdgeHUD.Configuration.GetConfigValue( "ConfigAccess" )

		if string.Right(configTxt, 1) == ";" then
			configTxt = string.Left(configTxt, #configTxt - 1)
		end

		local groupsAccess = string.Explode(";", configTxt)

		--Check so the player is the owner of the addon.
		if EdgeHUD.Owner != ply:SteamID64() and !table.HasValue(groupsAccess, ply:GetUserGroup()) then return end

		--Save the config.
		EdgeHUD.Configuration.SaveConfiguration( net.ReadTable() )

		--Tell the player that we suceeded.
		net.Start("EdgeHUD:ConfigurationSaved")
		net.Send(ply)

		include("autorun/sh_edgehud_loader.lua")

	end)

	hook.Add("PlayerSay","EdgeHUD:ConfigCommand",function( ply, text )

		if string.lower(text) == "!edgehud_config" then
			ply:ConCommand("edgehud_config")
		end

	end)

else

	--Get the config from below but from the previous instance of the script.
	EdgeHUD.Configuration.Config = hook.Run("EdgeHUD:Internal_GetConfig") or {}

	--Create a table for the config.
	local config = {}

	if table.Count(EdgeHUD.Configuration.Config) > 0 then
		config = EdgeHUD.Configuration.Config
	else
		net.Start("EdgeHUD:RequestConfig")
		net.SendToServer()
	end

	--Add a hook to get the config when the script is reloaded.
	hook.Add("EdgeHUD:Internal_GetConfig","EdgeHUD:Config",function(  )
		return config
	end)

	--Create a receiver for EdgeHUD:UpdatePlayerConfig.
	net.Receive("EdgeHUD:UpdatePlayerConfig",function(  )

		--Save the config.
		config = net.ReadTable()

		--Read the latest version.
		EdgeHUD.LatestVersion = net.ReadString() or ""

		--Reload the script.
		include("autorun/sh_edgehud_loader.lua")

	end)

end