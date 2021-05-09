--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeHUD.RegisterLanguage({
   Name = "Portuguese",
   Author = "Igor",
   CompatibleVersion = "1.14.0",
})

--[[-------------------------------------------------------------------------
Phrases - Lower Left
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"IDENTITY", "Identidade")
EdgeHUD.AddPhrase(LANG,"JOB", "Serviço")

--[[-------------------------------------------------------------------------
Phrases - Lower Right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_KPH","KPH")
EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_MPH","MPH")

--TAGS: %P = Amount of props.
EdgeHUD.AddPhrase(LANG,"PROPLIMIT","%P Props")

EdgeHUD.AddPhrase(LANG,"GUNLICENSE","Licença de Arma")

--[[-------------------------------------------------------------------------
Phrases - Top Left
---------------------------------------------------------------------------]]

--TAGS: %V = Number of votes
EdgeHUD.AddPhrase(LANG,"VOTE_QUEUE","Possui %V items na fila!")

EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_VOTE","VOTAÇÃO")
EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_QUESTION","PERGUNTA")

--TAGS: %T = Time until expiration.
EdgeHUD.AddPhrase(LANG,"VOTE_EXPIRE","Expira em %T")

EdgeHUD.AddPhrase(LANG,"VOTE_YES","Sim")
EdgeHUD.AddPhrase(LANG,"VOTE_NO","Não")

EdgeHUD.AddPhrase(LANG,"VOTE_PENDING","[EdgeHUD] Você tem uma votação pendente. Tire sua toolgun para votar.")

--[[-------------------------------------------------------------------------
Phrases - Top right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN_TITLE","LOCKDOWN")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN","O prefeito iniciou um lockdown, saia da rua!")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED_TITLE","PROCURADO")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED","Você está sendo procurado pela polícia!")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED_TITLE","PRESO")

--TAGS: %T = Time until release.
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED","Você será solto em %T.")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_AGENDAHELP","Digite /agenda <mensagem> para modificar a agenda.")

--[[-------------------------------------------------------------------------
Phrases - Time
---------------------------------------------------------------------------]]

--TAGS: %H = Hours, %M = Minutes
EdgeHUD.AddPhrase(LANG,"TIME_HOUR_MIN","%H horas e %M minutos")

--TAGS: %M = Minutes, %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_MIN_SEC","%M minutos e %S segundos")

--TAGS: %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_SEC","%S segundos")

--[[-------------------------------------------------------------------------
Phrases - Arrested
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ARRESTED", "PRESO")

--TAGS: %C = Criminal Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_COP", "Você prendeu %C por %T.")

--TAGS: %P = Officer Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT", "Você foi preso por %P por %T.")
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT2", "Você foi preso por %T.")

--[[-------------------------------------------------------------------------
Phrases - Released
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"RELEASED", "SOLTO")

--TAGS: %C = Criminal Name
EdgeHUD.AddPhrase(LANG,"RELEASED_COP", "Você soltou %C da cadeia.")

EdgeHUD.AddPhrase(LANG,"RELEASED_SUSPECT", "Você foi solto da cadeia.")

--[[-------------------------------------------------------------------------
Phrases - Wanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WANTED", "PROCURADO")

--TAGS: %C = Criminal Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_COP", "Você fez %C ser procurado por %R.")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT", "Você está sendo procurado por %P devido %R.")
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT2", "Você está sendo procurado por %R.")

--[[-------------------------------------------------------------------------
Phrases - Unwanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWANTED", "PERDOADO")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWANTED_COP", "Você tirou o procurado de %S.")

EdgeHUD.AddPhrase(LANG,"UNWANTED_SUSPECT", "Você não é mais procurado pela polícia.")

--[[-------------------------------------------------------------------------
Phrases - Warranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WARRANTED", "MANDATO DE BUSCA")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"WARRANTED_COP", "Você está autorizado a entrar na casa de  %S.")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT", "Você recebeu um mandato de busca por %P devido %R.")
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT2", "Você recebeu um mandato de busca por %R.")

--[[-------------------------------------------------------------------------
Phrases - Unwarranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWARRANTED", "CASA LIMPA")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWARRANTED_COP", "Você removeu o mandato de busca de %S.")

EdgeHUD.AddPhrase(LANG,"UNWARRANTED_SUSPECT", "Seu mandato de busca expirou.")

--[[-------------------------------------------------------------------------
Phrases - Vehicle Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE", "Veículo")

--TAGS: %N = Name of owner
EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER", "Dono: %N")

--TAGS: %G = Groupname
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_GROUP", "Acesso: %G")

--TAGS: %J = Number of jobs
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_JOBS", "Acesso: %J serviço(s)")

EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER_UNKNOWN", "Dono: Desconhecido")

EdgeHUD.AddPhrase(LANG,"VEHICLE_NOTOWNABLE", "Não Compravel")

EdgeHUD.AddPhrase(LANG,"VEHICLE_UNOWNED", "Sem dono")

EdgeHUD.AddPhrase(LANG,"VEHICLE_COOWNERS", "Co-Donos:")

EdgeHUD.AddPhrase(LANG,"VEHICLE_ALLOWED_COOWNERS", "Co-Donos permitidos:")

--[[-------------------------------------------------------------------------
Phrases - Door Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOOR_SOLD", "Porta vendida")
EdgeHUD.AddPhrase(LANG,"DOOR_FORSALE", "A venda")
EdgeHUD.AddPhrase(LANG,"DOOR_F2PURCHASE", "Aperte F2 para comprar a porta")

EdgeHUD.AddPhrase(LANG,"DOOR_COOWNERS", "Co-Donos:")
EdgeHUD.AddPhrase(LANG,"DOOR_ALLOWED_COOWNERS", "Co-Donos permitidos:")

--TAGS: %G = Name of group.
EdgeHUD.AddPhrase(LANG,"DOOR_GROUP_TITLE", "Porta de Grupo")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_GROUP", "Acesso: %G")

--TAGS: %J = Number of jobs.
EdgeHUD.AddPhrase(LANG,"DOOR_TEAM_TITLE", "Porta de Serviço")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_TEAM", "Acesso: %J serviço(s)")

--TAGS: %N = Name of owner.
EdgeHUD.AddPhrase(LANG,"DOOR_OWNER", "Dono: %N")

EdgeHUD.AddPhrase(LANG,"DOOR_OWNER_UNKNOWN", "Dono: Desconhecido")

--[[-------------------------------------------------------------------------
Phrases - Situations
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"LOCKDOWN", "LOCKDOWN")

EdgeHUD.AddPhrase(LANG,"LOCKDOWN_INITIATED", "O prefeito iniciou um lockdown, saia da rua!")

--[[-------------------------------------------------------------------------
Phrases - Door Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_DOOR", "Comprar porta")
EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_VEHICLE", "Comprar carro")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_DOOR", "Vender porta")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_VEHICLE", "Vender carro")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ADDOWNER", "Adicionar dono")
EdgeHUD.AddPhrase(LANG,"DOORMENU_REMOVEOWNER", "Remover dono")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ALLOWOWNERSHIP", "Permitir propriedade")
EdgeHUD.AddPhrase(LANG,"DOORMENU_DISALLOWOWNERSHIP", "Proibir propriedade")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_DOOR", "Definir título da porta")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_VEHICLE", "Definir título do veículo")

EdgeHUD.AddPhrase(LANG,"DOORMENU_EDITGROUPS", "Editar acesso de grupo")

--[[-------------------------------------------------------------------------
Phrases - Crash Screen
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TITLE", "Conexão perdida")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT1", "Sua conexão ao servidor foi perdida.")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT2", "Aguarde enquanto tentamos te reconectar.")

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_RECONNECT", "Reconectar")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_LEAVE", "Sair")

--[[-------------------------------------------------------------------------
Phrases - Gesture Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"GESTURE_BOW", "Bow")
EdgeHUD.AddPhrase(LANG,"GESTURE_SEXYDANCE", "Sexy dance")
EdgeHUD.AddPhrase(LANG,"GESTURE_FOLLOWME", "Siga-me")
EdgeHUD.AddPhrase(LANG,"GESTURE_LAUGH", "Rizada")
EdgeHUD.AddPhrase(LANG,"GESTURE_LIONPOSE", "Pode de leão")
EdgeHUD.AddPhrase(LANG,"GESTURE_NONVERBALNO", "Não")
EdgeHUD.AddPhrase(LANG,"GESTURE_THUMBSUP", "Joinha")
EdgeHUD.AddPhrase(LANG,"GESTURE_WAVE", "Onda")
EdgeHUD.AddPhrase(LANG,"GESTURE_DANCE", "Dançar")

--[[-------------------------------------------------------------------------
Phrases - Vehicle warnings HUD.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXTERIORLIGHT", "[Veículo] : Luzes exteriores do veículo quebradas. Verifique a iluminação externa antes de continuar a dirigir.")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXHAUST", "[Veículo]: Dano de exaustão detectado. Faça a manutenção imediata do veículo para evitar danos ao motor. ")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_ENGINE", "[Veículo]: Danos no motor detectados. Faça a manutenção imediata do veículo para evitar mais danos ao motor.")

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTLEFT", "Frente-Esqurda")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTRIGHT", "Frente-Direita")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKLEFT", "Traseira-Esquerda")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKRIGHT", "Traseira-Direita")

--TAGS: %T = Damaged tires.
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRES", "[Veículo]: perda de pressão (%T) no pneu.")

--[[-------------------------------------------------------------------------
Phrases - Battery Notifications.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CHARGER_CONNECTED", "Carregador conectado")
EdgeHUD.AddPhrase(LANG,"CHARGER_DISCONNECTED", "Carregador desconectado")
EdgeHUD.AddPhrase(LANG,"BATTERY_STATUS", "Status da bateria")

EdgeHUD.AddPhrase(LANG,"CHARGING_STARTED", "Seu computador está carregando agora.")
EdgeHUD.AddPhrase(LANG,"CHARGING_ABORTED", "Seu computador não está mais carregando.")

--TAGS: %B = Battery precentage left.
EdgeHUD.AddPhrase(LANG,"BATTERY_NOTICE", "Você tem %B% de carga restante. Conecte um carregador para continuar.")

--[[-------------------------------------------------------------------------
Phrases - Level bar
---------------------------------------------------------------------------]]

--TAGS: %L = Current Level, %P = Percentage to next level
EdgeHUD.AddPhrase(LANG,"LEVELBAR", "Level %L - %P%")

--[[-------------------------------------------------------------------------
Phrases - AdminTell
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ADMINTELL_TITLE", "AVISO DE ADMINISTRAÇÃO")
EdgeHUD.AddPhrase(LANG,"ADMINTELL_NOMSG", "Nenhuma mensagem fornecida")

--[[-------------------------------------------------------------------------
Phrases - General
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CLOSE","Fechar")