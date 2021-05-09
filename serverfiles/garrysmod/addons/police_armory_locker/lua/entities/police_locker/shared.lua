ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Police Armory Locker"
ENT.Author = "Crap-Head"

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.AutomaticFrameAdvance = true

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 1, "LockerDoor1" )
	self:NetworkVar( "Bool", 2, "LockerDoor2" )
	self:NetworkVar( "Bool", 3, "LockerDoor3" )
	self:NetworkVar( "Bool", 4, "LockerDoor4" )
	self:NetworkVar( "Bool", 5, "LockerDoor5" )
	self:NetworkVar( "Bool", 6, "LockerDoor6" )
	self:NetworkVar( "Bool", 7, "LockerDoor7" )
	self:NetworkVar( "Bool", 8, "LockerDoor8" )
end

CH_Armory_Locker.DoorPos = CH_Armory_Locker.DoorPos or {
	doorone = Vector(2.00000, -62.591232, 23.25000),
	doorone2 = Vector(-21.00000, -47.498146, 94.00000),

	doortwo = Vector(2.00000, -47.488146, 23.25000),
	doortwo2 = Vector(-21.00000, -34.132117, 94.00000),
	
	doorthree = Vector(2.00000, -33.194775, 23.25000),
	doorthree2 = Vector(-21.00000, -19.089687, 94.00000),
	
	doorfour = Vector(2.00000, 19.856634, 23.25000),
	doorfour2 = Vector(-21.00000, 33.396439, 94.00000),
	
	doorfive = Vector(2.00000, 33.932758, 23.25000),
	doorfive2 = Vector(-21.00000, 47.291241, 94.00000),
	
	doorsix = Vector(2.00000, 47.950176, 23.25000),
	doorsix2 = Vector(-21.00000, 61.521336, 94.00000),
	
	doorseven = Vector(2.00000, -18.521753, 50.50000),
	doorseven2 = Vector(-21.00000, 18.600552, 94.00000),
	
	dooreight = Vector(2.00000, -18.521753, 50.49000),
	dooreight2 = Vector(-21.00000, 18.600552, 0.00000)
}

CH_Armory_Locker.Doors = CH_Armory_Locker.Doors or {}

CH_Armory_Locker.Doors[1] = 0
CH_Armory_Locker.Doors[2] = 0
CH_Armory_Locker.Doors[3] = 0
CH_Armory_Locker.Doors[4] = 0
CH_Armory_Locker.Doors[5] = 0
CH_Armory_Locker.Doors[6] = 0
CH_Armory_Locker.Doors[7] = 0
CH_Armory_Locker.Doors[8] = 0