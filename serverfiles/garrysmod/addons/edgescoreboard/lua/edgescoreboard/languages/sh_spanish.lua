--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeScoreboard.RegisterLanguage({
	Name = "Spanish",
	Author = "Chisma944",
	CompatibleVersion = "1.9.1",
})

--[[-------------------------------------------------------------------------
Left Sidebar
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_PLAYERS", "Jugadores")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SERVERS", "Servers")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WEBSITE", "Sitio Web")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_DONATE", "Donar")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_UTILITIES", "Utilidades")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WORKSHOP", "Workshop")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_REQUESTSTAFF", "Pedir Staff")

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SEARCHFIELD", "Buscar")

EdgeScoreboard.AddPhrase(LANG,"WEBSITE_URL_COPIED", "La URL ha sido copiada a tu portapapeles.")

--[[-------------------------------------------------------------------------
Statistics
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_SERVER", "Estadísticas del Server")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLYCOUNT", "Player Count")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_STAFF", "Staff en Línea")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_UPTIME", "Tiempo de actividad")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_AVGPING", "Ping Promedio")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_GAME", "Estadísticas del Juego")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLAYTIME", "Tiempo de Juego")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_SESSION", "Sesión")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PING", "Ping")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT", "Jugadores")
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT_SUFFIX", "3h") -- Stands for 3 hours
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_LOWEST", "Más bajo")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_HIGHEST", "Mas alto")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_AVERAGE", "Promedio")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_CURRENT", "Actual")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD", "B/M") -- Stands for Kills (Divided by) Deaths 
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD_SUFFIX", "1h") -- Stands for 1 hour
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_KILLS", "Bajas")
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_DEATHS", "Muertes")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS", "FPS") -- Stands for "Frames Per Second"
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS_SUFFIX", "30m") -- Stands for 30 minutes
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_KILLS", "FPS")
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_DEATHS", "Prm. FPS") -- Stands for "Average FPS"

--[[-------------------------------------------------------------------------
Server Browser
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SERVERS_MAP_PREFIX", "Mapa")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_GM_PREFIX", "Modo de Juego")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_PS_PREFIX", "Máx. de Jugadores")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_IP_PREFIX", "Dirección IP")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD", "Sin servidores adicionales")
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD_SUBTIT", "Parece que el desarrollador del servidor no ha agregado servidores adicionales.")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_CONNECT", "Conectar")

-- TAGS: %S = Server Name or IP
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_VERIFY_CONNECT", "¿Estás seguro de que quieres conectarte a %S?")

--[[-------------------------------------------------------------------------
Player Row
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PING", "Ping")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_DEATHS", "Muertes")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KILLS", "Bajas")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_SCORE", "Puntuación")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KARMA", "Karma")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PLAYTIME", "Tiempo de Juego")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_NAME", "Nombre")

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_RANK", "Rango")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_JOB", "Trabajo")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_LEVEL", "Nivel")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_WALLET", "Dinero")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_STATUS", "Estado")

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_WANTED", "Buscado")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ARRESTED", "Arrestado")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ALIVE", "Vivo")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_DEAD", "Muerto")

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_MURDER_JOINTEAM", "Unirse")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_COPIED", "La información se ha copiado a tu portapapeles.")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAM", "Ver perfil de Steam")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_MUTE", "Silencar Jugador")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_UNMUTE", "Desilencar Jugador")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_INFO", "Información")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_USERNAME", "Copiar Nombre de Usuario")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_GROUP", "Copiar Rango")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TEAM", "Copiar Nombre del Equipo/Trabajo")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID", "Copiar SteamID")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID64", "Copiar SteamID64")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TRANSFER", "Transferir jugador")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP", "Ingresar IP")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP_LONG", "Ingrese la dirección IP y el puerto del servidor al que desea conectar a este jugador.")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_INVALIDIP", "La dirección IP que ingresó no es una dirección IP válida.")

-- Tags: %N = Server Name
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_VERIFY", "¿Está seguro de que desea transferir a este jugador a %N?")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_RANK_NONE", "Ninguno")

-- Tags: %M = Number (Money)
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_THOUSAND", "%MK")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_MILLION", "%MM")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_BILLION", "%MMM")

--[[-------------------------------------------------------------------------
Admin Player Actions
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOTO", "Ir a")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BRING", "Traer Aquí")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_RETURN", "Devolver")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETTEAM", "Establecer Trabajo")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGFREEZE", "Alternar Congelar")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_FREEZE", "Congelar")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNFREEZE", "Descongelar")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BAN", "Ban")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_KICK", "Kick")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGJAIL", "Alternar Jail")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_JAIL", "Jail")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNJAIL", "Unjail")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCHATMUTE", "Alternar Muteo de Chat")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATMUTE", "Mutear del Chat")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATUNMUTE", "Desmutear del Chat")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGVOICEMUTE", "Alternar Silenciar")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEMUTE", "Silenciar")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEUNMUTE", "Desilenciar")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SPECTATE", "Espectear")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_STRIP", "Quitar Armas")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETHP", "Establecer Vida")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGGOD", "Alternar Godmode")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOD", "Habilitar Godmode")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNGOD", "Deshabilitar Godmode")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAY", "Slay")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGIGNITE", "Alternar Ignite")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAP", "Slap")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCLOAK", "Cloak")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_REASON", "Escribe un motivo para realizar esta acción.")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SECONDS", "¿Durante cuántos segundos quieres que se aplique esta acción?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_MINUTES", "¿Durante cuántos minutos quieres que se aplique esta acción?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_HOURS", "¿Durante cuántas horas quieres que se aplique esta acción?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CONFIRM", "¿Estás seguro de que quieres realizar esta acción?")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_NUMBER", "Escribe el valor numérico asociado con este comando.")

--[[-------------------------------------------------------------------------
Utilities
---------------------------------------------------------------------------]]

-- Tags: // = Put this between the two words that are closest to the center of the text.
EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL", "Acciones//Personales")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD", "Acciones//Scoreboard")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER", "Acciones//Server")

EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL_DESC", "Utiliza este menú para realizar fácilmente diferentes acciones en ti sin tener que escribir comandos largos.")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD_DESC", "Utiliza este menú para esconderte del scoreboard y controlar su identidad falsa en el scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_DESC", "Utiliza este menú para cambiar fácilmente la configuración del servidor o realizar acciones en el servidor.")

EdgeScoreboard.AddPhrase(LANG,"UTIL_GOBACK", "Volver a Utilidades.")

EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_NOPERMISSION", "No tienes permiso para realizar ninguna acción en esta categoría.")

--[[-------------------------------------------------------------------------
Personal Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY", "Hacerte Slay")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME", "Cambiarte el Nombre")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY", "Soltar Dinero")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE", "Crear Cheque")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS", "Vender todas las Puertas")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM", "Unirse al equipo opuesto")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS", "Borrar todos los Props")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY_DESC", "Mata a tu personaje.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME_DESC", "Cambia el nombre dentro de rol del juego.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY_DESC", "Soltar dinero al suelo frente a ti.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE_DESC", "Crea un cheque de dinero en el suelo frente a ti.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS_DESC", "Vender todas las puertas que posees actualmente.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM_DESC", "Cambiar entre jugadores y espectadores.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS_DESC", "Elimina todos tus Props.")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SLAY", "¿Estás seguro de que quieres matarte?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RPNAME", "¿Cómo quieres llamarte?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_DROPMONEY", "¿Cuánto dinero te gustaría soltar?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_CHEQUE", "¿Para quién es el cheque?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SELLALLDOORS", "¿Estás seguro de que quieres vender todas las puertas que tienes?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_REMOVEALLPROPS", "¿Estás seguro de que quieres eliminar todos tus props?")

--[[-------------------------------------------------------------------------
Scoreboard Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET", "Restablecer Identidad")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW", "Mostrarte a ti mismo")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE", "Esconderte a ti mismo")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME", "Nombre de usuario falso")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR", "Avatar falso")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SPOOF", "Rango falso")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE", "Esconder Rango")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW", "Mostrar Rango")

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET_DESC", "Restablece su identidad falsa.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW_DESC", "Te muestra en el scoreboard de nuevo.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE_DESC", "Te quita del scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME_DESC", "Falsifica tu nombre en el scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR_DESC", "Falsifica tu avatar en el scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_FAKE_DESC", "Falsifica tu rango en el scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE_DESC", "Esconde tu rango en el scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW_DESC", "Muestra tu rango en el scoreboard.")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RESET", "¿Estás seguro de que quieres establecer tu identidad falsa por defecto?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_VISIBILITY", "¿Estás seguro de que quieres cambiar la visibilidad de su scoreboard?")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_USERNAME", "Escribe el nombre de usuario que te gustaría suplantar o nada para restablecer.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_AVATAR", "Escribe la SteamID de un usuario de Steam para usar su avatar de Steam o nada para restablecer.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANK", "Escribe el rango que te gustaría suplantar o nada para restablecer.")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANKVISIBILITY", "¿Estás seguro de que quieres cambiar la visibilidad de tu rango?")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_INVALIDSTEAMID", "Ingresaste un formato SteamID inválido.")

--[[-------------------------------------------------------------------------
Server Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP", "Reiniciar Mapa")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS", "Borrar todos los Props")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT", "Anuncio del servidor")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG", "EdgeScoreboard Config")

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP_DESC", "Reinicia el mapa y hace que todos los jugadores se vuelvan a conectar.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS_DESC", "Borra los props de todos en el servidor.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT_DESC", "Muestra un anuncio en la pantalla de todos los jugadores.")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG_DESC", "Opens the EdgeScoreboard configuration.")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_FADMIN_DESC", "Una acción/ajuste de FAdmin.")

-- %Q = Math Question (2+2, 1+2, etc)
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHQUESTION", "Por favor ingrese la respuesta de %Q para realizar esta acción.")

EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHWRONG", "Responda la pregunta de matemáticas correctamente para realizar esta acción.")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_TITLE", "¿Qué título debería tener el anuncio del servidor?")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_MESSAGE", "¿Qué mensaje debe tener el anuncio del servidor?")

-- Tags: %N = Name of player.
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_REMOVEDPROPS", "%N borró los props de todo el mundo.")

--[[-------------------------------------------------------------------------
Misc
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"UNCATEGORIZED", "Equipos sin categoría")

EdgeScoreboard.AddPhrase(LANG,"LOADING_WEBSITE", "Cargando sitio web...")
EdgeScoreboard.AddPhrase(LANG,"HOME_WEBSITE", "Volver al Inicio")

EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CONFIRM", "Confirmar")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CANCEL", "Cancelar")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_AFFIRM", "Entendido")

-- Tags: %S = Server Name or IP.
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_NOTIFY", "Serás transferido a %S en 10 segundos por un staff.")
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_ADMINNOTIFY", "El jugador será transferido a %S momentáneamente.")

EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RESET", "Se ha restablecido tu identidad falsa.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_HIDDEN", "Te has ocultado del scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_VISIBLE", "Se te ha hecho visible en el scoreboard.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_NAME", "Tu nombre de usuario ha sido cambiado visualmente.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_AVATAR", "Tu avatar ha sido cambiado visualmente.")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RANK", "Tu rango ha cambiado visualmente.")

EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_NOTSUPPORTED", "El addon utilizado para la administración no es compatible con EdgeScoreboard. ¡Abra un ticket de soporte para que sea compatible!")
EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_CANNOTDO", "¡No puedes hacer esto ahora mismo! ¡Póngase en contacto con el desarrollador del servidor!")

EdgeScoreboard.AddPhrase(LANG,"REQUESTSTAFF_QUERY", "Escribe el mensaje que le gustaría enviar a los miembros del staff.")

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