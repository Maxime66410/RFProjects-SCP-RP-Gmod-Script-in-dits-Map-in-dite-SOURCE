-- Get the colors.
local COLORS = EdgeScoreboard.Colors

-- Create some enums.
EDGESCOREBOARD_NOTIFY_NOTI = 0
EDGESCOREBOARD_NOTIFY_POPUP = 1
EDGESCOREBOARD_NOTIFY_CHAT = 2
EDGESCOREBOARD_NOTIFY_CONSOLE = 3

-- Create a function to show a notificiation.
function EdgeScoreboard.Notify( type, message, rf )

	-- Check if we are running serverside or clientside.
	if CLIENT then

		-- Check the type.
		if type == EDGESCOREBOARD_NOTIFY_NOTI then

			-- Show the notification.
			notification.AddLegacy("[EdgeScoreboard] : " .. message, NOTIFY_UNDO, 6)

		elseif type == EDGESCOREBOARD_NOTIFY_POPUP then

			-- Show the notification.
			EdgeScoreboard.ShowMessage( message )

		elseif type == EDGESCOREBOARD_NOTIFY_CHAT then

			-- Show the notification.
			chat.AddText(COLORS["Chat_Prefix"],"[EdgeScoreboard]", COLORS["Chat_Suffix"], " : ", COLORS["White"], message )

		end

		-- Print into the console.
		print("[EdgeScoreboard] : [" .. EdgeScoreboard.Version .. "] : " .. message)

	else

		-- Check if the notification is for the server.
		if type == EDGESCOREBOARD_NOTIFY_CONSOLE and rf == nil then

			-- Print into the console.
			print("[EdgeScoreboard] : [" .. EdgeScoreboard.Version .. "] : " .. message)

		else

			-- Send the message to the client.
			net.Start("EdgeScoreboard:Notify")
				net.WriteUInt(type, 3)
				net.WriteString(message)
			net.Send(rf)

		end

	end

end

-- Check if we are running clientside.
if CLIENT then

	-- Add a receiver for EdgeScoreboard:Notify.
	net.Receive("EdgeScoreboard:Notify", function(  )

		-- Show the message.
		EdgeScoreboard.Notify( net.ReadUInt(3), net.ReadString() )

	end)

end