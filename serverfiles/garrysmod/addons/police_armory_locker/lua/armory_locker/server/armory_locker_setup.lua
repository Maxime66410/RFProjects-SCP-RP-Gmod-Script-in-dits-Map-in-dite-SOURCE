resource.AddWorkshop( "1917043256" )

util.AddNetworkString( "ARMORY_Weapon_Menu" )

util.AddNetworkString( "ARMORY_RetrieveItem" )
util.AddNetworkString( "ARMORY_DepositItem" )

util.AddNetworkString( "ARM_LOCKER_DoorOpenSeq" )
util.AddNetworkString( "ARM_LOCKER_CloseDoorAnim" )

util.AddNetworkString( "ARM_LOCKER_Weapon_Menu" )
util.AddNetworkString( "ARM_LOCKER_FinishLockpicking" )
util.AddNetworkString( "ARM_LOCKER_CL_LockStart" )
util.AddNetworkString( "ARM_LOCKER_StealItem" )

local map = string.lower( game.GetMap() )

function ARMORY_LOCKER_Initialize()
	-- Setup folders
	if not file.IsDir( "craphead_scripts", "DATA") then
		file.CreateDir( "craphead_scripts", "DATA")
	end
	 
	if not file.IsDir( "craphead_scripts/police_armory_locker/".. map .."", "DATA" ) then
		file.CreateDir( "craphead_scripts/police_armory_locker/".. map .."", "DATA" )
	end
	
	if not file.Exists( "craphead_scripts/police_armory_locker/".. map .."/policelocker_location.txt", "DATA" ) then
		file.Write( "craphead_scripts/police_armory_locker/".. map .."/policelocker_location.txt", "0;-0;-0;0;0;0", "DATA" )
	end

	ARMORY_LOCKER_InitArmoryEnt()
end 
hook.Add( "Initialize", "ARMORY_LOCKER_Initialize", ARMORY_LOCKER_Initialize )

local function ARMORY_LOCKER_RespawnEntsCleanup()
	print( "[Police Armory Locker] - Map cleaned up. Respawning the armory entity..." )

	timer.Simple( 1, function()
		ARMORY_LOCKER_InitArmoryEnt()
	end )
end
hook.Add("PostCleanupMap", "ARMORY_LOCKER_RespawnEntsCleanup", ARMORY_LOCKER_RespawnEntsCleanup )

local function DEBUG_PrintWeaponInfo( ply )
	local curwep = ply:GetActiveWeapon()
	print( "Name: ".. curwep:GetPrintName() )
	print( "Class: ".. curwep:GetClass() )
	print( "Model: ".. curwep:GetModel() )
	
	--PrintTable( game.GetAmmoTypes() )
end
concommand.Add( "armory_printweaponinfo", DEBUG_PrintWeaponInfo )