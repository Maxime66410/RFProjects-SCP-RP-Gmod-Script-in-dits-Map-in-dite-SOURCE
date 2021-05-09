--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeHUD.RegisterLanguage({
	Name = "French",
	Author = "_Fireless",
	CompatibleVersion = "1.14.0",
})

--[[-------------------------------------------------------------------------
Phrases - Lower Left
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"IDENTITY", "Identité")
EdgeHUD.AddPhrase(LANG,"JOB", "Métier")

--[[-------------------------------------------------------------------------
Phrases - Lower Right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_KPH","KPH")
EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_MPH","MPH")

--TAGS: %P = Amount of props.
EdgeHUD.AddPhrase(LANG,"PROPLIMIT","%P props")

EdgeHUD.AddPhrase(LANG,"GUNLICENSE","License d'arme")

--[[-------------------------------------------------------------------------
Phrases - Top Left
---------------------------------------------------------------------------]]

--TAGS: %V = Number of votes
EdgeHUD.AddPhrase(LANG,"VOTE_QUEUE","Il y a %V d'items dans la file d'attente")

EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_VOTE","VOTE")
EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_QUESTION","QUESTION")

--TAGS: %T = Time until expiration.
EdgeHUD.AddPhrase(LANG,"VOTE_EXPIRE","Expire dans %T")

EdgeHUD.AddPhrase(LANG,"VOTE_YES","Oui")
EdgeHUD.AddPhrase(LANG,"VOTE_NO","Non")

EdgeHUD.AddPhrase(LANG,"VOTE_PENDING","Tu as une nouveau vote/question en attente. Enlève ton tool gun de t'es main pour voter.")

--[[-------------------------------------------------------------------------
Phrases - Top right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN_TITLE","Couvre-Feu")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN","Un couvre-feu est en cours, veuillez vous abriter !")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED_TITLE","RECHERCHÉE")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED","Tu es recherché(e) ! La police te recherche !")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED_TITLE","ARRÊTÉ(E)")

--TAGS: %T = Time until release.
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED","Tu seras libéré(e) dans %T.")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_AGENDAHELP","Ecris /agenda <message> dans le tchat pour modifier l'agenda.")

--[[-------------------------------------------------------------------------
Phrases - Time
---------------------------------------------------------------------------]]

--TAGS: %H = Hours, %M = Minutes
EdgeHUD.AddPhrase(LANG,"TIME_HOUR_MIN","%H Heures et %M Minutes")

--TAGS: %M = Minutes, %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_MIN_SEC","%M Minutes et %S Secondes")

--TAGS: %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_SEC","%S secondes")

--[[-------------------------------------------------------------------------
Phrases - Arrested
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ARRESTED", "ARRÊTÉ(E)")

--TAGS: %C = Criminal Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_COP", "Tu as arrêté %C pendant %T.")

--TAGS: %P = Officer Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT", "Tu as été arrêté(e) par %P pendant %T.")
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT2", "Tu as été arrêté(e) pendant %T.")

--[[-------------------------------------------------------------------------
Phrases - Released
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"RELEASED", "LIBÉRÉ(E)")

--TAGS: %C = Criminal Name
EdgeHUD.AddPhrase(LANG,"RELEASED_COP", "Tu as libéré %C de prison.")

EdgeHUD.AddPhrase(LANG,"RELEASED_SUSPECT", "Tu as été libéré(e) de prison.")

--[[-------------------------------------------------------------------------
Phrases - Wanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WANTED", "RECHERCHÉ(E)")

--TAGS: %C = Criminal Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_COP", "Tu recherches %C pour : \"%R\".")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT", "Tu recherches %P pour : \"%R\".")
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT2", "Tu es recherché(e) pour : \"%R\".")

--[[-------------------------------------------------------------------------
Phrases - Unwanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWANTED", "PLUS RECHERCHÉ(E)")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWANTED_COP", "Ton contrat de recherche pour %S a été abandoné ou résolu.")

EdgeHUD.AddPhrase(LANG,"UNWANTED_SUSPECT", "Tu n'es plus recherché(e) par la police.")

--[[-------------------------------------------------------------------------
Phrases - Warranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WARRANTED", "MANDAT")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"WARRANTED_COP", "Tu es maintenant autorisé(e) à rechercher le domicile de %S")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT", "Tu as reçu un mandat de %P pour %R.")
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT2", "Tu as reçu un mandat pour %R.")

--[[-------------------------------------------------------------------------
Phrases - Unwarranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWARRANTED", "INJUSTIFIÉ")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWARRANTED_COP", "Le mandat de %S a été abandonné ou résolu.")

EdgeHUD.AddPhrase(LANG,"UNWARRANTED_SUSPECT", "Votre mandat a expiré.")

--[[-------------------------------------------------------------------------
Phrases - Vehicle Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE", "Véhicule")

--TAGS: %N = Name of owner
EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER", "Propriétaire: %N")

--TAGS: %G = Groupname
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_GROUP", "Accès: %G")

--TAGS: %J = Number of jobs
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_JOBS", "Accès: %J Métier(s)")

EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER_UNKNOWN", "Propriétaire: Inconnu(e)")

EdgeHUD.AddPhrase(LANG,"VEHICLE_NOTOWNABLE", "Inachetable")

EdgeHUD.AddPhrase(LANG,"VEHICLE_UNOWNED", "Sans propriétaire")

EdgeHUD.AddPhrase(LANG,"VEHICLE_COOWNERS", "Co-Propriétaire:")

EdgeHUD.AddPhrase(LANG,"VEHICLE_ALLOWED_COOWNERS", "Autoriser en Co-Propriétaire:")

--[[-------------------------------------------------------------------------
Phrases - Door Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOOR_SOLD", "Porte Vendue")
EdgeHUD.AddPhrase(LANG,"DOOR_FORSALE", "Achetable")
EdgeHUD.AddPhrase(LANG,"DOOR_F2PURCHASE", "Appuyer sur F2 pour acheter la porte")

EdgeHUD.AddPhrase(LANG,"DOOR_COOWNERS", "Co-Propriétaire:")
EdgeHUD.AddPhrase(LANG,"DOOR_ALLOWED_COOWNERS", "Autoriser en Co-Propriétaire:")

--TAGS: %G = Name of group.
EdgeHUD.AddPhrase(LANG,"DOOR_GROUP_TITLE", "Groupe de portes")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_GROUP", "Accès: %G")

--TAGS: %J = Number of jobs.
EdgeHUD.AddPhrase(LANG,"DOOR_TEAM_TITLE", "Métiers de porte")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_TEAM", "Accès: %J Métier(s)")

--TAGS: %N = Name of owner.
EdgeHUD.AddPhrase(LANG,"DOOR_OWNER", "Propriétaire: %N")

EdgeHUD.AddPhrase(LANG,"DOOR_OWNER_UNKNOWN", "Propriétaire: Inconnu(e)")

--[[-------------------------------------------------------------------------
Phrases - Situations
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"LOCKDOWN", "COUVRE-FEU")

EdgeHUD.AddPhrase(LANG,"LOCKDOWN_INITIATED", "Le maire a initialisé un couvre-feu, Mets-toi a l'abri !")

--[[-------------------------------------------------------------------------
Phrases - Door Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_DOOR", "Acheter la porte")
EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_VEHICLE", "Acheter le vehicule")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_DOOR", "Vendre la porte")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_VEHICLE", "Vendre le véhicule")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ADDOWNER", "Ajouter un co-propriétaire")
EdgeHUD.AddPhrase(LANG,"DOORMENU_REMOVEOWNER", "Retirer un co-propriétaire")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ALLOWOWNERSHIP", "Autoriser d'acheter")
EdgeHUD.AddPhrase(LANG,"DOORMENU_DISALLOWOWNERSHIP", "Refuser d'acheter")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_DOOR", "Définir le titre de la porte")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_VEHICLE", "Définir le titre du véhicule")

EdgeHUD.AddPhrase(LANG,"DOORMENU_EDITGROUPS", "Modifier l'accès au groupe")

--[[-------------------------------------------------------------------------
Phrases - Crash Screen
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TITLE", "Connexion perdue")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT1", "Il semble que la connexion au serveur ait été interrompue.")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT2", "Veuillez patienter pendant que nous essayons d'établir une nouvelle connexion.")

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_RECONNECT", "Se reconnecter")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_LEAVE", "Partir")

--[[-------------------------------------------------------------------------
Phrases - Gesture Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"GESTURE_BOW", "Arc")
EdgeHUD.AddPhrase(LANG,"GESTURE_SEXYDANCE", "Danse Sexy")
EdgeHUD.AddPhrase(LANG,"GESTURE_FOLLOWME", "Suis moi")
EdgeHUD.AddPhrase(LANG,"GESTURE_LAUGH", "Rire")
EdgeHUD.AddPhrase(LANG,"GESTURE_LIONPOSE", "Pose de Lion")
EdgeHUD.AddPhrase(LANG,"GESTURE_NONVERBALNO", "Non verbale")
EdgeHUD.AddPhrase(LANG,"GESTURE_THUMBSUP", "Pouces vers le haut")
EdgeHUD.AddPhrase(LANG,"GESTURE_WAVE", "Vague")
EdgeHUD.AddPhrase(LANG,"GESTURE_DANCE", "Danse")

--[[-------------------------------------------------------------------------
Phrases - Vehicle warnings HUD.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXTERIORLIGHT", "[Véhicule] : Une lampe du véhicule s'est cassée, Vérifie l'éclairage extérieur avant de continuer à rouler.")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXHAUST", "[Véhicule] : Pot d'échappement défectueux, Répare immédiatement le véhicule pour éviter d'endommager le moteur.")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_ENGINE", "[Véhicule] : Dommages moteur détectés. Répare immédiatement le véhicule pour éviter d'autres dommages au moteur.")

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTLEFT", "Avant gauche")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTRIGHT", "Avant droit")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKLEFT", "Arrière gauche")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKRIGHT", "Arrière droit")

--TAGS: %T = Damaged tires.
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRES", "[Véhicule] : Le pneu (%T) s'est dégonflé.")

--[[-------------------------------------------------------------------------
Phrases - Battery Notifications.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CHARGER_CONNECTED", "Chargeur connecté")
EdgeHUD.AddPhrase(LANG,"CHARGER_DISCONNECTED", "Chargeur déconnecté")
EdgeHUD.AddPhrase(LANG,"BATTERY_STATUS", "État de la batterie")

EdgeHUD.AddPhrase(LANG,"CHARGING_STARTED", "Ta batterie est en train de charger.")
EdgeHUD.AddPhrase(LANG,"CHARGING_ABORTED", "Ta batterie ne charge plus.")

--TAGS: %B = Battery precentage left.
EdgeHUD.AddPhrase(LANG,"BATTERY_NOTICE", "Tu as %B% d'énergie dans ta batterie. Connecte le chargeur !")

--[[-------------------------------------------------------------------------
Phrases - Level bar
---------------------------------------------------------------------------]]

--TAGS: %L = Current Level, %P = Percentage to next level
EdgeHUD.AddPhrase(LANG,"LEVELBAR", "Level %L - %P%")

--[[-------------------------------------------------------------------------
Phrases - AdminTell
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ADMINTELL_TITLE", "MESSAGE D'ADMIN")
EdgeHUD.AddPhrase(LANG,"ADMINTELL_NOMSG", "Aucun message fourni")


--[[-------------------------------------------------------------------------
Phrases - General
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CLOSE","Fermer")