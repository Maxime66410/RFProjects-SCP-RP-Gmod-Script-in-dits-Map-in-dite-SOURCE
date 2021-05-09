--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeHUD.RegisterLanguage({
	Name = "English",
	Author = "Jompe",
	CompatibleVersion = "1.14.0",
})

--[[-------------------------------------------------------------------------
Phrases - Lower Left
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"IDENTITY", "Identity")
EdgeHUD.AddPhrase(LANG,"JOB", "Job")

--[[-------------------------------------------------------------------------
Phrases - Lower Right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_KPH","KPH")
EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_MPH","MPH")

--TAGS: %P = Amount of props.
EdgeHUD.AddPhrase(LANG,"PROPLIMIT","%P Props")

EdgeHUD.AddPhrase(LANG,"GUNLICENSE","Gun License")

--[[-------------------------------------------------------------------------
Phrases - Top Left
---------------------------------------------------------------------------]]

--TAGS: %V = Number of votes
EdgeHUD.AddPhrase(LANG,"VOTE_QUEUE","There are %V items in queue!")

EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_VOTE","VOTING")
EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_QUESTION","QUESTION")

--TAGS: %T = Time until expiration.
EdgeHUD.AddPhrase(LANG,"VOTE_EXPIRE","Expires in %T")

EdgeHUD.AddPhrase(LANG,"VOTE_YES","Yes")
EdgeHUD.AddPhrase(LANG,"VOTE_NO","No")

EdgeHUD.AddPhrase(LANG,"VOTE_PENDING","[EdgeHUD] You have a new vote/question pending. Take away your tool gun to vote.")

--[[-------------------------------------------------------------------------
Phrases - Top right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN_TITLE","LOCKDOWN")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN","The mayor have initiated a lockdown, return to your homes!")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED_TITLE","WANTED")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED","You are wanted! The police are looking for you!")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED_TITLE","ARRESTED")

--TAGS: %T = Time until release.
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED","You will be released in %T.")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_AGENDAHELP","Type /agenda <message> in chat to modify the agenda.")

--[[-------------------------------------------------------------------------
Phrases - Time
---------------------------------------------------------------------------]]

--TAGS: %H = Hours, %M = Minutes
EdgeHUD.AddPhrase(LANG,"TIME_HOUR_MIN","%H hours and %M minutes")

--TAGS: %M = Minutes, %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_MIN_SEC","%M minutes and %S seconds")

--TAGS: %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_SEC","%S seconds")

--[[-------------------------------------------------------------------------
Phrases - Arrested
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ARRESTED", "ARRESTED")

--TAGS: %C = Criminal Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_COP", "You have arrested %C for %T.")

--TAGS: %P = Officer Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT", "You have been arrested by %P for %T.")
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT2", "You have been arrested for %T.")

--[[-------------------------------------------------------------------------
Phrases - Released
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"RELEASED", "RELEASED")

--TAGS: %C = Criminal Name
EdgeHUD.AddPhrase(LANG,"RELEASED_COP", "You have released %C from jail.")

EdgeHUD.AddPhrase(LANG,"RELEASED_SUSPECT", "You have been released from jail.")

--[[-------------------------------------------------------------------------
Phrases - Wanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WANTED", "WANTED")

--TAGS: %C = Criminal Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_COP", "You made %C wanted for %R.")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT", "You have been wanted by %P for %R.")
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT2", "You have been wanted for %R.")

--[[-------------------------------------------------------------------------
Phrases - Unwanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWANTED", "UNWANTED")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWANTED_COP", "You have taken away %S's wanted status.")

EdgeHUD.AddPhrase(LANG,"UNWANTED_SUSPECT", "You are no longer wanted by the police.")

--[[-------------------------------------------------------------------------
Phrases - Warranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WARRANTED", "WARRANTED")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"WARRANTED_COP", "You are now allowed to search %S's buildings.")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT", "You have received a warrant by %P for %R.")
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT2", "You have received a warrant for %R.")

--[[-------------------------------------------------------------------------
Phrases - Unwarranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWARRANTED", "UNWARRANTED")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWARRANTED_COP", "You have removed %S's warrant.")

EdgeHUD.AddPhrase(LANG,"UNWARRANTED_SUSPECT", "Your warrant have expired.")

--[[-------------------------------------------------------------------------
Phrases - Vehicle Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE", "Vehicle")

--TAGS: %N = Name of owner
EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER", "Owner: %N")

--TAGS: %G = Groupname
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_GROUP", "Access: %G")

--TAGS: %J = Number of jobs
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_JOBS", "Access: %J job(s)")

EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER_UNKNOWN", "Owner: Unknown")

EdgeHUD.AddPhrase(LANG,"VEHICLE_NOTOWNABLE", "Not Ownable")

EdgeHUD.AddPhrase(LANG,"VEHICLE_UNOWNED", "Unowned")

EdgeHUD.AddPhrase(LANG,"VEHICLE_COOWNERS", "Co-Owners:")

EdgeHUD.AddPhrase(LANG,"VEHICLE_ALLOWED_COOWNERS", "Allowed Co-Owners:")

--[[-------------------------------------------------------------------------
Phrases - Door Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOOR_SOLD", "Sold Door")
EdgeHUD.AddPhrase(LANG,"DOOR_FORSALE", "For Sale")
EdgeHUD.AddPhrase(LANG,"DOOR_F2PURCHASE", "Press F2 to purchase door")

EdgeHUD.AddPhrase(LANG,"DOOR_COOWNERS", "Co-Owners:")
EdgeHUD.AddPhrase(LANG,"DOOR_ALLOWED_COOWNERS", "Allowed Co-Owners:")

--TAGS: %G = Name of group.
EdgeHUD.AddPhrase(LANG,"DOOR_GROUP_TITLE", "Group Door")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_GROUP", "Access: %G")

--TAGS: %J = Number of jobs.
EdgeHUD.AddPhrase(LANG,"DOOR_TEAM_TITLE", "Team Door")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_TEAM", "Access: %J job(s)")

--TAGS: %N = Name of owner.
EdgeHUD.AddPhrase(LANG,"DOOR_OWNER", "Owner: %N")

EdgeHUD.AddPhrase(LANG,"DOOR_OWNER_UNKNOWN", "Owner: Unknown")

--[[-------------------------------------------------------------------------
Phrases - Situations
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"LOCKDOWN", "LOCKDOWN")

EdgeHUD.AddPhrase(LANG,"LOCKDOWN_INITIATED", "The mayor have initiated a lockdown, return to your homes!")

--[[-------------------------------------------------------------------------
Phrases - Door Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_DOOR", "Buy door")
EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_VEHICLE", "Buy vehicle")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_DOOR", "Sell door")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_VEHICLE", "Sell vehicle")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ADDOWNER", "Add owner")
EdgeHUD.AddPhrase(LANG,"DOORMENU_REMOVEOWNER", "Remove owner")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ALLOWOWNERSHIP", "Allow ownership")
EdgeHUD.AddPhrase(LANG,"DOORMENU_DISALLOWOWNERSHIP", "Disallow ownership")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_DOOR", "Set door title")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_VEHICLE", "Set vehicle title")

EdgeHUD.AddPhrase(LANG,"DOORMENU_EDITGROUPS", "Edit group access")

--[[-------------------------------------------------------------------------
Phrases - Crash Screen
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TITLE", "Connection Lost")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT1", "It seems like the connection to the server was interupted.")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT2", "Please hold on while we try to establish a new connection.")

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_RECONNECT", "Reconnect")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_LEAVE", "Leave")

--[[-------------------------------------------------------------------------
Phrases - Gesture Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"GESTURE_BOW", "Bow")
EdgeHUD.AddPhrase(LANG,"GESTURE_SEXYDANCE", "Sexy dance")
EdgeHUD.AddPhrase(LANG,"GESTURE_FOLLOWME", "Follow me")
EdgeHUD.AddPhrase(LANG,"GESTURE_LAUGH", "Laugh")
EdgeHUD.AddPhrase(LANG,"GESTURE_LIONPOSE", "Lion pose")
EdgeHUD.AddPhrase(LANG,"GESTURE_NONVERBALNO", "Non-verbal no")
EdgeHUD.AddPhrase(LANG,"GESTURE_THUMBSUP", "Thumbs up")
EdgeHUD.AddPhrase(LANG,"GESTURE_WAVE", "Wave")
EdgeHUD.AddPhrase(LANG,"GESTURE_DANCE", "Dance")

--[[-------------------------------------------------------------------------
Phrases - Vehicle warnings HUD.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXTERIORLIGHT", "[Vehicle] : Vehicle exterior lights broken. Check exterior lighting before continuing drive.")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXHAUST", "[Vehicle] : Exhaust damage detected. Service vehicle immediately to prevent engine damage.")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_ENGINE", "[Vehicle] : Engine damage detected. Service vehicle immediately to prevent further engine damage.")

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTLEFT", "Front-Left")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTRIGHT", "Front-Right")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKLEFT", "Back-Left")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKRIGHT", "Back-Right")

--TAGS: %T = Damaged tires.
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRES", "[Vehicle] : Tire pressure loss in the (%T) tire.")

--[[-------------------------------------------------------------------------
Phrases - Battery Notifications.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CHARGER_CONNECTED", "Charger Connected")
EdgeHUD.AddPhrase(LANG,"CHARGER_DISCONNECTED", "Charger Disconnected")
EdgeHUD.AddPhrase(LANG,"BATTERY_STATUS", "Battery Status")

EdgeHUD.AddPhrase(LANG,"CHARGING_STARTED", "Your computer is now charging.")
EdgeHUD.AddPhrase(LANG,"CHARGING_ABORTED", "Your computer is no longer charging.")

--TAGS: %B = Battery precentage left.
EdgeHUD.AddPhrase(LANG,"BATTERY_NOTICE", "You currently have %B% of battery left. Connect charger to continue playing.")

--[[-------------------------------------------------------------------------
Phrases - Level bar
---------------------------------------------------------------------------]]

--TAGS: %L = Current Level, %P = Percentage to next level
EdgeHUD.AddPhrase(LANG,"LEVELBAR", "Level %L - %P%")

--[[-------------------------------------------------------------------------
Phrases - AdminTell
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ADMINTELL_TITLE", "ADMIN NOTICE")
EdgeHUD.AddPhrase(LANG,"ADMINTELL_NOMSG", "No message provided")

--[[-------------------------------------------------------------------------
Phrases - General
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CLOSE","Close")