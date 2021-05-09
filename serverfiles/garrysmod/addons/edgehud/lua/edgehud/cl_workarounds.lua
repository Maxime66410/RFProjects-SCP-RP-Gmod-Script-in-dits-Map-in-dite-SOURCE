--[[-------------------------------------------------------------------------
Avoid notifications getting stuck on late load of HUD.
---------------------------------------------------------------------------]]

local addLegacyData = debug.getinfo(notification.AddLegacy)
local addProgressData = debug.getinfo(notification.AddLegacy)
local killData = debug.getinfo(notification.Kill)

--This will be outside the edgeHUD table to avoid being overriden.
EdgeHUD_NotificationsQueue_Legacy = EdgeHUD_NotificationsQueue_Legacy or {}
EdgeHUD_NotificationsQueue_Progress = EdgeHUD_NotificationsQueue_Progress or {}

local defaultPath = "lua/autorun/client/cl_notifications.lua"
local defaultPath2 = "lua/includes/modules/notification.lua"

local isDefault = (addLegacyData.short_src == defaultPath and addProgressData.short_src == defaultPath and killData.short_src == defaultPath) or (addLegacyData.short_src == defaultPath2 and addProgressData.short_src == defaultPath2 and killData.short_src == defaultPath2)

if isDefault or string.find(string.lower(addLegacyData.short_src),"edgehud") != nil then

	--Override the notification functions.
	function notification.AddLegacy(text,type,length)
		table.insert(EdgeHUD_NotificationsQueue_Legacy,{text = text,type = type,length = length})
	end

	function notification.AddProgress(id,strText)
		EdgeHUD_NotificationsQueue_Progress[id] = strText
	end

	function notification.Kill(id)
		EdgeHUD_NotificationsQueue_Progress[id] = nil
	end

end

--[[-------------------------------------------------------------------------
Avoid notifications being visible for a slight second on load
---------------------------------------------------------------------------]]

timer.Simple(0,function(  )

	local EdgeHUD_MVLevels_HUDPaintA = EdgeHUD_MVLevels_HUDPaintA or hook.GetTable()["HUDPaint"]["manolis:MVLevels:HUDPaintA"] or function() end

	hook.Add("HUDPaint","manolis:MVLevels:HUDPaintA",function(  )

		if !EdgeHUD.Loaded3D2D then return end

		EdgeHUD_MVLevels_HUDPaintA()

	end)

end)