local function ARMORY_LOCKER_WeaponCooldown( ply )
	ply.WeaponArmoryDelay = true
	ply.WeaponArmoryCooldown = CurTime() + ( CH_Armory_Locker.Config.RetrieveCooldown * 60 )
	
	timer.Simple( CH_Armory_Locker.Config.RetrieveCooldown * 60, function()
		if IsValid( ply ) then
			ply.WeaponArmoryDelay = false
			ply.WeaponArmoryCooldown = 0
		end
	end )
end

net.Receive( "ARMORY_RetrieveItem", function( length, ply )
	local OurKey = net.ReadDouble()
	local TheItem = CH_Armory_Locker.Weapons[ OurKey ]
	
	if ply.WeaponArmoryDelay then
		DarkRP.notify( ply, 1, 5, "Please wait ".. string.ToMinutesSeconds( math.Round( ply.WeaponArmoryCooldown - CurTime() ) ) .. " before retrieving another item from the police armory." )
		return
	end
	
	if not table.HasValue( CH_Armory_Locker.Config.GovernmentTeams, team.GetName( ply:Team() ) ) then
		DarkRP.notify( ply, 1, 5, "You are not allowed to retrieve items as a ".. team.GetName( ply:Team() ) .."!")
		return
	end
	
	if CH_Armory_Locker.Config.UseJobRestrictions and CH_Armory_Locker.TeamCategories[ TheItem.Weapon ] and not table.HasValue( CH_Armory_Locker.TeamCategories[ TheItem.Weapon ], team.GetName( ply:Team() ) ) then
		DarkRP.notify( ply, 1, 5, "You are not allowed to retrieve item '".. TheItem.Name .."' as a ".. team.GetName( ply:Team() ) .."!")
		return
	end
	
	for ent, v in pairs( CH_Armory_Locker.PoliceLockers ) do
		if ent:GetClass() == "police_locker" and IsValid( ent ) then
			if ply:GetPos():DistToSqr( ent:GetPos() ) > 10000 then
				DarkRP.notify( ply, 1, 5, "You are not close enough to the police armory to retrieve items!")
				return
			end
		end
	end

	if TheItem.Category == "pistol" or TheItem.Category == "smg" or TheItem.Category == "rifle" or TheItem.Category == "shotgun" or TheItem.Category == "sniper" then
		ply:Give( TheItem.Weapon )
		ply:SelectWeapon( TheItem.Weapon )
		ply:GiveAmmo( TheItem.AmmoAmt, TheItem.AmmoType )
		DarkRP.notify( ply, 1, 5, "You have retrieved a ".. TheItem.Name .." with ".. TheItem.AmmoAmt .. " bullets." )
		
		ARMORY_LOCKER_WeaponCooldown( ply )
		
		-- Stop people from being able to drop retrieve weapons from the armory
		ply:GetActiveWeapon().IsFromArmory = true
	elseif TheItem.Category == "ammo" then
		ply:GiveAmmo( TheItem.AmmoAmt, TheItem.AmmoType )
		DarkRP.notify( ply, 1, 5, "You have retrieved ".. TheItem.AmmoAmt .." rounds of ".. TheItem.AmmoType .. " ammunition." )
		
		ARMORY_LOCKER_WeaponCooldown( ply )
	elseif TheItem.Category == "health" then
		if ply:Health() < ply:GetMaxHealth() then
			local total_health = ply:Health() + TheItem.AmmoAmt
			local new_health = math.Clamp( total_health, 0, ply:GetMaxHealth() )
			
			ply:SetHealth( new_health )
			DarkRP.notify( ply, 1, 5, "Your health has been set to ".. new_health )
			
			ARMORY_LOCKER_WeaponCooldown( ply )
		else
			DarkRP.notify( ply, 1, 5, "You already have maximum health!" )
		end
	elseif TheItem.Category == "armor" then
		if ply:Armor() < 100 then
			local total_armor = ply:Armor() + TheItem.AmmoAmt
			local new_armor = math.Clamp( total_armor, 0, 100 )
		
			ply:SetArmor( new_armor )
			DarkRP.notify( ply, 1, 5, "Your armor has been set to ".. new_armor )
			
			ARMORY_LOCKER_WeaponCooldown( ply )
		else
			DarkRP.notify( ply, 1, 5, "You already have maximum body armor!" )
		end
	end
end )

net.Receive( "ARMORY_DepositItem", function( length, ply )
	local OurKey = net.ReadDouble()
	local TheItem = CH_Armory_Locker.Weapons[ OurKey ]
	
	if not table.HasValue( CH_Armory_Locker.Config.GovernmentTeams, team.GetName( ply:Team() ) ) then
		DarkRP.notify( ply, 1, 5, "You are not allowed to deposit weapons as a ".. team.GetName( ply:Team() ) .."!" )
		return
	end
	
	for ent, v in pairs( CH_Armory_Locker.PoliceLockers ) do
		if ent:GetClass() == "police_locker" and IsValid( ent ) then
			if ply:GetPos():DistToSqr( ent:GetPos() ) > 10000 then
				DarkRP.notify( ply, 1, 5, "You are not close enough to the police armory to deposit a weapon!" )
				return
			end
		end
	end
	
	if TheItem.Category == "pistol" or TheItem.Category == "smg" or TheItem.Category == "rifle" or TheItem.Category == "shotgun" or TheItem.Category == "sniper" then
		if ply:HasWeapon( TheItem.Weapon ) then
			ply:StripWeapon( TheItem.Weapon )
			DarkRP.notify( ply, 1, 5, "You have deposited your ".. TheItem.Name )
			
			if ply:HasWeapon( "weapon_physgun" ) then
				ply:SelectWeapon( "weapon_physgun" )
			elseif ply:HasWeapon( "weapon_physcannon" ) then
				ply:SelectWeapon( "weapon_physcannon" )
			end
		else
			DarkRP.notify( ply, 1, 5, "You have no weapons from the police armory to deposit!" )
		end
	end
end )

local function ARMORY_CanDropWeapon( ply, wep )
	if wep.IsFromArmory then
		for k, v in pairs( CH_Armory_Locker.Weapons ) do
			if wep:GetClass() == v.Weapon then
				ply:ChatPrint( "You can not drop weapons retrieved from the police armory." )
				return false
			end
		end
	end
end
hook.Add( "canDropWeapon", "ARMORY_CanDropWeapon", ARMORY_CanDropWeapon )