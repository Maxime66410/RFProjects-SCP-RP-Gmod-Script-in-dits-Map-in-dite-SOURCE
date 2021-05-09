include( "shared.lua" )

function ENT:Initialize()
end

local color_gray = Color( 125, 125, 125, 255 )

local mat_cooldown = Material( "craphead_scripts/lockpick/icon_cooldown.png" )
local mat_lockpick = Material( "craphead_scripts/lockpick/icon_lockpick.png")
local mat_icon

function ENT:DrawTranslucent()
	self:DrawModel()
	
	local Dist = self:GetPos():Distance( EyePos() )
	if not LocalPlayer():Alive() then
		return
	end
	if not IsValid( LocalPlayer() ) then
		return
	end
	
	-- Header
	if Dist <= CH_Armory_Locker.Config.DistanceToHeader then 
		local pos = self:GetPos() + Vector( 0, 0, 70 )
		local PlayersAngle = LocalPlayer():GetAngles()
		local ang = Angle( 0, PlayersAngle.y - 180, 0 )
		
		ang:RotateAroundAxis( ang:Right(), -90 )
		ang:RotateAroundAxis( ang:Up(), 90 )
		
		cam.Start3D2D( pos, ang, 0.11 )
			if CH_Armory_Locker.Config.DisplayHeaderText then
				draw.SimpleTextOutlined( CH_Armory_Locker.Config.HeaderText, "ARMORY_OverheadTitle", 0, -300, CH_Armory_Locker.Design.ArmoryHeaderColor, 1, 1, 2, CH_Armory_Locker.Design.ArmoryHeaderBoarder )
			end
		cam.End3D2D()
	end
	
	if Dist > CH_Armory_Locker.Config.DistanceToIcons then 
		return 
	end
	
	if not IsValid( LocalPlayer():GetActiveWeapon() ) then
		return
	end
	if LocalPlayer():GetActiveWeapon():GetClass() != "armory_lockpick" then
		return
	end
	
	-- When aiming at it
	local PosEnt = self:GetPos()
	local AngEnt = self:GetAngles()
	
	local tr = self:WorldToLocal( LocalPlayer():GetEyeTrace().HitPos )

	AngEnt:RotateAroundAxis( AngEnt:Up(), 90 )
	AngEnt:RotateAroundAxis( AngEnt:Forward(), 90 )

	if LocalPlayer():GetNWBool( "LockpickCooldown" ) then
		mat_icon = mat_cooldown
	else
		mat_icon = mat_lockpick
	end

	cam.Start3D2D( PosEnt + AngEnt:Up() * 1.1, AngEnt, 0.11 )
		if tr:WithinAABox( CH_Armory_Locker.DoorPos.doorone, CH_Armory_Locker.DoorPos.doorone2 ) and Dist <= 100 then
			if not self:GetLockerDoor1() then
				surface.SetDrawColor( color_white )
				surface.SetMaterial( mat_icon )
				surface.DrawTexturedRect( -534, -559, 53, 53 )
			end
		elseif not self:GetLockerDoor1() then
			surface.SetDrawColor( color_gray )
			surface.SetMaterial( mat_icon )
			surface.DrawTexturedRect( -534, -559, 53, 53 )
		end
		
		if tr:WithinAABox( CH_Armory_Locker.DoorPos.doortwo, CH_Armory_Locker.DoorPos.doortwo2 ) and Dist <= 100 then
			if not self:GetLockerDoor2() then
				surface.SetDrawColor( color_white )
				surface.SetMaterial( mat_icon )
				surface.DrawTexturedRect( -406, -559, 53, 53 )
			end
		elseif not self:GetLockerDoor2() then
			surface.SetDrawColor( color_gray )
			surface.SetMaterial( mat_icon )
			surface.DrawTexturedRect( -406, -559, 53, 53 )
		end
		
		if tr:WithinAABox( CH_Armory_Locker.DoorPos.doorthree, CH_Armory_Locker.DoorPos.doorthree2 ) and Dist <= 100 then
			if not self:GetLockerDoor3() then
				surface.SetDrawColor( color_white )
				surface.SetMaterial( mat_icon )
				surface.DrawTexturedRect( -279, -559, 53, 53 )
			end
		elseif not self:GetLockerDoor3() then
			surface.SetDrawColor( color_gray )
			surface.SetMaterial( mat_icon )
			surface.DrawTexturedRect( -279, -559, 53, 53 )
		end
		
		if tr:WithinAABox( CH_Armory_Locker.DoorPos.doorfour, CH_Armory_Locker.DoorPos.doorfour2 ) and Dist <= 100 then
			if not self:GetLockerDoor4() then
				surface.SetDrawColor( color_white )
				surface.SetMaterial( mat_icon )
				surface.DrawTexturedRect( 227, -559, 53, 53 )
			end
		elseif not self:GetLockerDoor4() then
			surface.SetDrawColor( color_gray )
			surface.SetMaterial( mat_icon )
			surface.DrawTexturedRect( 227, -559, 53, 53 )
		end
		
		if tr:WithinAABox( CH_Armory_Locker.DoorPos.doorfive, CH_Armory_Locker.DoorPos.doorfive2 ) and Dist <= 100 then
			if not self:GetLockerDoor5() then
				surface.SetDrawColor( color_white )
				surface.SetMaterial( mat_icon )
				surface.DrawTexturedRect( 354, -559, 53, 53 )
			end
		elseif not self:GetLockerDoor5() then
			surface.SetDrawColor( color_gray )
			surface.SetMaterial( mat_icon )
			surface.DrawTexturedRect( 354, -559, 53, 53 )
		end
		
		if tr:WithinAABox( CH_Armory_Locker.DoorPos.doorsix, CH_Armory_Locker.DoorPos.doorsix2 ) and Dist <= 100 then
			if not self:GetLockerDoor6() then
				surface.SetDrawColor( color_white )
				surface.SetMaterial( mat_icon )
				surface.DrawTexturedRect( 482, -559, 53, 53 )
			end
		elseif not self:GetLockerDoor6() then
			surface.SetDrawColor( color_gray )
			surface.SetMaterial( mat_icon )
			surface.DrawTexturedRect( 482, -559, 53, 53 )
		end
	cam.End3D2D()
	
	-- ammo doors need special treatment huuuuh
	cam.Start3D2D( PosEnt + AngEnt:Up() * 0.57, AngEnt, 0.11 )
		if tr:WithinAABox( CH_Armory_Locker.DoorPos.doorseven, CH_Armory_Locker.DoorPos.doorseven2 ) and Dist <= 100 then
			if not self:GetLockerDoor7() then
				surface.SetDrawColor( color_white )
				surface.SetMaterial( mat_icon )
				surface.DrawTexturedRect( -78, -525, 48, 48 )
			end
		elseif not self:GetLockerDoor7() then
			surface.SetDrawColor( color_gray )
			surface.SetMaterial( mat_icon )
			surface.DrawTexturedRect( -78, -525, 49, 49 )
		end
		
		if tr:WithinAABox( CH_Armory_Locker.DoorPos.dooreight, CH_Armory_Locker.DoorPos.dooreight2 ) and Dist <= 100 then
			if not self:GetLockerDoor8() then
				surface.SetDrawColor( color_white )
				surface.SetMaterial( mat_icon )
				surface.DrawTexturedRect( -78, -375, 48, 48 )
			end
		elseif not self:GetLockerDoor8() then
			surface.SetDrawColor( color_gray )
			surface.SetMaterial( mat_icon )
			surface.DrawTexturedRect( -78, -375, 48, 48 )
		end
	cam.End3D2D()
end

local LastThink = 0
local SeqSpeed = 200

net.Receive( "ARM_LOCKER_DoorOpenSeq", function( length, ply )
	local locker_ent = net.ReadEntity()
	local door_num = net.ReadInt( 8 )
	local door_open = net.ReadBool()

	locker_ent.SwitchOn = door_open
	locker_ent.DoorNum = door_num
end )

function ENT:Think()
	local now = CurTime()
	local timepassed = now - LastThink
	LastThink = now
	
	if not self.DoorNum then
		return
	end
	
	if self.SwitchOn then
		CH_Armory_Locker.Doors[self.DoorNum] = math.Approach( CH_Armory_Locker.Doors[self.DoorNum], 100, SeqSpeed * timepassed )
	else
		CH_Armory_Locker.Doors[self.DoorNum] = math.Approach( CH_Armory_Locker.Doors[self.DoorNum], 0, SeqSpeed * timepassed )
	end

	self:SetPoseParameter( "door_1", CH_Armory_Locker.Doors[1] )
	self:SetPoseParameter( "door_2", CH_Armory_Locker.Doors[2] )
	self:SetPoseParameter( "door_3", CH_Armory_Locker.Doors[3] )
	self:SetPoseParameter( "door_4", CH_Armory_Locker.Doors[4] )
	self:SetPoseParameter( "door_5", CH_Armory_Locker.Doors[5] )
	self:SetPoseParameter( "door_6", CH_Armory_Locker.Doors[6] )
	self:SetPoseParameter( "door_7", CH_Armory_Locker.Doors[7] )
	self:SetPoseParameter( "door_8", CH_Armory_Locker.Doors[8] )
	
	self:InvalidateBoneCache()
end