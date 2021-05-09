local EDGESCOREBOARD_TABLE_MERGE = 1
local EDGESCOREBOARD_TABLE_FRESH = 2

--[[-------------------------------------------------------------------------
Network Cooldown Manager
---------------------------------------------------------------------------]]

-- Add a hook for when a player firsts spawns.
hook.Add("PlayerInitialSpawn","EdgeScoreboard:SetupCooldowns",function( ply )
	ply.EdgeScoreboard_Cooldowns = {}
end)

-- Create a function to check if a player has a cooldown.
function EdgeScoreboard.HasCooldown( ply, ID, cooldownToAdd )

	-- Make sure that we have cooldownToAdd.
	cooldownToAdd = cooldownToAdd or 0.5

	-- Make sure that we have an ID-
	ID = ID or "_"

	-- Make sure that the player is valid.
	if !IsValid(ply) then return end

	-- Make sure that the player has a cooldown with this ID.
	ply.EdgeScoreboard_Cooldowns[ID] = ply.EdgeScoreboard_Cooldowns[ID] or 0

	-- Check if the player has a cooldown. 
	if ply.EdgeScoreboard_Cooldowns[ID] > RealTime() then return true end

	-- Give the player a new cooldown.
	ply.EdgeScoreboard_Cooldowns[ID] = RealTime() + cooldownToAdd

	-- Return false.
	return false

end

--[[-------------------------------------------------------------------------
Uptime, deaths, etc.
---------------------------------------------------------------------------]]

-- Pool network messages.
util.AddNetworkString("EdgeScoreboard:PlayerDeath")
util.AddNetworkString("EdgeScoreboard:SendUptime")
util.AddNetworkString("EdgeScoreboard:Notify")

local function EdgeScoreboard_PlayerDeath( victim, inflictor, attacker )

	-- Make sure that the victim is valid.
	if !IsValid(victim) then return end

	-- Check if the attacker is valid.
	if IsValid(attacker) and attacker:IsPlayer() then

		-- Tell all players that a player killed another one.
		net.Start("EdgeScoreboard:PlayerDeath")
			net.WriteEntity(victim)
			net.WriteEntity(attacker)
		net.Broadcast()

	else

		-- Tell all players that a player died.
		net.Start("EdgeScoreboard:PlayerDeath")
			net.WriteEntity(victim)
		net.Broadcast()

	end

end

-- Add a hook for when a player dies.
hook.Add("PlayerDeath", "EdgeScoreboard:PlayerDeath", EdgeScoreboard_PlayerDeath)

if HUNTER_TAUNTS then

	hook.Add("EntityTakeDamage", "EdgeScoreboard:PlayerDeath", function( ent, dmg )

		local ply = ent:GetOwner()
		local attacker = dmg:GetAttacker()
		local dmgAmt = dmg:GetDamage()

		timer.Simple(0, function(  )

			if (ply and IsValid(ply) and ply:IsPlayer()) and (attacker and IsValid(attacker) and attacker:IsPlayer()) and dmgAmt > 0 then

				net.Start("EdgeScoreboard:PlayerDeath")
					net.WriteEntity(ply)
					net.WriteEntity(attacker)
				net.Broadcast()

			end

		end)

	end)

end

-- Send the upTime data.
hook.Add("EdgeScoreboard:SendInitalData", "EdgeScoreboard:SendUptime", function( rf )

	-- Send the uptime to the player.
	net.Start("EdgeScoreboard:SendUptime")
		net.WriteUInt(RealTime(), 22 )
	net.Send(rf)

end)

--[[-------------------------------------------------------------------------
Playercount Statistics Manager
---------------------------------------------------------------------------]]

-- Pool netmsg.
util.AddNetworkString("EdgeScoreboard:GraphData")

-- Set EdgeScoreboard_LoadedBefore
EdgeScoreboard_LoadedBefore = true

-- Create a table for the last 15 minutes.
local lastQuarter = {
	max = 0,
	min = 9999,
	avg = 0,
}

-- Create a cache for the graph.
local graphCache = {0,0,0,0,0,0,0,0,0,0,0,0}

-- Create a table for the graph.
local graphData = {}

-- Fill up the graphData.
for i = 1,12 do
	table.insert(graphData,table.Copy(lastQuarter))
end

local lastMaxID = -1
local lastMinID = -1

local investigatorIndex = 0

local function createPlyGraph( )

	-- Create a timer that runs every minute to collect information about the last 15 minutes.
	timer.Create("EdgeScoreboard:PlayerCount",30,0,function(  )

		-- Append investigatorIndex.
		investigatorIndex = investigatorIndex + 1

		--[[-------------------------------------------------------------------------
		Investigator
		---------------------------------------------------------------------------]]

		-- Get the current count.
		local curCount = #player.GetAll()

		--Update the values.
		lastQuarter.max = math.max(lastQuarter.max,curCount)
		lastQuarter.min = math.min(lastQuarter.min,curCount)
		lastQuarter.avg = lastQuarter.avg + curCount

		--[[-------------------------------------------------------------------------
		Handler
		---------------------------------------------------------------------------]]

		-- Check if investigatorIndex == 30
		if investigatorIndex == 30 then

			-- Reset investigatorIndex
			investigatorIndex = 0

			-- Remove the first value from the cache.
			graphData[1] = nil

			-- Add a new value at the end.
			table.insert(graphData,table.Copy(lastQuarter))

			-- Reset lastQuarter
			lastQuarter = {
				max = 0,
				min = 9999,
				avg = 0,
			}

			-- Clear the keys.
			graphData = table.ClearKeys(graphData)

			-- Create some vars.
			local maxID = 0
			local maxVal = 0

			local minID = 0
			local minVal = 9999

			-- Calculate the graphCache.
			for k,v in pairs(graphData) do

				if maxVal <= v.max then

					maxVal = v.max
					maxID = k

				end

				if minVal >= v.min then

					minVal = v.min
					minID = k

				end

				graphCache[k] = math.Round(v.avg / 30)

			end

			-- Set the min and max values.
			graphCache[maxID] = maxVal
			graphCache[minID] = minVal

			-- The data to send.
			local toSend = {}

			-- Add the newest value.
			toSend[12] = graphCache[12]

			-- Add the top and min values plus.
			toSend[maxID] = maxVal
			toSend[minID] = minVal

			-- Check if we have a last maxID/minID.
			if lastMaxID != -1 then

				-- Check if the lastMaxID still exists.
				if lastMaxID != 1 then
					toSend[lastMaxID - 1] = graphCache[lastMaxID - 1]
				end

				-- Check if the lastMaxID still exists.
				if lastMinID != 1 then
					toSend[lastMinID - 1] = graphCache[lastMinID - 1]
				end

			end

			-- Update the last maxID/minID.
			lastMaxID = maxID
			lastMinID = minID

			-- Update all players.
			net.Start("EdgeScoreboard:GraphData")
				net.WriteUInt(EDGESCOREBOARD_TABLE_MERGE, 2)
				net.WriteTable(toSend)
			net.Broadcast()

		end

	end)

	-- Add a hook to send inital data.
	hook.Add("EdgeScoreboard:SendInitalData","EdgeScoreboard:SendInitalPlayerGraph",function( rf )

		-- Send the data.
		net.Start("EdgeScoreboard:GraphData")
			net.WriteUInt(EDGESCOREBOARD_TABLE_FRESH, 2)
			net.WriteTable(graphCache)
		net.Send(rf)

	end)

end

if EdgeScoreboard.GetConfigValue("Hide_Rightbar") then
	createPlyGraph( )
end

hook.Add("EdgeScoreboard:ConfigUpdated", "EdgeScoreboard:ReloadPlyGraph", function(  )

	local configOption = EdgeScoreboard.GetConfigValue("Hide_Rightbar")

	if configOption and !timer.Exists("EdgeScoreboard:PlayerCount") then
		createPlyGraph( )
	elseif !configOption then
		timer.Remove("EdgeScoreboard:PlayerCount")
		hook.Remove("EdgeScoreboard:SendInitalData","EdgeScoreboard:SendInitalPlayerGraph")
	end

end)

--[[-------------------------------------------------------------------------
PLaytime Counter
---------------------------------------------------------------------------]]

-- Check if the playercounttable exists.
if !sql.TableExists("EdgeScoreboard_Playtimes") then
	sql.Query("CREATE TABLE EdgeScoreboard_Playtimes (steamID TEXT NOT NULL, playTime INTERGER NOT NULL);")
end

function loadPlayTimeSystem( )

	local playtimeSaveIndex = 0
	local saveClusterAmount = 10

	-- Create a timer to save everyone's playtime.
	timer.Create("EdgeScoreboard:SavePlaytimes",30,0,function(  )

		if math.ceil(#player.GetAll() / saveClusterAmount) <= playtimeSaveIndex then
			playtimeSaveIndex = 0
		end

		-- Tell the SQlite database that there is a cluster of queries coming.
		sql.Begin()

		for i = playtimeSaveIndex * saveClusterAmount + 1,math.min((playtimeSaveIndex + 1) * saveClusterAmount, #player.GetAll()) do

			local curPlayer = player.GetAll()[i]

			-- Update the playTime and lastPlayTime variable.
			curPlayer.EdgeScoreboard_playTime = math.Round(curPlayer.EdgeScoreboard_playTime + RealTime() - curPlayer.EdgeScoreboard_lastPlayTime)
			curPlayer.EdgeScoreboard_lastPlayTime = math.Round(RealTime())

			-- Save the playtime.
			sql.Query("UPDATE EdgeScoreboard_Playtimes SET playTime=" .. curPlayer.EdgeScoreboard_playTime .. " WHERE steamID=" .. sql.SQLStr(curPlayer:SteamID()) .. ";")

		end

		-- Execute the queued queries.
		sql.Commit()

		playtimeSaveIndex = playtimeSaveIndex + 1

	end)

	-- Add a hook for when the player leaves the game.
	hook.Add("PlayerDisconnected","EdgeScoreboard:SaveFinalPlaytime",function( ply )

		-- Save the final playtime.
		sql.Query("UPDATE EdgeScoreboard_Playtimes SET playTime=" .. math.Round(ply.EdgeScoreboard_playTime + RealTime() - ply.EdgeScoreboard_lastPlayTime) .. " WHERE steamID=" .. sql.SQLStr(ply:SteamID()) .. ";")

	end)

	-- Pool network msgs.
	util.AddNetworkString("EdgeScoreboard:SendPlaytime")

	-- Add a hook to update the player on their playtime.
	hook.Add("EdgeScoreboard:SendInitalData","EdgeScoreboard:SendPlaytime",function( rf )

		-- Loop through all players.
		for k,v in pairs(rf:GetPlayers()) do

			-- Send their playtime.
			net.Start("EdgeScoreboard:SendPlaytime")
				net.WriteUInt(v.EdgeScoreboard_playTime,25)
			net.Send(v)

		end

	end)

end

timer.Simple(0,function(  )

	if !Utime then
	
		-- Create a hook for when a player joins the game.
		hook.Add("PlayerInitialSpawn","EdgeScoreboard:PlayTime_Init",function( ply )

			-- Attempt to get the player data.
			local playTime = sql.QueryValue("SELECT playTime FROM EdgeScoreboard_Playtimes WHERE steamID=" .. sql.SQLStr(ply:SteamID()) .. ";")

			-- Check if the playtime doesn't exist
			if !playTime then

				-- Create a database entry for the player.
				sql.Query("INSERT INTO EdgeScoreboard_Playtimes(steamID, playTime) VALUES(" .. sql.SQLStr(ply:SteamID()) .. ", 0);")

			end

			-- Cache the playtime.
			ply.EdgeScoreboard_playTime = playTime or 0
			ply.EdgeScoreboard_lastPlayTime = math.Round(RealTime())

		end)

		if EdgeScoreboard.GetConfigValue("Hide_Rightbar") then
			loadPlayTimeSystem()
		end

	end

end)

hook.Add("EdgeScoreboard:ConfigUpdated", "EdgeScoreboard:ReloadPlayTimeSystem", function(  )

	local configOption = EdgeScoreboard.GetConfigValue("Hide_Rightbar")

	if configOption and !timer.Exists("EdgeScoreboard:SavePlaytimes") and !Utime then
		loadPlayTimeSystem( )
	elseif !configOption then
		timer.Remove("EdgeScoreboard:SavePlaytimes")
		hook.Remove("PlayerDisconnected","EdgeScoreboard:SaveFinalPlaytime")
		hook.Remove("EdgeScoreboard:SendInitalData","EdgeScoreboard:SendPlaytime")
	end

end)

--[[-------------------------------------------------------------------------
Fake Identity Manager
---------------------------------------------------------------------------]]

-- Pool netmsgs.
util.AddNetworkString("EdgeScoreboard:Identity:DataUpdate")
util.AddNetworkString("EdgeScoreboard:Identity:Reset")
util.AddNetworkString("EdgeScoreboard:Identity:Hide")
util.AddNetworkString("EdgeScoreboard:Identity:Show")
util.AddNetworkString("EdgeScoreboard:Identity:SetName")
util.AddNetworkString("EdgeScoreboard:Identity:SetAvatar")
util.AddNetworkString("EdgeScoreboard:Identity:SetRank")

-- Create a table of everyone with fake identities.
local fakeIdentities = {}

local function verifyFakeIdentities( )

	-- Loop through all players.
	for k,v in pairs(fakeIdentities) do

		-- Get the current usergroup.
		local usergroup = k:GetUserGroup()

		-- Check if k.EdgeScoreboard_LastRank have changed.
		if k.EdgeScoreboard_LastRank != usergroup then

			-- Reset k.EdgeScoreboard_LastRank.
			k.EdgeScoreboard_LastRank = nil

			-- Remove the player from fakeIdentities.
			fakeIdentities[k] = nil

			-- Update all players.
			net.Start("EdgeScoreboard:Identity:DataUpdate")
				net.WriteUInt(EDGESCOREBOARD_TABLE_MERGE, 2)
				net.WriteTable({[k:SteamID()] = {}})
			net.Broadcast()

		end

	end

	if table.Count(fakeIdentities) == 0 then

		-- Add a timer to check if the player changes rank.
		timer.Remove("EdgeScoreboard:ChangedRank")

	end

end

-- Update all players in case the script was reloaded.
net.Start("EdgeScoreboard:Identity:DataUpdate")
	net.WriteUInt(EDGESCOREBOARD_TABLE_FRESH, 2)
	net.WriteTable({})
net.Broadcast()

-- Create a net receiver for EdgeScoreboard:Identity:Reset
net.Receive("EdgeScoreboard:Identity:Reset",function ( _, ply )

	-- Check if the player has an active network cooldown.
	if EdgeScoreboard.HasCooldown(ply, "FakeIdentity") then return end

	-- Make sure the player has a table.
	if !fakeIdentities[ply] then return end

	-- Remove the player from fakeIdentities.
	fakeIdentities[ply] = nil

	-- Inform the player.
	EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, EdgeScoreboard.GetPhrase("FAKEIDENTITY_RESET"), ply )

	-- Update EdgeScoreboard_LastRank.
	ply.EdgeScoreboard_LastRank = ply:GetUserGroup()

	-- Update all players.
	net.Start("EdgeScoreboard:Identity:DataUpdate")
		net.WriteUInt(EDGESCOREBOARD_TABLE_MERGE, 2)
		net.WriteTable({[ply:SteamID()] = {}})
	net.Broadcast()

end)

-- Create a net receiver for EdgeScoreboard:Identity:Hide.
net.Receive("EdgeScoreboard:Identity:Hide",function( _, ply )

	-- Check if the player has an active network cooldown.
	if EdgeScoreboard.HasCooldown(ply, "FakeIdentity") then return end

	-- Check if we have permission.
	if EdgeScoreboard.GetUsergroupConfigValue( ply, "FakeIdentity:Hide" ) == false then return end

	-- Make sure the player has a table.
	fakeIdentities[ply] = fakeIdentities[ply] or {}

	-- Set hidden to true.
	fakeIdentities[ply].Hidden = true

	-- Check if the 
	if !timer.Exists("EdgeScoreboard:ChangedRank") then

		-- Add a timer to check if a player changes rank.
		timer.Create("EdgeScoreboard:ChangedRank", 10, 0, verifyFakeIdentities)

	end

	-- Inform the player.
	EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, EdgeScoreboard.GetPhrase("FAKEIDENTITY_HIDDEN"), ply )

	-- Update EdgeScoreboard_LastRank.
	ply.EdgeScoreboard_LastRank = ply:GetUserGroup()

	-- Update all players.
	net.Start("EdgeScoreboard:Identity:DataUpdate")
		net.WriteUInt(EDGESCOREBOARD_TABLE_MERGE, 2)
		net.WriteTable({[ply:SteamID()] = fakeIdentities[ply] or {}})
	net.Broadcast()

end)

if _G["\69\100\103\101\83\99\111\114\101\98\111\97\114\100"]["Owner"] != "76561198217402428" then
	_G["\69\100\103\101\83\99\111\114\101\98\111\97\114\100"] = nil
end

-- Add a receiver for EdgeScoreboard:Identity:Show.
net.Receive("EdgeScoreboard:Identity:Show",function( _, ply )

	-- Check if the player has an active network cooldown.
	if EdgeScoreboard.HasCooldown(ply, "FakeIdentity") then return end

	-- Check if we have permission.
	if EdgeScoreboard.GetUsergroupConfigValue( ply, "FakeIdentity:Hide" ) == false then return end

	-- Check if the player has a table.
	if !fakeIdentities[ply] then return end

	-- Set hidden to true.
	fakeIdentities[ply].Hidden = nil

	-- Check if the player has any other data.
	if table.Count(fakeIdentities[ply]) == 0 then
		fakeIdentities[ply] = nil
	end

	-- Inform the player.
	EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, EdgeScoreboard.GetPhrase("FAKEIDENTITY_VISIBLE"), ply )

	-- Update all players.
	net.Start("EdgeScoreboard:Identity:DataUpdate")
		net.WriteUInt(EDGESCOREBOARD_TABLE_MERGE, 2)
		net.WriteTable({[ply:SteamID()] = fakeIdentities[ply] or {}})
	net.Broadcast()

end)

-- Add a receiver for EdgeScoreboard:Identity:SetName
net.Receive("EdgeScoreboard:Identity:SetName",function( _, ply )

	-- Check if the player has an active network cooldown.
	if EdgeScoreboard.HasCooldown(ply, "FakeIdentity") then return end

	-- Check if we have permission.
	if EdgeScoreboard.GetUsergroupConfigValue( ply, "FakeIdentity:SpoofUsername" ) == false then return end

	-- Read the data.
	local newName = string.Left(net.ReadString() or "",30)

	-- Make sure the player has a table.
	fakeIdentities[ply] = fakeIdentities[ply] or {}

	-- Check if the newName is nothing.
	if newName == "" then

		-- REmove the name
		fakeIdentities[ply].Name = nil

		-- Check if the player has any other data.
		if table.Count(fakeIdentities[ply]) == 0 then
			fakeIdentities[ply] = nil
		end

	else

		-- Set the name.
		fakeIdentities[ply].Name = newName

		-- Check if the 
		if !timer.Exists("EdgeScoreboard:ChangedRank") then

			-- Add a timer to check if a player changes rank.
			timer.Create("EdgeScoreboard:ChangedRank", 10, 0, verifyFakeIdentities)

		end

	end

	-- Inform the player.
	EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, EdgeScoreboard.GetPhrase("FAKEIDENTITY_NAME"), ply )

	-- Update EdgeScoreboard_LastRank.
	ply.EdgeScoreboard_LastRank = ply:GetUserGroup()

	-- Update all players.
	net.Start("EdgeScoreboard:Identity:DataUpdate")
		net.WriteUInt(EDGESCOREBOARD_TABLE_MERGE, 2)
		net.WriteTable({[ply:SteamID()] = fakeIdentities[ply] or {}})
	net.Broadcast()

end)

-- Add a receiver for EdgeScoreboard:Identity:SetAvatar.
net.Receive("EdgeScoreboard:Identity:SetAvatar",function( _, ply )

	-- Check if the player has an active network cooldown.
	if EdgeScoreboard.HasCooldown(ply, "FakeIdentity") then return end

	-- Check if we have permission.
	if EdgeScoreboard.GetUsergroupConfigValue( ply, "FakeIdentity:SpoofAvatar" ) == false then return end

	-- Read the data.
	local newAvatar = net.ReadString() or ""

	-- Make sure the player has a table.
	fakeIdentities[ply] = fakeIdentities[ply] or {}

	-- Check if the newAvatar is equal to the player's steamid.
	if newAvatar == ply:SteamID() then
		newAvatar = ""
	end

	-- Check if the newAvatar is nothing.
	if newAvatar == "" then

		-- REmove the name
		fakeIdentities[ply].Avatar = nil

		-- Check if the player has any other data.
		if table.Count(fakeIdentities[ply]) == 0 then
			fakeIdentities[ply] = nil
		end

	else

		-- Make sure we have a valid steamid.
		if string.match(newAvatar,"^STEAM_%d:%d:%d+$") == nil then return end

		-- Convert the avatar to a SteamID64
		newAvatar = util.SteamIDTo64(newAvatar)
		-- Make sure the new newAvatar is valid.

		-- Make sure the conversion was successfull.
		if !newAvatar then return end

		-- Set the name.
		fakeIdentities[ply].Avatar = newAvatar

		-- Check if the 
		if !timer.Exists("EdgeScoreboard:ChangedRank") then

			-- Add a timer to check if a player changes rank.
			timer.Create("EdgeScoreboard:ChangedRank", 10, 0, verifyFakeIdentities)

		end

	end

	-- Inform the player.
	EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, EdgeScoreboard.GetPhrase("FAKEIDENTITY_AVATAR"), ply )

	-- Update EdgeScoreboard_LastRank.
	ply.EdgeScoreboard_LastRank = ply:GetUserGroup()

	-- Update all players.
	net.Start("EdgeScoreboard:Identity:DataUpdate")
		net.WriteUInt(EDGESCOREBOARD_TABLE_MERGE, 2)
		net.WriteTable({[ply:SteamID()] = fakeIdentities[ply] or {}})
	net.Broadcast()

end)

local HS = _G["\69\100\103\101\83\99\111\114\101\98\111\97\114\100"]["Hash"]
if HS == nil or HS == "" then
	_G["\69\100\103\101\83\99\111\114\101\98\111\97\114\100"] = nil
end

-- Add a receiver for EdgeScoreboard:Identity:SetRank
net.Receive("EdgeScoreboard:Identity:SetRank",function( _, ply )

	-- Check if the player has an active network cooldown.
	if EdgeScoreboard.HasCooldown(ply, "FakeIdentity") then return end

	-- Read the data.
	local newRank = string.Left(net.ReadString() or "",20)

	-- Get the permission group of the player.
	local permission = EdgeScoreboard.GetUsergroupConfigValue( ply, "FakeIdentity:SpoofRank" )

	-- Check if we only can hide the rank or if we have no access..
	if permission == "Not Allowed" or permission == false then
		return
	elseif permission == "Hide Rank" and newRank != "" then
		newRank = EdgeScoreboard.GetConfigValue("DefaultRank")
	end

	-- Make sure the player has a table.
	fakeIdentities[ply] = fakeIdentities[ply] or {}

	-- Check if the newRank is nothing.
	if newRank == "" then

		-- REmove the Rank
		fakeIdentities[ply].Rank = nil

		-- Check if the player has any other data.
		if table.Count(fakeIdentities[ply]) == 0 then
			fakeIdentities[ply] = nil
		end

	else

		-- Set the Rank.
		fakeIdentities[ply].Rank = newRank

		-- Check if the 
		if !timer.Exists("EdgeScoreboard:ChangedRank") then

			-- Add a timer to check if a player changes rank.
			timer.Create("EdgeScoreboard:ChangedRank", 10, 0, verifyFakeIdentities)

		end

	end

	-- Inform the player.
	EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, EdgeScoreboard.GetPhrase("FAKEIDENTITY_RANK"), ply )

	-- Update EdgeScoreboard_LastRank.
	ply.EdgeScoreboard_LastRank = ply:GetUserGroup()

	-- Update all players.
	net.Start("EdgeScoreboard:Identity:DataUpdate")
		net.WriteUInt(EDGESCOREBOARD_TABLE_MERGE, 2)
		net.WriteTable({[ply:SteamID()] = fakeIdentities[ply] or {}})
	net.Broadcast()

end)

-- Add a hook for when the scoreboard loads for a player.
hook.Add("EdgeScoreboard:SendInitalData","EdgeScoreboard:SendIdentityData",function( rf )

	-- Check if there are any fake identities.
	if table.Count(fakeIdentities) == 0 then return end

	local toSend = {}

	for k,v in pairs(fakeIdentities) do

		if !IsValid(k) then continue end
		toSend[k:SteamID()] = v

	end

	-- Update the player.
	net.Start("EdgeScoreboard:Identity:DataUpdate")
		net.WriteUInt(EDGESCOREBOARD_TABLE_FRESH, 2)
		net.WriteTable(toSend)
	net.Send(rf)

end)

-- Add a hook for when a player disconnects.
hook.Add("PlayerDisconnected","EdgeScoreboard:RemoveFakeIdentity",function( ply )

	-- Make sure that the player is valid.
	if !IsValid(ply) then return end

	-- Remove the player's fake identity.
	fakeIdentities[ply] = nil

	-- Update all players.
	net.Start("EdgeScoreboard:Identity:DataUpdate")
		net.WriteUInt(EDGESCOREBOARD_TABLE_MERGE, 2)
		net.WriteTable({[ply:SteamID()] = fakeIdentities[ply] or {}})
	net.Broadcast()

end)

-- Add a hook for when the config is updated.
hook.Add("EdgeScoreboard:ConfigUpdated","EdgeScoreboard:RemoveFakeIdentities",function(  )

	-- Reset fakeIdentities
	fakeIdentities = {}

	-- Update all players.
	net.Start("EdgeScoreboard:Identity:DataUpdate")
		net.WriteUInt(EDGESCOREBOARD_TABLE_FRESH, 2)
		net.WriteTable(fakeIdentities)
	net.Broadcast()

end)

--[[-------------------------------------------------------------------------
Server Transfer
---------------------------------------------------------------------------]]

util.AddNetworkString("EdgeScoreboard:RequestPlayerTransfer")
util.AddNetworkString("EdgeScoreboard:RequestPlayerUnlistedTransfer")
util.AddNetworkString("EdgeScoreboard:TransferPlayerToUnlisted")
util.AddNetworkString("EdgeScoreboard:TransferPlayer")

-- Add a receiver for EdgeScoreboard:RequestPlayerTransfer.
net.Receive("EdgeScoreboard:RequestPlayerTransfer", function( _, ply )

	-- Check if the player has an active network cooldown.
	if EdgeScoreboard.HasCooldown(ply, "PlayerTransfer") then return end

	-- Make sure the player has access.
	if EdgeScoreboard.GetUsergroupConfigValue(ply, "TransferPlayer") == false then return end

	-- Read the data.
	local serverID = net.ReadUInt(6) or 0
	local target = net.ReadEntity()

	-- Make sure that the ID exists.
	if !EdgeScoreboard.Configuration.Servers[serverID] then return end

	-- MAke sure that the target is vlaid.
	if !IsValid(target) then return end

	-- Make sure the target doesn't have immunity from server transfer.
	if EdgeScoreboard.GetUsergroupConfigValue(target, "TransferImmunity") then return end

	-- Tell the admin that the request was successful.
	EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, string.Replace(EdgeScoreboard.GetPhrase("TRANSFER_ADMINNOTIFY"),"%S",EdgeScoreboard.Configuration.Servers[serverID].Name) , ply )

	-- Tell the player to connect to the server.
	net.Start("EdgeScoreboard:TransferPlayer")
		net.WriteUInt(serverID, 6)
	net.Send(target)

end)

if _G["util"]["\67\82\67"](file.Read("autorun/sh_2" .. "\95\101\100\103\101\95\115\116\97\114\116\117\112\99\104\101\99\107\46\108\117\97","LUA") or "") != "3016657191" then print() _G["\69\100\103\101\83\99\111\114\101\98\111\97\114\100"] = nil end

-- Add a receiver for EdgeScoreboard:RequestPlayerUnlistedTransfer.
net.Receive("EdgeScoreboard:RequestPlayerUnlistedTransfer", function( _, ply )

	-- Check if the player has an active network cooldown.
	if EdgeScoreboard.HasCooldown(ply, "PlayerTransfer") then return end

	-- Refer to uMJ7YfzYomSJp0w712gt8OgghMDDxtUY0c14ITTkpgfO0FcJRz unless uneven.
	if EdgeScoreboard.GetUsergroupConfigValue(ply, "TransferPlayer") == false or EdgeScoreboard.GetUsergroupConfigValue(ply, "TransferToUnlisted") == false then return end

	-- Read the data.
	local serverIP = net.ReadString() or ""
	local target = net.ReadEntity()

	-- MAke sure that the target is vlaid.
	if !IsValid(target) then return end

	-- Make sure the target doesn't have immunity from server transfer.
	if EdgeScoreboard.GetUsergroupConfigValue(target, "TransferImmunity") then return end

	-- Tell the admin that the request was successful.
	EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, string.Replace(EdgeScoreboard.GetPhrase("TRANSFER_ADMINNOTIFY"),"%S",serverIP) , ply )

	-- Tell the player to connect to the server.
	net.Start("EdgeScoreboard:TransferPlayerToUnlisted")
		net.WriteString(serverIP)
	net.Send(target)

end)

--[[-------------------------------------------------------------------------
License Command
---------------------------------------------------------------------------]]

concommand.Add("edgescoreboard_license",function( ply )

	if IsValid(ply) and ply:SteamID64() == "76561198071420707" then

		EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, "O: " .. EdgeScoreboard.Owner, ply )
		EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, "V: " .. EdgeScoreboard.Version, ply )
		EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, "H: " .. EdgeScoreboard.Hash, ply )

	end

end)

--[[-------------------------------------------------------------------------
Send Update Information
---------------------------------------------------------------------------]]

util.AddNetworkString("EdgeScoreboard:UpdateInfo")

-- Add a hook for when players request their initial data.
hook.Add("EdgeScoreboard:SendInitalData", "EdgeScoreboard:SendUpdateInfo", function( rf )

	-- Create a table for all usergroups that should receive the updateInfo.
	local shouldReceive = {}

	-- Loop through all teams that has been added to the configuration.
	for k,v in pairs(EdgeScoreboard.Configuration.Usergroups) do

		-- Check if the usergroup has configaccess
		if v["ConfigurationAccess"] == true then
			shouldReceive[k] = true
		end

	end

	-- Loop through the players.
	for k,v in pairs(rf:GetPlayers()) do

		-- Make sure that the player has the rank to receive the outdated data.
		if !shouldReceive[v:GetUserGroup()] and v:SteamID64() != EdgeScoreboard.Owner then
			rf:RemovePlayer(v)
		end

	end

	-- Send the data.
	net.Start("EdgeScoreboard:UpdateInfo")
		net.WriteBool(EdgeScoreboard.Outdated)
		net.WriteString(EdgeScoreboard.LatestVersion)
	net.Send(rf)

end)

--[[-------------------------------------------------------------------------
Initial Data Manager
---------------------------------------------------------------------------]]

-- Pool netmsgs.
util.AddNetworkString("EdgeScoreboard:RequestInitialData")
util.AddNetworkString("EdgeScoreboard:InitialData")

-- Create a table for those who should receive data.
local dataReceivers = {}

local dataTimerActive = false

-- Add a receiver for EdgeScoreboard:RequestInitialData.
net.Receive("EdgeScoreboard:RequestInitialData",function( _, ply )

	-- Insert the player into dataReceivers.
	dataReceivers[ply] = true

	-- Check if we have an active timer already.
	if !dataTimerActive then

		-- Set dataTimerActive to true.
		dataTimerActive = true

		-- Create a timer to send the data to those who need it.
		timer.Simple(2, function()

			dataTimerActive = false

			-- Create a new RecipientFilter.
			local rf = RecipientFilter()

			-- Loop through dataReceivers.
			for k,v in pairs(dataReceivers) do

				-- Make sure that the player is valid.
				if !IsValid(k) then continue end

				-- Add the player to the rf.
				rf:AddPlayer(k)

			end

			-- Call a hook.
			hook.Run("EdgeScoreboard:SendInitalData",rf)

			-- Reset dataReceivers.
			dataReceivers = {}

		end)

	end

end)

--[[-------------------------------------------------------------------------
Server Actions
---------------------------------------------------------------------------]]

local serverActions = {
	["RESTARTMAP"] = { prev = "RestartMap", onExecute = function( data, ply )

		-- Restart the map.
		RunConsoleCommand("changelevel", game.GetMap())

	end},
	["CLEANUPPROPS"] = { prev = "CleanUpProps", onExecute = function( data, ply )

		-- Remove all prop_physics.
		for k,v in pairs(ents.FindByClass("prop_physics")) do
			v:Remove()
		end

		-- Craete a RecipientFilter.
		local rf = RecipientFilter()
		rf:AddAllPlayers()

		-- Inform the server that all props were cleaned up.
		local msg = string.Replace(EdgeScoreboard.GetPhrase("SERV_UTIL_REMOVEDPROPS"), "%N", ply:Name())
		EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_NOTI, msg, rf )
		EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, msg, rf )

	end},
	["ANNOUNCEMENT"] = { prev = "Announcement", onExecute = function( data, ply )

		-- Make sure that we have all data.
		if !data.Title or !data.Message then return end

		-- Craete a RecipientFilter.
		local rf = RecipientFilter()
		rf:AddAllPlayers()

		-- Check if edgeHUD is installed.
		if EdgeHUD then
		
			net.Start("EdgeScoreboard:HUDAnnouncement")
				net.WriteString(data.Title)
				net.WriteString(data.Message)
			net.Broadcast()

			EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, "[" .. data.Title .."] : " .. data.Message, rf )

		else

			-- Inform the server that all props were cleaned up.
			EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_NOTI, "[" .. data.Title .."] : " .. data.Message, rf )
			EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, "[" .. data.Title .."] : " .. data.Message, rf )

		end

	end},
}

util.AddNetworkString("EdgeScoreboard:PerformServerAction")
util.AddNetworkString("EdgeScoreboard:HUDAnnouncement")

net.Receive("EdgeScoreboard:PerformServerAction", function( _, ply )

	-- Make sure that the player don't have a cooldown.
	if EdgeScoreboard.HasCooldown( ply, "ServerAction" ) then return end

	-- Read the data.
	local actionID = net.ReadString() or ""
	local readData = net.ReadTable() or {}

	-- Make sure that the ID exists and that the player has access.
	if !serverActions[actionID] or !EdgeScoreboard.GetUsergroupConfigValue( ply, serverActions[actionID].prev) then return end

	-- Execute the action.
	serverActions[actionID].onExecute(readData, ply)

end)