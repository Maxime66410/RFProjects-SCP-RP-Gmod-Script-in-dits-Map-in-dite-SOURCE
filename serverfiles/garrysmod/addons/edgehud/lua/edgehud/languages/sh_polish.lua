--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeHUD.RegisterLanguage({
	Name = "Polish",
	Author = "Kyo",
	CompatibleVersion = "1.14.0",
})

--[[-------------------------------------------------------------------------
Phrases - Lower Left
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"IDENTITY", "Tożsamość")
EdgeHUD.AddPhrase(LANG,"JOB", "Praca")

--[[-------------------------------------------------------------------------
Phrases - Lower Right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_KPH","KM/H")
EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_MPH","MPH")

--TAGS: %P = Amount of props.
EdgeHUD.AddPhrase(LANG,"PROPLIMIT","%P Propów")

EdgeHUD.AddPhrase(LANG,"GUNLICENSE","Licencja na broń")

--[[-------------------------------------------------------------------------
Phrases - Top Left
---------------------------------------------------------------------------]]

--TAGS: %V = Number of votes
EdgeHUD.AddPhrase(LANG,"VOTE_QUEUE","Aktualnie w kolejce znajdują się %V głosowania!")

EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_VOTE","GŁOSOWANIE")
EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_QUESTION","PYTANIE")

--TAGS: %T = Time until expiration.
EdgeHUD.AddPhrase(LANG,"VOTE_EXPIRE","Wygasa za %T")

EdgeHUD.AddPhrase(LANG,"VOTE_YES","Tak")
EdgeHUD.AddPhrase(LANG,"VOTE_NO","Nie")

EdgeHUD.AddPhrase(LANG,"VOTE_PENDING","[EdgeHUD] You have a new vote/question pending. Take away your tool gun to vote.")

--[[-------------------------------------------------------------------------
Phrases - Top right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN_TITLE","STAN WYJĄTKOWY")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN","Burmistrz ogłosił stan wyjątkowy, należy udać się do swoich domów!")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED_TITLE","POSZUKIWANY")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED","Jesteś poszukiwany przez policję!")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED_TITLE","ARESZTOWANY")

--TAGS: %T = Time until release.
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED","Zostaniesz wypuszczony za %T.")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_AGENDAHELP","Wpisz /agenda <wiadomość>, aby zmodyfikować agende.")

--[[-------------------------------------------------------------------------
Phrases - Time
---------------------------------------------------------------------------]]

--TAGS: %H = Hours, %M = Minutes
EdgeHUD.AddPhrase(LANG,"TIME_HOUR_MIN","%H godzin i %M minut")

--TAGS: %M = Minutes, %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_MIN_SEC","%M minut i %S sekund")

--TAGS: %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_SEC","%S sekund")

--[[-------------------------------------------------------------------------
Phrases - Arrested
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ARRESTED", "ARESZTOWANY")

--TAGS: %C = Criminal Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_COP", "Zaaresztowałeś gracza %C na %T.")

--TAGS: %P = Officer Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT", "Zostałeś zaaresztowany przez %P na %T.")
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT2", "Zostałeś aresztowany na %T.")

--[[-------------------------------------------------------------------------
Phrases - Released
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"RELEASED", "WYPUSZCZONY")

--TAGS: %C = Criminal Name
EdgeHUD.AddPhrase(LANG,"RELEASED_COP", "Wypuściłeś %C z więzienia.")

EdgeHUD.AddPhrase(LANG,"RELEASED_SUSPECT", "Zostałeś wypuszczony z więzienia.")

--[[-------------------------------------------------------------------------
Phrases - Wanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WANTED", "POSZUKIWANY")

--TAGS: %C = Criminal Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_COP", "Nałożyłeś status poszukiwanego na gracza %C za %R.")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT", "Jesteś poszukiwany z rozkazu %P za %R.")
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT2", "Jesteś poszukiwany za %R.")

--[[-------------------------------------------------------------------------
Phrases - Unwanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWANTED", "NIE POSZUKIWANY")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWANTED_COP", "Gracz %S nie jest już poszukiwany z twojego rozkazu.")

EdgeHUD.AddPhrase(LANG,"UNWANTED_SUSPECT", "Nie jesteś już poszukiwany przez policję.")

--[[-------------------------------------------------------------------------
Phrases - Warranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WARRANTED", "NAKAZ PRZESZUKANIA")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"WARRANTED_COP", "Od teraz możesz przeszukać posiadłość gracza %S.")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT", "Został na ciebie nałożony nakaz przeszukania przez %P za %R.")
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT2", "Otrzymałeś nakaz przeszukania za %R.")

--[[-------------------------------------------------------------------------
Phrases - Unwarranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWARRANTED", "BEZ NAKAZU PRZESZUKANIA")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWARRANTED_COP", "Usunąłeś nakaz przeszukania z gracza %S.")

EdgeHUD.AddPhrase(LANG,"UNWARRANTED_SUSPECT", "Twój nakaz przeszukania wygasł.")

--[[-------------------------------------------------------------------------
Phrases - Vehicle Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE", "Pojazd")

--TAGS: %N = Name of owner
EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER", "Właściciel: %N")

--TAGS: %G = Groupname
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_GROUP", "Dostęp: %G")

--TAGS: %J = Number of jobs
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_JOBS", "Dostęp: prace %J")

EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER_UNKNOWN", "Właściciel: Nieznany")

EdgeHUD.AddPhrase(LANG,"VEHICLE_NOTOWNABLE", "Nie do zakupienia")

EdgeHUD.AddPhrase(LANG,"VEHICLE_UNOWNED", "Możliwe do zakupu")

EdgeHUD.AddPhrase(LANG,"VEHICLE_COOWNERS", "Współwłaściciele:")

EdgeHUD.AddPhrase(LANG,"VEHICLE_ALLOWED_COOWNERS", "Dozwoleni współwłaściciele:")

--[[-------------------------------------------------------------------------
Phrases - Door Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOOR_SOLD", "WYKUPIONE DRZWI")
EdgeHUD.AddPhrase(LANG,"DOOR_FORSALE", "NA SPRZEDAŻ")
EdgeHUD.AddPhrase(LANG,"DOOR_F2PURCHASE", "Wciśnij F2, aby zakupić drzwi")

EdgeHUD.AddPhrase(LANG,"DOOR_COOWNERS", "Współwłaściciele:")
EdgeHUD.AddPhrase(LANG,"DOOR_ALLOWED_COOWNERS", "Dozwoleni współwłaściciele:")

--TAGS: %G = Name of group.
EdgeHUD.AddPhrase(LANG,"DOOR_GROUP_TITLE", "Grupa - drzwi")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_GROUP", "Dostęp: %G")

--TAGS: %J = Number of jobs.
EdgeHUD.AddPhrase(LANG,"DOOR_TEAM_TITLE", "Drużyna - drzwi")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_TEAM", "Dostęp: prace %J")

--TAGS: %N = Name of owner.
EdgeHUD.AddPhrase(LANG,"DOOR_OWNER", "Właściciel: %N")

EdgeHUD.AddPhrase(LANG,"DOOR_OWNER_UNKNOWN", "Właściciel: Nieznany")

--[[-------------------------------------------------------------------------
Phrases - Situations
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"LOCKDOWN", "STAN WYJĄTKOWY")

EdgeHUD.AddPhrase(LANG,"LOCKDOWN_INITIATED", "Burmistrz ogłosił stan wyjątkowy, należy udać się do swoich domów!")

--[[-------------------------------------------------------------------------
Phrases - Door Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_DOOR", "Zakup drzwi")
EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_VEHICLE", "Zakup pojazd")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_DOOR", "Sprzedaj drzwi")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_VEHICLE", "Sprzedaj pojazd")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ADDOWNER", "Dodaj założyciela")
EdgeHUD.AddPhrase(LANG,"DOORMENU_REMOVEOWNER", "Usuń założyciela")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ALLOWOWNERSHIP", "Zezwól na kupno")
EdgeHUD.AddPhrase(LANG,"DOORMENU_DISALLOWOWNERSHIP", "Wyłącz opcję kupna")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_DOOR", "Ustaw tytuł drzwi")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_VEHICLE", "Ustaw nazwę pojazdu")

EdgeHUD.AddPhrase(LANG,"DOORMENU_EDITGROUPS", "Zmień grupy dostępu")

--[[-------------------------------------------------------------------------
Phrases - Crash Screen
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TITLE", "Stracono Połączenie")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT1", "Wygląda na to że połączenie do serwera zostało przerwane.")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT2", "Proszę poczekać do momentu ustalenia nowego połączenia.")

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_RECONNECT", "Dołącz ponownie")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_LEAVE", "Wyjdź")

--[[-------------------------------------------------------------------------
Phrases - Gesture Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"GESTURE_BOW", "Ukłoń się")
EdgeHUD.AddPhrase(LANG,"GESTURE_SEXYDANCE", "Zatańcz uwodzicielsko")
EdgeHUD.AddPhrase(LANG,"GESTURE_FOLLOWME", "Podążaj za mną")
EdgeHUD.AddPhrase(LANG,"GESTURE_LAUGH", "Śmiej się")
EdgeHUD.AddPhrase(LANG,"GESTURE_LIONPOSE", "Poza lwa")
EdgeHUD.AddPhrase(LANG,"GESTURE_NONVERBALNO", "Nie")
EdgeHUD.AddPhrase(LANG,"GESTURE_THUMBSUP", "Kciuk w górę")
EdgeHUD.AddPhrase(LANG,"GESTURE_WAVE", "Przywitaj się")
EdgeHUD.AddPhrase(LANG,"GESTURE_DANCE", "Zatańcz")

--[[-------------------------------------------------------------------------
Phrases - Vehicle warnings HUD.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXTERIORLIGHT", "[Pojazd] : Wykryto uszkodzenie świateł. Sprawdź światła przed dalszą jazdą.")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXHAUST", "[Pojazd] : Wykryto uszkodzenie rury wydechowej. Udaj się do najbliżeszgo mechanika, aby zapobiec dalszemu uszkodzeniu.")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_ENGINE", "[Pojazd] : Wykryto uszkodzenie silnika. Udaj się do najbliższego mechanika, aby zapobiec dalszemu uszkodzeniu silnika.")

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTLEFT", "Przednia lewa")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTRIGHT", "Przednia prawa")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKLEFT", "Tylna lewa")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKRIGHT", "Tylna prawa")

--TAGS: %T = Damaged tires.
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRES", "[Pojazd] : Spadek ciśnienia w oponie wynosi (%T).")

--[[-------------------------------------------------------------------------
Phrases - Battery Notifications.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CHARGER_CONNECTED", "Podłączono ładowarkę")
EdgeHUD.AddPhrase(LANG,"CHARGER_DISCONNECTED", "Odłączono ładowarkę")
EdgeHUD.AddPhrase(LANG,"BATTERY_STATUS", "STATUS BATERII")

EdgeHUD.AddPhrase(LANG,"CHARGING_STARTED", "Twój komputer zaczął się ładować.")
EdgeHUD.AddPhrase(LANG,"CHARGING_ABORTED", "Twój komputer już się nie ładuje.")

--TAGS: %B = Battery precentage left.
EdgeHUD.AddPhrase(LANG,"BATTERY_NOTICE", "Pozostało ci %B% baterii. Podłącz ładowarkę, aby dalej cieszyć się rozgrywką.")

--[[-------------------------------------------------------------------------
Phrases - Level bar
---------------------------------------------------------------------------]]

--TAGS: %L = Current Level, %P = Percentage to next level
EdgeHUD.AddPhrase(LANG,"LEVELBAR", "Poziom %L - %P%")

--[[-------------------------------------------------------------------------
Phrases - AdminTell
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ADMINTELL_TITLE", "UWAGA")
EdgeHUD.AddPhrase(LANG,"ADMINTELL_NOMSG", "Nie wprowadzono wiadomości")

--[[-------------------------------------------------------------------------
Phrases - General
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CLOSE","Zamknij")