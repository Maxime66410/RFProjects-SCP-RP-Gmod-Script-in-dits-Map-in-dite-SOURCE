AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

local map = string.lower( game.GetMap() )

CH_Armory_Locker.PoliceLockers = CH_Armory_Locker.PoliceLockers or {}

function ARMORY_LOCKER_InitArmoryEnt()
	-- Get the file
	local PositionFile = file.Read( "craphead_scripts/police_armory_locker/".. map .."/policelocker_location.txt", "DATA" )
	local ThePosition = string.Explode( ";", PositionFile )
	
	local TheVector = Vector( ThePosition[1], ThePosition[2], ThePosition[3] )
	local TheAngle = Angle( tonumber(ThePosition[4]), ThePosition[5], ThePosition[6] )
	
	-- Spawn the armory
	local PoliceLocker = ents.Create( "police_locker" )
	PoliceLocker:SetModel( "models/craphead_scripts/armory_robbery2/armory.mdl" )
	PoliceLocker:SetPos( TheVector )
	PoliceLocker:SetAngles( TheAngle )
	PoliceLocker:Spawn()
	PoliceLocker:PhysicsInit( SOLID_VPHYSICS )
	PoliceLocker:SetMoveType( MOVETYPE_NONE )
	PoliceLocker:SetSolid( SOLID_VPHYSICS )
	
	PoliceLocker:SetBodygroup( 10, 1 )
	PoliceLocker:SetBodygroup( 12, 1 )
	PoliceLocker.ActiveLockerPlayers = 0
	
	CH_Armory_Locker.PoliceLockers[ PoliceLocker ] = true
	
	PoliceLocker:SetLockerDoor1( false )
	PoliceLocker:SetLockerDoor2( false )
	PoliceLocker:SetLockerDoor3( false )
	PoliceLocker:SetLockerDoor4( false )
	PoliceLocker:SetLockerDoor5( false )
	PoliceLocker:SetLockerDoor6( false )
	PoliceLocker:SetLockerDoor7( false )
	PoliceLocker:SetLockerDoor8( false )
end

function ARMORY_LOCKER_SetPos( ply )
	if ply:IsAdmin() then
		local HisVector = string.Explode(" ", tostring(ply:GetPos()))
		local HisAngles = string.Explode(" ", tostring(ply:GetAngles()))
		
		file.Write( "craphead_scripts/police_armory_locker/".. map .."/policelocker_location.txt", ""..(HisVector[1])..";"..(HisVector[2])..";"..(HisVector[3])..";"..(HisAngles[1])..";"..(HisAngles[2])..";"..(HisAngles[3]).."", "DATA" )
		ply:ChatPrint( "New position for the police armory has been succesfully set." )
		ply:ChatPrint( "The police armory will respawn in 5 seconds. Move out the way." )
		
		-- Respawn the armory
		for ent, v in pairs( CH_Armory_Locker.PoliceLockers ) do
			if ent:GetClass() == "police_locker" and IsValid( ent ) then
				ent:Remove()
			end
		end
		
		timer.Simple( 5, function()
			if IsValid( ply ) then
				ARMORY_LOCKER_InitArmoryEnt()
				ply:ChatPrint( "The police armory has been respawned." )
			end
		end )
	else
		ply:ChatPrint( "Only administrators can perform this action." )
	end
end
concommand.Add( "policearmory_locker_setpos", ARMORY_LOCKER_SetPos )

function ENT:AcceptInput( ply, caller )
	if caller:IsPlayer() then
		if ( self.lastUsed or CurTime() ) <= CurTime() then

			self.lastUsed = CurTime() + 2

			if IsValid( caller ) then
				local tr = self:WorldToLocal( caller:GetEyeTrace().HitPos )
				--print(tr)
				
				if table.HasValue( CH_Armory_Locker.Config.GovernmentTeams, team.GetName( caller:Team() ) ) then
					if self:GetLockerDoor1() or self:GetLockerDoor2() or self:GetLockerDoor3() or self:GetLockerDoor4() or self:GetLockerDoor5() or self:GetLockerDoor6() or self:GetLockerDoor7() or self:GetLockerDoor8() then
						DarkRP.notify( caller, 1, 7, "You cannot access the police armory at the moment." )
						DarkRP.notify( caller, 1, 7, "One of the doors in the armory has recently been robbed or is being robbed!" )
						return
					end
					
					if CH_Armory_Locker.Config.WeaponsArmoryEnabled then
						net.Start( "ARMORY_Weapon_Menu" )
						net.Send( caller )
						
						caller.IsInLocker = true
						caller.ActiveLockerEnt = self
						
						self.ActiveLockerPlayers = self.ActiveLockerPlayers + 1
						
						if self.ActiveLockerPlayers == 1 then
							self:ResetSequence( "open" ) -- open/opened and close/closed
							self:EmitSound( "doors/default_move.wav" )
							
							self:SetBodygroup( 10, 0 )
							self:SetBodygroup( 12, 0 )
							
							self:SetBodygroup( 11, 1 )
							self:SetBodygroup( 13, 1 )
						end
					else
						DarkRP.notify( caller, 1, 5, "The police armory is currently disabled!" )
					end
				else
					DarkRP.notify( caller, 1, 5, "You are not authorized to access the police armory!" )
				end
			end
		end
	end
end

net.Receive( "ARM_LOCKER_CloseDoorAnim", function( length, ply )
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
end )

function ENT:Think()
	self:NextThink( CurTime() + 0.05 )
	return true
end

function ENT:OnRemove()
	if IsValid( self ) then
		CH_Armory_Locker.PoliceLockers[ self ] = nil
	end
end