-- Get the calculated values.
local listData = EdgeScoreboard.listData

-- Get the colors.
local COLORS = EdgeScoreboard.Colors

-- Create a table for the rankColors.
local rankColors = {}

-- Get the rowsorting.
local rowSortingConfig = EdgeScoreboard.GetConfigValue("RowSorting")

-- Loop through all ranks.
for k,v in pairs(EdgeScoreboard.Configuration.Usergroups) do

	if v["CustomDisplayColor_Enabled"] then
		rankColors[string.lower(k)] = v["CustomDisplayColor"]
	end

end

-- Create a function to copy stuff.
local function copyToClipboard(text)
	EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, EdgeScoreboard.GetPhrase("PLYROW_ACT_COPIED") )
	SetClipboardText(text)
end

-- Player basic actions.
local basicPlayerActions = {
	{Title = EdgeScoreboard.GetPhrase("PLYROW_ACT_STEAM"), Icon = "icon16/vcard.png", DoClick = function( ply ) ply:ShowProfile() end},
	{Title = EdgeScoreboard.GetPhrase("PLYROW_ACT_MUTE"), Icon = "icon16/sound_mute.png", DoClick = function( ply ) ply:SetMuted(true) end, ShouldShow = function(ply) return !ply:IsMuted() and ply != LocalPlayer() and !ply:IsBot() and !EdgeScoreboard.GetUsergroupConfigValue( ply,"MuteImmunity")  end},
	{Title = EdgeScoreboard.GetPhrase("PLYROW_ACT_UNMUTE"), Icon = "icon16/sound_mute.png", DoClick = function( ply ) ply:SetMuted(false) end, ShouldShow = function(ply) return ply:IsMuted() and ply != LocalPlayer() and !ply:IsBot() end},
	{CategoryTitle = EdgeScoreboard.GetPhrase("PLYROW_ACT_INFO"), Icon = "icon16/page_paste.png", Items = {
			{Title = EdgeScoreboard.GetPhrase("PLYROW_ACT_USERNAME"), Icon = "icon16/page_copy.png", DoClick = function( ply ) copyToClipboard(EdgeScoreboard.GetFakeIdentity("Name", ply) or (EdgeScoreboard.GetConfigValue("NameType") == "In-Game Name" and ply:Name() or ply:SteamName())) end},
			{Title = EdgeScoreboard.GetPhrase("PLYROW_ACT_GROUP"), Icon = "icon16/page_copy.png", DoClick = function( ply ) copyToClipboard(EdgeScoreboard.GetFakeIdentity("Rank", ply) or ply:GetUserGroup()) end},
			{Title = EdgeScoreboard.GetPhrase("PLYROW_ACT_TEAM"), Icon = "icon16/page_copy.png", DoClick = function( ply ) copyToClipboard(team.GetName(ply:Team())) end, ShouldShow = function(ply) return EdgeScoreboard.GetConfigValue("CopyTeamname") end},
			{Title = EdgeScoreboard.GetPhrase("PLYROW_ACT_STEAMID"), Icon = "icon16/page_copy.png", DoClick = function( ply ) copyToClipboard(ply:SteamID()) end, ShouldShow = function(ply) return !ply:IsBot() end},
			{Title = EdgeScoreboard.GetPhrase("PLYROW_ACT_STEAMID64"), Icon = "icon16/page_copy.png", DoClick = function( ply ) copyToClipboard(ply:SteamID64()) end, ShouldShow = function(ply) return !ply:IsBot() end},
		}
	},
}

-- Insert the category and obtain the key.
local categoryKey = table.insert(basicPlayerActions, {CategoryTitle = EdgeScoreboard.GetPhrase("PLYROW_ACT_TRANSFER"), Icon = "icon16/connect.png", Items = {} })

-- Add the option to transfer a player to a unlisted server.
table.insert(basicPlayerActions[categoryKey].Items, {
	Title = EdgeScoreboard.GetPhrase("PLYROW_TRANSFER_ENTERIP"),
	Icon = "icon16/computer_link.png",
	DoClick = function( ply )
		EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_TRANSFER_ENTERIP_LONG"), "00.00.000.00:27015", function( text )

			-- Make sure that the ip address entered is valid.
			if !string.match(text, "^%d+%.%d+%.%d+%.%d+$") and !string.match(text, "^%d+%.%d+%.%d+%.%d+:%d+$") then
				EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, EdgeScoreboard.GetPhrase("PLYROW_TRANSFER_INVALIDIP") , ply )
				return
			end

			-- Request the server transfer.
			net.Start("EdgeScoreboard:RequestPlayerUnlistedTransfer")
				net.WriteString(text)
				net.WriteEntity(ply)
			net.SendToServer()

		end)
	end,
	ShouldShow = function(ply)
		return EdgeScoreboard.GetUsergroupConfigValue( LocalPlayer(), "TransferToUnlisted" ) and !EdgeScoreboard.GetUsergroupConfigValue( ply, "TransferImmunity" ) and !ply:IsBot()
	end
})

-- Loop through the EdgeScoreboard.Configuration.Servers.
for k,v in pairs(EdgeScoreboard.Configuration.Servers) do

	-- Insert the server.
	table.insert(basicPlayerActions[categoryKey].Items, {
		Title = v.Name,
		Icon = "icon16/computer_link.png",
		DoClick = function( ply )
			EdgeScoreboard.DermaQuery( string.Replace(EdgeScoreboard.GetPhrase("PLYROW_TRANSFER_VERIFY"),"%N",v.Name), {{function(  )
				net.Start("EdgeScoreboard:RequestPlayerTransfer")
					net.WriteUInt(k, 6)
					net.WriteEntity(ply)
				net.SendToServer()
			end}})
		end,
		ShouldShow = function(ply)
			return EdgeScoreboard.GetUsergroupConfigValue( LocalPlayer(), "TransferPlayer" ) and !EdgeScoreboard.GetUsergroupConfigValue( ply, "TransferImmunity" ) and !ply:IsBot()
		end
	})

end

-- Check if the FAdmin actions should be added.
if FAdmin and EdgeScoreboard.GetConfigValue("FAdminPlayerActions") then

	-- Add FAdmin.
	local categoryKey = table.insert(basicPlayerActions,{CategoryTitle = "FAdmin", Icon = "icon16/shield.png", Items = { } })

	-- Create a table for all the FAdmin actions.
	local FAdminActions = {
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_GOTO"), Icon = "icon16/world_go.png", Prev = "Teleport", DoClick = function( ply )
			RunConsoleCommand("fadmin","goto", ply:UserID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_BRING"), Icon = "icon16/world_go.png", Prev = "Teleport", DoClick = function( ply )
			RunConsoleCommand("fadmin","bring", ply:UserID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_SETTEAM"), Icon = "icon16/group.png", Prev = "SetTeam", getOptions = function(  )

			local options = {}

			if DarkRP then

				for k,v in pairs(RPExtraTeams) do
					table.insert(options,{v.name,k,"icon16/chart_line.png"})
				end

			end

			return options

		end, DoClick = function( ply, teamID )
			RunConsoleCommand("fadmin","setteam", ply:UserID(), teamID)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_TOGFREEZE"), Icon = "icon16/controller_delete.png", Prev = "Freeze", DoClick = function( ply )
			RunConsoleCommand("fadmin",ply:FAdmin_GetGlobal("FAdmin_frozen") and "unfreeze" or "freeze",ply:UserID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_BAN"), Icon = "icon16/cancel.png", Prev = "Ban", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_REASON"), "", function( text )
				EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_HOURS"), "60", function( text2 )
					RunConsoleCommand("fadmin","ban", ply:UserID(), text2, text)
				end)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_KICK"), Icon = "icon16/door_out.png", Prev = "Kick", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_REASON"), "", function( text )
				RunConsoleCommand("fadmin","kick", ply:UserID(), text)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_TOGJAIL"), Icon = "icon16/lock.png", Prev = "Jail", DoClick = function( ply )
			if ply:FAdmin_GetGlobal("fadmin_jailed") then
				RunConsoleCommand("fadmin","unjail",ply:UserID())
			else
				EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_SECONDS"), "60", function( text )
					RunConsoleCommand("fadmin","jail",ply:UserID(),"normal",text)
				end)
			end
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_TOGCHATMUTE"), Icon = "icon16/comments_delete.png", Prev = "Chatmute", DoClick = function( ply )
			if ply:FAdmin_GetGlobal("FAdmin_chatmuted") then
				RunConsoleCommand("fadmin","unchatmute",ply:UserID())
			else
				EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_SECONDS"), "60", function( text )
					RunConsoleCommand("fadmin","chatmute", ply:UserID(), text)
				end)
			end
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_TOGVOICEMUTE"), Icon = "icon16/sound_mute.png", Prev = "Voicemute", DoClick = function( ply )
			if ply:FAdmin_GetGlobal("FAdmin_voicemuted") then
				RunConsoleCommand("fadmin","unvoicemute",ply:UserID())
			else
				EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_SECONDS"), "60", function( text )
					RunConsoleCommand("fadmin","voicemute",ply:UserID(),text)
				end)
			end
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_SPECTATE"), Icon = "icon16/eye.png", Prev = "FSpectate", DoClick = function( ply )
			RunConsoleCommand("fspectate", ply:UserID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_STRIP"), Icon = "icon16/basket_remove.png", Prev = "StripWeapons", DoClick = function( ply )
			EdgeScoreboard.DermaQuery( EdgeScoreboard.GetPhrase("PLYROW_AACT_CONFIRM"), {{function(  )
				RunConsoleCommand("fadmin","stripweapons", ply:UserID())
			end}})
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_SETHP"), Icon = "icon16/heart.png", Prev = "SetHealth", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_NUMBER"), "100", function( text )
				RunConsoleCommand("fadmin","sethealth", ply:UserID(), text)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_TOGGOD"), Icon = "icon16/heart_add.png", Prev = "God", DoClick = function( ply )
			RunConsoleCommand("fadmin",ply:FAdmin_GetGlobal("FAdmin_godded") and "ungod" or "god",ply:UserID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_SLAY"), Icon = "icon16/heart_delete.png", Prev = "Slay", DoClick = function( ply )
			EdgeScoreboard.DermaQuery( EdgeScoreboard.GetPhrase("PLYROW_AACT_CONFIRM"), {{function(  )
				RunConsoleCommand("fadmin","slay", ply:UserID())
			end}})
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_TOGIGNITE"), Icon = "icon16/weather_sun.png", Prev = "Ignite", DoClick = function( ply )
			if ply:FAdmin_GetGlobal("FAdmin_ignited") then
				RunConsoleCommand("fadmin","unignite",ply:UserID())
			else
				EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_SECONDS"), "60", function( text )
					RunConsoleCommand("fadmin","ignite",ply:UserID(),text)
				end)
			end
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_SLAP"), Icon = "icon16/bomb.png", Prev = "Slap", DoClick = function( ply )
			RunConsoleCommand("fadmin","slap", ply:UserID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_TOGCLOAK"), Icon = "icon16/status_offline.png", Prev = "Cloak", DoClick = function( ply )
			RunConsoleCommand("fadmin",ply:FAdmin_GetGlobal("FAdmin_cloaked") and "uncloak" or "cloak", ply:UserID())
		end},
	}

	-- Loop through all FAdminActions.
	for k,v in pairs(FAdminActions) do

		-- Insert the ban command.
		table.insert(basicPlayerActions[categoryKey]["Items"], {
			Title = v.Title,
			Icon = v.Icon,
			DoClick = v.DoClick,
			Options = v.getOptions and v.getOptions(),
			ShouldShow = function() return FAdmin.Access.PlayerHasPrivilege(LocalPlayer(), v.Prev) end
		})

	end

end

-- Check if the FAdmin actions should be added.
if ulx and EdgeScoreboard.GetConfigValue("ULXPlayerActions") then

	-- Add FAdmin.
	local categoryKey = table.insert(basicPlayerActions,{CategoryTitle = "ULX", Icon = "icon16/lightning.png", Items = { } })

	-- Create a table for all the FAdmin actions.
	local ULXActions = {
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_GOTO"), Icon = "icon16/world_go.png", Prev = "ulx goto", DoClick = function( ply )
			RunConsoleCommand("ulx","goto", "$" .. ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_BRING"), Icon = "icon16/world_go.png", Prev = "ulx bring", DoClick = function( ply )
			RunConsoleCommand("ulx","bring", "$" .. ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_RETURN"), Icon = "icon16/world_go.png", Prev = "ulx return", DoClick = function( ply )
			RunConsoleCommand("ulx","return", "$" .. ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_TOGFREEZE"), Icon = "icon16/controller_delete.png", Prev = "ulx freeze", DoClick = function( ply )
			RunConsoleCommand("ulx",ply:IsFrozen() == true and "unfreeze" or "freeze","$" .. ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_BAN"), Icon = "icon16/cancel.png", Prev = "ulx ban", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_REASON"), "", function( text )
				EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_SECONDS"), "60", function( text2 )
					RunConsoleCommand("ulx","ban", "$" .. ply:UniqueID(), text2, text)
				end)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_KICK"), Icon = "icon16/door_out.png", Prev = "ulx kick", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_REASON"), "", function( text )
				RunConsoleCommand("ulx","kick", "$" .. ply:UniqueID(), text)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_JAIL"), Icon = "icon16/lock.png", Prev = "ulx jail", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_SECONDS"), "60", function( text )
				RunConsoleCommand("ulx","jail","$" .. ply:UniqueID(),text)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_UNJAIL"), Icon = "icon16/lock.png", Prev = "ulx unjail", DoClick = function( ply )
			RunConsoleCommand("ulx","unjail","$" .. ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_TOGCHATMUTE"), Icon = "icon16/comments_delete.png", Prev = "ulx mute", DoClick = function( ply )
			RunConsoleCommand("ulx",ply:GetNWBool( "ulx_muted", false ) == true and "unmute" or "mute","$" .. ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_TOGVOICEMUTE"), Icon = "icon16/sound_mute.png", Prev = "ulx gag", DoClick = function( ply )
			if ply:GetNWBool( "ulx_gagged", false ) then
				RunConsoleCommand("ulx","ungag","$" .. ply:UniqueID())
			else
				RunConsoleCommand("ulx","gag","$" .. ply:UniqueID())
			end
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_SPECTATE"), Icon = "icon16/eye.png", Prev = "ulx spectate", DoClick = function( ply )
			RunConsoleCommand("ulx", "spectate", "$" .. ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_STRIP"), Icon = "icon16/basket_remove.png", Prev = "ulx strip", DoClick = function( ply )
			EdgeScoreboard.DermaQuery( EdgeScoreboard.GetPhrase("PLYROW_AACT_CONFIRM"), {{function(  )
				RunConsoleCommand("ulx","strip", "$" .. ply:UniqueID())
			end}})
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_SETHP"), Icon = "icon16/heart.png", Prev = "ulx hp", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_NUMBER"), "100", function( text )
				RunConsoleCommand("ulx","hp", "$" .. ply:UniqueID(), text)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_GOD"), Icon = "icon16/heart_add.png", Prev = "ulx god", DoClick = function( ply )
			RunConsoleCommand("ulx","god","$" .. ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_UNGOD"), Icon = "icon16/heart_add.png", Prev = "ulx ungod", DoClick = function( ply )
			RunConsoleCommand("ulx","ungod","$" .. ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_SLAY"), Icon = "icon16/heart_delete.png", Prev = "ulx slay", DoClick = function( ply )
			EdgeScoreboard.DermaQuery( EdgeScoreboard.GetPhrase("PLYROW_AACT_CONFIRM"), {{function(  )
				RunConsoleCommand("ulx","slay", "$" .. ply:UniqueID())
			end}})
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_TOGIGNITE"), Icon = "icon16/weather_sun.png", Prev = "ulx ignite", DoClick = function( ply )
			if ply:IsOnFire() then
				RunConsoleCommand("ulx","unignite","$" .. ply:UniqueID())
			else
				EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_SECONDS"), "60", function( text )
					RunConsoleCommand("ulx","ignite","$" .. ply:UniqueID(),text)
				end)
			end
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_SLAP"), Icon = "icon16/bomb.png", Prev = "ulx slap", DoClick = function( ply )
			RunConsoleCommand("ulx","slap", "$" .. ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_TOGCLOAK"), Icon = "icon16/status_offline.png", Prev = "ulx cloak", DoClick = function( ply )
			RunConsoleCommand("ulx",ply:GetMaterial() == "models/effects/vol_light001" and "uncloak" or "cloak","$" .. ply:UniqueID())
		end},
	}

	-- Loop through all FAdminActions.
	for k,v in pairs(ULXActions) do

		-- Insert the ban command.
		table.insert(basicPlayerActions[categoryKey]["Items"], {
			Title = v.Title,
			Icon = v.Icon,
			DoClick = v.DoClick,
			ShouldShow = function() return !!ULib.ucl.query(LocalPlayer(),v.Prev) end
		})

	end

end

-- Check if the FAdmin actions should be added.
if xAdmin and EdgeScoreboard.GetConfigValue("XADMINPlayerActions") then

	-- Add FAdmin.
	local categoryKey = table.insert(basicPlayerActions,{CategoryTitle = "xAdmin 2", Icon = "icon16/package.png", Items = { } })

	-- Create a table for all the FAdmin actions.
	local xAdminActions = {
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_GOTO"), Icon = "icon16/world_go.png", Prev = "goto", DoClick = function( ply )
			RunConsoleCommand("xadmin","goto", ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_BRING"), Icon = "icon16/world_go.png", Prev = "bring", DoClick = function( ply )
			RunConsoleCommand("xadmin","bring", ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_FREEZE"), Icon = "icon16/controller_delete.png", Prev = "freeze", DoClick = function( ply )
			RunConsoleCommand("xadmin","freeze",ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_UNFREEZE"), Icon = "icon16/controller_delete.png", Prev = "unfreeze", DoClick = function( ply )
			RunConsoleCommand("xadmin","unfreeze",ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_BAN"), Icon = "icon16/cancel.png", Prev = "ban", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_REASON"), "", function( text )
				EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_MINUTES"), "60", function( text2 )
					RunConsoleCommand("xadmin","ban", ply:SteamID(), text2, text)
				end)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_KICK"), Icon = "icon16/door_out.png", Prev = "kick", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_REASON"), "", function( text )
				RunConsoleCommand("xadmin","kick", ply:SteamID(), text)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_JAIL"), Icon = "icon16/lock.png", Prev = "jail", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_REASON"), "", function( text )
				EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_MINUTES"), "60", function( text2 )
					RunConsoleCommand("xadmin","jail", ply:SteamID(), text2, text)
				end)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_UNJAIL"), Icon = "icon16/lock.png", Prev = "unjail", DoClick = function( ply )
			RunConsoleCommand("xadmin","unjail",ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_CHATMUTE"), Icon = "icon16/comments_delete.png", Prev = "mute", DoClick = function( ply )
			RunConsoleCommand("xadmin","mute",ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_CHATUNMUTE"), Icon = "icon16/comments_delete.png", Prev = "unmute", DoClick = function( ply )
			RunConsoleCommand("xadmin","unmute",ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_VOICEMUTE"), Icon = "icon16/sound_mute.png", Prev = "gag", DoClick = function( ply )
			RunConsoleCommand("xadmin","gag",ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_VOICEUNMUTE"), Icon = "icon16/sound_mute.png", Prev = "ungag", DoClick = function( ply )
			RunConsoleCommand("xadmin","ungag",ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_STRIP"), Icon = "icon16/basket_remove.png", Prev = "strip", DoClick = function( ply )
			EdgeScoreboard.DermaQuery( EdgeScoreboard.GetPhrase("PLYROW_AACT_CONFIRM"), {{function(  )
				RunConsoleCommand("xadmin","strip", ply:SteamID())
			end}})
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_SETHP"), Icon = "icon16/heart.png", Prev = "sethealth", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_NUMBER"), "100", function( text )
				RunConsoleCommand("xadmin","sethealth", ply:SteamID(), text)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_TOGGOD"), Icon = "icon16/heart_add.png", Prev = "god", DoClick = function( ply )
			RunConsoleCommand("xadmin","god",ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_SLAY"), Icon = "icon16/heart_delete.png", Prev = "slay", DoClick = function( ply )
			EdgeScoreboard.DermaQuery( EdgeScoreboard.GetPhrase("PLYROW_AACT_CONFIRM"), {{function(  )
				RunConsoleCommand("xadmin","slay", ply:SteamID())
			end}})
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_TOGCLOAK"), Icon = "icon16/status_offline.png", Prev = "cloak", DoClick = function( ply )
			RunConsoleCommand("xadmin","cloak",ply:SteamID())
		end},
	}

	-- Loop through all FAdminActions.
	for k,v in pairs(xAdminActions) do

		-- Insert the ban command.
		table.insert(basicPlayerActions[categoryKey]["Items"], {
			Title = v.Title,
			Icon = v.Icon,
			DoClick = v.DoClick,
			ShouldShow = function(target) return LocalPlayer():xAdminHasPermission(v.Prev) and !target:IsBot() end
		})

	end

end

-- Check if the FAdmin actions should be added.
if serverguard and EdgeScoreboard.GetConfigValue("SERVERGUARDPlayerActions") then

	-- Add FAdmin.
	local categoryKey = table.insert(basicPlayerActions,{CategoryTitle = "ServerGuard", Icon = "icon16/lock.png", Items = { } })

	-- Create a table for all the FAdmin actions.
	local SGActions = {
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_GOTO"), Icon = "icon16/world_go.png", Prev = "Goto", DoClick = function( ply )
			RunConsoleCommand("sg","goto", ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_BRING"), Icon = "icon16/world_go.png", Prev = "Bring", DoClick = function( ply )
			RunConsoleCommand("sg","bring", ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_TOGFREEZE"), Icon = "icon16/controller_delete.png", Prev = "Freeze", DoClick = function( ply )
			RunConsoleCommand("sg","freeze",ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_BAN"), Icon = "icon16/cancel.png", Prev = "Ban", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_REASON"), "", function( text )
				EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_MINUTES"), "60", function( text2 )
					RunConsoleCommand("sg","ban", ply:UniqueID(), text2, text)
				end)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_KICK"), Icon = "icon16/door_out.png", Prev = "Kick", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_REASON"), "", function( text )
				RunConsoleCommand("sg","kick", ply:UniqueID(), text)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_JAIL"), Icon = "icon16/lock.png", Prev = "Jail", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_SECONDS"), "60", function( text )
				RunConsoleCommand("sg","jail", ply:UniqueID(), text)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_UNJAIL"), Icon = "icon16/lock.png", Prev = "Jail", DoClick = function( ply )
			RunConsoleCommand("sg","unjail",ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_CHATMUTE"), Icon = "icon16/comments_delete.png", Prev = "Mute", DoClick = function( ply )
			RunConsoleCommand("sg","mute",ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_CHATUNMUTE"), Icon = "icon16/comments_delete.png", Prev = "Unmute", DoClick = function( ply )
			RunConsoleCommand("sg","unmute",ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_VOICEMUTE"), Icon = "icon16/sound_mute.png", Prev = "Gag", DoClick = function( ply )
			RunConsoleCommand("sg","gag",ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_VOICEUNMUTE"), Icon = "icon16/sound_mute.png", Prev = "Ungag", DoClick = function( ply )
			RunConsoleCommand("sg","ungag",ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_STRIP"), Icon = "icon16/basket_remove.png", Prev = "Strip Weapons", DoClick = function( ply )
			EdgeScoreboard.DermaQuery( EdgeScoreboard.GetPhrase("PLYROW_AACT_CONFIRM"), {{function(  )
				RunConsoleCommand("sg","stripweapons", ply:UniqueID())
			end}})
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_SETHP"), Icon = "icon16/heart.png", Prev = "Set Health", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_NUMBER"), "100", function( text )
				RunConsoleCommand("sg","hp", ply:UniqueID(), text)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_GOD"), Icon = "icon16/heart_add.png", Prev = "God mode", DoClick = function( ply )
			RunConsoleCommand("sg","god",ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_UNGOD"), Icon = "icon16/heart_add.png", Prev = "God mode", DoClick = function( ply )
			RunConsoleCommand("sg","ungod",ply:UniqueID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_SLAY"), Icon = "icon16/heart_delete.png", Prev = "Slay", DoClick = function( ply )
			EdgeScoreboard.DermaQuery( EdgeScoreboard.GetPhrase("PLYROW_AACT_CONFIRM"), {{function(  )
				RunConsoleCommand("sg","slay", ply:UniqueID())
			end}})
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_TOGCLOAK"), Icon = "icon16/status_offline.png", Prev = "Invisible", DoClick = function( ply )
			RunConsoleCommand("sg","cloak",ply:UniqueID())
		end},
	}

	-- Loop through all FAdminActions.
	for k,v in pairs(SGActions) do

		-- Insert the ban command.
		table.insert(basicPlayerActions[categoryKey]["Items"], {
			Title = v.Title,
			Icon = v.Icon,
			DoClick = v.DoClick,
			ShouldShow = function() return serverguard.player:HasPermission(LocalPlayer(), v.Prev) end
		})

	end

end

-- Check if the FAdmin actions should be added.
if sam and EdgeScoreboard.GetConfigValue("SAMPlayerActions") then

	-- Add FAdmin.
	local categoryKey = table.insert(basicPlayerActions,{CategoryTitle = "SAM", Icon = "icon16/eye.png", Items = { } })

	-- Create a table for all the FAdmin actions.
	local SGActions = {
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_GOTO"), Icon = "icon16/world_go.png", Prev = "goto", DoClick = function( ply )
			RunConsoleCommand("sam","goto", ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_BRING"), Icon = "icon16/world_go.png", Prev = "bring", DoClick = function( ply )
			RunConsoleCommand("sam","bring", ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_SETTEAM"), Icon = "icon16/group.png", Prev = "setjob", getOptions = function(  )

			local options = {}

			if DarkRP then

				for k,v in pairs(RPExtraTeams) do
					table.insert(options,{v.name,v.command,"icon16/chart_line.png"})
				end

			end

			return options

		end, DoClick = function( ply, teamID )
			RunConsoleCommand("sam","setjob", ply:SteamID(), teamID)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_FREEZE"), Icon = "icon16/controller_delete.png", Prev = "freeze", DoClick = function( ply )
			RunConsoleCommand("sam","freeze",ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_UNFREEZE"), Icon = "icon16/controller_delete.png", Prev = "unfreeze", DoClick = function( ply )
			RunConsoleCommand("sam","unfreeze",ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_BAN"), Icon = "icon16/cancel.png", Prev = "ban", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_REASON"), "", function( text )
				EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_MINUTES"), "60", function( text2 )
					RunConsoleCommand("sam","ban", ply:SteamID(), text2, text)
				end)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_KICK"), Icon = "icon16/door_out.png", Prev = "kick", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_REASON"), "", function( text )
				RunConsoleCommand("sam","kick", ply:SteamID(), text)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_JAIL"), Icon = "icon16/lock.png", Prev = "jail", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_MINUTES"), "60", function( text )
				RunConsoleCommand("sam","jail", ply:SteamID(), text)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_UNJAIL"), Icon = "icon16/lock.png", Prev = "unjail", DoClick = function( ply )
			RunConsoleCommand("sam","unjail",ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_CHATMUTE"), Icon = "icon16/comments_delete.png", Prev = "mute", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_REASON"), "", function( text )
				EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_MINUTES"), "60", function( text2 )
					RunConsoleCommand("sam","mute", ply:SteamID(), text2, text)
				end)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_CHATUNMUTE"), Icon = "icon16/comments_delete.png", Prev = "unmute", DoClick = function( ply )
			RunConsoleCommand("sam","unmute",ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_VOICEMUTE"), Icon = "icon16/sound_mute.png", Prev = "gag", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_REASON"), "", function( text )
				EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_MINUTES"), "60", function( text2 )
					RunConsoleCommand("sam","gag", ply:SteamID(), text2, text)
				end)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_VOICEUNMUTE"), Icon = "icon16/sound_mute.png", Prev = "ungag", DoClick = function( ply )
			RunConsoleCommand("sam","ungag",ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_STRIP"), Icon = "icon16/basket_remove.png", Prev = "strip", DoClick = function( ply )
			EdgeScoreboard.DermaQuery( EdgeScoreboard.GetPhrase("PLYROW_AACT_CONFIRM"), {{function(  )
				RunConsoleCommand("sam","strip", ply:SteamID())
			end}})
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_SETHP"), Icon = "icon16/heart.png", Prev = "hp", DoClick = function( ply )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PLYROW_AACT_NUMBER"), "100", function( text )
				RunConsoleCommand("sam","hp", ply:SteamID(), text)
			end)
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_GOD"), Icon = "icon16/heart_add.png", Prev = "god", DoClick = function( ply )
			RunConsoleCommand("sam","god",ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_UNGOD"), Icon = "icon16/heart_add.png", Prev = "ungod", DoClick = function( ply )
			RunConsoleCommand("sam","ungod",ply:SteamID())
		end},
		{Title = EdgeScoreboard.GetPhrase("PLYROW_AACT_SLAY"), Icon = "icon16/heart_delete.png", Prev = "slay", DoClick = function( ply )
			EdgeScoreboard.DermaQuery( EdgeScoreboard.GetPhrase("PLYROW_AACT_CONFIRM"), {{function(  )
				RunConsoleCommand("sam","slay", ply:SteamID())
			end}})
		end},
	}

	-- Loop through all FAdminActions.
	for k,v in pairs(SGActions) do

		-- Insert the ban command.
		table.insert(basicPlayerActions[categoryKey]["Items"], {
			Title = v.Title,
			Icon = v.Icon,
			DoClick = v.DoClick,
			Options = v.getOptions and v.getOptions(),
			ShouldShow = function(target) return LocalPlayer():HasPermission(v.Prev) and !target:IsBot() end
		})

	end

end


-- Check if we are running the murder gamemode.
if engine.ActiveGamemode() == "murder" then

	-- Insert the murder category.
	local categoryKey = table.insert(basicPlayerActions,{CategoryTitle = "Murder", Icon = "icon16/folder_brick.png", Items = { } })

	table.insert(basicPlayerActions[categoryKey]["Items"], {
		Title = function ( ply )
			return Translator:QuickVar(translate.adminMoveToSpectate, "spectate", team.GetName(1))
		end,
		Icon = "icon16/status_busy.png",
		DoClick = function(ply) RunConsoleCommand("mu_movetospectate", ply:EntIndex()) end,
		ShouldShow = function(ply) return LocalPlayer():IsAdmin() and ply:Team() == 2 end
	})

	table.insert(basicPlayerActions[categoryKey]["Items"], {
		Title = translate.adminMurdererForce,
		Icon = "icon16/delete.png",
		DoClick = function(ply) RunConsoleCommand("mu_forcenextmurderer", ply:EntIndex()) end,
		ShouldShow = function(ply) return LocalPlayer():IsAdmin() and ply:Team() == 2 end
	})

	table.insert(basicPlayerActions[categoryKey]["Items"], {
		Title = translate.adminSpectate,
		Icon = "icon16/status_online.png",
		DoClick = function(ply) RunConsoleCommand("mu_spectate", ply:EntIndex()) end,
		ShouldShow = function(ply) return LocalPlayer():IsAdmin() and ply:Team() == 2 end
	})

end

-- Create materials.
local MAT_HIDDEN = Material("edgescoreboard/icon_hidden.png","smooth")
local MAT_MUTED = Material("edgescoreboard/icon_muted.png","smooth")

local friendAlpha = 0
local alphaIncreasing = true

if EdgeScoreboard.GetConfigValue("ShowFriends") then

	hook.Add("HUDPaint", "EdgeScoreboard:FriendAlphaLerp", function(  )

		if IsValid(EdgeScoreboard.boardData) and EdgeScoreboard.boardData:IsVisible() then return end

		-- Check if we are increasing or decreasing.
		if alphaIncreasing then

			-- Set alphaIncreasing to true if it isn't set.
			if friendAlpha >= 14.9 then alphaIncreasing = false end

			-- Update the friendAlpha.
			friendAlpha = Lerp(FrameTime() * 3, friendAlpha, 15)

		else

			-- Set alphaIncreasing to true if it isn't set.
			if friendAlpha <= 0.1 then alphaIncreasing = true end

			-- Update the friendAlpha.
			friendAlpha = Lerp(FrameTime() * 3, friendAlpha, 0)

		end

	end)

	hook.Add("EdgeScoreboard:Show", "EdgeScoreboard:ResetPlayerAlpha", function(  )
		friendAlpha = 8
		alphaIncreasing = true
	end)

end

local dataTypes = {
	["Rank"] = {
		title = EdgeScoreboard.GetPhrase("PLAYERLIST_PREFIX_RANK"),
		getData = function( panel )

			-- Check if we have access to see hidden names.
			if EdgeScoreboard.GetUsergroupConfigValue( LocalPlayer(), "FakeIdentity:SeeOriginal" ) and EdgeScoreboard.GetFakeIdentity("Rank", panel.Player) != nil then

				-- Set the centerField color.
				panel.centerField.dataColor = rankColors[ string.lower(EdgeScoreboard.GetFakeIdentity("Rank", panel.Player) or "") ] or COLORS["White"]

				-- Set the data.
				panel.centerField.Data = panel.Player:ESB_GetRank(true) .. " (" .. panel.Player:ESB_GetRank() .. ")"

			else

				-- Get the fake rank.
				local fakeUserGroup = EdgeScoreboard.GetFakeIdentity("Rank", panel.Player)

				-- Get the usergroup of the player.
				local playerUserGroup = fakeUserGroup and panel.Player:ESB_GetRank(true) or panel.Player:ESB_GetRank()

				-- Set the centerField color.
				panel.centerField.dataColor = rankColors[ string.lower(fakeUserGroup or panel.Player:GetUserGroup()) ] or COLORS["White"]

				-- Make sure the usergroup isnt empty.
				if playerUserGroup == "" then
					playerUserGroup = EdgeScoreboard.GetPhrase("PLYROW_RANK_NONE")
				end

				-- Set the data.
				panel.centerField.Data = playerUserGroup

			end
		end
	},
	["Job"] = {
		title = EdgeScoreboard.GetPhrase("PLAYERLIST_PREFIX_JOB"),
		getData = function( panel )
			panel.centerField.Data = IsValid(panel.Player) and (DarkRP and panel.Player:getDarkRPVar("job") or team.GetName(panel.Player:Team())) or "-"
		end
	},
	["DarkRP Level"] = {
		title = EdgeScoreboard.GetPhrase("PLAYERLIST_PREFIX_LEVEL"),
		getData = function( panel )
			panel.centerField.Data = IsValid(panel.Player) and (DarkRP and LevelSystemConfiguration and panel.Player:getDarkRPVar("level") or 0) or "-"
		end
	},
	["DarkRP Wallet"] = {
		title = EdgeScoreboard.GetPhrase("PLAYERLIST_PREFIX_WALLET"),
		getData = function( panel )

			-- Make sure DarkRP is installed.
			if !DarkRP then panel.centerField.Data = "DarkRP" return end
			if !IsValid(panel.Player) then panel.centerField.Data = "-" return end

			local curMoney = panel.Player:getDarkRPVar("money") or 0

			if curMoney < 1000 then
				panel.centerField.Data = DarkRP.formatMoney(curMoney)
			elseif curMoney / 10^9 >= 1 then
				panel.centerField.Data = string.Replace(EdgeScoreboard.GetPhrase("PLYROW_MONEY_BILLION"), "%M", DarkRP.formatMoney(tonumber(string.Left(curMoney / 10^9, 4))))
			elseif curMoney / 10^6 >= 1 then
				panel.centerField.Data = string.Replace(EdgeScoreboard.GetPhrase("PLYROW_MONEY_MILLION"), "%M", DarkRP.formatMoney(tonumber(string.Left(curMoney / 10^6, 4))))
			elseif curMoney / 10^3 >= 1 then
				panel.centerField.Data = string.Replace(EdgeScoreboard.GetPhrase("PLYROW_MONEY_THOUSAND"), "%M", DarkRP.formatMoney(tonumber(string.Left(curMoney / 10^3, 4))))
			end

		end
	},
	["DarkRP Status"] = {
		title = EdgeScoreboard.GetPhrase("PLAYERLIST_PREFIX_STATUS"),
		getData = function( panel )

			if !DarkRP then panel.centerField.Data = "DarkRP" return end
			if !IsValid(panel.Player) then panel.centerField.Data = "-" return end

			if panel.Player:Alive() then
				if panel.Player:getDarkRPVar("Arrested") then
					panel.centerField.Data = EdgeScoreboard.GetPhrase("PLAYERLIST_STATUS_ARRESTED")
				elseif panel.Player:getDarkRPVar("wanted") then
					panel.centerField.Data = EdgeScoreboard.GetPhrase("PLAYERLIST_STATUS_WANTED")
				else
					panel.centerField.Data = EdgeScoreboard.GetPhrase("PLAYERLIST_STATUS_ALIVE")
				end
			else
				panel.centerField.Data = EdgeScoreboard.GetPhrase("PLAYERLIST_STATUS_DEAD")
			end

		end
	},
}

local usergroupsZIndex = {}

local mainType = EdgeScoreboard.GetConfigValue("CenterFieldType")
local hoverType = EdgeScoreboard.GetConfigValue("CenterFieldType_Hover")

-- Create a table to store the derma element in.
local PANEL = {}

-- Create a function to create a new dataField.
function PANEL:CreateDataField( id, prefix, align, getDataColor )

	-- Create a panel for the username of the player.
	local dataField = vgui.Create("DPanel",self)
	dataField:SetTall(listData.RowHeight)

	-- Create a variable to store the data.
	dataField.Data = ""
	dataField.prefix = prefix

	-- Draw the information in the NameField.
	dataField.Paint = function( s, w, h)

		-- Get the XPos.
		local xPos = align == TEXT_ALIGN_CENTER and w / 2 or 0

		-- Draw the prefix.
		draw.SimpleText( dataField.prefix, "EdgeScoreboard:ListRowPrefix", xPos, listData.RowTextMargin, self.rowColor, align )

		-- Draw the data.
		draw.SimpleText( s.Data, "EdgeScoreboard:ListRowData", xPos, listData.RowHeight - listData.RowTextMargin, getDataColor and getDataColor() or COLORS["White"], align, TEXT_ALIGN_BOTTOM )

	end

	-- Register the datafield.
	self.dataFields[id] = dataField

	-- Return the datafield.
	return dataField

end

local isTTT = engine.ActiveGamemode() == "terrortown"

-- Create a init function for the panel.
function PANEL:Init( )

	-- Setup thr row.
	self:SetSize(listData.RowWidth,listData.RowHeight)

	-- Create a var for if the row is hovered.
	self.isHovered = false
	self.isFriend = false

	-- Paint the panel.
	EdgeScoreboard.SetEdgeTheme( self, true, true, function( s,w,h )

		local drawFriend = true
		local drawDead = EdgeScoreboard.GetConfigValue("HighlightDead")

		if isTTT then
			drawDead = false
		end

		if EdgeScoreboard.GetConfigValue("TTTGroups") then

			-- Check if the player is a detective.
			if isTTT and self.Player:IsDetective() then

				surface.SetDrawColor(COLORS["TTT_Detective"])
				surface.DrawRect(0, 0, w, h)

				drawFriend = false

			end

			-- Check if the player is a steam friend.
			if isTTT and self.Player:IsTraitor() then

				surface.SetDrawColor(COLORS["TTT_Traitor"])
				surface.DrawRect(0, 0, w, h)

				drawFriend = false

			end

		end

		if drawDead and IsValid(self.Player) and !self.Player:Alive() and self.Player:Deaths() > 0 then
			surface.SetDrawColor(COLORS["Row_Dead"])
			surface.DrawRect(0, 0, w, h)
			drawFriend = false
		end

		-- Check if the player is a steam friend.
		if drawFriend and EdgeScoreboard.GetConfigValue("ShowFriends") and self.isFriend and IsValid(self.Player) and !EdgeScoreboard.HasFakeIdentity(self.Player) then
			surface.SetDrawColor(ColorAlpha(COLORS["Row_Friend"], math.Round(friendAlpha)))
			surface.DrawRect(0, 0, w, h)
		end

		-- Check if the panel is hovered.
		if self.isHovered then
			surface.SetDrawColor(COLORS["HoverRow"])
			surface.DrawRect(0, 0, w, h)
		end

	end )

	-- Create a table for the fake identity.
	self.fakeIdentity = {}

	-- Create a table of all fields that should autoUpdate.
	self.AutoUpdatingFields = {}

	-- Create a var for the color of the row.
	self.rowColor = Color(255, 255, 255, 255)

	-- Create a table for the rows dataFields.
	self.dataFields = {}

	-- Create the avatar.
	self.avatar = vgui.Create("AvatarImage",self)
	self.avatar:SetSize(listData.AvatarSize,listData.AvatarSize)
	self.avatar:SetPos(listData.AvatarMargin,listData.AvatarMargin)

	-- Add a outline to the avatar.
	self.avatar.PaintOver = function( s, w, h )

		if !IsValid(self.Player) then return end

		-- Check if the user doesn't have an avatar.
		if self.Player:IsBot() then

			-- Draw the background.
			surface.SetDrawColor(COLORS["Avatar_Gray"])
			surface.DrawRect(0,0,w,h)

			-- Draw the first letter of the name. FirstCharacter
			draw.SimpleText("?", "EdgeScoreboard:List_Avatar", w / 2, h / 2, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

		end

		if math.Round(CurTime() % 1.25) == 1 then

			-- Check if the player is hidden and if we have access to see it.
			if EdgeScoreboard.GetFakeIdentity("Hidden", self.Player) and EdgeScoreboard.GetUsergroupConfigValue(LocalPlayer(),"FakeIdentity:SeeHidden") then

				-- Draw the background.
				surface.SetDrawColor(COLORS["Hidden_Red"])
				surface.DrawRect(0, 0, w, h)

				-- Draw the icon.
				surface.SetDrawColor(COLORS["White"])
				surface.SetMaterial(MAT_HIDDEN)
				surface.DrawTexturedRect(w * 0.15, w * 0.15, w * 0.7, w * 0.7)

			elseif self.Player:IsMuted() then

				-- Draw the background.
				surface.SetDrawColor(COLORS["Muted_Red"])
				surface.DrawRect(0, 0, w, h)

				-- Draw the icon.
				surface.SetDrawColor(COLORS["White"])
				surface.SetMaterial(MAT_MUTED)
				surface.DrawTexturedRect(w * 0.15, w * 0.15, w * 0.7, w * 0.7)

			end

		end

		-- Draw the outline.
		surface.SetDrawColor(COLORS["Avatar_Outline"])
		surface.DrawOutlinedRect(0,0,w,h)

	end

	-- Calculate the nameFieldPositon.
	local nameFieldPos = listData.AvatarMargin * 2.5 + listData.AvatarSize

	-- Create the nameField.
	self.nameField = self:CreateDataField("NAME", EdgeScoreboard.GetPhrase("PLAYERLIST_PREFIX_NAME"), TEXT_ALIGN_LEFT)
	self.nameField:SetWide(EdgeScoreboard.nameDataWidth)
	self.nameField:SetPos(nameFieldPos, 0)

	-- Add the name field to autoUpdating.
	self.AutoUpdatingFields["NAME"] = self.nameField

	-- Create a UpdateField function for the namefield.
	self.nameField.UpdateField = function(  )

		-- Check if we have access to see hidden names.
		if EdgeScoreboard.GetUsergroupConfigValue( LocalPlayer(), "FakeIdentity:SeeOriginal" ) and EdgeScoreboard.GetFakeIdentity("Name", self.Player) != nil then
			self.nameField.Data = EdgeScoreboard.GetFakeIdentity("Name", self.Player) .. " (" .. (EdgeScoreboard.GetConfigValue("NameType") == "In-Game Name" and self.Player:Name() or self.Player:SteamName()) .. ")"
		else
			self.nameField.Data = EdgeScoreboard.GetFakeIdentity("Name", self.Player) or (EdgeScoreboard.GetConfigValue("NameType") == "In-Game Name" and self.Player:Name() or self.Player:SteamName())
		end

		-- Make sure that the player is valid.
		if !IsValid(self.Player) then
			self:SetZPos(32767)
		elseif rowSortingConfig == "Usergroup" then

			-- Check if the usergroup of this player has a custom predefined zindex.
			local predefinedZIndex = EdgeScoreboard.GetUsergroupConfigValue(self.Player,"UsergroupZIndex")

			if predefinedZIndex and predefinedZIndex != -1 and isnumber(predefinedZIndex) then

				-- Set the ZIndex.
				self:SetZPos(predefinedZIndex)

			else

				-- Get the usergroup of the player.
				local plyUsergroup = self.Player:GetUserGroup()

				-- Make sure the usergroup is valid
				if !plyUsergroup or plyUsergroup == "" then
					self:SetZPos(32767)
				end

				-- Check if we have a index for the usergroup.
				if !usergroupsZIndex[plyUsergroup] then
					usergroupsZIndex[plyUsergroup] = table.Count(usergroupsZIndex) + 501
				end

				-- Set the ZIndex.
				self:SetZPos(usergroupsZIndex[plyUsergroup])

			end

		else

			-- Update the ZPos.
			self:SetZPos(string.byte(string.lower(self.nameField.Data[1])))

		end

	end

	-- Create a var for the next autoUpdate.
	self.nextAutoUpdate = CurTime() + 3

	-- Create a variable for the next fieldPosition.
	local nextFieldPosition = listData.RowWidth - listData.AvatarMargin * 1.5

	-- Loop through the other dataSources.
	for k,v in pairs(EdgeScoreboard.list_RowDataSources) do

		-- Get the width of the prefixText.
		surface.SetFont("EdgeScoreboard:ListRowPrefix")
		local width, _ = surface.GetTextSize(v.prefix) + 2

		-- Update nextFieldPosition.
		nextFieldPosition = nextFieldPosition - width

		-- Create a new dataField.
		local dataField = self:CreateDataField(v.id,v.prefix,TEXT_ALIGN_CENTER)
		dataField:SetWide(width)
		dataField:SetPos(nextFieldPosition)
		EdgeScoreboard.list_RowDataSources[k].Element = dataField

		-- Check if the field is autoUpdating.
		if v.autoUpdate then

			-- Add the field to the list.
			self.AutoUpdatingFields[v.id] = dataField

		end

		-- Attach a getdata function.
		dataField.UpdateField = function( )

			dataField.Data = v.getData(self.Player)

		end


		-- Set the data.
		dataField.Data = "N/A"

		-- Check if there are more rows.
		if EdgeScoreboard.list_RowDataSources[k + 1] then
			nextFieldPosition = nextFieldPosition - listData.RowTextSideMargin
		end

	end

	local curTitle = dataTypes[mainType].title

	-- Create the centerField.
	self.centerField = self:CreateDataField("CENTER", curTitle, TEXT_ALIGN_CENTER, function(  ) return self.centerField.dataColor end)
	self.centerField:SetWide(math.min(nextFieldPosition - self.nameField:GetWide() - nameFieldPos,listData.RowWidth * 0.2))
	self.centerField:SetPos(self.nameField:GetWide() + nameFieldPos, 0)
	self.centerField.dataColor = COLORS["White"]

	-- Add the name field to autoUpdating.
	self.AutoUpdatingFields["CENTER"] = self.centerField

	-- Create the rowButton.
	local rowButton = vgui.Create("DButton",self)
	rowButton:SetSize(self:GetWide(), self:GetTall())
	rowButton:SetText("")
	rowButton.Paint = function( ) end
	self.rowButton = rowButton

	rowButton.Think = function(  )

		self.isHovered = rowButton:IsHovered()

	end

	rowButton.DoClick = function(  )

		-- Create the menu
		local actionsMenu = DermaMenu(self)
		EdgeScoreboard.SetEdgeTheme(actionsMenu)

		-- Loop through basicPlayerActions
		for k,v in pairs(basicPlayerActions) do

			-- Check what type it is.
			if v == "SPACE" then
				actionsMenu:AddSpacer()
				continue
			elseif v.CategoryTitle then

				local submenu, submenuOption = actionsMenu:AddSubMenu( v.CategoryTitle )
				EdgeScoreboard.SetEdgeTheme(submenu)
				submenuOption:SetIcon(v.Icon)
				submenuOption:SetTextColor(COLORS["White"])

				for k2,v2 in pairs(v.Items) do

					if v2.ShouldShow == nil or v2.ShouldShow(self.Player) == true then

						if v2.Options then

							local submenu2, submenuOption2 = submenu:AddSubMenu( v2.Title )
							EdgeScoreboard.SetEdgeTheme(submenu2)
							submenuOption2:SetIcon(v2.Icon)
							submenuOption2:SetTextColor(COLORS["White"])

							for k3,v3 in pairs(v2.Options) do

								local option = submenu2:AddOption(v3[1], function(  )
									v2.DoClick(self.Player, v3[2])
								end)
								option:SetIcon(v3[3])
								option:SetTextColor(COLORS["White"])

							end

						else

							local option = submenu:AddOption(isstring(v2.Title) and v2.Title or v2.Title(self.Player), function(  )
								v2.DoClick(self.Player)
							end)
							option:SetIcon(v2.Icon)
							option:SetTextColor(COLORS["White"])

						end

					end

				end

				if submenu:ChildCount() == 0 then
					submenuOption:Remove()
				end

			else

				if v.ShouldShow == nil or v.ShouldShow(self.Player) == true then

					local option = actionsMenu:AddOption(isstring(v.Title) and v.Title or v.Title(self.Player), function(  )
						v.DoClick(self.Player)
					end)
					option:SetIcon(v.Icon)
					option:SetTextColor(COLORS["White"])

				end

			end

		end

		-- Open the menu.
		actionsMenu:Open()

		-- Add a hook to hide the actionsMenu.
		hook.Add("EdgeScoreboard:Hide", "EdgeScoreboard:HideActionsMenu", function(  )

			-- Make sure actionsMenu is valid.
			if !IsValid(actionsMenu) then return end

			-- Hide the actionsMenu.
			actionsMenu:Hide()

		end)

	end

	rowButton.OnCursorEntered = function (  )

		-- Play a clicking sound.
		EdgeScoreboard.ClickSound()

		if !dataTypes[hoverType] then return end

		-- Check if the title has been updated.
		if dataTypes[hoverType].title != curTitle then
			curTitle = dataTypes[hoverType].title
			self.centerField.prefix = dataTypes[hoverType].title
		end

		-- Update the data field.
		self.centerField.dataColor = COLORS["White"]
		dataTypes[hoverType].getData(self)

	end

	rowButton.OnCursorExited = function(  )

		-- Check if the title has been updated.
		if dataTypes[mainType].title != curTitle then
			curTitle = dataTypes[mainType].title
			self.centerField.prefix = dataTypes[mainType].title
		end

		-- Update the data field.
		self.centerField.dataColor = COLORS["White"]
		dataTypes[mainType].getData(self)

	end

	rowButton.OnFocusChanged = function(  )

		if !rowButton:IsHovered() then
			rowButton.OnCursorExited()
		end

	end

	-- Create a UpdateField function for the centerField.
	self.centerField.UpdateField = function( ply )

		-- Check if the row is hovered.
		if rowButton:IsHovered() and hoverType != "Disabled" then
			rowButton.OnCursorEntered()
		else
			rowButton.OnCursorExited()
		end

	end

end

-- Create a function to setup the player.
function PANEL:SetupPlayer( ply )

	-- Check if the player already have a row.
	if ply.EdgeScoreboard_Row and IsValid(ply.EdgeScoreboard_Row) then

		-- Remove the row.
		ply.EdgeScoreboard_Row:Remove()

	end

	-- Set the player of the row.
	self.Player = ply

	-- Assign the current row to the player.
	ply.EdgeScoreboard_Row = self

	-- Update vars.
	self.rowCategory = ply:ESB_GetTeam(  )
	self.rowColor = EdgeScoreboard.GetTeamColor(self.rowCategory)

	-- Check if the player is a steam friend.
	if ply:GetFriendStatus() == "friend" then
		self.isFriend = true
	end

	-- Loop through all dataFields.
	for k,v in pairs(self.dataFields) do

		-- Set the data in the datafield.
		v.UpdateField()

	end

	-- Make sure that the player is valid.
	if !IsValid(self.Player) then
		self:SetZPos(32767)
	elseif rowSortingConfig == "Usergroup" then

		-- Check if the usergroup of this player has a custom predefined zindex.
		local predefinedZIndex = EdgeScoreboard.GetUsergroupConfigValue(self.Player,"UsergroupZIndex")

		if predefinedZIndex != false and predefinedZIndex != -1 then

			-- Set the ZIndex.
			self:SetZPos(predefinedZIndex)

		else

			-- Get the usergroup of the player.
			local plyUsergroup = self.Player:GetUserGroup()

			-- Make sure the usergroup is valid
			if !plyUsergroup or plyUsergroup == "" then
				self:SetZPos(32767)
			end

			-- Check if we have a index for the usergroup.
			if !usergroupsZIndex[plyUsergroup] then
				usergroupsZIndex[plyUsergroup] = table.Count(usergroupsZIndex) + 501
			end

			-- Set the ZIndex.
			self:SetZPos(usergroupsZIndex[plyUsergroup])

		end

	else

		-- Update the ZPos.
		self:SetZPos(string.byte(string.lower(self.nameField.Data[1])))

	end

	-- Check if the player has a fake identity and avatar.
	if EdgeScoreboard.GetFakeIdentity("Avatar", ply) then

		-- Set the fake avatar of the row.
		self.avatar:SetSteamID(EdgeScoreboard.GetFakeIdentity("Avatar", ply),listData.AvatarSize)

	else

		-- Set the avatar of the row.
		self.avatar:SetPlayer(ply,listData.AvatarSize)

	end

end

-- Create a think function for the panel.
function PANEL:Think( )

	-- Make sure that the player is still online.
	if !IsValid(self.Player) then

		-- Call a hook that the row is about to be removed.
		hook.Run("EdgeScoreboard:RowRemoved", self)

		-- Remove the row.
		self:Remove()

		-- Stop the function
		return

	end

	-- Check if we should autoUpdate some datafields.
	if self.nextAutoUpdate < CurTime() then

		-- Set the next autoupdate.
		self.nextAutoUpdate = CurTime() + 3

		-- Loop through all autoupdating fields.
		for k,v in pairs(self.AutoUpdatingFields) do

			-- Call their updateFunction.
			v.UpdateField()

		end

	end

end

-- Register the derma element.
vgui.Register("EdgeScoreboard:Row", PANEL)