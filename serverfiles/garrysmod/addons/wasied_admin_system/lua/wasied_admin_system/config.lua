--[[----------------------------]]--
--[[-- CONFIGURATION GÉNÉRALE --]]--
--[[----------------------------]]--

-- Nom de votre communauté
WasiedAdminSystem.Config.ServerName = "Nosria"

-- Cacher les commandes dans le chat (exemple : !staff) ?
WasiedAdminSystem.Config.HideCommands = true

-- Est-ce que les actions du staff doivent-être affichées dans le chat des hauts-gradés ?
WasiedAdminSystem.Config.ShowStaffActions = true

-- Les grades autorisés à utiliser le système administratif
WasiedAdminSystem.Config.RanksAllowed = {
    ["superadmin"] = true,
    ["admin"] = true,
    ["Modérateur"] = true,
    ["Helpeur"] = true,
}

-- Les grades supérieurs/hauts-gradés
WasiedAdminSystem.Config.HighRanks = {
    ["superadmin"] = true,
    ["admin"] = true,
}

--[[-----------------------------------------]]--
--[[-- CONFIGURATION DU MENU ADMINISTRATIF --]]--
--[[-----------------------------------------]]--

-- Est-ce que ce module doit être activé ? (http://prntscr.com/obuwtb)
WasiedAdminSystem.Config.AdminMenuEnabled = true

-- Commande à envoyer pour ouvrir le menu administratif
WasiedAdminSystem.Config.AdminMenuCommand = "!amenu"

-- Commande utilisée par VOTRE système de logs (pour ouvrir le menu)
WasiedAdminSystem.Config.LogsCommand = "/logs"

-- Commande utilisée par VOTRE système de warns (pour ouvrir le menu)
WasiedAdminSystem.Config.WarnsCommand = "!warns"

--[[-----------------------------------------]]--
--[[-- CONFIGURATION DU MODE ADMINISTRATIF --]]--
--[[-----------------------------------------]]--

-- Est-ce que ce module doit être activé ? (http://prntscr.com/obuwnm)
-- Si désactivé, uniquement le système d'informations HUD reste actif avec la commande ci-dessous
WasiedAdminSystem.Config.AdminSystemEnabled = true

-- Commande à envoyer pour passer en mode administratif
WasiedAdminSystem.Config.AdminModeCommand = "!staff"

-- Le staff est-il automatiquement défini en mode admin lorsqu'il noclip ?
WasiedAdminSystem.Config.AdminOnNoclip = true

-- Devons-nous utiliser ULX ou FAdmin pour le système de cloak ?
WasiedAdminSystem.Config.ULXorFAdmin = "ulx" -- /!\ "ulx" ou "fadmin" seulement

-- Est-ce qu'un joueur doit être automatiquement cloak lorsqu'un admin le prend au physicgun ?
WasiedAdminSystem.Config.AutoCloakPhys = false

--[[----------------------------------------]]--
--[[-- CONFIGURATION DES INFORMATIONS HUD --]]--
--[[----------------------------------------]]--

-- Est-ce que le staff voit des informations en mode admin ? (http://prntscr.com/obuwdl)
WasiedAdminSystem.Config.ShowBasicsInfos = true

-- Est-ce que le staff voit des informations avancées en mode admin ? (http://prntscr.com/obuwa8)
-- (/!\ false = les informations avancées seront affichées lors de l'ouverture du menu contexutel)
WasiedAdminSystem.Config.ShowExtraInfos = false

-- Est-ce que le staff doit avoir des informations sur tous les véhicules en ville ?
WasiedAdminSystem.Config.ShowVehiclesInfos = true

-- À partir de quelle distance du staff les informations du joueur disparaissent ?
WasiedAdminSystem.Config.DistToShow = 12500

-- À partir de quelle distance du staff les informations avancées du joueur disparaissent ?
WasiedAdminSystem.Config.DistToShowExtra = 1500

--[[-------------------------------]]--
--[[-- CONFIGURATION DES TICKETS --]]--
--[[-------------------------------]]--

-- Est-ce que ce module doit être activé ?
WasiedAdminSystem.Config.TicketEnabled = true

-- Commande à envoyer pour ouvrir le menu des tickets
WasiedAdminSystem.Config.TicketMenuCommand = "!ticket"

-- Le temps en secondes que le joueur doit attendre entre 2 tickets
WasiedAdminSystem.Config.TicketTimer = 30

-- Le nombre maximum de joueurs que l'on peut choisir pour un ticket (/!\ 3 maximum)
WasiedAdminSystem.Config.TicketMaxPlayers = 3

-- Le nombre minimum de caractères que le joueur doit inscrire dans le ticket pour pouvoir l'envoyer
WasiedAdminSystem.Config.MinDescriptionLen = 5

-- Liste des raisons de ticket pour le menu
WasiedAdminSystem.Config.TicketsReasons = {
    "Non-RolePlay",
    "Troll",
    "Soundboard",
    "Freekill",
    "Question",
}

-- Le temps en secondes après lequel le ticket se supprime automatiquement s'il n'a pas été pris en charge
WasiedAdminSystem.Config.DeleteTicketTime = 60*10 -- 60*10 = 10 minutes

-- Est-ce que les tickets apparaissent aux administrateurs lorsqu'ils ne sont pas en mode admin ?
WasiedAdminSystem.Config.TicketOnlyAdmin = true -- False : Uniquement en mode admin

--[[-------------------------------------------------]]--
--[[-- CONFIGURATION DU MENU DE GESTION DE JOUEURS --]]--
--[[-------------------------------------------------]]--

-- Est-ce que ce module doit être activé ?
WasiedAdminSystem.Config.PlayerManagmentEnabled = true

-- Commande à envoyer pour ouvrir le menu de gestion de joueurs
WasiedAdminSystem.Config.PlayerManagMenuCommand = "!pmenu"

-- Le nombre maximum de caractères que peut contenir une raison de ban/kick/etc...
WasiedAdminSystem.Config.PlayerManagMaxLen = 100

-- Pour ceux qui s'y connaissent et qui désirent modifier les commandes du menu, rendez-vous dans client/cl_player_managment.lua --

--[[--------------------------------------------]]--
--[[-- CONFIGURATION DU MENU DE REMBOURSEMENT --]]--
--[[--------------------------------------------]]--

-- Est-ce que ce module doit être activé ?
WasiedAdminSystem.Config.RefundMenuEnabled = true

-- Commande à envoyer pour ouvrir le menu de gestion des joueurs
WasiedAdminSystem.Config.RefundMenuCommand = "!rmenu"

-- Est-ce que le système prend en compte les armes lors de la mort ?
WasiedAdminSystem.Config.RefundWeapons = true

-- Est-ce que le système prend en compte l'argent lors de la mort ?
WasiedAdminSystem.Config.RefundMoney = true

-- Est-ce que le système prend en compte le modèle du joueur lors de la mort ?
WasiedAdminSystem.Config.RefundPM = true

-- Est-ce que le système prend en compte le job du métier lors de la mort ?
WasiedAdminSystem.Config.RefundJob = true

--[[------------------------------]]--
--[[-- CONFIGURATION DU LANGAGE --]]--
--[[------------------------------]]--

-- Mode administratif
WasiedAdminSystem.Language.ModeAdmin = "Mode admin"
WasiedAdminSystem.Language.AdminModeEnabled = "Vous avez activé votre mode administratif !"
WasiedAdminSystem.Language.AdminModeDisabled = "Vous avez désactivé votre mode administratif !"

-- Menu administratif
WasiedAdminSystem.Language.AdminMenuTitle = "Menu administratif"

-- Menu de gestions de joueurs
WasiedAdminSystem.Language.PlayerManagTitle = "Gestion des joueurs"

-- Menu de remboursement
WasiedAdminSystem.Language.RefundMenuTitle = "Menu de remboursement"

-- Menu des tickets
WasiedAdminSystem.Language.TicketMenuTitle = "Menu de tickets"
WasiedAdminSystem.Language.DefaultText = "Cliquez ici pour choisir la raison du ticket..."
WasiedAdminSystem.Language.SuccessTicketMsg = "Votre ticket a été envoyé avec succès !"
WasiedAdminSystem.Language.TicketExpires = "Votre ticket a expiré car aucun staff ne s'en est occupé, veuillez en refaire un !"