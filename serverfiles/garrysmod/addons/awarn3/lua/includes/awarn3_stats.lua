--[[
      __          __              ____  
     /\ \        / /             |___ \ 
    /  \ \  /\  / /_ _ _ __ _ __   __) |
   / /\ \ \/  \/ / _` | '__| '_ \ |__ < 
  / ____ \  /\  / (_| | |  | | | |___) |
 /_/    \_\/  \/ \__,_|_|  |_| |_|____/ 

	AWarn3 by Mr.President
]]


local enable_consolemessage = true  --Set to false if you don't want to see the notice in your server console.



local serverStats = {}
local feedback = ""


local function statSuccess( body )
	feedback = body
	if enable_consolemessage then
		ServerLog("AWarn: Your server info has been updated to the online statistics tracking\n")
	end
end

local function AWarn3_Statistics_Post()

	serverStats.hostname = GetHostName()
	serverStats.ipport = game.GetIPAddress()
	serverStats.map = game.GetMap()
	serverStats.gamemode = gmod.GetGamemode().Name or "UNKNOWN"
	serverStats.addon = "AWarn3"
	serverStats.addonversion = AWarn.Version
	serverStats.addoninfo = "76561198217402405"

	http.Post( "https://g4p.org/addonstats/post.php", serverStats, statSuccess, function(errorCode) end )
	timer.Simple( 1800, AWarn3_Statistics_Post )
end

local function AWarn3_Stats_TimerStart()
	timer.Simple( 5, AWarn3_Statistics_Post )
end
hook.Add( "InitPostEntity", "awarn3_stats_post", AWarn3_Stats_TimerStart )