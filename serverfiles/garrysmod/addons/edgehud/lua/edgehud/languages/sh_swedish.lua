--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeHUD.RegisterLanguage({
	Name = "Swedish",
	Author = "Jompe",
	CompatibleVersion = "1.14.0",
})

--[[-------------------------------------------------------------------------
Phrases - Lower Left
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"IDENTITY", "Identitet")
EdgeHUD.AddPhrase(LANG,"JOB", "Jobb")

--[[-------------------------------------------------------------------------
Phrases - Lower Right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_KPH","KPH")
EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_MPH","MPH")

--TAGS: %P = Amount of props.
EdgeHUD.AddPhrase(LANG,"PROPLIMIT","%P Föremål")

EdgeHUD.AddPhrase(LANG,"GUNLICENSE","Vapenlicens")

--[[-------------------------------------------------------------------------
Phrases - Top Left
---------------------------------------------------------------------------]]

--TAGS: %V = Number of votes
EdgeHUD.AddPhrase(LANG,"VOTE_QUEUE","Det är %V objekt i kön!")

EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_VOTE","RÖSTNING")
EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_QUESTION","FRÅGA")

--TAGS: %T = Time until expiration.
EdgeHUD.AddPhrase(LANG,"VOTE_EXPIRE","Utgår om %T")

EdgeHUD.AddPhrase(LANG,"VOTE_YES","Ja")
EdgeHUD.AddPhrase(LANG,"VOTE_NO","Nej")

EdgeHUD.AddPhrase(LANG,"VOTE_PENDING","[EdgeHUD] Du har en väntande röstning/fråga. Byt ifrån din Tool Gun för att rösta.")

--[[-------------------------------------------------------------------------
Phrases - Top right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN_TITLE","UTEGÅNGSFÖRBUD")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN","Borgmästaren har utfärdat utegångsförbud, återgå till era hem!")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED_TITLE","EFTERLYST")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED","Du är efterlyst! Polisen letar efter dig!")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED_TITLE","ARRESTERAD")

--TAGS: %T = Time until release.
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED","Du kommer att bli frisläppt om %T.")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_AGENDAHELP","Skriv /agenda <message> i chatten för att ändra agendan.")

--[[-------------------------------------------------------------------------
Phrases - Time
---------------------------------------------------------------------------]]

--TAGS: %H = Hours, %M = Minutes
EdgeHUD.AddPhrase(LANG,"TIME_HOUR_MIN","%H timmar och %M minuter")

--TAGS: %M = Minutes, %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_MIN_SEC","%M minuter och %S sekunder")

--TAGS: %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_SEC","%S sekunder")

--[[-------------------------------------------------------------------------
Phrases - Arrested
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ARRESTED", "ARRESTERAD")

--TAGS: %C = Criminal Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_COP", "Du har arresterat %C i %T.")

--TAGS: %P = Officer Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT", "Du har blivit arresterad av %P i %T.")
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT2", "Du har blivit arresterad i %T.")

--[[-------------------------------------------------------------------------
Phrases - Released
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"RELEASED", "FRISLÄPPT")

--TAGS: %C = Criminal Name
EdgeHUD.AddPhrase(LANG,"RELEASED_COP", "Du har släppt %C fri från fängelset.")

EdgeHUD.AddPhrase(LANG,"RELEASED_SUSPECT", "Du har blivit frisläppt från fängelset.")

--[[-------------------------------------------------------------------------
Phrases - Wanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WANTED", "EFTERLYSNING")

--TAGS: %C = Criminal Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_COP", "Du gjorde %C efterlyst för %R.")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT", "Du har blivit efterlyst av %P för %R.")
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT2", "Du har blivit efterlyst för %R.")

--[[-------------------------------------------------------------------------
Phrases - Unwanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWANTED", "EFTERLYSNING ÅTERKALLAD")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWANTED_COP", "Du har återkallat %Ss efterlysning.")

EdgeHUD.AddPhrase(LANG,"UNWANTED_SUSPECT", "Du är inte längre efterlyst av polisen.")

--[[-------------------------------------------------------------------------
Phrases - Warranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WARRANTED", "HUSRANNSAKAN")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"WARRANTED_COP", "Du får nu söka igenom %Ss byggnader.")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT", "Du har blivit utfärdad en husrannsakan av %P för %R.")
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT2", "Du har blivit utfärdad en husrannsakan för %R.")

--[[-------------------------------------------------------------------------
Phrases - Unwarranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWARRANTED", "HUSRANNSAKAN ÅTERKALLAD")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWARRANTED_COP", "Du har återkallat %Ss husrannsakan.")

EdgeHUD.AddPhrase(LANG,"UNWARRANTED_SUSPECT", "Din husrannsakan har utgått.")

--[[-------------------------------------------------------------------------
Phrases - Vehicle Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE", "Fordon")

--TAGS: %N = Name of owner
EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER", "Ägare: %N")

--TAGS: %G = Groupname
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_GROUP", "Tillträde: %G")

--TAGS: %J = Number of jobs
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_JOBS", "Tillträde: %J jobb")

EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER_UNKNOWN", "Ägare: Unknown")

EdgeHUD.AddPhrase(LANG,"VEHICLE_NOTOWNABLE", "Ej Ägbar")

EdgeHUD.AddPhrase(LANG,"VEHICLE_UNOWNED", "Oägd")

EdgeHUD.AddPhrase(LANG,"VEHICLE_COOWNERS", "Delägare:")

EdgeHUD.AddPhrase(LANG,"VEHICLE_ALLOWED_COOWNERS", "Tillåtna Delägare:")

--[[-------------------------------------------------------------------------
Phrases - Door Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOOR_SOLD", "Såld Dörr")
EdgeHUD.AddPhrase(LANG,"DOOR_FORSALE", "Till Salu")
EdgeHUD.AddPhrase(LANG,"DOOR_F2PURCHASE", "Tryck F2 för att köpa dörr")

EdgeHUD.AddPhrase(LANG,"DOOR_COOWNERS", "Delägare:")
EdgeHUD.AddPhrase(LANG,"DOOR_ALLOWED_COOWNERS", "Tillåtna Delägare:")

--TAGS: %G = Name of group.
EdgeHUD.AddPhrase(LANG,"DOOR_GROUP_TITLE", "Grupp Dörr")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_GROUP", "Tillträde: %G")

--TAGS: %J = Number of jobs.
EdgeHUD.AddPhrase(LANG,"DOOR_TEAM_TITLE", "Jobb Dörr")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_TEAM", "Tillträde: %J jobb")

--TAGS: %N = Name of owner.
EdgeHUD.AddPhrase(LANG,"DOOR_OWNER", "Ägare: %N")

EdgeHUD.AddPhrase(LANG,"DOOR_OWNER_UNKNOWN", "Ägare: Okänd")

--[[-------------------------------------------------------------------------
Phrases - Situations
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"LOCKDOWN", "UTEGÅNGSFÖRBUD")

EdgeHUD.AddPhrase(LANG,"LOCKDOWN_INITIATED", "Borgmästaren har utfärdat ett utegångsförbud, återgå till era hem!")

--[[-------------------------------------------------------------------------
Phrases - Door Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_DOOR", "Köp dörr")
EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_VEHICLE", "Köp fordon")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_DOOR", "Sälj dörr")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_VEHICLE", "Sälj fordon")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ADDOWNER", "Lägg till ägare")
EdgeHUD.AddPhrase(LANG,"DOORMENU_REMOVEOWNER", "Ta bort ägare")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ALLOWOWNERSHIP", "Tillåt ägarskap")
EdgeHUD.AddPhrase(LANG,"DOORMENU_DISALLOWOWNERSHIP", "Förbjud ägarskap")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_DOOR", "Ändra dörrtitel")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_VEHICLE", "Ändra fordonstitel")

EdgeHUD.AddPhrase(LANG,"DOORMENU_EDITGROUPS", "Ändra grupp-tillträde")

--[[-------------------------------------------------------------------------
Phrases - Crash Screen
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TITLE", "Anslutning Förlorad")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT1", "Det verkar som att anslutningen till servern tappades.")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT2", "Vänligen vänta medan vi försöker återansluta dig.")

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_RECONNECT", "Återanslut")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_LEAVE", "Lämna")

--[[-------------------------------------------------------------------------
Phrases - Gesture Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"GESTURE_BOW", "Buga")
EdgeHUD.AddPhrase(LANG,"GESTURE_SEXYDANCE", "Sexig dans")
EdgeHUD.AddPhrase(LANG,"GESTURE_FOLLOWME", "Följ mig")
EdgeHUD.AddPhrase(LANG,"GESTURE_LAUGH", "Skratta")
EdgeHUD.AddPhrase(LANG,"GESTURE_LIONPOSE", "Lejonposera")
EdgeHUD.AddPhrase(LANG,"GESTURE_NONVERBALNO", "Icke verbalt nej")
EdgeHUD.AddPhrase(LANG,"GESTURE_THUMBSUP", "Tummen upp")
EdgeHUD.AddPhrase(LANG,"GESTURE_WAVE", "Vinka")
EdgeHUD.AddPhrase(LANG,"GESTURE_DANCE", "Dansa")

--[[-------------------------------------------------------------------------
Phrases - Vehicle warnings HUD.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXTERIORLIGHT", "[Vehicle] : Yttre fordonsljus ej funktionellt. Kontrollera yttre fordonsljus innan du försätter körningen.")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXHAUST", "[Vehicle] : Avgasrörskada detekterad. Serva fordonet omedelbart för att undvika motorskada.")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_ENGINE", "[Vehicle] : Motorskada detekterad. Serva fordonet omedelbart för att undvika yttligare motorskada.")

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTLEFT", "Främre-Vänster")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTRIGHT", "Främre-Höger")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKLEFT", "Bakre-Vänster")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKRIGHT", "Bakre-Höger")

--TAGS: %T = Damaged tires.
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRES", "[Vehicle] : Tryckförlust i det (%T) däcket.")

--[[-------------------------------------------------------------------------
Phrases - Battery Notifications.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CHARGER_CONNECTED", "Laddare Ansluten")
EdgeHUD.AddPhrase(LANG,"CHARGER_DISCONNECTED", "Laddare Frånkopplad")
EdgeHUD.AddPhrase(LANG,"BATTERY_STATUS", "Batteristatus")

EdgeHUD.AddPhrase(LANG,"CHARGING_STARTED", "Din dator laddar nu.")
EdgeHUD.AddPhrase(LANG,"CHARGING_ABORTED", "Din dator laddar inte längre")

--TAGS: %B = Battery precentage left.
EdgeHUD.AddPhrase(LANG,"BATTERY_NOTICE", "Du har %B% batteri kvar. Anslut laddare för att forsätta spela.")

--[[-------------------------------------------------------------------------
Phrases - Level bar
---------------------------------------------------------------------------]]

--TAGS: %L = Current Level, %P = Percentage to next level
EdgeHUD.AddPhrase(LANG,"LEVELBAR", "Nivå %L - %P%")

--[[-------------------------------------------------------------------------
Phrases - AdminTell
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ADMINTELL_TITLE", "ADMIN MEDDELANDE")
EdgeHUD.AddPhrase(LANG,"ADMINTELL_NOMSG", "Inget meddelande försett")


--[[-------------------------------------------------------------------------
Phrases - General
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CLOSE","Stäng")