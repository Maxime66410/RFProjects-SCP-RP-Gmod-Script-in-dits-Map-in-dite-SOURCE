--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeHUD.RegisterLanguage({
	Name = "Danish",
	Author = "Jompe",
	CompatibleVersion = "1.14.0",
})

--[[-------------------------------------------------------------------------
Phrases - Lower Left
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"IDENTITY", "Identitet")
EdgeHUD.AddPhrase(LANG,"JOB", "Arbejde")

--[[-------------------------------------------------------------------------
Phrases - Lower Right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_KPH","KPH")
EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_MPH","MPH")

--TAGS: %P = Amount of props.
EdgeHUD.AddPhrase(LANG,"PROPLIMIT","%P Props")

EdgeHUD.AddPhrase(LANG,"GUNLICENSE","Våbentilladelse")

--[[-------------------------------------------------------------------------
Phrases - Top Left
---------------------------------------------------------------------------]]

--TAGS: %V = Number of votes
EdgeHUD.AddPhrase(LANG,"VOTE_QUEUE","Der er %V ting i kø!")

EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_VOTE","AFSTEMNING")
EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_QUESTION","SPØRGSMÅL")

--TAGS: %T = Time until expiration.
EdgeHUD.AddPhrase(LANG,"VOTE_EXPIRE","Udløber om %T")

EdgeHUD.AddPhrase(LANG,"VOTE_YES","Ja")
EdgeHUD.AddPhrase(LANG,"VOTE_NO","Nej")

EdgeHUD.AddPhrase(LANG,"VOTE_PENDING","[EdgeHUD] Du har en ny afstemning / spørgsmål, der venter. Fjern din toolgun for at stemme.")

--[[-------------------------------------------------------------------------
Phrases - Top right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN_TITLE","LOCKDOWN")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN","Borgmesteren har indledt en lockdown, vend tilbage til dit hjem!")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED_TITLE","EFTERLYST")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED","Du er efterlyst! Politiet leder efter dig!")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED_TITLE","ARRESTERET")

--TAGS: %T = Time until release.
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED","Du bliver løsladt om %T.")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_AGENDAHELP","Skriv /agenda <meddelelse> i chat for at ændre dagsordenen.")

--[[-------------------------------------------------------------------------
Phrases - Time
---------------------------------------------------------------------------]]

--TAGS: %H = Hours, %M = Minutes
EdgeHUD.AddPhrase(LANG,"TIME_HOUR_MIN","%H timer og %M minutter")

--TAGS: %M = Minutes, %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_MIN_SEC","%M minut og %S sekunder")

--TAGS: %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_SEC","%S sekunder")

--[[-------------------------------------------------------------------------
Phrases - Arrested
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ARRESTED", "ARRESTERET")

--TAGS: %C = Criminal Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_COP", "Du har arresteret %C for %T.")

--TAGS: %P = Officer Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT", "Du er blevet arresteret af %P for %T.")
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT2", "Du er blevet arresteret for %T.")

--[[-------------------------------------------------------------------------
Phrases - Released
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"RELEASED", "LØSLADT")

--TAGS: %C = Criminal Name
EdgeHUD.AddPhrase(LANG,"RELEASED_COP", "Du har løsladt %C fra fængsel.")

EdgeHUD.AddPhrase(LANG,"RELEASED_SUSPECT", "Du er blevet løsladt fra fængslet.")

--[[-------------------------------------------------------------------------
Phrases - Wanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WANTED", "EFTERLYST")

--TAGS: %C = Criminal Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_COP", "Du har gjort %C efterlyst for %R.")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT", "Du er blevet efterlyst af %P for %R.")
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT2", "Du er blevet efterlyst for %R.")

--[[-------------------------------------------------------------------------
Phrases - Unwanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWANTED", "IKKE EFTERLYST")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWANTED_COP", "Du har fjernet %S's efterlyst status.")

EdgeHUD.AddPhrase(LANG,"UNWANTED_SUSPECT", "Du er ikke efterlyst længere.")

--[[-------------------------------------------------------------------------
Phrases - Warranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WARRANTED", "RANSAGNINGSKENDELSE")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"WARRANTED_COP", "Du har nu lov til at ransage %S's hus.")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT", "Du har modtaget en dommerkendelse af %P for %R.")
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT2", "Du har modtaget en dommerkendelse for %R.")

--[[-------------------------------------------------------------------------
Phrases - Unwarranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWARRANTED", "INGEN DOMMERKENDELSE")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWARRANTED_COP", "Du har fjernet %S's dommerkendelse.")

EdgeHUD.AddPhrase(LANG,"UNWARRANTED_SUSPECT", "Din ransagning er slut.")

--[[-------------------------------------------------------------------------
Phrases - Vehicle Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE", "Køretøj")

--TAGS: %N = Name of owner
EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER", "Ejer: %N")

--TAGS: %G = Groupname
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_GROUP", "Adgang: %G")

--TAGS: %J = Number of jobs
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_JOBS", "Adgang: %J arbejde(re)")

EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER_UNKNOWN", "Ejer: Ukendt")

EdgeHUD.AddPhrase(LANG,"VEHICLE_NOTOWNABLE", "Ikke ejelig")

EdgeHUD.AddPhrase(LANG,"VEHICLE_UNOWNED", "Ejes ikke")

EdgeHUD.AddPhrase(LANG,"VEHICLE_COOWNERS", "Medejere:")

EdgeHUD.AddPhrase(LANG,"VEHICLE_ALLOWED_COOWNERS", "Tilladte medejere:")

--[[-------------------------------------------------------------------------
Phrases - Door Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOOR_SOLD", "Solgt dør")
EdgeHUD.AddPhrase(LANG,"DOOR_FORSALE", "Til salg")
EdgeHUD.AddPhrase(LANG,"DOOR_F2PURCHASE", "Tryk på F2 for at købe dør")

EdgeHUD.AddPhrase(LANG,"DOOR_COOWNERS", "Medejere:")
EdgeHUD.AddPhrase(LANG,"DOOR_ALLOWED_COOWNERS", "Tilladte medejere:")

--TAGS: %G = Name of group.
EdgeHUD.AddPhrase(LANG,"DOOR_GROUP_TITLE", "Gruppedør")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_GROUP", "Adgang: %G")

--TAGS: %J = Number of jobs.
EdgeHUD.AddPhrase(LANG,"DOOR_TEAM_TITLE", "Team Dør")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_TEAM", "Adgang: %J job(s)")

--TAGS: %N = Name of owner.
EdgeHUD.AddPhrase(LANG,"DOOR_OWNER", "Ejer: %N")

EdgeHUD.AddPhrase(LANG,"DOOR_OWNER_UNKNOWN", "Ejer: Ukendt")

--[[-------------------------------------------------------------------------
Phrases - Situations
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"LOCKDOWN", "LOCKDOWN")

EdgeHUD.AddPhrase(LANG,"LOCKDOWN_INITIATED", "Borgmesteren har indledt en lockdown, vend tilbage til dit hjem!")

--[[-------------------------------------------------------------------------
Phrases - Door Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_DOOR", "Køb dør")
EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_VEHICLE", "Køb køretøj")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_DOOR", "Sælg dør")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_VEHICLE", "Sælg køretøj")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ADDOWNER", "Tilføj medejer")
EdgeHUD.AddPhrase(LANG,"DOORMENU_REMOVEOWNER", "Fjern medejer")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ALLOWOWNERSHIP", "Tillad ejerskab")
EdgeHUD.AddPhrase(LANG,"DOORMENU_DISALLOWOWNERSHIP", "Tillad ikke ejerskab")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_DOOR", "Indstil dørens titel")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_VEHICLE", "Indstil køretøjets titel")

EdgeHUD.AddPhrase(LANG,"DOORMENU_EDITGROUPS", "Rediger gruppeadgang")

--[[-------------------------------------------------------------------------
Phrases - Crash Screen
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TITLE", "Forbindelse afbrudt")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT1", "Det ser ud til, at forbindelsen til serveren blev afbrudt.")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT2", "Vent venligst mens vi prøver at etablere en ny forbindelse.")

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_RECONNECT", "Tilslut")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_LEAVE", "Forlad")

--[[-------------------------------------------------------------------------
Phrases - Gesture Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"GESTURE_BOW", "Bøj dig")
EdgeHUD.AddPhrase(LANG,"GESTURE_SEXYDANCE", "Sexet dans")
EdgeHUD.AddPhrase(LANG,"GESTURE_FOLLOWME", "Følg mig")
EdgeHUD.AddPhrase(LANG,"GESTURE_LAUGH", "Grin")
EdgeHUD.AddPhrase(LANG,"GESTURE_LIONPOSE", "Løve position")
EdgeHUD.AddPhrase(LANG,"GESTURE_NONVERBALNO", "Ikke-verbalt nej")
EdgeHUD.AddPhrase(LANG,"GESTURE_THUMBSUP", "Tommel op")
EdgeHUD.AddPhrase(LANG,"GESTURE_WAVE", "Vink")
EdgeHUD.AddPhrase(LANG,"GESTURE_DANCE", "Dans")

--[[-------------------------------------------------------------------------
Phrases - Vehicle warnings HUD.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXTERIORLIGHT", "[Køretøj]: Køretøjets udvendige lys er smadret. Kontroller udvendig belysning, før du fortsætter med at køre.")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXHAUST", "[Køretøj]: Udstødningsskade fundet. Servicer køretøjet straks for at forhindre motorskader.")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_ENGINE", "[Køretøj]: Motorskade fundet. Servicer køretøjet straks for at forhindre yderligere motorskader.")

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTLEFT", "Foran-Venstre")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTRIGHT", "Foran-Højre")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKLEFT", "Bagved-Venstre")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKRIGHT", "Bagved-Højre")

--TAGS: %T = Damaged tires.
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRES", "[Køretøj]: Dæktrykstab i (%T) hjul.")

--[[-------------------------------------------------------------------------
Phrases - Battery Notifications.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CHARGER_CONNECTED", "Oplader tilsluttet")
EdgeHUD.AddPhrase(LANG,"CHARGER_DISCONNECTED", "Opladeren er afbrudt")
EdgeHUD.AddPhrase(LANG,"BATTERY_STATUS", "Batteristatus")

EdgeHUD.AddPhrase(LANG,"CHARGING_STARTED", "Din computer oplades nu.")
EdgeHUD.AddPhrase(LANG,"CHARGING_ABORTED", "Din computer oplades ikke længere.")

--TAGS: %B = Battery precentage left.
EdgeHUD.AddPhrase(LANG,"BATTERY_NOTICE", "Du har i øjeblikket %B% batteri tilbage. Tilslut opladeren for at fortsætte med at spille.")

--[[-------------------------------------------------------------------------
Phrases - Level bar
---------------------------------------------------------------------------]]

--TAGS: %L = Current Level, %P = Percentage to next level
EdgeHUD.AddPhrase(LANG,"LEVELBAR", "Niveau %L - %P%")

--[[-------------------------------------------------------------------------
Phrases - AdminTell
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ADMINTELL_TITLE", "ADMIN MEDDELELSE")
EdgeHUD.AddPhrase(LANG,"ADMINTELL_NOMSG", "Ingen besked leveret")

--[[-------------------------------------------------------------------------
Phrases - General
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CLOSE","Luk")