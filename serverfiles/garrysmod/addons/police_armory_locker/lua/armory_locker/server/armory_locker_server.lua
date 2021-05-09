net.Receive( "ARM_LOCKER_StealItem", function(length, ply)
	local TheLocker = net.ReadEntity()
	local TheItem = net.ReadTable()
	
	if not ply.IsLockpicking then
		return
	end
	
	--[[
	
	if not CH_Armory_Locker.Weapons[ TheItem ] then
		return
	end
	
	
	--]]
	-- Safe check for position (avoid possible exploiters)
	for ent, v in pairs( CH_Armory_Locker.PoliceLockers ) do
		if ent:GetClass() == "police_locker" and IsValid( ent ) then
			if ply:GetPos():DistToSqr( ent:GetPos() ) > 5000 then
				DarkRP.notify( ply, 1, 5, "You are not close enough to the police locker to steal this item!")
				return
			end
		end
	end
	
	if not table.HasValue( CH_Armory_Locker.Config.AllowedTeams, team.GetName( ply:Team() ) ) then
		DarkRP.notify( ply, 1, 5, "You are not allowed to steal weapons and ammo from here as a ".. team.GetName( ply:Team() ) .."!")
		return
	end
	
	if TheItem.Category == "pistol" or TheItem.Category == "smg" or TheItem.Category == "rifle" or TheItem.Category == "shotgun" or TheItem.Category == "sniper" then
		ply:Give( TheItem.Weapon )
		ply:GiveAmmo( TheItem.AmmoAmt, TheItem.AmmoType )
		DarkRP.notify( ply, 1, 5, "You have stolen a ".. TheItem.Name .." with ".. TheItem.AmmoAmt .. " bullets." )
	elseif TheItem.Category == "ammo" then
		ply:GiveAmmo( TheItem.AmmoAmt, TheItem.AmmoType )
		DarkRP.notify( ply, 1, 5, "You have stolen ".. TheItem.AmmoAmt .." rounds of ".. TheItem.AmmoType .. " ammunition." )
	elseif TheItem.Category == "health" then
		if ply:Health() < ply:GetMaxHealth() then
			local total_health = ply:Health() + TheItem.AmmoAmt
			local new_health = math.Clamp( total_health, 0, ply:GetMaxHealth() )
			
			ply:SetHealth( new_health )
			DarkRP.notify( ply, 1, 5, "Your health has been set to ".. new_health )
		else
			DarkRP.notify( ply, 1, 5, "You already have maximum health!" )
		end
	elseif TheItem.Category == "armor" then
		if ply:Armor() < 100 then
			local total_armor = ply:Armor() + TheItem.AmmoAmt
			local new_armor = math.Clamp( total_armor, 0, 100 )
		
			ply:SetArmor( new_armor )
			DarkRP.notify( ply, 1, 5, "Your armor has been set to ".. new_armor )
		else
			DarkRP.notify( ply, 1, 5, "You already have maximum body armor!" )
		end
	end
end )

net.Receive( "ARM_LOCKER_FinishLockpicking", function( length, ply )
	local locker = net.ReadEntity()
	local locker_num = net.ReadInt( 8 )

	if locker then
		ply.IsLockpicking = false
		
		-- Initialize a cooldown on the player before he/she can lockpick any door again.
		ply:SetNWBool( "LockpickCooldown", true )
	
		DarkRP.notify( ply, 1, 10, "Lockpicking was succesfull. You will be able to lockpick doors again in " .. CH_Armory_Locker.Config.LockpickCooldown .." seconds." )
		
		timer.Simple( CH_Armory_Locker.Config.LockpickCooldown, function() -- cooldown for players who can't lockpick for a certain amount of seconds
			if IsValid( ply ) then
				ply:SetNWBool( "LockpickCooldown", false )
				DarkRP.notify( ply, 1, 5, "Your armory lockpick cooldown has ended. You can steal weapons, ammo and armor again!" )
			end
		end )
		
		-- Notify police jobs
		if CH_Armory_Locker.Config.NotifyPolice then
			for k, v in ipairs( player.GetAll() ) do
				if table.HasValue( CH_Armory_Locker.Config.GovernmentTeams, team.GetName( v:Team() ) ) then
					DarkRP.notify( v, 1, 7, "Someone has stolen items from the police armory!" )
				end
			end
		end
		
		-- Close door again once we restock the weapons inside the specific locker
		timer.Simple( CH_Armory_Locker.Config.DoorCooldown, function()
			if IsValid( locker ) and IsValid( ply ) then
				timer.Simple( 0.4, function()
					locker:EmitSound( "doors/door_metal_thin_open1.wav" ) -- OR doors/door_metal_gate_close1.wav
				end )
		
				net.Start( "ARM_LOCKER_DoorOpenSeq" )
					net.WriteEntity( locker )
					net.WriteInt( locker_num, 8 )
					net.WriteBool( false )
				net.Send( ply )
			end
		end )
		
		-- XP System Support
		-- Give experience support for Vronkadis DarkRP Level System
		if CH_Armory_Locker.Config.DarkRPLevelSystemEnabled then
			ply:addXP( CH_Armory_Locker.Config.XPSuccessfulLockpick, true )
		end

		-- Give experience support for Sublime Levels
		if CH_Armory_Locker.Config.SublimeLevelSystemEnabled then
			ply:SL_AddExperience( CH_Armory_Locker.Config.XPSuccessfulLockpick, "for successfully lockpicking the police armory.")
		end
		
		-- Check for which locker door and change bodygroups/cooldowns accordingly
		if locker_num == 1 then
			locker:SetBodygroup( 2, 1 ) -- "empty" the locker bodygroup
			
			timer.Simple( CH_Armory_Locker.Config.DoorCooldown, function()
				if IsValid( locker ) then
					locker:SetLockerDoor1( false ) -- Make the door available again for lockpicking.
					locker:SetBodygroup( 2, 0 ) -- "restock" the weapons inside bodygroup
				end
			end )
		elseif locker_num == 2 then
			locker:SetBodygroup( 3, 1 ) -- "empty" the locker bodygroup
			
			timer.Simple( CH_Armory_Locker.Config.DoorCooldown, function()
				if IsValid( locker ) then
					locker:SetLockerDoor2( false ) -- Make the door available again for lockpicking.
					locker:SetBodygroup( 3, 0 ) -- "restock" the weapons inside bodygroup
				end
			end )
		elseif locker_num == 3 then
			locker:SetBodygroup( 4, 1 ) -- "empty" the locker bodygroup
			
			timer.Simple( CH_Armory_Locker.Config.DoorCooldown, function()
				if IsValid( locker ) then
					locker:SetLockerDoor3( false ) -- Make the door available again for lockpicking.
					locker:SetBodygroup( 4, 0 ) -- "restock" the weapons inside bodygroup
				end
			end )
		elseif locker_num == 4 then
			locker:SetBodygroup( 5, 1 ) -- "empty" the locker bodygroup
			
			timer.Simple( CH_Armory_Locker.Config.DoorCooldown, function()
				if IsValid( locker ) then
					locker:SetLockerDoor4( false ) -- Make the door available again for lockpicking.
					locker:SetBodygroup( 5, 0 ) -- "restock" the weapons inside bodygroup
				end
			end )
		elseif locker_num == 5 then
			locker:SetBodygroup( 6, 1 ) -- "empty" the locker bodygroup
			
			timer.Simple( CH_Armory_Locker.Config.DoorCooldown, function()
				if IsValid( locker ) then
					locker:SetLockerDoor5( false ) -- Make the door available again for lockpicking.
					locker:SetBodygroup( 6, 0 ) -- "restock" the weapons inside bodygroup
				end
			end )
		elseif locker_num == 6 then
			locker:SetBodygroup( 7, 1 ) -- "empty" the locker bodygroup
			
			timer.Simple( CH_Armory_Locker.Config.DoorCooldown, function()
				if IsValid( locker ) then
					locker:SetLockerDoor6( false ) -- Make the door available again for lockpicking.
					locker:SetBodygroup( 7, 0 ) -- "restock" the weapons inside bodygroup
				end
			end )
		elseif locker_num == 7 then
			locker:SetBodygroup( 8, 1 ) -- "empty" the locker bodygroup
			
			timer.Simple( CH_Armory_Locker.Config.DoorCooldown, function()
				if IsValid( locker ) then
					locker:SetLockerDoor7( false ) -- Make the door available again for lockpicking.
					locker:SetBodygroup( 8, 0 ) -- "restock" the weapons inside bodygroup
				end
			end )
		elseif locker_num == 8 then
			locker:SetBodygroup( 9, 1 ) -- "empty" the locker bodygroup
			
			timer.Simple( CH_Armory_Locker.Config.DoorCooldown, function()
				if IsValid( locker ) then
					locker:SetLockerDoor8( false ) -- Make the door available again for lockpicking.
					locker:SetBodygroup( 9, 0 ) -- "restock" the weapons inside bodygroup
				end
			end )
		end
	end
end )

-- Lockpicking failure checks
local function ARMORY_LOCKER_PlayerDeath( ply, inflictor, attacker )
	if ply.IsLockpicking then
		DarkRP.notify( ply, 1, 5, "[Lockpick Failed] You have died while lockpicking the armory." )
		ply.IsLockpicking = false
		
		if attacker != ply then
			if table.HasValue( CH_Armory_Locker.Config.GovernmentTeams, team.GetName( attacker:Team() ) ) then
				DarkRP.notify( attacker, 1, 5, "[Armory Robbery] You have been awarded ".. DarkRP.formatMoney( CH_Armory_Locker.Config.PoliceKillRobberReward ) .." for killing a robber." )
				attacker:addMoney( CH_Armory_Locker.Config.PoliceKillRobberReward )
			else
				DarkRP.notify( attacker, 1, 5, "[Armory Robbery] You have been awarded ".. DarkRP.formatMoney( CH_Armory_Locker.Config.KillRobberReward ) .." for killing a robber." )
				attacker:addMoney( CH_Armory_Locker.Config.KillRobberReward )
			end
		end

		for locker, v in pairs( CH_Armory_Locker.PoliceLockers ) do
			if locker:GetClass() == "police_locker" and IsValid( locker ) then
				if locker:GetLockerDoor1() then
					locker:SetLockerDoor1( false )
				end
				if locker:GetLockerDoor2() then
					locker:SetLockerDoor2( false )
				end
				if locker:GetLockerDoor3() then
					locker:SetLockerDoor3( false )
				end
				if locker:GetLockerDoor4() then
					locker:SetLockerDoor4( false )
				end
				if locker:GetLockerDoor5() then
					locker:SetLockerDoor5( false )
				end
				if locker:GetLockerDoor6() then
					locker:SetLockerDoor6( false )
				end
				if locker:GetLockerDoor7() then
					locker:SetLockerDoor7( false )
				end
				if locker:GetLockerDoor8() then
					locker:SetLockerDoor8( false )
				end
			end
		end
		
		return
	end
end
hook.Add( "PlayerDeath", "ARMORY_LOCKER_PlayerDeath", ARMORY_LOCKER_PlayerDeath )

-- Armory doors and bodygroup checks
function ARMORY_LOCKER_CloseArmoryDoors( ply )
	local locker = ply.ActiveLockerEnt

	if locker then
		if ply.IsInLocker then
			ply.IsInLocker = false
			ply.ActiveLockerEnt = nil
			
			if locker.ActiveLockerPlayers == 1 then
				locker:ResetSequence( "close" )
				locker:EmitSound( "doors/door_metal_thin_open1.wav" ) -- OR doors/door_metal_gate_close1.wav
				
				-- Switch bodygroups of lights
				locker:SetBodygroup( 10, 1 )
				locker:SetBodygroup( 12, 1 )
				
				locker:SetBodygroup( 11, 0 )
				locker:SetBodygroup( 13, 0 )
			end
			
			locker.ActiveLockerPlayers = locker.ActiveLockerPlayers - 1
		end
	end
end
hook.Add( "PlayerDeath", "ARMORY_LOCKER_CloseArmoryDoors", ARMORY_LOCKER_CloseArmoryDoors )
hook.Add( "PlayerDisconnected", "ARMORY_LOCKER_CloseArmoryDoors", ARMORY_LOCKER_CloseArmoryDoors )