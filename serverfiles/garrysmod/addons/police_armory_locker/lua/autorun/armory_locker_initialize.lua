-- INITIALIZE SCRIPT
if SERVER then
	for k, v in pairs( file.Find( "armory_locker/server/*.lua", "LUA" ) ) do
		include( "armory_locker/server/" .. v )
		--print("server: ".. v)
	end
	
	for k, v in pairs( file.Find( "armory_locker/client/*.lua", "LUA" ) ) do
		AddCSLuaFile( "armory_locker/client/" .. v )
		--print("cs client: ".. v)
	end
	
	for k, v in pairs( file.Find( "armory_locker/shared/*.lua", "LUA" ) ) do
		include( "armory_locker/shared/" .. v )
		--print("shared: ".. v)
	end
	
	for k, v in pairs( file.Find( "armory_locker/shared/*.lua", "LUA" ) ) do
		AddCSLuaFile( "armory_locker/shared/" .. v )
		--print("cs shared: ".. v)
	end
end

if CLIENT then
	for k, v in pairs( file.Find( "armory_locker/client/*.lua", "LUA" ) ) do
		include( "armory_locker/client/" .. v )
		--print("client: ".. v)
	end
	
	for k, v in pairs( file.Find( "armory_locker/shared/*.lua", "LUA" ) ) do
		include( "armory_locker/shared/" .. v )
		--print("shared client: ".. v)
	end
end