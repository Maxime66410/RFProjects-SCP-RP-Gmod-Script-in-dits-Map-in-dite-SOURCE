--[[ INFO
#Armory Lockpick
models/craphead_scripts/armory_robbery2/c_lockpick.mdl
models/craphead_scripts/armory_robbery2/w_lockpick.mdl
76561198217402428
FOV: 50
Hold type: slam
Sequences:
(sequence_name       activity)
idle 		ACT_VM_IDLE
draw 		ACT_VM_DRAW
start 		ACT_VM_IDLE_TO_LOWERED
finish 		ACT_VM_LOWERED_TO_IDLE
lockpick 	ACT_VM_PRIMARYATTACK
--]]

if SERVER then
	AddCSLuaFile( "shared.lua" )
end

if CLIENT then
	SWEP.PrintName = "Armory Lockpick"
	SWEP.Slot = 2
	SWEP.SlotPos = 4
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
end

SWEP.Author = "Crap-Head"
SWEP.Instructions = "Left click to start lockpicking a door. You must keep aiming at the same door."
SWEP.Contact = ""
SWEP.Purpose = "Used specifically to lockpick the police armory."

SWEP.UseHands = true
SWEP.ViewModelFOV = 50
SWEP.ViewModelFlip = false
SWEP.AnimPrefix = "slam"

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "Crap-Head Scripts"

SWEP.ViewModel = "models/craphead_scripts/armory_robbery2/c_lockpick.mdl"
SWEP.WorldModel = "models/craphead_scripts/armory_robbery2/w_lockpick.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Primary.Delay = 1.0

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""
SWEP.Secondary.Delay = 2.0

function SWEP:Initialize()
	self:SetWeaponHoldType( "slam" )
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	self.Weapon:SetDeploySpeed( self.WeaponDeploySpeed )
end

function SWEP:Deploy()
	timer.Simple( 0.5, function()
		if IsValid( self.Weapon ) then
			self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
		end
	end )
	return true
end

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	
	local tr = self.Owner:GetEyeTrace()
	local locker = tr.Entity
	local trent = locker:WorldToLocal( self.Owner:GetEyeTrace().HitPos )
	
	local Dist = self.Owner:EyePos():DistToSqr( tr.HitPos )
	
	if Dist >= 2734 then
		if SERVER then
			DarkRP.notify( self.Owner, 1, 5, "Please move closer to the police armory." )
		end
		return 
	end
	
	if not table.HasValue( CH_Armory_Locker.Config.AllowedTeams, team.GetName( self.Owner:Team() ) ) then
		if SERVER then
			DarkRP.notify( self.Owner, 1, 5, "You are not allowed to steal weapons and ammo from here as a ".. team.GetName( self.Owner:Team() ) .."!")
		end
		return
	end
	
	if locker:GetClass() == "police_locker" then
		if SERVER then
			local ARM_LOCKPICK_RequiredTeamsCount = 0
			local ARM_LOCKPICK_PlayersCounted = 0
			
			for k, v in ipairs( player.GetAll() ) do
				ARM_LOCKPICK_PlayersCounted = ARM_LOCKPICK_PlayersCounted + 1
				
				if table.HasValue( CH_Armory_Locker.Config.RequiredTeams, team.GetName( v:Team() ) ) then
					ARM_LOCKPICK_RequiredTeamsCount = ARM_LOCKPICK_RequiredTeamsCount + 1
				end
				
				if ARM_LOCKPICK_PlayersCounted == #player.GetAll() then
					if ARM_LOCKPICK_RequiredTeamsCount < CH_Armory_Locker.Config.RequiredGovTeams then
						DarkRP.notify( self.Owner, 1, 5, "There must be ".. CH_Armory_Locker.Config.RequiredGovTeams .." police officers before you can lockpick into the armory." )
						return
					end
				end
			end
			
			if self.Owner:GetNWBool( "LockpickCooldown" ) then
				DarkRP.notify( self.Owner, 1, 5, "You are currently on a cooldown from being able to lockpick into the police armory." )
				return
			end

			if locker.ActiveLockerPlayers != 0 then
				DarkRP.notify( self.Owner, 1, 5, "You cannot lockpick the armory while an officer is accesing it!" )
				return
			end
			
			if self.Owner.IsLockpicking then
				DarkRP.notify( self.Owner, 1, 5, "You are already lockpicking another door. Keep looking at that door!" )
				return
			end

			if trent:WithinAABox( CH_Armory_Locker.DoorPos.doorone, CH_Armory_Locker.DoorPos.doorone2 ) then
				if not locker:GetLockerDoor1() then
					net.Start( "ARM_LOCKER_CL_LockStart" )
						net.WriteEntity( locker )
						net.WriteEntity( self )
					net.Send( self.Owner )
		
					locker:SetLockerDoor1( true )
					self.Owner.IsLockpicking = true
					
					timer.Simple( CH_Armory_Locker.Config.LockpickTime, function()
						if not IsValid( self.Owner ) then
							return
						end
						if not locker:GetLockerDoor1() then
							return
						end
						
						trent = locker:WorldToLocal( self.Owner:GetEyeTrace().HitPos )
						Dist = self.Owner:EyePos():DistToSqr( tr.HitPos )
						
						if trent:WithinAABox( CH_Armory_Locker.DoorPos.doorone, CH_Armory_Locker.DoorPos.doorone2 ) and Dist < 2734 then
							self:LockpickFinished( 1, locker, self.Owner )
						else
							locker:SetLockerDoor1( false )
							self.Owner.IsLockpicking = false
							DarkRP.notify( self.Owner, 1, 5, "[Lockpick Failed] Keep aiming at the same door." )
							return
						end
					end )
				else
					DarkRP.notify( self.Owner, 1, 5, "This door is unavailable for lockpicking at the moment!" )
					return
				end
			elseif trent:WithinAABox( CH_Armory_Locker.DoorPos.doortwo, CH_Armory_Locker.DoorPos.doortwo2 ) then
				if not locker:GetLockerDoor2() then
					net.Start( "ARM_LOCKER_CL_LockStart" )
						net.WriteEntity( locker )
						net.WriteEntity( self )
					net.Send( self.Owner )
		
					locker:SetLockerDoor2( true )
					self.Owner.IsLockpicking = true
					
					timer.Simple( CH_Armory_Locker.Config.LockpickTime, function()
						if not IsValid( self.Owner ) then
							return
						end
						if not locker:GetLockerDoor2() then
							return
						end
						
						trent = locker:WorldToLocal( self.Owner:GetEyeTrace().HitPos )
						Dist = self.Owner:EyePos():DistToSqr( tr.HitPos )
						
						if trent:WithinAABox( CH_Armory_Locker.DoorPos.doortwo, CH_Armory_Locker.DoorPos.doortwo2 ) and Dist < 2734 then
							self:LockpickFinished( 2, locker, self.Owner )
						else
							locker:SetLockerDoor2( false )
							self.Owner.IsLockpicking = false
							DarkRP.notify( self.Owner, 1, 5, "[Lockpick Failed] Keep aiming at the same door." )
							return
						end
					end )
				else
					DarkRP.notify( self.Owner, 1, 5, "This door is unavailable for lockpicking at the moment!" )
					return
				end
			elseif trent:WithinAABox( CH_Armory_Locker.DoorPos.doorthree, CH_Armory_Locker.DoorPos.doorthree2 ) then
				if not locker:GetLockerDoor3() then
					net.Start( "ARM_LOCKER_CL_LockStart" )
						net.WriteEntity( locker )
						net.WriteEntity( self )
					net.Send( self.Owner )
		
					locker:SetLockerDoor3( true )
					self.Owner.IsLockpicking = true
					
					timer.Simple( CH_Armory_Locker.Config.LockpickTime, function()
						if not IsValid( self.Owner ) then
							return
						end
						if not locker:GetLockerDoor3() then
							return
						end
						
						trent = locker:WorldToLocal( self.Owner:GetEyeTrace().HitPos )
						Dist = self.Owner:EyePos():DistToSqr( tr.HitPos )
						
						if trent:WithinAABox( CH_Armory_Locker.DoorPos.doorthree, CH_Armory_Locker.DoorPos.doorthree2 ) and Dist < 2734 then
							self:LockpickFinished( 3, locker, self.Owner )
						else
							locker:SetLockerDoor3( false )
							self.Owner.IsLockpicking = false
							DarkRP.notify( self.Owner, 1, 5, "[Lockpick Failed] Keep aiming at the same door." )
							return
						end
					end )
				else
					DarkRP.notify( self.Owner, 1, 5, "This door is unavailable for lockpicking at the moment!" )
					return
				end
			elseif trent:WithinAABox( CH_Armory_Locker.DoorPos.doorfour, CH_Armory_Locker.DoorPos.doorfour2 ) then
				if not locker:GetLockerDoor4() then
					net.Start( "ARM_LOCKER_CL_LockStart" )
						net.WriteEntity( locker )
						net.WriteEntity( self )
					net.Send( self.Owner )
		
					locker:SetLockerDoor4( true )
					self.Owner.IsLockpicking = true
					
					timer.Simple( CH_Armory_Locker.Config.LockpickTime, function()
						if not IsValid( self.Owner ) then
							return
						end
						if not locker:GetLockerDoor4() then
							return
						end
						
						trent = locker:WorldToLocal( self.Owner:GetEyeTrace().HitPos )
						Dist = self.Owner:EyePos():DistToSqr( tr.HitPos )
						
						if trent:WithinAABox( CH_Armory_Locker.DoorPos.doorfour, CH_Armory_Locker.DoorPos.doorfour2 ) and Dist < 2734 then
							self:LockpickFinished( 4, locker, self.Owner )
						else
							locker:SetLockerDoor4( false )
							self.Owner.IsLockpicking = false
							DarkRP.notify( self.Owner, 1, 5, "[Lockpick Failed] Keep aiming at the same door." )
							return
						end
					end )
				else
					DarkRP.notify( self.Owner, 1, 5, "This door is unavailable for lockpicking at the moment!" )
					return
				end
			elseif trent:WithinAABox( CH_Armory_Locker.DoorPos.doorfive, CH_Armory_Locker.DoorPos.doorfive2 ) then
				if not locker:GetLockerDoor5() then
					net.Start( "ARM_LOCKER_CL_LockStart" )
						net.WriteEntity( locker )
						net.WriteEntity( self )
					net.Send( self.Owner )
		
					locker:SetLockerDoor5( true )
					self.Owner.IsLockpicking = true
					
					timer.Simple( CH_Armory_Locker.Config.LockpickTime, function()
						if not IsValid( self.Owner ) then
							return
						end
						if not locker:GetLockerDoor5() then
							return
						end
						
						trent = locker:WorldToLocal( self.Owner:GetEyeTrace().HitPos )
						Dist = self.Owner:EyePos():DistToSqr( tr.HitPos )
						
						if trent:WithinAABox( CH_Armory_Locker.DoorPos.doorfive, CH_Armory_Locker.DoorPos.doorfive2 ) and Dist < 2734 then
							self:LockpickFinished( 5, locker, self.Owner )
						else
							locker:SetLockerDoor5( false )
							self.Owner.IsLockpicking = false
							DarkRP.notify( self.Owner, 1, 5, "[Lockpick Failed] Keep aiming at the same door." )
							return
						end
					end )
				else
					DarkRP.notify( self.Owner, 1, 5, "This door is unavailable for lockpicking at the moment!" )
					return
				end
			elseif trent:WithinAABox( CH_Armory_Locker.DoorPos.doorsix, CH_Armory_Locker.DoorPos.doorsix2 ) then
				if not locker:GetLockerDoor6() then
					net.Start( "ARM_LOCKER_CL_LockStart" )
						net.WriteEntity( locker )
						net.WriteEntity( self )
					net.Send( self.Owner )
		
					locker:SetLockerDoor6( true )
					self.Owner.IsLockpicking = true
					
					timer.Simple( CH_Armory_Locker.Config.LockpickTime, function()
						if not IsValid( self.Owner ) then
							return
						end
						if not locker:GetLockerDoor6() then
							return
						end
						
						trent = locker:WorldToLocal( self.Owner:GetEyeTrace().HitPos )
						Dist = self.Owner:EyePos():DistToSqr( tr.HitPos )
						
						if trent:WithinAABox( CH_Armory_Locker.DoorPos.doorsix, CH_Armory_Locker.DoorPos.doorsix2 ) and Dist < 2734 then
							self:LockpickFinished( 6, locker, self.Owner )
						else
							locker:SetLockerDoor6( false )
							self.Owner.IsLockpicking = false
							DarkRP.notify( self.Owner, 1, 5, "[Lockpick Failed] Keep aiming at the same door." )
							return
						end
					end )
				else
					DarkRP.notify( self.Owner, 1, 5, "This door is unavailable for lockpicking at the moment!" )
					return
				end
			elseif trent:WithinAABox( CH_Armory_Locker.DoorPos.doorseven, CH_Armory_Locker.DoorPos.doorseven2 ) then
				if not locker:GetLockerDoor7() then
					net.Start( "ARM_LOCKER_CL_LockStart" )
						net.WriteEntity( locker )
						net.WriteEntity( self )
					net.Send( self.Owner )
		
					locker:SetLockerDoor7( true )
					self.Owner.IsLockpicking = true
					
					timer.Simple( CH_Armory_Locker.Config.LockpickTime, function()
						if not IsValid( self.Owner ) then
							return
						end
						if not locker:GetLockerDoor7() then
							return
						end
						
						trent = locker:WorldToLocal( self.Owner:GetEyeTrace().HitPos )
						Dist = self.Owner:EyePos():DistToSqr( tr.HitPos )
						
						if trent:WithinAABox( CH_Armory_Locker.DoorPos.doorseven, CH_Armory_Locker.DoorPos.doorseven2 ) and Dist < 2734 then
							self:LockpickFinished( 7, locker, self.Owner )
						else
							locker:SetLockerDoor7( false )
							self.Owner.IsLockpicking = false
							DarkRP.notify( self.Owner, 1, 5, "[Lockpick Failed] Keep aiming at the same door." )
							return
						end
					end )
				else
					DarkRP.notify( self.Owner, 1, 5, "This door is unavailable for lockpicking at the moment!" )
					return
				end
			elseif trent:WithinAABox( CH_Armory_Locker.DoorPos.dooreight, CH_Armory_Locker.DoorPos.dooreight2 ) then
				if not locker:GetLockerDoor8() then
					net.Start( "ARM_LOCKER_CL_LockStart" )
						net.WriteEntity( locker )
						net.WriteEntity( self )
					net.Send( self.Owner )
		
					locker:SetLockerDoor8( true )
					self.Owner.IsLockpicking = true
					
					timer.Simple( CH_Armory_Locker.Config.LockpickTime, function()
						if not IsValid( self.Owner ) then
							return
						end
						if not locker:GetLockerDoor8() then
							return
						end
						
						trent = locker:WorldToLocal( self.Owner:GetEyeTrace().HitPos )
						Dist = self.Owner:EyePos():DistToSqr( tr.HitPos )
						
						if trent:WithinAABox( CH_Armory_Locker.DoorPos.dooreight, CH_Armory_Locker.DoorPos.dooreight2 ) and Dist < 2734 then
							self:LockpickFinished( 8, locker, self.Owner )
						else
							locker:SetLockerDoor8( false )
							self.Owner.IsLockpicking = false
							DarkRP.notify( self.Owner, 1, 5, "[Lockpick Failed] Keep aiming at the same door." )
							return
						end
					end )
				else
					DarkRP.notify( self.Owner, 1, 5, "This door is unavailable for lockpicking at the moment!" )
					return
				end
			end
			
			DarkRP.notify( self.Owner, 1, 5, "Lockpicking armory has begun. Keep aiming at the same door through the process!" )
		end
		

		if locker:GetLockerDoor1() or locker:GetLockerDoor2() or locker:GetLockerDoor3() or locker:GetLockerDoor4() or locker:GetLockerDoor5() or locker:GetLockerDoor6() or locker:GetLockerDoor7() or locker:GetLockerDoor8() then
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			
			timer.Simple( ( CH_Armory_Locker.Config.LockpickTime - 1 ), function()
				if IsValid( self.Weapon ) then
					if locker:GetLockerDoor1() or locker:GetLockerDoor2() or locker:GetLockerDoor3() or locker:GetLockerDoor4() or locker:GetLockerDoor5() or locker:GetLockerDoor6() or locker:GetLockerDoor7() or locker:GetLockerDoor8() then
						self.Weapon:SendWeaponAnim( ACT_VM_LOWERED_TO_IDLE )
						
						timer.Simple( 1, function()
							if IsValid( self.Weapon ) then
								self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
							end
						end )
					end
				end
			end )
		end
	else
		if SERVER then
			DarkRP.notify( self.Owner, 1, 5, "You need to be aiming at a police armory." )
		end
		return
	end
end

function SWEP:LockpickFinished( doornum, locker )	
	net.Start( "ARM_LOCKER_DoorOpenSeq" )
		net.WriteEntity( locker )
		net.WriteInt( doornum, 8 )
		net.WriteBool( true )
	net.Send( self.Owner )

	net.Start( "ARM_LOCKER_Weapon_Menu" )
		net.WriteEntity( locker )
		net.WriteInt( doornum, 8 )
		net.WriteTable( table.Random( CH_Armory_Locker.Weapons ) )
		net.WriteTable( table.Random( CH_Armory_Locker.Weapons ) )
		net.WriteTable( table.Random( CH_Armory_Locker.Weapons ) )
	net.Send( self.Owner )

	locker:EmitSound( "doors/default_move.wav" )
end

function SWEP:SecondaryAttack()
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
end

local ourmat_locker = Material( "icon16/accept.png" )
local ourmat_cooldown = Material( "icon16/cross.png" )

local mat_lock_bg = Material( "craphead_scripts/lockpick/bg_stripes.png")
local mat_lock_white = Material( "craphead_scripts/lockpick/white_bar.png")

if CLIENT then
	local Lenght_Target = 350
	local Lenght_Speed = 4 / CH_Armory_Locker.Config.LockpickTime
	
	net.Receive( "ARM_LOCKER_CL_LockStart", function( length, ply )
		local locker = net.ReadEntity()
		local self = net.ReadEntity()
		
		if locker:GetClass() == "police_locker" then
			self.Target = locker
			self.LockpickTarget = CurTime() + CH_Armory_Locker.Config.LockpickTime
			self.Cur_Num = 0
		end
	end )
	
	function SWEP:DrawHUD()
		local tr = self.Owner:GetEyeTrace()
		local locker = tr.Entity
		
		if not locker:GetClass() == "police_locker" then
			self.Target = nil 
			self.LockpickTarget = nil 
		end
		
		if not IsValid( self.Owner ) then
			self.Target = nil 
			self.LockpickTarget = nil 
		end
		
		local Dist = self.Owner:EyePos():DistToSqr( tr.HitPos )
		if Dist > 50000 then
			self.Target = nil 
			self.LockpickTarget = nil 
			return false 
		end
		
		if locker == self.Target then
			if self.LockpickTarget <= CurTime() then
				self.Target = nil
				self.LockpickTarget = nil
				return
			else
				self.Cur_Num = math.Approach( self.Cur_Num, Lenght_Target, Lenght_Speed )
				
				surface.SetDrawColor( color_white )
				surface.SetMaterial( mat_lock_bg )
				surface.DrawTexturedRect( ScrW() * 0.4, ScrH() * 0.875, 350, ScrH() * 0.02 )

				surface.SetDrawColor( color_white )
				surface.SetMaterial( mat_lock_white )
				surface.DrawTexturedRect( ScrW() * 0.4, ScrH() * 0.875, self.Cur_Num, ScrH() * 0.02 )
				
				draw.SimpleTextOutlined( "Lockpicking...", "ARMORY_UIFontButton", ScrW() / 2, ScrH() * 0.85, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, color_black )
			end
		end
	end
end

function SWEP:DoDrawCrosshair( x, y )
	local size = 7
	
	if LocalPlayer():GetNWBool( "LockpickCooldown" ) then
		surface.SetDrawColor( color_white )
		surface.SetMaterial( ourmat_cooldown )
		surface.DrawTexturedRect( x, y, 16, 16 )
	else
		draw.RoundedBox( 6, x, y, size, size, color_white )
	end
	return true
end