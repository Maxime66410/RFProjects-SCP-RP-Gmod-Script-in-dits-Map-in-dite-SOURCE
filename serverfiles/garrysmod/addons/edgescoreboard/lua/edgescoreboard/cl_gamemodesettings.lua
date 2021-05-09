--[[-------------------------------------------------------------------------
Player Row Prefixes
---------------------------------------------------------------------------]]

-- Create a table for the rowDataSources.
EdgeScoreboard.list_RowDataSources = {}
EdgeScoreboard.nameDataWidth = 0
EdgeScoreboard.HideCategories = false

-- Get the calculated values.
local listData = EdgeScoreboard.listData

-- Check if we are running Deathrun/Murder.
if engine.ActiveGamemode() == "deathrun" or engine.ActiveGamemode() == "murder" then

	EdgeScoreboard.list_RowDataSources = {
		{id = "PING", prefix = EdgeScoreboard.GetPhrase("PLAYERLIST_PREFIX_PING"), autoUpdate = true, getData = function( ply ) return ply:IsBot() and "-" or ply:Ping() end},
	}

	EdgeScoreboard.nameDataWidth = listData.RowWidth * 0.35

-- Check if we are running TTT.
elseif engine.ActiveGamemode() == "terrortown" then

	EdgeScoreboard.list_RowDataSources = {
		{id = "PING", prefix = EdgeScoreboard.GetPhrase("PLAYERLIST_PREFIX_PING"), autoUpdate = true, getData = function( ply ) return ply:IsBot() and "-" or ply:Ping() end},
	}

	if EdgeScoreboard.GetConfigValue("ShowKillsDeaths") then
		table.insert(EdgeScoreboard.list_RowDataSources, {id = "DEATHS", prefix = EdgeScoreboard.GetPhrase("PLAYERLIST_PREFIX_DEATHS"), autoUpdate = false, getData = function( ply ) return ply:Deaths() end})
		table.insert(EdgeScoreboard.list_RowDataSources, {id = "KILLS", prefix = EdgeScoreboard.GetPhrase("PLAYERLIST_PREFIX_SCORE"), autoUpdate = false, getData = function( ply ) return ply:Frags() end})
		EdgeScoreboard.nameDataWidth = listData.RowWidth * 0.25
	else
		EdgeScoreboard.nameDataWidth = listData.RowWidth * 0.35
	end

	table.insert(EdgeScoreboard.list_RowDataSources, {id = "KARMA", prefix = EdgeScoreboard.GetPhrase("PLAYERLIST_PREFIX_KARMA"), autoUpdate = true, getData = function( ply ) return math.Round(ply:GetBaseKarma()) end})

	EdgeScoreboard.nameDataWidth = listData.RowWidth * 0.25

else

	EdgeScoreboard.list_RowDataSources = {
		{id = "PING", prefix = EdgeScoreboard.GetPhrase("PLAYERLIST_PREFIX_PING"), autoUpdate = true, getData = function( ply ) return ply:IsBot() and "-" or ply:Ping() end},
	}

	if EdgeScoreboard.GetConfigValue("ShowKillsDeaths") then
		table.insert(EdgeScoreboard.list_RowDataSources, {id = "KILLS", prefix = EdgeScoreboard.GetPhrase("PLAYERLIST_PREFIX_KILLS"), autoUpdate = false, getData = function( ply ) return ply:Frags() end})
		table.insert(EdgeScoreboard.list_RowDataSources, {id = "DEATHS", prefix = EdgeScoreboard.GetPhrase("PLAYERLIST_PREFIX_DEATHS"), autoUpdate = false, getData = function( ply ) return ply:Deaths() end})
		EdgeScoreboard.nameDataWidth = listData.RowWidth * 0.28
	else
		EdgeScoreboard.nameDataWidth = listData.RowWidth * 0.35
	end

	if Utime and EdgeScoreboard.GetConfigValue("UTimePlayerRow") then
		table.insert(EdgeScoreboard.list_RowDataSources, {id = "PLAYTIME", prefix = EdgeScoreboard.GetPhrase("PLAYERLIST_PREFIX_PLAYTIME"), autoUpdate = true, getData = function( ply ) return ply:IsBot() and "-" or EdgeScoreboard.FormatTime(ply:GetUTimeTotalTime(), true) end})
	end

end

-- Check if we are running sandbox.
if engine.ActiveGamemode() == "sandbox" then
	EdgeScoreboard.HideCategories = true
end

--[[-------------------------------------------------------------------------
Category Customization
---------------------------------------------------------------------------]]

-- Create a table for teams that should have a suffix.
EdgeScoreboard.teamSuffixes = {}

-- Create a table for team categories that should be clickable.
EdgeScoreboard.teamClickables = {}

-- Check if the active gamemode is murder.
if engine.ActiveGamemode() == "murder" then

	EdgeScoreboard.teamSuffixes = {
		["Players"] = " [" .. EdgeScoreboard.GetPhrase("PLAYERLIST_MURDER_JOINTEAM") .. "]",
		["Spectators"] = " [" .. EdgeScoreboard.GetPhrase("PLAYERLIST_MURDER_JOINTEAM") .. "]",
	}

	EdgeScoreboard.teamClickables = {
		["Players"] = function(  ) RunConsoleCommand("mu_jointeam", 2) end,
		["Spectators"] = function(  ) RunConsoleCommand("mu_jointeam", 1) end,
	}

end

--[[-------------------------------------------------------------------------
Personal Actions - Utilities
---------------------------------------------------------------------------]]

-- Add a hook for EdgeScoreboard:PersonalWidgets.
hook.Add("EdgeScoreboard:PersonalWidgets","EdgeScoreboard:AddGamemodeWidgets",function( items )

	-- Check if we are running darkrp.
	if DarkRP then

		-- ADd the buttons for the personal tab.
		table.insert(items, {
			title = EdgeScoreboard.GetPhrase("PERS_UTIL_RPNAME"), subTitle = EdgeScoreboard.GetPhrase("PERS_UTIL_RPNAME_DESC"), onClick = function(  )
				EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PERS_UTIL_QUERY_RPNAME"), "", function( text )
					RunConsoleCommand("darkrp","name", text)
				end)
			end
		})

		table.insert(items, {
			title = EdgeScoreboard.GetPhrase("PERS_UTIL_DROPMONEY"), subTitle = EdgeScoreboard.GetPhrase("PERS_UTIL_DROPMONEY_DESC"), onClick = function(  )
				EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PERS_UTIL_QUERY_DROPMONEY"), "", function( text )
					RunConsoleCommand("darkrp","dropmoney", text)
				end)
			end
		})

		table.insert(items, {
			title = EdgeScoreboard.GetPhrase("PERS_UTIL_CHEQUE"), subTitle = EdgeScoreboard.GetPhrase("PERS_UTIL_CHEQUE_DESC"), onClick = function(  )
				EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PERS_UTIL_QUERY_DROPMONEY"), "", function( text )
					EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PERS_UTIL_QUERY_CHEQUE"), "", function( text2 )
						RunConsoleCommand("darkrp","cheque", text2, text)
					end)
				end)
			end
		})

		table.insert(items, {
			title = EdgeScoreboard.GetPhrase("PERS_UTIL_SELLALLDOORS"), subTitle = EdgeScoreboard.GetPhrase("PERS_UTIL_SELLALLDOORS_DESC"), onClick = function(  )
				EdgeScoreboard.DermaQuery( EdgeScoreboard.GetPhrase("PERS_UTIL_QUERY_SELLALLDOORS"), {{function(  )
					RunConsoleCommand("darkrp","unownalldoors")
				end}})
			end
		})

	elseif engine.ActiveGamemode() == "murder" then

		table.insert(items, {
			title = EdgeScoreboard.GetPhrase("PERS_UTIL_MURDER_JOINOPPOSITETEAM"), subTitle = EdgeScoreboard.GetPhrase("PERS_UTIL_MURDER_JOINOPPOSITETEAM_DESC"), onClick = function(  )
				RunConsoleCommand("mu_jointeam", LocalPlayer():Team() == 1 and 2 or 1)
			end
		})

	end

	if engine.ActiveGamemode() == "sandbox" or DarkRP then

		table.insert(items, {
			title = EdgeScoreboard.GetPhrase("PERS_UTIL_REMOVEPROPS"), subTitle = EdgeScoreboard.GetPhrase("PERS_UTIL_REMOVEPROPS_DESC"), onClick = function(  )
				EdgeScoreboard.DermaQuery( EdgeScoreboard.GetPhrase("PERS_UTIL_QUERY_REMOVEALLPROPS"), {{function(  )
					RunConsoleCommand("gmod_cleanup")
				end}})
			end
		})

	end

end)

--[[-------------------------------------------------------------------------
Final
---------------------------------------------------------------------------]]

local config_hideCategories = EdgeScoreboard.GetConfigValue( "HideCategories" )
local config_categoryType = EdgeScoreboard.GetConfigValue( "CategoryType" )

if config_hideCategories == "Auto" then

	EdgeScoreboard.CategoriesHidden = EdgeScoreboard.GetConfigValue( "HideCategories" ) == "Hidden" or EdgeScoreboard.HideCategories

else

	EdgeScoreboard.CategoriesHidden = config_hideCategories == "Visible" and false or config_hideCategories == "Hidden" and true

end

if config_categoryType == "Job Name" then
	EdgeScoreboard.CategoriesAsJobs = true
else
	EdgeScoreboard.CategoriesAsJobs = false
end