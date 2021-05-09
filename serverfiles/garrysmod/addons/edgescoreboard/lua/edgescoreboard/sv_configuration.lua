--[[-------------------------------------------------------------------------
Functions
---------------------------------------------------------------------------]]

-- Create a table to check the types.
local typeFunction = {
	[EDGESCOREBOARD_CONFIG_BOOL] = isbool,
	[EDGESCOREBOARD_CONFIG_STRING] = isstring,
	[EDGESCOREBOARD_CONFIG_NUMBER] = isnumber,
	[EDGESCOREBOARD_CONFIG_TABLE] = isstring,
	[EDGESCOREBOARD_CONFIG_COLOR] = function( colorTbl )
		if !istable(colorTbl) then return false end
		if !colorTbl.r or !colorTbl.g or !colorTbl.b or !colorTbl.a then return end
		return true
	end,
}

local serverFields = {
	["Name"] = "Unknown Server",
	["Address"] = "00.00.000.00",
	["Port"] = "27015",
	["Map"] = "gm_construct",
	["Gamemode"] = "DarkRP",
	["Slots"] = "32",
}

-- Create a function to verify a configtable.
function EdgeScoreboard.VerifyConfig( globalConfig, usergroupsConfig, hiddenTeams, orderedTeams, servers )

	-- Create a var if there was any changes made.
	local changesMade = false

	-- Loop through EdgeScoreboard.ConfigValues.Config.
	for k,v in pairs(EdgeScoreboard.ConfigValues.Config) do

		-- Make sure the configuration isn't missing any value.
		if globalConfig[k] == nil or (typeFunction[v.TypeEnum] and typeFunction[v.TypeEnum](globalConfig[k]) == false) or (v.TypeEnum == EDGESCOREBOARD_CONFIG_TABLE and !table.HasValue(v.AllowedValues, globalConfig[k])) then

			-- Print that we added a missing configuration value.
			EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CONSOLE, "Reset missing/invalid configuration value '" .. k .. "'." )

			-- Add the missing configuration.
			globalConfig[k] = v.Default

			-- Update changesMade.
			changesMade = true

		end

	end

	-- Loop through usergroupsConfig.
	for groupName,groupConfig in pairs(usergroupsConfig) do

		-- Loop through all the usergroups.
		for configName,configTable in pairs(EdgeScoreboard.ConfigValues.Usergroups) do

			-- Make sure the configuration isn't missing any value.
			if groupConfig[configName] == nil or (typeFunction[configTable.TypeEnum] and typeFunction[configTable.TypeEnum](groupConfig[configName]) == false) then

				-- Print that we added a missing configuration value.
				EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CONSOLE, "Reset missing/invalid configuration value '" .. configName .. "' for usergroup '" .. groupName .. "'.")

				-- Add the missing configuration.
				usergroupsConfig[groupName][configName] = configTable.Default

				-- Update changesMade.
				changesMade = true

			end

		end

		-- Loop through the usergroup.
		for k2,v2 in pairs(groupConfig) do

			-- Make sure the configuration isn't having any unnecessary values.
			if !EdgeScoreboard.ConfigValues.Usergroups[k2] then

				-- Print that we added a missing configuration value.
				EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CONSOLE, "Removed unused configuration value '" .. k2 .. "' for usergroup '" .. groupName .. "'.")

				-- Add the missing configuration.
				usergroupsConfig[groupName][k2] = nil

				-- Update changesMade.
				changesMade = true

			end

		end

	end

	-- Loop through globalConfig.
	for k,v in pairs(globalConfig) do

		-- Make sure the configuration isn't having any unnecessary values.
		if !EdgeScoreboard.ConfigValues.Config[k] then

			-- Print that we added a missing configuration value.
			EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CONSOLE, "Removed unused configuration value '" .. k .. "'.")

			-- Add the missing configuration.
			globalConfig[k] = nil

			-- Update changesMade.
			changesMade = true

		end

	end

	-- Loop through hiddenTeams.
	for k,v in pairs(hiddenTeams) do
		if !isnumber(k) or !isstring(v) then
			hiddenTeams[k] = nil
			changesMade = true
		end
	end

	-- Loop through orderedTeams.
	for k,v in pairs(orderedTeams) do
		if !isnumber(k) or !isstring(v) then
			orderedTeams[k] = nil
			changesMade = true
		end
	end

	-- Loop through the servers
	for k,v in pairs(servers) do

		-- Make sure the table dont have any illegal keys.
		for k2,v2 in pairs(v) do

			if !serverFields[k2] then
				servers[k][k2] = nil
				changesMade = true
			end

		end

		--Loop through all the required fields.
		for k2,v2 in pairs(serverFields) do

			if !v[k2] then
				v[k2] = v2
				changesMade = true
			end

		end

	end

	-- Return the updated configurations and if there was any changes made.
	return changesMade, globalConfig, usergroupsConfig, hiddenTeams, orderedTeams, servers

end

-- Create a function to save the configuration.
function EdgeScoreboard.SaveConfig( globalConfig, usergroupsConfig, hiddenTeams, orderedTeams, servers )

	-- Convert the tables into JSOn.
	globalConfig = util.TableToJSON(globalConfig)
	usergroupsConfig = util.TableToJSON(usergroupsConfig)
	local teamConfig = util.TableToJSON({["hiddenTeams"] = hiddenTeams, ["orderedTeams"] = orderedTeams})
	servers = util.TableToJSON(servers)

	-- Make sure that the conversation was successfull.
	if !globalConfig or !usergroupsConfig or !teamConfig or !servers then
		error("Failed to save configuration: Couldn't convert from table to JSON.")
	end

	-- Write the configuration.
	file.Write("edgescoreboard/config.txt",globalConfig)
	file.Write("edgescoreboard/usergroups.txt",usergroupsConfig)
	file.Write("edgescoreboard/teams.txt", teamConfig)
	file.Write("edgescoreboard/servers.txt", servers)

end

-- Create a function to read the configuration.
function EdgeScoreboard.ReadConfig(  )

	-- Attempt to read the configuration.
	local globalConfig = file.Read("edgescoreboard/config.txt","DATA")
	local usergroupsConfig = file.Read("edgescoreboard/usergroups.txt","DATA")
	local teamConfig = file.Read("edgescoreboard/teams.txt","DATA")
	local serversConfig = file.Read("edgescoreboard/servers.txt","DATA")

	-- Convert the configurations from JSON to a table.
	globalConfig = util.JSONToTable(globalConfig)
	usergroupsConfig = util.JSONToTable(usergroupsConfig)
	teamConfig = util.JSONToTable(teamConfig)
	serversConfig = util.JSONToTable(serversConfig)

	-- Make sure we read the configurations successfully.
	if !globalConfig or !usergroupsConfig or !teamConfig or !serversConfig then
		error("Failed to read EdgeScoreboard configuration.")
	end

	-- Cache the config.
	EdgeScoreboard.Configuration.Config = globalConfig
	EdgeScoreboard.Configuration.Usergroups = usergroupsConfig
	EdgeScoreboard.Configuration.HiddenTeams = teamConfig.hiddenTeams
	EdgeScoreboard.Configuration.OrderedTeams = teamConfig.orderedTeams
	EdgeScoreboard.Configuration.Servers = serversConfig

	-- Return the data.
	return globalConfig, usergroupsConfig, teamConfig.hiddenTeams, teamConfig.orderedTeams, serversConfig

end

-- Create a function to send the config to the player.
function EdgeScoreboard.UpdatePlayerConfig( rf )

	-- Check if we have a rf.
	if !rf then
		rf = RecipientFilter()
		rf:AddAllPlayers()
	end

	-- Start sending the message.
	net.Start("EdgeScoreboard:SendConfiguration")
		net.WriteTable({
			Config = EdgeScoreboard.Configuration.Config,
			Usergroups = EdgeScoreboard.Configuration.Usergroups,
			Teams = {Hidden = EdgeScoreboard.Configuration.HiddenTeams,Ordered = EdgeScoreboard.Configuration.OrderedTeams},
			Servers = EdgeScoreboard.Configuration.Servers
		})
	net.Send(rf)

end

--[[-------------------------------------------------------------------------
Read Config
---------------------------------------------------------------------------]]

-- Create a function to create the datafiles.
local function createDataFiles( )

	-- Create the directory.
	file.CreateDir("edgescoreboard")

	-- Generate a default configuration.
	local configData = {}

	-- Loop through EdgeScoreboard.ConfigValues.Config.
	for k,v in pairs(EdgeScoreboard.ConfigValues.Config) do

		-- Insert the data.
		configData[k] = v.Default

	end

	local superAdmin = {}

	for k,v in pairs(EdgeScoreboard.ConfigValues.Usergroups) do

		-- Insert the data.
		superAdmin[k] = v.Default

	end

	-- Save the config.
	file.Write("edgescoreboard/config.txt",util.TableToJSON(configData))
	file.Write("edgescoreboard/usergroups.txt",util.TableToJSON({["superadmin"] = superAdmin}))
	file.Write("edgescoreboard/teams.txt", util.TableToJSON({["hiddenTeams"] = {},["orderedTeams"] = {}}))
	file.Write("edgescoreboard/servers.txt", util.TableToJSON({}))

end

-- Check if there is a edgescoreboard folder.
if !file.Exists("edgescoreboard","DATA") then

	createDataFiles()

end

-- Read and verify the configurations.
local changesMade, newGlobalConfig, newUsergroupsConfig, hiddenTeams, orderedTeams, serversConfig = EdgeScoreboard.VerifyConfig( EdgeScoreboard.ReadConfig(  ) )

-- Check if any changes were made to the configuration.
if changesMade then

	-- Save the new configuration.
	EdgeScoreboard.SaveConfig(newGlobalConfig, newUsergroupsConfig,hiddenTeams, orderedTeams, serversConfig)

end

-- Cache the configuration.
EdgeScoreboard.Configuration.Config = newGlobalConfig
EdgeScoreboard.Configuration.Usergroups = newUsergroupsConfig
EdgeScoreboard.Configuration.HiddenTeams = hiddenTeams
EdgeScoreboard.Configuration.OrderedTeams = orderedTeams
EdgeScoreboard.Configuration.Servers = serversConfig

--[[-------------------------------------------------------------------------
Configuration Networking
---------------------------------------------------------------------------]]

-- Pool netmsgs.
util.AddNetworkString("EdgeScoreboard:RequestConfiguration")
util.AddNetworkString("EdgeScoreboard:SendConfiguration")

-- Create a table for those who need their configuration.
local configurationQueue = {}

local configTimerActive = false

-- Add a receiver for EdgeScoreboard:RequestConfiguration.
net.Receive("EdgeScoreboard:RequestConfiguration",function( _, ply )

	-- Insert the player into configurationQueue
	configurationQueue[ply] = true

	if !configTimerActive then

		-- Set configTimerActive.
		configTimerActive = true

		-- Create a timer.
		timer.Simple(2, function(  )

			-- Set configTimerActive,
			configTimerActive = false

			-- Craete a RecipientFilter.
			local rf = RecipientFilter()

			-- Loop through configurationQueue.
			for k,v in pairs(configurationQueue) do

				-- Make sure the player is valid.
				if !IsValid(k) then continue end

				-- Add the player.
				rf:AddPlayer(k)

			end

			-- Send the configuration to everyone who requested it.
			EdgeScoreboard.UpdatePlayerConfig( rf )

			-- Reset configurationQueue.
			configurationQueue = {}

		end)

	end

end)

--[[-------------------------------------------------------------------------
Configurator Manager
---------------------------------------------------------------------------]]

-- Pool network messages.
util.AddNetworkString("EdgeScoreboard:SendConfig")
util.AddNetworkString("EdgeScoreboard:ResetConfig")

net.Receive("EdgeScoreboard:SendConfig", function( len, ply )

	-- Check if the player has an active network cooldown.
	if EdgeScoreboard.HasCooldown(ply, "SendConfig", 3) then return end

	--Check so the player is the owner of the addon or has config access.
	if EdgeScoreboard.Owner != ply:SteamID64() and !EdgeScoreboard.GetUsergroupConfigValue( ply, "ConfigurationAccess" ) then return end

	-- Decompress the data.
	local data = net.ReadTable()

	-- Make sure we got all values.
	if !data.Config or !data.Usergroups or !data.Teams or !data.Teams.Hidden or !data.Teams.Ordered or !data.Servers then
		EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, "Failed to save configuration. (Missing Values)", ply )
		return
	end

	-- Verify the config.
	local _, newGeneralConfig, newUsergroupsConfig, newHiddenTeams, newOrderedTeams, newServers = EdgeScoreboard.VerifyConfig( data.Config, data.Usergroups, data.Teams.Hidden, data.Teams.Ordered, data.Servers )

	-- Save the configuration.
	EdgeScoreboard.SaveConfig( newGeneralConfig, newUsergroupsConfig, newHiddenTeams, newOrderedTeams, newServers )

	-- Read the new configuration.
	EdgeScoreboard.ReadConfig()

	-- Update the player.
	EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, "Successfully saved the configuration.", ply )

	-- Create a recipentfilter.
	local rf = RecipientFilter()

	-- Get all players.
	rf:AddAllPlayers()

	-- Remove the current player.
	rf:RemovePlayer(ply)

	-- Tell everyone that the edgescoreboard config was updated.
	EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, "Script has been reloaded due to a configuration change.", rf )

	-- Update all players.
	EdgeScoreboard.UpdatePlayerConfig( )

	-- Call a hook that the config was updated.
	hook.Run("EdgeScoreboard:ConfigUpdated")

end)

net.Receive("EdgeScoreboard:ResetConfig", function( len, ply )

	-- Check if the player has an active network cooldown.
	if EdgeScoreboard.HasCooldown(ply, "SendConfig", 3) then return end

	--Check so the player is the owner of the addon or has config access.
	if EdgeScoreboard.Owner != ply:SteamID64() and !EdgeScoreboard.GetUsergroupConfigValue( ply, "ConfigurationAccess" ) then return end

	-- Reset the config.
	createDataFiles( )

	-- Read the new configuration.
	EdgeScoreboard.ReadConfig()

	-- Update the player.
	EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, "Successfully reset the configuration.", ply )

	-- Create a recipentfilter.
	local rf = RecipientFilter()

	-- Get all players.
	rf:AddAllPlayers()

	-- Remove the current player.
	rf:RemovePlayer(ply)

	-- Tell everyone that the edgescoreboard config was updated.
	EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, "Script has been reloaded due to a configuration change.", rf )

	-- Update all players.
	EdgeScoreboard.UpdatePlayerConfig( )

	-- Call a hook that the config was updated.
	hook.Run("EdgeScoreboard:ConfigUpdated")

end)

--[[-------------------------------------------------------------------------
Chat Command
---------------------------------------------------------------------------]]

hook.Add("PlayerSay","EdgeScoreboard:ConfigCommand",function( ply, text )

	if string.lower(text) == "!edgescoreboard_config" then
		ply:ConCommand("edgescoreboard_config")
	end

end)