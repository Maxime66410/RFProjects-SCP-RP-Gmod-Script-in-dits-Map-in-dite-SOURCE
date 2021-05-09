--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeScoreboard.RegisterLanguage({
	Name = "French",
	Author = "Nathan.Smiley",
	CompatibleVersion = "1.0.0",
})

--[[-------------------------------------------------------------------------
Left Sidebar
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_PLAYERS", "Joueurs")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SERVERS", "Serveurs")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WEBSITE", "Site Web")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_DONATE", "Donations")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_UTILITIES", "Raccourcis")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WORKSHOP", "Workshop")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_REQUESTSTAFF", "Appeler Staff")

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SEARCHFIELD", "Chercher")

EdgeScoreboard.AddPhrase(LANG,"WEBSITE_URL_COPIED", "L'url a bien été copiée.")

--[[-------------------------------------------------------------------------
Statistics
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_SERVER", "Stats du serveur")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLYCOUNT", "Nbr de joueurs")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_STAFF", "Staff Connecté")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_UPTIME", "Uptime")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_AVGPING", "Ping Moyen")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_GAME", "Stats de jeu")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLAYTIME", "Temps joué")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_SESSION", "Session")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PING", "Ping")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT", "Nbr de joueurs")
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT_SUFFIX", "3h") -- Stands for 3 hours
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_LOWEST", "Le plus bas")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_HIGHEST", "Le plus haut")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_AVERAGE", "Moyenne")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_CURRENT", "Actuellement")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD", "K/D") -- Stands for Kills (Divided by) Deaths 
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD_SUFFIX", "1h") -- Stands for 1 hour
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_KILLS", "Meurtres")
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_DEATHS", "Morts")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS", "FPS") -- Stands for "Frames Per Second"
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS_SUFFIX", "30m") -- Stands for 30 minutes
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_KILLS", "FPS")
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_DEATHS", "Moy. FPS") -- Stands for "Average FPS"

--[[-------------------------------------------------------------------------
Server Browser
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SERVERS_MAP_PREFIX", "Map")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_GM_PREFIX", "Gamemode")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_PS_PREFIX", "Slots")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_IP_PREFIX", "Adresse IP")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD", "Aucun autre serveur")
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD_SUBTIT", "Il semble que le fondateur de cette communauté n'ait ajouté aucun serveur supplémentaire.")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_CONNECT", "Se connecter")

-- TAGS: %S = Server Name or IP
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_VERIFY_CONNECT", "Voulez-vous vraiment vous connecter à %S?")

--[[-------------------------------------------------------------------------
Player Row
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PING", "Ping")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_DEATHS", "Morts")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KILLS", "Meurtres")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_SCORE", "Score")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KARMA", "Karma")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PLAYTIME", nil) -- English: Playtime
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_NAME", nil) -- English: Name

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_RANK", "Grade")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_JOB", nil) -- English: Job
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_LEVEL", nil) -- English: Level
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_WALLET", nil) -- English: Money
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_STATUS", nil) -- English: Status

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_WANTED", nil) -- English: Wanted
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ARRESTED", nil) -- English: Arrested
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ALIVE", nil) -- English: Alive 
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_DEAD", nil) -- English: Dead

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_MURDER_JOINTEAM", "Rejoindre")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_COPIED", "Les informations ont été copiées.")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAM", "Voir le profil Steam")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_MUTE", "Mute le joueur")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_UNMUTE", "Unmute le joueur")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_INFO", "Information")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_USERNAME", "Copier le Nom")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_GROUP", "Copier le grade")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TEAM", "Copier le nom du métier")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID", "Copier SteamID")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID64", "Copier SteamID64")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TRANSFER", "Transférer le joueur")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP", "Entrer l'IP")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP_LONG", "Saisissez l'adresse IP et le port du serveur auquel vous souhaitez connecter ce joueur.")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_INVALIDIP", "L'adresse IP que vous avez entrée n'est pas une adresse IP valide.")

-- Tags: %N = Server Name
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_VERIFY", "Voulez-vous vraiment transférer ce joueur vers %N?")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_RANK_NONE", "Aucun")

-- Tags: %M = Number (Money)
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_THOUSAND", nil) -- English: %MK
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_MILLION", nil) -- English: %MM
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_BILLION", nil) -- English: %MB

--[[-------------------------------------------------------------------------
Admin Player Actions
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOTO", "Allez à")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BRING", "Apporter")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_RETURN", "Retourner")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETTEAM", nil) -- English: Set Team
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGFREEZE", "Activer/désactiver Geler")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_FREEZE", "Geler")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNFREEZE", "Dégeler")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BAN", "Ban")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_KICK", "Kick")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGJAIL", "Activer/désactiver Jail")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_JAIL", "Jail")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNJAIL", "Unjail")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCHATMUTE", "Activer/désactiver mute chat")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATMUTE", "Chat Mute")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATUNMUTE", "Chat Unmute")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGVOICEMUTE", "Activer/désactiver mute vocal")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEMUTE", "Mute vocal")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEUNMUTE", "Unmute vocal")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SPECTATE", "Spectate")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_STRIP", "Enlever les armes")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETHP", "Définir la santé")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGGOD", "Activer/désactiver Godmode")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOD", "Activer Godmode")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNGOD", "Désactiver Godmode")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAY", "Tuer")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGIGNITE", "Activer/désactiver Enflammer")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAP", "Taper")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCLOAK", "Invisible")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_REASON", "Entrez une raison pour effectuer cette action.")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SECONDS", "Pendant combien de secondes souhaitez-vous que cette action s'applique?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_MINUTES", "Pendant combien de minutes souhaitez-vous que cette action s'applique?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_HOURS", nil) -- English: For how many hours would you like this action to apply?
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CONFIRM", "Voulez-vous vraiment effectuer cette action?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_NUMBER", "Entrez la bonne valeur associée à cette commande.")

--[[-------------------------------------------------------------------------
Utilities
---------------------------------------------------------------------------]]

-- Tags: // = Put this between the two words that are closest to the center of the text.
EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL", "Actions//Personnelles")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD", "Actions du//Scoreboard")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER", "Actions//du Serveur")

EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL_DESC", "Utilisez ce menu pour effectuer facilement différentes actions sur votre joueur sans avoir à taper de longues commandes.")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD_DESC", "Utilisez ce menu pour vous cacher dans le scoreboard et contrôler votre fausse identité sur celui-ci.")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_DESC", "Utilisez ce menu pour modifier facilement les paramètres du serveur ou pour effectuer des actions sur le serveur.")

EdgeScoreboard.AddPhrase(LANG,"UTIL_GOBACK", "Retourner aux raccourcis")

EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_NOPERMISSION", "Vous n'êtes autorisé à effectuer aucune action dans cette catégorie.")

--[[-------------------------------------------------------------------------
Personal Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY", "Tuez-vous")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME", "Changer de nom RP")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY", "Jeter de l'argent")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE", "Créer un chèque")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS", "Vendre toutes ses portes")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM", "Rejoindre l'équipe opposée")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS", "Supprimer tous les props")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY_DESC", "Tue votre personnage.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME_DESC", "Modifie le nom rp.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY_DESC", "Fait tomber de l'argent sur le sol devant vous.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE_DESC", "Crée un chèque d'argent par terre devant vous.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS_DESC", "Vend toutes les portes que vous possédez actuellement.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM_DESC", "Vous change d'équipe entre joueurs et spectateurs.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS_DESC", "Supprime tous vos props.")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SLAY", "Êtes-vous sûr de vouloir vous tuer?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RPNAME", "Comment voulez-vous vous nommer?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_DROPMONEY", "Combien d'argent aimeriez-vous déposer?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_CHEQUE", "Qui devrait être capable de ramasser le chèque d'argent?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SELLALLDOORS", "Êtes-vous sûr de vouloir vendre toutes vos portes?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_REMOVEALLPROPS", "Êtes-vous sûr de vouloir supprimer tous vos props?")

--[[-------------------------------------------------------------------------
Scoreboard Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET", "Réinitialiser l'identité")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW", "Se montrer")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE", "Se cacher")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME", "Usurper un nom")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR", "Usurper un Avatar")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SPOOF", "Usurper un grade")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE", "Cacher le grade")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW", "Montrer le grade")

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET_DESC", "Réinitialise votre fausse identité.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW_DESC", "Vous montre à nouveau sur scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE_DESC", "Vous supprime du scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME_DESC", "Vous donne un faux nom sur le scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR_DESC", "Vous donne un faux avatar sur le scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_FAKE_DESC", "Vous donne un faux grade sur le scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE_DESC", "Cache votre grade sur le scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW_DESC", "Montre votre nom sur le scoreboard.")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RESET", "Êtes-vous sûr de vouloir réinitialiser votre fausse identité?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_VISIBILITY", "Voulez-vous vraiment modifier votre visibilité dans le scoreboard?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_USERNAME", "Entrez le nom d'utilisateur que vous souhaitez usurper ou rien pour réinitialiser.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_AVATAR", "Entrez le SteamID d'un utilisateur Steam pour utiliser son avatar Steam ou rien pour réinitialiser.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANK", "Entrez le grade que vous souhaitez usurper ou rien pour réinitialiser.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANKVISIBILITY", "Voulez-vous vraiment modifier la visibilité de votre grade?")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_INVALIDSTEAMID", "Vous avez entré un format SteamID non valide.")

--[[-------------------------------------------------------------------------
Server Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP", "Redémarrer la carte")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS", "Supprimer tous les Props")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT", "Annonce du serveur")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG", nil) -- English: EdgeScoreboard Config
 
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP_DESC", "Redémarre la carte et reconnecte tous les joueurs.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS_DESC", "Supprime tous les props de tous les joueurs.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT_DESC", "Affiche une annonce sur l'écran de tous les joueurs.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG_DESC", nil) -- English: Opens the EdgeScoreboard configuration.
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_FADMIN_DESC", "Un paramètre/une action FAdmin.")
 
-- %Q = Math Question (2+2, 1+2, etc)
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHQUESTION", "Veuillez entrer la réponse de %Q pour effectuer cette action.")
 
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHWRONG", "Veuillez répondre correctement à la question mathématique pour effectuer cette action.")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_TITLE", "Quel titre doit avoir l'annonce du serveur?")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_MESSAGE", "Quel message l'annonce du serveur doit-elle contenir?")
 
-- Tags: %N = Name of player.
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_REMOVEDPROPS", "%N a supprimé les props de tous les joueurs.")

--[[-------------------------------------------------------------------------
Misc
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"UNCATEGORIZED", nil) -- English: Uncategorized Teams

EdgeScoreboard.AddPhrase(LANG,"LOADING_WEBSITE", "Chargement du site internet...")
EdgeScoreboard.AddPhrase(LANG,"HOME_WEBSITE", "Retourner au menu principal")

EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CONFIRM", "Confirmer")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CANCEL", "Annuler")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_AFFIRM", "Je comprends")

-- Tags: %S = Server Name or IP.
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_NOTIFY", "Vous allez être téléporté à %S dans 10 secondes suite à la demande d'un staff.")
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_ADMINNOTIFY", "Le joueur sera téléporté à %S momentanément.")

EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RESET", "Votre fausse identité a été réinitialisée.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_HIDDEN", "Vous avez été caché du scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_VISIBLE", "Vous avez été rendu visible sur le scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_NAME", "Votre nom d'utilisateur a été modifié visuellement.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_AVATAR", "Votre avatar a été modifié visuellement.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RANK", "Votre grade a été changé visuellement.")

EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_NOTSUPPORTED", "L'addon utilisé pour l'administration n'est pas pris en charge par EdgeScoreboard. Ouvrez un ticket de support pour le faire prendre en charge!")
EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_CANNOTDO", "Vous ne pouvez pas faire ça maintenant! Contactez le fondateur!")

EdgeScoreboard.AddPhrase(LANG,"REQUESTSTAFF_QUERY", "Saisissez le message que vous souhaitez envoyer aux membres du personnel.")

--[[-------------------------------------------------------------------------
Formatted Time
---------------------------------------------------------------------------]]

-- Tags: %H = Hours, %M = Minutes
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_HM", "%Hh & %Mm")
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_H", "%Hh")

-- Tags: %M = Minutes, %S = Seconds
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_MS", "%Mm & %Ss")
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_M", "%Mm")

-- Tags: %S = Seconds
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_S", "%Ss")