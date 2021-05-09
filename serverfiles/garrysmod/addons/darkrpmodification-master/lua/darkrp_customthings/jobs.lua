----[[---------------------------------------------------------------------------
                                        -- Scientifique
---------------------------------------------------------------------------]]

TEAM_CLASSED = DarkRP.createJob("Classe D", {
    color = Color(255, 93, 0, 255),
    model = {
    "models/player/cosmos/prisonnier_1.mdl",
    "models/player/cosmos/prisonnier_2.mdl",
    "models/player/cosmos/prisonnier_3.mdl",
    "models/player/cosmos/prisonnier_4.mdl",
    "models/player/cosmos/prisonnier_5.mdl",
    "models/player/cosmos/prisonnier_6.mdl",
    "models/player/cosmos/prisonnier_7.mdl",
    "models/player/cosmos/p2_chell_new.mdl",
    "models/player/faith.mdl"
    },
    description = [[]],
    weapons = {"weapon_physcannon", "high_five_swep", "cross_arms_swep", "itemstore_pickup"},
    command = "classed",
    max = 0,
    salary = 10,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Branche Carcérale",
	sortOrder = 0,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetMaterial("")
end
})

TEAM_COOK = DarkRP.createJob("[VIP] Cuisinier", {
    color = Color(255, 93, 0, 255),
    model = {"models/obese_male.mdl"},
    description = [[]],
    weapons = {"carte_1","cross_arms_infront_swep","point_in_direction_swep","m9k_fists","weapon_physcannon"},
    command = "kouizine",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Branche Carcérale",
	sortOrder = 1,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetMaterial("")
end,
PlayerDeath = function(ply, weapon, killer)
            ply:teamBan(60)
            ply:changeTeam(GAMEMODE.DefaultTeam, true)
                end,
 customCheck = function(ply) 
    return (ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))
end,
    CustomCheckFailMsg = "Vous devez être VIP, VIP+, Légende, Cosmique !"
})

TEAM_CHERCHEUR_ASSISTANT = DarkRP.createJob("Assistant de Recherche", {
    color = Color(0, 255, 255, 255),
    model = {"models/bmscientistcits/p_female_01.mdl","models/bmscientistcits/p_female_02.mdl","models/bmscientistcits/p_female_03.mdl", 
    	"models/bmscientistcits/p_female_04.mdl", "models/bmscientistcits/p_female_06.mdl","models/bmscientistcits/p_female_07.mdl","models/bmscientistcits/p_male_01.mdl","models/bmscientistcits/p_male_02.mdl","models/bmscientistcits/p_male_03.mdl",
    	"models/bmscientistcits/p_male_04.mdl", "models/bmscientistcits/p_male_05.mdl", "models/bmscientistcits/p_male_06.mdl", "models/bmscientistcits/p_male_07.mdl", 
    	"models/bmscientistcits/p_male_08.mdl", "models/bmscientistcits/p_male_09.mdl", "models/bmscientistcits/p_male_10.mdl","models/player/mykhail_kozak/proximitysuit.mdl","models/hazmat/bmhaztechs.mdl"},
    description = [[]],
    weapons = {"weapon_flashlight", "weapon_physcannon", "weapon_physgun", "gmod_tool", "dradio"},
    command = "chercheur_assistant",
    max = 4,
    level = 7,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Branche Scientifique",
	sortOrder = 0,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 7) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 7"
})

TEAM_CHERCHEUR_NOVICE = DarkRP.createJob("Chercheur Novice", {
    color = Color(0, 255, 255, 255),
    model = {"models/bmscientistcits/p_female_01.mdl","models/bmscientistcits/p_female_02.mdl","models/bmscientistcits/p_female_03.mdl", 
    	"models/bmscientistcits/p_female_04.mdl", "models/bmscientistcits/p_female_06.mdl","models/bmscientistcits/p_female_07.mdl","models/bmscientistcits/p_male_01.mdl","models/bmscientistcits/p_male_02.mdl","models/bmscientistcits/p_male_03.mdl",
    	"models/bmscientistcits/p_male_04.mdl", "models/bmscientistcits/p_male_05.mdl", "models/bmscientistcits/p_male_06.mdl", "models/bmscientistcits/p_male_07.mdl", 
    	"models/bmscientistcits/p_male_08.mdl", "models/bmscientistcits/p_male_09.mdl", "models/bmscientistcits/p_male_10.mdl","models/player/mykhail_kozak/proximitysuit.mdl","models/hazmat/bmhaztechs.mdl"},
    description = [[]],
    weapons = {"weapon_flashlight", "carte_2", "weapon_physcannon", "weapon_physgun", "gmod_tool", "weapon_tablettesci"},
    command = "chercheur_novice",
    max = 0,
    level = 12,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Branche Scientifique",
	sortOrder = 1,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
end,
	 customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 12) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 12",
})


TEAM_CHERCHEUR = DarkRP.createJob("[WL] Chercheur", {
    color = Color(0, 255, 255, 255),
    model = {"models/bmscientistcits/p_female_01.mdl","models/bmscientistcits/p_female_02.mdl","models/bmscientistcits/p_female_03.mdl", 
    	"models/bmscientistcits/p_female_04.mdl", "models/bmscientistcits/p_female_06.mdl","models/bmscientistcits/p_female_07.mdl","models/bmscientistcits/p_male_01.mdl","models/bmscientistcits/p_male_02.mdl","models/bmscientistcits/p_male_03.mdl",
    	"models/bmscientistcits/p_male_04.mdl", "models/bmscientistcits/p_male_05.mdl", "models/bmscientistcits/p_male_06.mdl", "models/bmscientistcits/p_male_07.mdl", 
    	"models/bmscientistcits/p_male_08.mdl", "models/bmscientistcits/p_male_09.mdl", "models/bmscientistcits/p_male_10.mdl","models/player/mykhail_kozak/proximitysuit.mdl","models/hazmat/bmhaztechs.mdl"},
    description = [[]],
    weapons = {"weapon_flashlight", "carte_2", "weapon_physcannon", "weapon_physgun", "gmod_tool", "weapon_tablettesci"},
    command = "chercheur",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Branche Scientifique",
	sortOrder = 2,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetMaterial("")
end
})

TEAM_CHERCHEURSPE = DarkRP.createJob("[WL] Chercheur Spécialiste", {
    color = Color(0, 255, 255, 255),
    model = {"models/bmscientistcits/p_female_01.mdl","models/bmscientistcits/p_female_02.mdl","models/bmscientistcits/p_female_03.mdl", 
    	"models/bmscientistcits/p_female_04.mdl", "models/bmscientistcits/p_female_06.mdl","models/bmscientistcits/p_female_07.mdl","models/bmscientistcits/p_male_01.mdl","models/bmscientistcits/p_male_02.mdl","models/bmscientistcits/p_male_03.mdl",
    	"models/bmscientistcits/p_male_04.mdl", "models/bmscientistcits/p_male_05.mdl", "models/bmscientistcits/p_male_06.mdl", "models/bmscientistcits/p_male_07.mdl", 
    	"models/bmscientistcits/p_male_08.mdl", "models/bmscientistcits/p_male_09.mdl", "models/bmscientistcits/p_male_10.mdl","models/player/mykhail_kozak/proximitysuit.mdl","models/hazmat/bmhaztechs.mdl"},
    description = [[]],
    weapons = {"weapon_flashlight", "carte_2", "weapon_physcannon", "weapon_physgun", "gmod_tool", "weapon_tablettesci"},
    command = "chercheurspecialiste",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Branche Scientifique",
	sortOrder = 3,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetMaterial("")
end
})

TEAM_CHERCHEURCONF = DarkRP.createJob("[WL] Chercheur Titulaire", {
    color = Color(0, 255, 255, 255),
    model = {"models/bmscientistcits/p_female_01.mdl","models/bmscientistcits/p_female_02.mdl","models/bmscientistcits/p_female_03.mdl", 
    	"models/bmscientistcits/p_female_04.mdl", "models/bmscientistcits/p_female_06.mdl","models/bmscientistcits/p_female_07.mdl","models/bmscientistcits/p_male_01.mdl","models/bmscientistcits/p_male_02.mdl","models/bmscientistcits/p_male_03.mdl",
    	"models/bmscientistcits/p_male_04.mdl", "models/bmscientistcits/p_male_05.mdl", "models/bmscientistcits/p_male_06.mdl", "models/bmscientistcits/p_male_07.mdl", 
    	"models/bmscientistcits/p_male_08.mdl", "models/bmscientistcits/p_male_09.mdl", "models/bmscientistcits/p_male_10.mdl","models/player/mykhail_kozak/proximitysuit.mdl","models/hazmat/bmhaztechs.mdl"},
    description = [[]],
    weapons = {"weapon_flashlight", "carte_3", "weapon_physcannon", "weapon_physgun", "gmod_tool", "weapon_tablettesci"},
    command = "chercheur_conf",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Branche Scientifique",
	sortOrder = 4,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetMaterial("")
end
})

TEAM_CHERCHEUR_EXP = DarkRP.createJob("[WL] Chercheur de Supervision", {
    color = Color(0, 255, 255, 255),
    model = {"models/bmscientistcits/p_female_01.mdl","models/bmscientistcits/p_female_02.mdl","models/bmscientistcits/p_female_03.mdl", 
    	"models/bmscientistcits/p_female_04.mdl", "models/bmscientistcits/p_female_06.mdl","models/bmscientistcits/p_female_07.mdl","models/bmscientistcits/p_male_01.mdl","models/bmscientistcits/p_male_02.mdl","models/bmscientistcits/p_male_03.mdl",
    	"models/bmscientistcits/p_male_04.mdl", "models/bmscientistcits/p_male_05.mdl", "models/bmscientistcits/p_male_06.mdl", "models/bmscientistcits/p_male_07.mdl", 
    	"models/bmscientistcits/p_male_08.mdl", "models/bmscientistcits/p_male_09.mdl", "models/bmscientistcits/p_male_10.mdl","models/player/mykhail_kozak/proximitysuit.mdl","models/hazmat/bmhaztechs.mdl"    
    },
    description = [[]],
    weapons = {"weapon_flashlight", "carte_3", "weapon_physcannon", "weapon_physgun", "gmod_tool", "weapon_tablettesci"},
    command = "chercheur_exp",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Branche Scientifique",
	sortOrder = 5,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetMaterial("")
end
})

TEAM_CHERCHEUR_FM = DarkRP.createJob("[WL] Formateur", {
    color = Color(0, 255, 255, 255),
    model = {"Models/Armacham/scientists/scientists_1.mdl",
        "Models/Armacham/scientists/scientists_2.mdl",
        "Models/Armacham/scientists/scientists_3.mdl",
        "Models/Armacham/scientists/scientists_4.mdl",
        "Models/Armacham/scientists/scientists_5.mdl",
        "Models/Armacham/scientists/scientists_6.mdl",
        "Models/Armacham/scientists/scientists_7.mdl","Models/Armacham/scientists/scientists_9.mdl",
        "Models/Armacham/scientists/scientists_8.mdl","models/player/mykhail_kozak/proximitysuit.mdl","models/hazmat/bmhaztechs.mdl"},
    description = [[]],
    weapons = {"weapon_flashlight", "carte_4", "weapon_physcannon", "weapon_physgun", "gmod_tool", "weapon_tablettesci","cross_arms_infront_swep"},
    command = "sciformateur",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Branche Scientifique",
	sortOrder = 6,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetMaterial("")
end
})

TEAM_CHERCHEUR_SUP = DarkRP.createJob("[WL] Superviseur de Recherche", {
    color = Color(0, 255, 255, 255),
    model = {"Models/Armacham/scientists/scientists_1.mdl",
        "Models/Armacham/scientists/scientists_2.mdl",
        "Models/Armacham/scientists/scientists_3.mdl",
        "Models/Armacham/scientists/scientists_4.mdl",
        "Models/Armacham/scientists/scientists_5.mdl",
        "Models/Armacham/scientists/scientists_6.mdl",
        "Models/Armacham/scientists/scientists_7.mdl","Models/Armacham/scientists/scientists_9.mdl",
        "Models/Armacham/scientists/scientists_8.mdl","models/player/mykhail_kozak/proximitysuit.mdl","models/hazmat/bmhaztechs.mdl"},
    description = [[]],
    weapons = {"weapon_flashlight", "carte_4", "weapon_physcannon", "weapon_physgun", "gmod_tool", "weapon_tablettesci","cross_arms_infront_swep"},
    command = "superviseur",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Branche Scientifique",
	sortOrder = 7,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetMaterial("")
end
})

TEAM_CHERCHEUR_DADJ = DarkRP.createJob("[WL] Directeur ADJ du Pôle Scientifique", {
    color = Color(0, 255, 255, 255),
    model = {
        "Models/Armacham/scientists/scientists_1.mdl",
        "Models/Armacham/scientists/scientists_2.mdl",
        "Models/Armacham/scientists/scientists_3.mdl",
        "Models/Armacham/scientists/scientists_4.mdl",
        "Models/Armacham/scientists/scientists_5.mdl",
        "Models/Armacham/scientists/scientists_6.mdl",
        "Models/Armacham/scientists/scientists_7.mdl","Models/Armacham/scientists/scientists_9.mdl",
        "Models/Armacham/scientists/scientists_8.mdl","models/player/mykhail_kozak/proximitysuit.mdl","models/hazmat/bmhaztechs.mdl"
    },
    description = [[]],
    weapons = {"weapon_flashlight", "carte_4", "weapon_physcannon", "weapon_physgun", "gmod_tool", "weapon_tablettesci","cross_arms_infront_swep"},
    command = "dadjoint",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Branche Scientifique",
	sortOrder = 8,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetMaterial("")
end
})

TEAM_CHERCHEUR_ADJ = DarkRP.createJob("[WL] Directeur du Pôle Scientifique", {
    color = Color(0, 255, 255, 255),
    model = {"models/player/Dr_Schwaiger.mdl","models/player/mykhail_kozak/proximitysuit.mdl","models/hazmat/bmhaztechs.mdl"},
    description = [[]],
    weapons = {"weapon_flashlight", "carte_4", "weapon_physcannon", "weapon_physgun", "gmod_tool", "weapon_tablettesci","cross_arms_infront_swep"},
    command = "adjoint",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Branche Scientifique",
	sortOrder = 100,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetMaterial("")
end
})

--[[---------------------------------------------------------------------------
                                        Sécurité
---------------------------------------------------------------------------]]

TEAM_SECU_RECRUE = DarkRP.createJob("Recrue de la Sécurité", {
    color = Color(29, 0, 255, 255),
    model = {
        "models/player/kerry/class_securety.mdl"
    },
    description = [[]],
    weapons = {"carte_1", "weapon_flashlight", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "secu_rgarde",
    max = 3,
    salary = 150,
    level = 5,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Branche Carcérale",
	sortOrder = 1,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(25)
        ply:SetMaterial("")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 5) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 5"

})

TEAM_SECU_GARDE = DarkRP.createJob("Garde de Sécurité", {
    color = Color(29, 0, 255, 255),
    model = {
        "models/player/kerry/class_securety.mdl"
    },
    description = [[]],
    weapons = {"carte_2","weapon_flashlight", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "secu_garde",
    max = 6,
    salary = 150,
    level = 10,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Branche Carcérale",
	sortOrder = 2,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(50)
        ply:SetMaterial("")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 10) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 10"

})

TEAM_LSECU_GARDE = DarkRP.createJob("Lieutenant de la Sécurité", {
    color = Color(29, 0, 255, 255),
    model = {"models/player/kerry/class_securety.mdl"},
    description = [[]],
    weapons = {"carte_2","weapon_flashlight", "tfa_ins2_m9", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "lsecu_garde",
    max = 3,
    salary = 150,
    level = 20,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Branche Carcérale",
	sortOrder = 3,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(50)
        ply:SetMaterial("")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 20) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 20"

})

TEAM_CASECU_GARDE = DarkRP.createJob("Capitaine de la Sécurité", {
    color = Color(29, 0, 255, 255),
    model = {"models/player/kerry/class_securety.mdl"},
    description = [[]],
    weapons = {"carte_2","weapon_flashlight", "tfa_ins2_ump45", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "casecu_garde",
    max = 2,
    salary = 150,
    level = 25,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Branche Carcérale",
	sortOrder = 4,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(50)
        ply:SetMaterial("")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 25) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 25"

})

TEAM_SECU_LGGARDE = DarkRP.createJob("[LEGENDE] Anti-Emeute ZC", {
    color = Color(29, 0, 255, 255),
    model = {"models/bloocobalt/player/l4d/riot_01.mdl","models/bloocobalt/player/l4d/riot_02.mdl","models/bloocobalt/player/l4d/riot_03.mdl","models/bloocobalt/player/l4d/riot_04.mdl",
    "models/bloocobalt/player/l4d/riot_05.mdl","models/bloocobalt/player/l4d/riot_06.mdl","models/bloocobalt/player/l4d/riot_07.mdl","models/bloocobalt/player/l4d/riot_08.mdl",
"models/bloocobalt/player/l4d/riot_09.mdl"},
    description = [[]],
    weapons = {"carte_2","weapon_flashlight", "riot_shield", "tfa_ins2_m4a1", "tfa_ins2_m500", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "secu_lggarde",
    max = 3,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    sortOrder = 5,
    category = "Branche Carcérale",
    PlayerSpawn = function(ply)
        ply:SetHealth(150)
        ply:SetArmor(200)
end,
    customCheck = function(ply) 
    return (ply:IsAdmin() or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))
    end,
    CustomCheckFailMsg = "Vous devez être Légende ou Cosmique !"

})

TEAM_SECU_CGARDE = DarkRP.createJob("[VIP] Chef de la Sécurité", {
    color = Color(29, 0, 255, 255),
    model = {"models/player/kerry/class_securety_2.mdl"},
    description = [[]],
    weapons = {"carte_2","weapon_flashlight", "tfa_ins2_glock_19", "tfa_ins2_fas2_g36c", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "secu_cgarde",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
	sortOrder = 6,
    category = "Branche Carcérale",
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(75)
end,
 customCheck = function(ply) 
    return (ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))
end,
    CustomCheckFailMsg = "Vous devez être VIP, VIP+, Légende, Cosmique !"
})

TEAM_POLICEMILITAIRE = DarkRP.createJob("[VIP+] Police Militaire", {
    color = Color(26, 46, 189, 255),
    model = {"models/kerry/detective/male_01.mdl","models/kerry/detective/male_02.mdl","models/kerry/detective/male_03.mdl","models/kerry/detective/male_04.mdl",
    "models/kerry/detective/male_05.mdl","models/kerry/detective/male_06.mdl","models/kerry/detective/male_07.mdl","models/kerry/detective/male_08.mdl","models/kerry/detective/male_09.mdl"},
    description = [[]],
    weapons = {"carte_4","weapon_flashlight", "tfa_ins2_ump45", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "policemilitaire",
    max = 3,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Administratif",
    sortOrder = 1,
    PlayerSpawn = function(ply)
        ply:SetHealth(100)
        ply:SetArmor(75)
end,
    customCheck = function(ply) 
    return (ply:IsAdmin() or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))
    end,
    CustomCheckFailMsg = "Vous devez être VIP+ Légende ou Cosmique !"
})

TEAM_RESECU_AGENT = DarkRP.createJob("Recrue UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/05.mdl",
        "models/player/r6s_iq.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "secu_reagent",
    max = 0,
    salary = 150,
    level = 10,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 0,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(75)
        ply:SetMaterial("")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 10) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 10"
})


TEAM_SECU_AGENT = DarkRP.createJob("[WL] Agent UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/05.mdl",
        "models/player/r6s_iq.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"carte_3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "secu_agent",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 1,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(75)
        ply:SetMaterial("")
end
})

TEAM_SECU_CAPORAL = DarkRP.createJob("[WL] Caporal UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/05.mdl ",
        "models/player/r6s_iq.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"carte_3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "secu_caporal",
    max = 8,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 2,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(75)
        ply:SetMaterial("")
end
})

TEAM_SECU_CAPORALCHEF = DarkRP.createJob("[WL] Caporal Chef UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/05.mdl ",
        "models/player/r6s_iq.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"carte_3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "secu_caporalchef",
    max = 6,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 3,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(75)
        ply:SetMaterial("")
end
})


TEAM_SECU_SERGENT = DarkRP.createJob("[WL] Sergent UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/05.mdl",
        "models/player/r6s_iq.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"carte_3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "secu_sergent",
    max = 5,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 4,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(75)
        ply:SetMaterial("")
end
})

TEAM_SECU_SERGENTCHEF = DarkRP.createJob("[WL] Sergent Chef UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/05.mdl",
        "models/player/r6s_iq.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"carte_3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "secu_sergentchef",
    max = 5,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 5,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(75)
        ply:SetMaterial("")
end
})


TEAM_SECU_ADJUDANT = DarkRP.createJob("[WL] Adjudant UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/04.mdl",
        "models/player/r6s_iq.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"carte_3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "secu_adjudant",
    max = 5,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 6,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end
})

TEAM_SECU_ADJUDANTCHEF = DarkRP.createJob("[WL] Adjudant Chef UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/04.mdl",
        "models/player/r6s_iq.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"carte_3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "secu_adjudantchef",
    max = 5,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 6,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end
})

TEAM_SECU_MAJOR = DarkRP.createJob("[WL] Major UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/03.mdl",
        "models/player/r6s_iq.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"carte_3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "secu_major",
    max = 5,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 7,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end
})

TEAM_SECU_ELEVE = DarkRP.createJob("[WL] Elève Officier UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/03.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"carte_4", "cross_arms_infront_swep", "weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "secu_eleve",
    max = 3,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 7.1,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end
})

TEAM_SECU_ASPPP = DarkRP.createJob("[WL] Aspirant UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/03.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"carte_4", "cross_arms_infront_swep", "weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "voice_amplifier"},
    command = "secu_aspirant",
    max = 3,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 7.2,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end
})

TEAM_SECU_SLTN = DarkRP.createJob("[WL] Sous-Lieutenant UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/03.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"carte_4", "cross_arms_infront_swep", "weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "voice_amplifier"},
    command = "secu_slieutenant",
    max = 3,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 7.3,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end
})
TEAM_SECU_LTN = DarkRP.createJob("[WL] Lieutenant UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/03.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"carte_4", "cross_arms_infront_swep", "weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "voice_amplifier"},
    command = "secu_lieutenant",
    max = 3,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 8,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end
})

TEAM_SECU_CPT = DarkRP.createJob("[WL] Capitaine UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/02.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"hololink_swep", "cross_arms_infront_swep",  "carte_4","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "voice_amplifier"},
    command = "secu_capitaine",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 9,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end
})

TEAM_SECU_CMD = DarkRP.createJob("[WL] Commandant UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/02.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"hololink_swep", "carte_4", "cross_arms_infront_swep", "weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "voice_amplifier"},
    command = "secu_commandant",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 10,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end
})

TEAM_SECU_LCLN = DarkRP.createJob("[WL] Lieutenant Colonel UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/01.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"hololink_swep", "carte_4","weapon_flashlight", "cross_arms_infront_swep",  "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "voice_amplifier"},
    command = "secu_lcolonel",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 11,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end
})

TEAM_SECU_CLN = DarkRP.createJob("[WL] Colonel UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/dragontech/oeildudragon/01.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/player/R6S_Ash.mdl"
    },
    description = [[]],
    weapons = {"hololink_swep", "carte_4","weapon_flashlight", "cross_arms_infront_swep",  "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "voice_amplifier"},
    command = "secu_colonel",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 12,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end
})

TEAM_GARDE_GNL = DarkRP.createJob("[VIP] Garde Du Général", {
    color = Color(26, 46, 189, 255),
    model = {"models/payday2/units/bandana_dee_dc_heavy_swat_player.mdl"},
    description = [[Vous assurez la protection du générale en permanence.]],
    weapons = {"carte_3", "ghosts_minigun", "parkourmod", "tfa_l4d2_ctm200", "tfa_ins2_m500", "tfa_ins2_rpk12", "weapon_stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "stungun"},
    command = "garde_generale",
    max = 3,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 13,
    PlayerSpawn = function(ply)
        ply:SetHealth(500)
        ply:SetArmor(500)
        ply:SetRunSpeed(450)
end,
	customCheck = function(ply) return team.NumPlayers(TEAM_SECU_GNL) ~= 0 and  (ply:IsAdmin() or ply:IsUserGroup("vip") or ply:IsUserGroup("vip+") or ply:IsUserGroup("legende") or ply:IsUserGroup("cosmique")) end,
    CustomCheckFailMsg = "Le général n'est pas présent ou vous n'êtes pas vip/vip+/legende ou cosmique !"
})

TEAM_SECU_GNL = DarkRP.createJob("[WL] Général UT", {
    color = Color(26, 46, 189, 255),
    model = {"models/payday2/units/zeal_taser_player.mdl","models/player/hazmat/hazmat1980.mdl"},
    description = [[]],
    weapons = {"hololink_swep", "carte_3", "cross_arms_infront_swep", "weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "voice_amplifier"},
    command = "secu_generale",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 13,
    PlayerSpawn = function(ply)
        ply:SetHealth(500)
        ply:SetArmor(250)
end
})

TEAM_SECU_MEDIC = DarkRP.createJob("[WL] Médecin UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/payday2/units/medic_player.mdl",
        "models/player/R6S_Ash.mdl","models/player/hazmat/hazmat1980.mdl",
    },
    description = [[]],
    weapons = {"carte_3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","med_kit_advanced","defibrillator_advanced"},
    command = "secu_medecin",
    max = 3,
    salary = 150,
    level = 17,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 14,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end,
 customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 17) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
})



TEAM_SECU_IENCH = DarkRP.createJob("Chien UT", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/pierce/police_k9.mdl"
    },
    description = [[]],
    weapons = {"weapon_dogswep"},
    command = "secu_chien",
    max = 2,
    salary = 150,
    level = 20,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 17,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(150)
        ply:SetMaterial("")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 20) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 20",
})

TEAM_SECU_SPEC = DarkRP.createJob("Spécialiste Confinement", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/ninja/mgs4_raven_sword_merc.mdl"
    },
    description = [[]],
    weapons = {"carte_3", "weapon_flashlight", "tfa_ins2_glock_19", "tfa_ins2_cw_ar15", "salute_swep", "tfa_nmrih_bcd", "tfa_nmrih_fubar", "tfa_nmrih_spade", "tfa_nmrih_wrench"},
    command = "secu_spec",
    max = 2,
    salary = 150,
    level = 20,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Administratif",
	sortOrder = 18,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetHealth(100)
        ply:SetArmor(150)
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 20) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 20",
})


-- FIM / Intervention Mobile

TEAM_SECU_MTF = DarkRP.createJob("[WL] F.I.M", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/Player/Calamity/Epsilon-11/Gaminglight_Epsilon-11.mdl"
    },
    description = [[]],
    weapons = {"hololink_swep", "carte_3","weapon_flashlight", "tfa_ins2_glock_19", "tfa_ins2_cw_ar15", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "tfa_ins2_m590o"},
    command = "secu_mtf",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "F.I.M",
	sortOrder = 16,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(150)
        ply:SetMaterial("")
end

})

TEAM_SECU_MTF2 = DarkRP.createJob("[WL] Tireur D'élite F.I.M", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/Player/Calamity/Epsilon-11/Gaminglight_Epsilon-11.mdl"
    },
    description = [[]],
    weapons = {"hololink_swep", "carte_3","weapon_flashlight", "tfa_ins2_glock_19", "tfa_ins2_cw_ar15", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "tfa_l4d2_ctm200", "tfa_ins2_m590o"},
    command = "secu_mtf2",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "F.I.M",
	sortOrder = 17,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(150)
        ply:SetMaterial("")
end

})

TEAM_SECU_MTFRB = DarkRP.createJob("[VIP+] Robot F.I.M", {
    color = Color(26, 46, 189, 255),
    model = {"models/player/TF2_HoloPilot.mdl"},
    description = [[]],
    weapons = {"carte_3","weapon_flashlight", "tfa_ins2_minimi", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "heavy_shield"},
    command = "secu_mtfrb",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "F.I.M",
    sortOrder = 21,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(250)
        ply:SetArmor(250)
end,
    customCheck = function(ply) 
    return (ply:IsAdmin() or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))
end,
    CustomCheckFailMsg = "Vous devez être VIP+ Légende ou Cosmique !"
})

TEAM_SECU_MTF3 = DarkRP.createJob("[WL] Médecin F.I.M", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/Player/Calamity/Epsilon-11/Gaminglight_Epsilon-11.mdl"
    },
    description = [[]],
    weapons = {"hololink_swep", "carte_3","weapon_flashlight", "tfa_ins2_glock_19", "tfa_ins2_cw_ar15", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","med_kit_advanced","defibrillator_advanced", "tfa_ins2_m590o"},
    command = "secu_mtf3",
    max = 3,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "F.I.M",
	sortOrder = 18,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(150)
        ply:SetMaterial("")
end

})

TEAM_SECU_LMTF = DarkRP.createJob("[WL] Officier F.I.M", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/Player/Calamity/Epsilon-11/Gaminglight_Epsilon-11.mdl"
    },
    description = [[]],
    weapons = {"hololink_swep", "carte_4","weapon_flashlight", "tfa_ins2_glock_19", "tfa_ins2_cw_ar15", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "tfa_ins2_m590o"},
    command = "secu_lmtf",
    max = 5,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "F.I.M",
	sortOrder = 20,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(150)
        ply:SetMaterial("")
end

})


TEAM_SECU_SOMTF = DarkRP.createJob("[WL] Sous-Officier F.I.M", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/Player/Calamity/Epsilon-11/Gaminglight_Epsilon-11.mdl"
    },
    description = [[]],
    weapons = {"hololink_swep", "carte_4","weapon_flashlight", "tfa_ins2_glock_19", "tfa_ins2_cw_ar15", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "tfa_ins2_m590o"},
    command = "secu_somtf",
    max = 5,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "F.I.M",
	sortOrder = 19,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(100)
        ply:SetArmor(150)
        ply:SetMaterial("")
end

})


TEAM_SECU_UTRLE = DarkRP.createJob("Unité Robotique Léger", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/sire/workingjoe.mdl"
    },
    description = [[]],
    weapons = {"carte_3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "secu_utrle",
    max = 2,
    salary = 150,
    level = 20,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 21,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(250)
        ply:SetArmor(250)
        ply:SetMaterial("")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 20) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 20",
})


TEAM_SECU_UTRLO = DarkRP.createJob("[VIP] Unité Robotique Lourd", {
    color = Color(26, 46, 189, 255),
    model = {
        "models/arachnit/wolfenstein2/ubersoldat/ubersoldat_player.mdl"
    },
    description = [[]],
    weapons = {"carte_3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "secu_utrlo",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 22,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(500)
        ply:SetArmor(250)
end,
    customCheck = function(ply) 
    return (ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))
end,
    CustomCheckFailMsg = "Vous devez être VIP, VIP+, Légende, Cosmique !"
})

TEAM_IA = DarkRP.createJob("[VIP] IA Du Site", {
    color = Color(30, 219, 73, 255),
    model = {
        "models/player/Group01/Female_01.mdl"
    },
    description = [[]],
    weapons = {"carte_4","weapon_noclip", "scprp_iagun"},
    command = "iasite",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 26,
    PlayerSpawn =  function(ply) ply:SetHealth(999999999) 
    ply:SetMaterial("models/props_combine/stasisshield_sheet") end,
	OnPlayerChangedTeam = function(ply) ply:SetMaterial("") end,
   customCheck = function(ply) 
    return (ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))
end,
    CustomCheckFailMsg = "Vous devez être VIP, VIP+, Légende, Cosmique !"
})

--[[---------------------------------------------------------------------------
                                        S.C.P
---------------------------------------------------------------------------]]
TEAM_999 = DarkRP.createJob("SCP-999", {
   color = Color(255, 0, 0, 255),
   model = {"models/scp/999/jq/scp_999_pmjq.mdl"},
   description = [[]],
   weapons = {"cscp_999"},
   command = "scp_999",
   max = 1,
   level = 7,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
   sortOrder = 0,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999)
        ply:SetArmor(0)
        ply:SetMaterial("")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 7) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 7",
})

TEAM_MAGECC = DarkRP.createJob("[COSMIQUE] SCP-MAGE-CC", {
   color = Color(255, 0, 0, 255),
   model = {"models/models/mage/mage.mdl"},
   description = [[]],
   weapons = {"weapon_hpwr_stick"},
   command = "magecc",
   max = 1,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
   sortOrder = 0,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(450)
        ply:SetHealth(999999)
end,
    customCheck = function(ply) return
     table.HasValue({"superadmin", "super-admin", "cosmique", "animateur", "administrateur"}, ply:GetNWString("usergroup"))
    end,
    CustomCheckFailMsg = "Vous devez être Cosmique !"
})

TEAM_TITANCC = DarkRP.createJob("[LEGENDE] SCP-TITAN-CC", {
   color = Color(255, 0, 0, 255),
   model = {"models/titansbydis/beasttitan/beasttitan.mdl"},
   description = [[]],
   weapons = {"weapon_force_fists","weapon_scp_011_fr"},
   command = "titancc",
   max = 1,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
   sortOrder = 0,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999)
end,
    customCheck = function(ply) 
    return (ply:IsAdmin() or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))
end,
    CustomCheckFailMsg = "Vous devez être Légende ou Cosmique !"
})

TEAM_173 = DarkRP.createJob("SCP-173", {
   color = Color(255, 0, 0, 255),
   model = {"models/breach173.mdl"},
   description = [[]],
   weapons = {"scp_173"},
   command = "scp_173",
   max = 1,
   level = 10,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
   sortOrder = 0.1,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999)
        ply:SetArmor(0)
        ply:SetMaterial("")
        ply:ConCommand("say /na <c=255,0,0>SCP-173 Disponible pour une Expérience.</c>")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 10) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 10",
})

TEAM_662 = DarkRP.createJob("SCP-662", {
   color = Color(255, 0, 0, 255),
   model = {"models/player/suits/male_09_shirt_tie.mdl"},
   description = [[]],
   weapons = {"carte_2", "tfa_ins2_m9", "weapon_camo"},
   command = "scp_662",
   max = 1,
   level = 10,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
   sortOrder = 0.1,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(150)
        ply:SetArmor(0)
        ply:SetMaterial("")
        ply:ConCommand("say /na <c=255,0,0>SCP-662 Disponible pour une Expérience.</c>")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 10) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 10",
})

TEAM_087 = DarkRP.createJob("SCP-087", {
   color = Color(255, 0, 0, 255),
   model = {"models/arachnit/gmod/invisible_pm/invisible_pm.mdl"},
   description = [[]],
   weapons = {"scprp_087gun"},
   command = "scp_087",
   max = 1,
   level = 12,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
   	sortOrder = 0.2,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999)
        ply:SetArmor(0)
        ply:SetMaterial("")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 12) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 12",
})
/*

TEAM_011 = DarkRP.createJob("SCP-011-FR", {
   color = Color(255, 0, 0, 255),
   model = {"models/arachnit/gmod/invisible_pm/invisible_pm.mdl"},
   description = [[]],
   weapons = {"weapon_noclip", "weapon_scp_011_fr"},
   command = "scp_011",
   max = 1,
   salary = 150,
   level = 15,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
    sortOrder = 0.2,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999)
        ply:SetArmor(0)
        ply:SetMaterial("")
        ply:ConCommand("say /na <c=255,0,0>SCP-011-FR Disponible pour une Expérience.</c>")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 15) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 15",
})

*/

TEAM_082 = DarkRP.createJob("SCP-082", {
   color = Color(255, 0, 0, 255),
   model = {"models/vasey105/darknessrises/orc.mdl"},
   description = [[]],
   weapons = {"weapon_mse_katana"},
   command = "scp_082",
   max = 1,
   salary = 150,
   level = 12,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
    sortOrder = 0.3,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999)
        ply:SetArmor(0)
        ply:SetMaterial("")
        ply:ConCommand("say /na <c=255,0,0>SCP-082 Disponible pour une Expérience.</c>")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 12) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 12",
})

TEAM_066 = DarkRP.createJob("SCP-066", {
   color = Color(255, 0, 0, 255),
   model = {"models/player/mrsilver/scp_066pm/scp_066_pm.mdl"},
   description = [[]],
   weapons = {"weapon_scp066"},
   command = "scp_066",
   max = 1,
   salary = 150,
   level = 15,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
    sortOrder = 0.4,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999)
        ply:SetArmor(0)
        ply:SetMaterial("")
        ply:ConCommand("say /na <c=255,0,0>SCP-066 Disponible pour une Expérience.</c>")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 15) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 15",
})

TEAM_035 = DarkRP.createJob("SCP-035", {
   color = Color(255, 0, 0, 255),
   model = {"models/logone/player/035_player.mdl"},
   description = [[]],
   weapons = {"weapon_035", "weapon_camo"},
   command = "scp_035",
   max = 1,
   level = 15,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
    sortOrder = 0.5,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(900)
        ply:SetArmor(0)
        ply:SetMaterial("")
        ply:ConCommand("say /na <c=255,0,0>SCP-035 Disponible pour une Expérience.</c>")
end,
    customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 15) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 15",
        PlayerDeath = function(ply, weapon, killer)
            ply:teamBan()
            ply:changeTeam(GAMEMODE.DefaultTeam, true)
                end,
})

TEAM_006 = DarkRP.createJob("SCP-006-FR", {
   color = Color(255, 0, 0, 255),
   model = {"models/player/p_butcher.mdl"},
   description = [[]],
   weapons = {"m9k_machete"},
   command = "scp_006",
   max = 1,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   modelScale = 1.1,
   category = "SCP",
    sortOrder = 0.5,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999)
        ply:ConCommand("say /advert <c=255,0,0>SCP-006-FR Disponible pour une Expérience.</c>")
end
})

TEAM_096 = DarkRP.createJob("SCP-096", {
   color = Color(255, 0, 0, 255),
   model = {"models/scp096anim/player/scp096pm_raf.mdl"},
   description = [[]],
   weapons = {"weapon_scp096", "carte_3"},
   command = "scp_096",
   max = 1,
   level = 17,
   scale = 2,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
         sortOrder = 0.8,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(99999)
        ply:SetArmor(0)
        ply:SetMaterial("")
        ply:ConCommand("say /advert <c=255,0,0>SCP-096 Disponible pour une Expérience.</c>")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 17) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 17",
})


TEAM_939 = DarkRP.createJob("SCP-939", {
   color = Color(255, 0, 0, 255),
   model = {"models/scp/939/unity/unity_scp_939.mdl"},
   description = [[]],
   weapons = {"weapon_scp_011_fr"},
   command = "scp_939", 
   max = 2,
   salary = 150,
    level = 20,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
   sortOrder = 1,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999)
        ply:SetArmor(0)
        ply:SetMaterial("")
        ply:ConCommand("say /advert <c=255,0,0>SCP-939 Disponible pour une Expérience.</c>")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 20) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 20",
        PlayerDeath = function(ply, weapon, killer)
            ply:teamBan()
            ply:changeTeam(GAMEMODE.DefaultTeam, true)
                end,
})

TEAM_049 = DarkRP.createJob("SCP-049", {
   color = Color(255, 0, 0, 255),
   model = {"models/vinrax/player/Scp049_player.mdl"},
   description = [[]],
   weapons = {"weapon_scp049"},
   command = "scp_049",
   max = 1,
   level = 20,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
      sortOrder = 1.1,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(5000)
        ply:SetArmor(0)
        ply:SetMaterial("")
        ply:ConCommand("say /advert <c=255,0,0>SCP-049 Disponible pour une Expérience.</c>")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 20) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 20",
        PlayerDeath = function(ply, weapon, killer)
            ply:teamBan()
            ply:changeTeam(GAMEMODE.DefaultTeam, true)
                end,
})

TEAM_076 = DarkRP.createJob("SCP-076-2", {
   color = Color(255, 0, 0, 255),
   model = {"models/abel/abel.mdl"},
   description = [[]],
   weapons = {"m9k_damascus"},
   command = "scp_076",
   max = 1,
   level = 20,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
      sortOrder = 1.1,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(5000)
        ply:SetArmor(0)
        ply:SetMaterial("")
        ply:ConCommand("say /advert <c=255,0,0>SCP-076-2 Disponible pour une Expérience.</c>")
end,
    customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 20) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 20",
        PlayerDeath = function(ply, weapon, killer)
            ply:teamBan()
            ply:changeTeam(GAMEMODE.DefaultTeam, true)
                end,
})
/*
TEAM_666 = DarkRP.createJob("SCP-666", {
   color = Color(255, 0, 0, 255),
   model = {"Models/player/pizzaroll/baronofhell.mdl"},
   description = [[]],
   weapons = {"weapon_scp_011_fr", "carte_3"},
   command = "scp_666",
   max = 1,
   salary = 150,
   level = 22,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
      sortOrder = 1.2,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(5000)
        ply:SetArmor(0)
        ply:SetMaterial("")
        ply:ConCommand("say /advert <c=255,0,0>SCP-666 Disponible pour une Expérience.</c>")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 22) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 22",
        PlayerDeath = function(ply, weapon, killer)
            ply:teamBan()
            ply:changeTeam(GAMEMODE.DefaultTeam, true)
                end,
})

TEAM_1128 = DarkRP.createJob("SCP-1128", {
   color = Color(255, 0, 0, 255),
   model = {"models/megalodon/megalodon.mdl"},
   description = [[]],
   weapons = {"weapon_scp_011_fr"},
   command = "scp_1128",
   max = 1,
   salary = 150,
   level = 23,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
      sortOrder = 1.3,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(700)
        ply:SetWalkSpeed(450)
        ply:SetHealth(999999)
        ply:SetArmor(0)
        ply:SetMaterial("")
        ply:ConCommand("say /advert <c=255,0,0>SCP-1128 Disponible pour une Expérience.</c>")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 23) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 23",
})

*/
TEAM_966 = DarkRP.createJob("SCP-966", {
   color = Color(255, 0, 0, 255),
   model = {"models/player/mishka/966_new.mdl"},
   description = [[]],
   weapons = {"weapon_966"},
   command = "scp_966",
   max = 3,
   salary = 150,
   level = 23,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
      sortOrder = 1.4,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(700)
        ply:SetHealth(999999)
        ply:SetArmor(0)
        ply:SetMaterial("")
        ply:ConCommand("say /advert <c=255,0,0>SCP-966 Disponible pour une Expérience.</c>")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 23) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 23",
})

TEAM_682 = DarkRP.createJob("[WL] SCP-682", {
   color = Color(255, 0, 0, 255),
   model = {"models/scp_682/scp_682.mdl"},
   description = [[]],
   weapons = {"weapon_scp_011_fr"},
   command = "scp_682",
   max = 1,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
    sortOrder = 10,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(500)
        ply:SetHealth(999999)
        ply:SetArmor(999999)
        ply:SetMaterial("")
        ply:ConCommand("say /advert <c=255,0,0>SCP-682 Disponible pour une Expérience.</c>")
end
})

TEAM_079 = DarkRP.createJob("[WL] SCP-079", {
   color = Color(255, 0, 0, 255),
   model = {"models/player/group01/male_01.mdl"},
   description = [[]],
   weapons = {"weapon_noclip", "scprp_iagun", "carte_3"},
   command = "scp_079", 
   max = 1,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
      sortOrder = 100,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999)
        ply:SetArmor(0)
        ply:SetMaterial("models/weapons/w_smg1/smg_crosshair")
end
})

TEAM_SCP106 = DarkRP.createJob("[WL] SCP-106", {
   color = Color(255, 0, 0, 255),
   model = {"models/scp/106/unity/unity_scp_106_player.mdl"},
   description = [[]],
   weapons = {"weapon_scp106swep", "weapon_scp_011_fr", "gu_scp_106"},
   command = "scp_106",
   max = 1,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
      sortOrder = 1000,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999)
        ply:SetArmor(0)
        ply:SetMaterial("")
        ply:ConCommand("say /advert <c=255,0,0>SCP-106 Disponible pour une Expérience.</c>")
end
})

TEAM_738 = DarkRP.createJob("[STAFF] SCP-738", {
   color = Color(255, 0, 0, 255),
   model = {"models/player/demon_violinist/demon_violinist.mdl"},
   description = [[]],
   weapons = {"weapon_noclip", "weapon_camo"},
   command = "scp_738",
   max = 1,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
      sortOrder = 10000,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(600)
        ply:SetHealth(999999)
        ply:SetArmor(0)
        ply:SetMaterial("")
        ply:ConCommand("say /na <c=255,0,0>SCP-738 Disponible pour une Expérience.</c>")
end,
    customCheck = function(ply) 
    return (((ply:IsSuperAdmin() or ply:IsUserGroup( "super-admin" ))))
    end,
    CustomCheckFailMsg = "Accès refusé",
})

TEAM_343 = DarkRP.createJob("[WL] SCP-343", {
   color = Color(255, 0, 0, 255),
   model = {"models/player/captainPawn/zeussmite.mdl"},
   description = [[]],
   weapons = {"weapon_noclip","enchanted_hand"},
   command = "scp_343",
   max = 1,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
      sortOrder = 100000,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(22000)
        ply:ConCommand("say /advert <c=255,0,0>SCP-343 Disponible pour une Expérience.</c>")
end,
})

TEAM_053 = DarkRP.createJob("[VIP] SCP-053", {
   color = Color(255, 0, 0, 255),
   model = {"models/player/hhp227/dawon_p.mdl"},
   description = [[]],
   weapons = {"weapon_scp_011_fr"},
   command = "scp_053",
   max = 1,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
    modelScale = 0.7,
   category = "SCP",
      sortOrder = 1000000,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(250)
        ply:SetHealth(99999)
        ply:SetArmor(0)
        ply:SetMaterial("")
        ply:ConCommand("say /advert <c=255,0,0>SCP-053 Disponible pour une Expérience.</c>")
end,
    customCheck = function(ply) 
    return (ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))
end,
    CustomCheckFailMsg = "Vous devez être VIP, VIP+, Légende, Cosmique !"
})

TEAM_1048 = DarkRP.createJob("[VIP] SCP-1048", {
   color = Color(255, 0, 0, 255),
   model = {"models/1048/tdy/tdybrownpm.mdl"},
   description = [[]],
   weapons = {"scp_1048", "weapon_camo"},
   command = "scp_1048",
   max = 1,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP",
   sortOrder = 10000000,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(1200)
        ply:SetArmor(0)
        ply:ConCommand("say /advert <c=255,0,0>SCP-1048 Disponible pour une Expérience.</c>")
end,
   customCheck = function(ply) 
    return (ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))
end,
    CustomCheckFailMsg = "Vous devez être VIP, VIP+, Légende, Cosmique !"
})

TEAM_527 = DarkRP.createJob("[VIP] SCP-527", {
   color = Color(255, 0, 0, 255),
   model = {"models/scp_527/scp_527.mdl"},
   description = [[]],
   weapons = {},
   command = "scp_527",
   max = 1,
   salary = 150,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
   category = "SCP", 
         sortOrder = 100000000,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(250)
        ply:SetHealth(99999)
end,
    customCheck = function(ply) 
    return (ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))
end,
    CustomCheckFailMsg = "Vous devez être VIP, VIP+, Légende, Cosmique !"
})

TEAM_457 = DarkRP.createJob("[VIP] SCP-457", {
   color = Color(255, 0, 0, 255),
    model = {
        "models/player/ntf_male.mdl"
    },
    description = [[]],
    weapons = {"carte_4","weapon_scp457"},
    command = "scp_457",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    modelScale = 1.2,
   category = "SCP", 
    sortOrder = 1000000000,
    PlayerSpawn =  function(ply) 
    ply:SetHealth(999999999)
    ply:SetMaterial("models/effects/splode1_sheet")
    ply:ConCommand("say /advert <c=255,0,0>SCP-457 Disponible pour une Expérience.</c>")
    end,
	OnPlayerChangedTeam = function(ply) ply:SetMaterial("") end,
   customCheck = function(ply) 
    return (ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))
end,
    CustomCheckFailMsg = "Vous devez être VIP, VIP+, Légende, Cosmique !"
})

TEAM_131 = DarkRP.createJob("[VIP] SCP-131", {
   color = Color(255, 0, 0, 255),
    model = {"models/scprp/scp131a2.mdl",
    "models/scprp/scp131b2.mdl"},
    description = [[]],
    weapons = {"parkourmod"},
    command = "scp_131",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    modelScale = 1.2,
   category = "SCP", 
    sortOrder = 1000000000,
    PlayerSpawn =  function(ply) 
    ply:SetHealth(999999999)
    ply:SetRunSpeed(450)
    ply:ConCommand("say /advert <c=255,0,0>SCP-131 Disponible pour une Expérience.</c>")
    end,
	OnPlayerChangedTeam = function(ply) ply:SetMaterial("") end,
    customCheck = function(ply) 
    return (ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))
end,
    CustomCheckFailMsg = "Vous devez être VIP, VIP+, Légende, Cosmique !"
})




TEAM_PSYCHOLOGUE = DarkRP.createJob("Psychologue", {
    color = Color(160, 40, 95, 255),
    model = {
        "models/scp/apsci_cohrt.mdl"
    },
    description = [[]],
    weapons = {"weapon_flashlight", "carte_3"},
    command = "admin_psychologue",
    max = 1,
    level = 5,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Administratif",
	sortOrder = 0,	
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetMaterial("")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 5) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 5",
        PlayerDeath = function(ply, weapon, killer)
            ply:teamBan()
            ply:changeTeam(GAMEMODE.DefaultTeam, true)
                end,
})

TEAM_INFIRMIER = DarkRP.createJob("Infirmier", {
    color = Color(160, 40, 95, 255),
    model = {
        "models/scp/pmedic01.mdl"
    },
    description = [[]],
    weapons = {"weapon_flashlight", "carte_3"},
    command = "admin_infirmier",
    max = 2,
    level = 5,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Administratif",
	sortOrder = 1,	
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetMaterial("")
end,
     customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 5) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 5",
        PlayerDeath = function(ply, weapon, killer)
            ply:teamBan()
            ply:changeTeam(GAMEMODE.DefaultTeam, true)
                end,
})

TEAM_INFIRMIEREXP = DarkRP.createJob("Infirmier Expérimenté", {
    color = Color(160, 40, 95, 255),
    model = {
        "models/player/kerry/medic/medic_01.mdl",
        "models/player/kerry/medic/medic_02.mdl",
        "models/player/kerry/medic/medic_05.mdl",
        "models/player/kerry/medic/medic_02_f.mdl",
        "models/player/kerry/medic/medic_01_f.mdl",
    },
    description = [[]],
    weapons = {"weapon_flashlight", "carte_3","defibrillator_advanced","med_kit_advanced"},
    command = "admin_infirmierexp",
    max = 3,
    salary = 150,
    admin = 0,
    level = 35,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Administratif",
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetMaterial("")
end,
 customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 35) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 35",
        PlayerDeath = function(ply, weapon, killer)
            ply:teamBan()
            ply:changeTeam(GAMEMODE.DefaultTeam, true)
                end,
})


TEAM_TECHNICIEN_INTENSIF = DarkRP.createJob("Technicien de surface Intensif", {
    color = Color(160, 40, 95, 255),
    model = {
        "models/player/hazmat/colorable_hazmat.mdl"
    },
    description = [[]],
    weapons = {"carte_2","weapon_flashlight", "salute_swep", "weapon_physgun", "gmod_tool" },
    command = "admin_technicien",
    max = 3,
    level = 20,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Administratif",
	sortOrder = 2,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetMaterial("")
end,
    customCheck = function(ply) 
    return (((ply:getDarkRPVar('level') or 0) >= 20) or ((ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))))
    end,
    CustomCheckFailMsg = "Vous devez être niveau 20",
})

TEAM_ADMIN_MEMBRE = DarkRP.createJob("[WL] Membre du Conseil Administratif", {
    color = Color(160, 40, 95, 255),
    model = {
        "models/player/suits/male_01_closed_tie.mdl",
		"models/player/suits/male_02_closed_tie.mdl",
		"models/player/suits/male_03_closed_tie.mdl",
		"models/player/suits/male_04_closed_tie.mdl",
		"models/player/suits/male_05_closed_tie.mdl",
		"models/player/suits/male_06_closed_tie.mdl",
		"models/player/suits/male_07_closed_tie.mdl",
		"models/player/suits/male_08_closed_tie.mdl",
		"models/player/suits/male_09_closed_tie.mdl",
		"models/player/darkrp/villian/villianvicki.mdl"
		
		
    },
    description = [[]],
    weapons = {"carte_4","weapon_flashlight", "cross_arms_infront_swep", "keys", "salute_swep"},
    command = "conseiller",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Administratif",
	sortOrder = 3,	
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetMaterial("")
end
})

TEAM_MRH = DarkRP.createJob("[WL] Membre Ressources Humaines", { 
	color = Color(160, 40, 95, 255),
	model = { "models/player/suits/male_01_closed_tie.mdl",
		"models/player/suits/male_02_closed_tie.mdl",
		"models/player/suits/male_03_closed_tie.mdl",
		"models/player/suits/male_04_closed_tie.mdl",
		"models/player/suits/male_05_closed_tie.mdl",
		"models/player/suits/male_06_closed_tie.mdl",
		"models/player/suits/male_07_closed_tie.mdl",
		"models/player/suits/male_08_closed_tie.mdl",
		"models/player/suits/male_09_closed_tie.mdl",
		"models/player/darkrp/villian/villianvicki.mdl" }, 
	description = [[]], 
	weapons = {"carte_4", "clone_card_c3navy", "cross_arms_swep", "cross_arms_infront_swep"}, 
	command = "mrh", 
	max = 0, 
	salary = 150, 
	admin = 0, 
	vote = false, 
	hasLicense = false, 
	candemote = false, 
	category = "Ressources Humaines", 
	sortOrder = 1, 
	PlayerSpawn = function(ply) 
		ply:SetJumpPower(150) 
		ply:SetHealth(100) 
		ply:SetMaterial("") 
end 
})

TEAM_DRH = DarkRP.createJob("[WL] Directeur Ressources Humaines", { 
	color = Color(160, 40, 95, 255),
	model = { "models/player/suits/male_01_closed_tie.mdl",
		"models/player/suits/male_02_closed_tie.mdl",
		"models/player/suits/male_03_closed_tie.mdl",
		"models/player/suits/male_04_closed_tie.mdl",
		"models/player/suits/male_05_closed_tie.mdl",
		"models/player/suits/male_06_closed_tie.mdl",
		"models/player/suits/male_07_closed_tie.mdl",
		"models/player/suits/male_08_closed_tie.mdl",
		"models/player/suits/male_09_closed_tie.mdl",
		"models/player/darkrp/villian/villianvicki.mdl" }, 
	description = [[]], 
	weapons = {"carte_4", "clone_card_c3navy", "cross_arms_swep", "cross_arms_infront_swep"}, 
	command = "drh", 
	max = 0, 
	salary = 150, 
	admin = 0, 
	vote = false, 
	hasLicense = false, 
	candemote = false, 
	category = "Ressources Humaines", 
	sortOrder = 2, 
	PlayerSpawn = function(ply) 
		ply:SetJumpPower(150) 
		ply:SetHealth(100) 
		ply:SetMaterial("") 
end 
})

TEAM_DIRADJ = DarkRP.createJob("[WL] Directeur Adjoint", { 
color = Color(160, 40, 95, 255),
model = {"models/player/fyk/drakeauction.mdl"}, 
description = [[]], 
weapons = {"carte_3", "tfa_ins2_m9", "cross_arms_swep", "cross_arms_swep"}, 
command = "dir_adj", 
max = 1, 
salary = 150, 
admin = 0, 
vote = false, 
hasLicense = false, 
candemote = false, 
category = "Direction", 
sortOrder = 2, 
PlayerSpawn = function(ply) 
ply:SetJumpPower(150) 
ply:SetHealth(300)
end 
})

TEAM_MASTOUT = DarkRP.createJob("[Cosmique] Mastodonte UT", {
    color = Color(0, 0, 0),
    model = {"Models/mw2guy/riot/juggernaut.mdl"},
    description = [[]],
    weapons = {"carte_4", "tfa_ins2_spas12", "riot_shield", "weapon_extinguisher_infinite", "weapon_stunstick", "weapon_flashlight", "ghosts_minigun", "weapon_force_fists", "med_kit_advanced", "weapon_r_handcuffs", "salute_swep", "defibrillator_advanced", "itemstore_checker", "stungun"},
    command = "mastout",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Sécurité",
	sortOrder = 1000,	
    PlayerSpawn = function(ply)
        ply:SetHealth(400)
        ply:SetArmor(200)
end,
    customCheck = function(ply) return
     table.HasValue({"superadmin", "super-admin", "cosmique", "animateur", "administrateur"}, ply:GetNWString("usergroup"))
    end,
    CustomCheckFailMsg = "Vous devez être Cosmique !"
})

TEAM_ADMIN_ADMIN = DarkRP.createJob("[WL] Directeur du site", {
    color = Color(160, 40, 95, 255),
    model = {
        "models/player/mgs4_bigboss.mdl"
    },
    description = [[]],
    weapons = {"carte_5","weapon_flashlight","tfa_ins2_m9"},
    command = "admin_admin",
    max = 1,
    salary = 300,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Direction",
	sortOrder = 3,	
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(300)
        ply:SetMaterial("")
end,
customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:169392337"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Seul Karl est le grand Directeur"
})

TEAM_ADMIN_O5 = DarkRP.createJob("[WL] Membre de L'O5", {
    color = Color(160, 40, 95, 255),
    model = {
        "models/player/suits/male_01_closed_tie.mdl",
		"models/player/suits/male_02_closed_tie.mdl",
		"models/player/suits/male_03_closed_tie.mdl",
		"models/player/suits/male_04_closed_tie.mdl",
		"models/player/suits/male_05_closed_tie.mdl",
		"models/player/suits/male_06_closed_tie.mdl",
		"models/player/suits/male_07_closed_tie.mdl",
		"models/player/suits/male_08_closed_tie.mdl",
		"models/player/suits/male_09_closed_tie.mdl",
		
		
    },
    description = [[]],
    weapons = {"carte_4","weapon_flashlight"},
    command = "admin_O5",
    max = 5,
    salary = 150,
    admin = 1,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Direction",
	sortOrder = 10,	
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetMaterial("")
end
})


--[[---------------------------------------------------------------------------
                                      Insurrection du chaos
---------------------------------------------------------------------------]]


TEAM_IC_AGENT = DarkRP.createJob("[WL] Agent Groupe d'intêret", {
    color = Color(0, 255, 255, 255),
    model = {
    	"models/mw2/skin_05/mw2_soldier_01.mdl",
        "models/player/kerry/class_scientist_2.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/hazmat/bmhaztechs.mdl",
        "models/dragontech/oeildudragon/05.mdl",
        "models/player/R6S_Ash.mdl",
    },
    description = [[]],
    weapons = {"weapon_flashlight", "tfa_ins2_ak400", "tfa_ins2_m9", "dradio", "salute_swep","weapon_r_handcuffs"},
    command = "ic_agent",
    max = 7,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Insurrection du chaos",
	sortOrder = 1,	
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end
})

TEAM_IC_AGENTMDC = DarkRP.createJob("[WL] Médecin Groupe d'intêret", {
    color = Color(0, 255, 255, 255),
    model = {
    	"models/mw2/skin_05/mw2_soldier_01.mdl",
        "models/player/kerry/class_scientist_2.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/hazmat/bmhaztechs.mdl",
        "models/dragontech/oeildudragon/05.mdl",
        "models/payday2/units/medic_player.mdl",
    },
    description = [[]],
    weapons = {"weapon_flashlight", "tfa_ins2_ak400", "tfa_ins2_m9", "dradio", "salute_swep","med_kit_advanced","defibrillator_advanced","weapon_r_handcuffs"},
    command = "ic_agentmdc",
    max = 7,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Insurrection du chaos",
	sortOrder = 3,	
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end
})


TEAM_IC_CHEF = DarkRP.createJob("[WL] Chef des Agents Groupe d'intêret", {
    color = Color(0, 255, 255, 255),
    model = {
        "models/player/kerry/class_scientist_2.mdl",
        "models/mw2/skin_04/mw2_soldier_05.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/hazmat/bmhaztechs.mdl",
        "models/dragontech/oeildudragon/05.mdl"
    },
    description = [[]],
    weapons = {"carte_3","weapon_flashlight", "tfa_ins2_ak400", "tfa_ins2_m9", "dradio", "salute_swep","weapon_r_handcuffs"},
    command = "ic_cagent",
    max = 3,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Insurrection du chaos",
	sortOrder = 2,	
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetArmor(100)
end
})

TEAM_IC_GERANT = DarkRP.createJob("[WL] Général IC", {
    color = Color(0, 255, 255, 255),
    model = {
        "models/mw2/skin_05/mw2_soldier_05.mdl",
		"models/player/kerry/class_scientist_2.mdl",
        "models/player/hazmat/hazmat1980.mdl",
        "models/hazmat/bmhaztechs.mdl",
        "models/dragontech/oeildudragon/05.mdl"
    },
    description = [[]],
    weapons = {"carte_4","weapon_flashlight", "tfa_ins2_ak400", "tfa_ins2_m9", "dradio", "salute_swep","weapon_r_handcuffs","cross_arms_infront_swep"},
    command = "ic_gerant",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Insurrection du chaos",
	sortOrder = 10,	
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end
})


TEAM_IC_VIP = DarkRP.createJob("[VIP] Agent Groupe d'intêret lourd", {
    color = Color(0, 255, 255, 255),
    model = {
        "models/mw2/skin_05/mw2_soldier_01.mdl"
    },
    description = [[]],
    weapons = {"weapon_flashlight", "tfa_ins2_m500", "tfa_l4d2_ctm200", "dradio", "tfa_ins2_cw_ar15", "tfa_ins2_m9", "salute_swep", "tfa_l4d2_ctm200","weapon_r_handcuffs", "riot_shield"},
    command = "ic_vipagent",
    max = 8,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Insurrection du chaos",
	sortOrder = 4,	
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(200)
        ply:SetArmor(200)
        ply:SetBodygroup(4, 3)
end,
customCheck = function(ply) 
    return (ply:IsAdmin() or ply:IsUserGroup( "vip" ) or ply:IsUserGroup( "vip+" ) or ply:IsUserGroup( "legende" ) or ply:IsUserGroup( "cosmique" ))
end,
    CustomCheckFailMsg = "Vous devez être VIP, VIP+, Légende, Cosmique !"
})


--[[---------------------------------------------------------------------------
                                        Staff
---------------------------------------------------------------------------]]

TEAM_STAFF = DarkRP.createJob("Staff en Service", {
    color = Color(233, 233, 233, 255),
    model = {
        "models/player/suits/male_01_closed_tie.mdl",
		"models/player/suits/male_02_closed_tie.mdl",
		"models/player/suits/male_03_closed_tie.mdl",
		"models/player/suits/male_04_closed_tie.mdl",
		"models/player/suits/male_05_closed_tie.mdl",
		"models/player/suits/male_06_closed_tie.mdl",
		"models/player/suits/male_07_closed_tie.mdl",
		"models/player/suits/male_08_closed_tie.mdl",
		"models/player/suits/male_09_closed_tie.mdl",
		        "models/player/spike/vamp.mdl",
                "models/player/miku_admin.mdl"
		
    },
    description = [[]],
    weapons = {"weapon_flashlight", "weapon_r_handcuffs", "gmod_tool", "weapon_physgun", "door_ram", "keys_admin", "itemstore_checker"},
    command = "staff",
    max = 0,
    salary = 150,
    admin = 1,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Divers",
	sortOrder = 1,	
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(99999999)
        ply:SetMaterial("")
end,
    customCheck = function(ply) return CLIENT or
            ply:IsAdmin()
                end,
    CustomCheckFailMsg = "Accès refusé",
})


--[[---------------------------------------------------------------------------
                                        Jobs Perso
---------------------------------------------------------------------------]]

--TEAM_CJ1 = DarkRP.createJob("SCP-131", { PROPRIETAIRE AFK
   -- color = Color(125, 50, 224, 255),
  --  model = {
  --  "models/scprp/scp131a2.mdl",
  --  "models/scprp/scp131b2.mdl"
  --  },
  --  description = [[Alex Profaci]],
 --   weapons = {"parkourmod"},
  --  command = "cj1",
 --   max = 2,
  --  salary = 150,
 --   admin = 0,
  --  vote = false,
  --  hasLicense = false,
  --  candemote = false,
  --      PlayerSpawn = function(ply)
  --      ply:SetHealth(99999999)
  --      ply:SetRunSpeed(250)
  --      ply:SetMaterial("")    
--end,
 --   category = "Jobs personnalisés",
 --    customJob = true,
  --  ownerName= "Alex Profaci",
  --  customCheck = function(ply) return
  --      table.HasValue({"STEAM_0:1:544747975","STEAM_0:1:184126955", "STEAM_0:0:453299055", "STEAM_0:1:467588430", "STEAM_0:1:75621018","STEAM_0:1:215455805","STEAM_0:1:109883645"}, ply:SteamID())
  --  end,
  --  CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
--})

TEAM_CJ2 = DarkRP.createJob("SCP-6666", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/player/dewobedil/underfell/sans/default_p.mdl"
    },
    description = [[Florian Flan]],
    weapons = {"defibrillator_advanced","", "weapon_flashlight", "clone_card_c3", "parkourmod", "gmod_camera", "keys", "blink", "weapon_healvial","","ae_superfists","", "", "",},
    command = "cj2",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
        PlayerSpawn = function(ply)
        ply:SetHealth(99999999)
        ply:SetRunSpeed(250)
        ply:SetMaterial("")    
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Florian Flan",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:93908967"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})
/*

--TEAM_CJ3 = DarkRP.createJob("SCP-629", { CHEF BAN PERM
 --   color = Color(125, 50, 224, 255),
 --   model = {
  --  "models/arachnit/Fallout4/synths/SynthGeneration1_pm.mdl"
  --  },
 --   description = [[Ethan Malfou]],
  --  weapons = {"parkourmod"},
 --   command = "cj3",
  --  max = 1,
  --  salary = 150,
  --  admin = 0,
  --  vote = false,
 --   hasLicense = false,
 --   candemote = false,
 --       PlayerSpawn = function(ply)
 --       ply:SetHealth(99999999)
  --      ply:SetRunSpeed(250)
  --      ply:SetMaterial("")    
--end,
  --  category = "Jobs personnalisés",
  --   customJob = true,
  --  ownerName= "Ethan Malfou",
  --  customCheck = function(ply) return
  --      table.HasValue({"STEAM_0:1:424169540"}, ply:SteamID())
  --  end,
  --  CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
--})

*/
TEAM_CJ4 = DarkRP.createJob("UTX D'execution Alpha", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/dizcordum/reaper.mdl"
    },
    description = [[Chris Carer]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "cj4",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(300)
        ply:SetArmor(250)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Chris Carer",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:179988221"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ5 = DarkRP.createJob("L'ombre du site-65", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/player/Lady_HUNK.mdl",
    "models/CSO2/player/ct_helga_player.mdl"
    },
    description = [[Maxence Sousaka]],
    weapons = {"tfa_ins2_glock_19","tfa_ins2_m590o","tfa_ins2_vector","tfa_ins2_m500","clone_card_c4", "weapon_stunstick", "bustersword", "ae_superfists", "blink"},
    command = "cj5",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(350)
        ply:SetHealth(500)
        ply:SetArmor(250)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Maxence Sousaka",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:502292859"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ6O = DarkRP.createJob("Opérateur ATLAS", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/player/killzone3/helghast.mdl"
    },
    description = [[tueurminecraft]],
    weapons = {"tfa_ins2_minimi","riot_shield","clone_card_c3","weapon_flashlight",
    "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep",
    "tfa_ins2_m590o","weapon_752_m2_flamethrower","","weapon_extinguisher_infinite","ghosts_minigun"},
    command = "cj6o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(200)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "tueurminecraft",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:526487168"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


TEAM_CJ6SO = DarkRP.createJob("Sous-Opérateur ATLAS", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/player/killzone3/helghast.mdl"
    },
    description = [[tueurminecraft]],
    weapons = {"tfa_ins2_minimi","riot_shield","clone_card_c3","weapon_flashlight",
    "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep",
    "tfa_ins2_m590o","weapon_752_m2_flamethrower","","weapon_extinguisher_infinite","ghosts_minigun"},
    command = "cj6so",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(200)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "tueurminecraft",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:196771293"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ6 = DarkRP.createJob("Escouade ATLAS", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/player/killzone3/helghast.mdl"
    },
    description = [[tueurminecraft]],
    weapons = {"tfa_ins2_minimi","riot_shield","clone_card_c3","weapon_flashlight",
    "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep",
    "tfa_ins2_m590o","weapon_752_m2_flamethrower","","weapon_extinguisher_infinite","ghosts_minigun"},
    command = "cj6",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(200)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "tueurminecraft",
})
/*
--TEAM_CJ7 = DarkRP.createJob("SCP-1012", { CHEF BAN PERM
  --  color = Color(125, 50, 224, 255),
 ---   model = {
 --   "models/EggHead/player/penpen/penpenvii_pm.mdl"
 --   },
--    description = [[Le Manchot Empereur]],
 --   weapons = {"clone_card_c3", "", "", "ae_superfists"},
 --   command = "cj7",
  --  max = 1,
 --   salary = 150,
 --   admin = 0,
--    vote = false,
 --   hasLicense = false,
--    candemote = false,
 --   PlayerSpawn = function(ply)
  --      ply:SetJumpPower(190)
  --      ply:SetRunSpeed(250)
  --      ply:SetHealth(99999999)
  --      ply:SetArmor(250)
   --     ply:SetMaterial("")end,
  --  category = "Jobs personnalisés",
  --   customJob = true,
   -- ownerName= "Le Manchot Empereur",
  --  customCheck = function(ply) return
   --     table.HasValue({"STEAM_0:0:427907623"}, ply:SteamID())
 --   end,
 --   CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
--})

*/

TEAM_CJ8 = DarkRP.createJob("SCP-147-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/player/valley/dbxv_beerus.mdl"
    },
    description = [[Jean Hord]],
    weapons = {"blink", "weapon_scp_011_fr", "clone_card_c3","weapon_force_fists","defibrillator_advanced","weapon_camo","middlefinger_animation_swep"},
    command = "cj8",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(99999999)
        ply:SetArmor(250)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Jean Hord",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:116860550"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ9 = DarkRP.createJob("SCP-1799", {
    color = Color(125, 50, 224, 255),
    model = {"models/winningrook/gtav/clowns/clown_000.mdl","models/winningrook/gtav/clowns/clown_001.mdl"},
    description = [[Alex Profacy]],
    weapons = {},
    command = "cj9",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(99999999)
        ply:SetArmor(250)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Alex Profacy",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:184126955"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ10C = DarkRP.createJob("Opérateur Charlie", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/omonru/riot/riot_ru.mdl"
    },
    description = [[Nous sommes tous sortis d'une carrière des foces spéciales qui ont étés remarqués dans des situations très spéciales. Nous sommes des élites et nous devons comme avant montrer notre force aux autres.]],
    weapons = {"weapon_hands","stungun","clone_card_c3","weapon_flashlight", "tfa_ins2_m9", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","tfa_ins2_m590o","tfa_ins2_aug","weapon_r_handcuffs"},
    command = "cj10c",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Adjudant Chef Enstay",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:467588430"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


TEAM_CJ10 = DarkRP.createJob("Escouade Charlie", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/omonru/riot/riot_ru.mdl"
    },
    description = [[Nous sommes tous sortis d'une carrière des foces spéciales qui ont étés remarqués dans des situations très spéciales. Nous sommes des élites et nous devons comme avant montrer notre force aux autres.]],
    weapons = {"weapon_hands","stungun","clone_card_c3","weapon_flashlight", "tfa_ins2_m9", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","tfa_ins2_m590o","tfa_ins2_aug","weapon_r_handcuffs"},
    command = "cj10",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Adjudant Chef Enstay",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})



TEAM_CJ12 = DarkRP.createJob("SCP-7457-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/pm_Shadow/Shadow.mdl"
    },
    description = [[Josh]],
    weapons = {"weapon_752_m2_flamethrower", "blink", "weapon_camo","parkourmod","ae_superfists"},
    command = "cj12",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(99999999)
        ply:SetArmor(250)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Josh",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:522259054","STEAM_0:1:508318524"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ13C = DarkRP.createJob("Opérateur Reds Hats", {
    color = Color(0, 216, 255),
    model = {"models/lb/kaan_redhats_v2/redhats_scp_v2.mdl","models/player/hazmat/hazmat1980.mdl"},
    description = [[.]],
    weapons = {"deployable_shield","clone_card_c4","weapon_flashlight", "tfa_ins2_cw_ar15", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","tfa_ins2_m590o", "riot_shield", "tfa_nam_rdg1", "cross_arms_infront_swep", "voice_amplifier"},
    command = "cj13c",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Karl Hord",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:169392337"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ13SO = DarkRP.createJob("Sous-Opérateur Reds Hats", {
    color = Color(0, 216, 255),
    model = {"models/lb/kaan_redhats_v2/redhats_scp_v2.mdl","models/player/hazmat/hazmat1980.mdl"},
    description = [[.]],
    weapons = {"deployable_shield","clone_card_c4","weapon_flashlight", "tfa_ins2_cw_ar15", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","tfa_ins2_m590o", "riot_shield", "tfa_nam_rdg1", "cross_arms_infront_swep", "voice_amplifier"},
    command = "cj13so",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Karl Hord",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


TEAM_CJ13 = DarkRP.createJob("Escouade Reds Hats", {
    color = Color(0, 216, 255),
    model = {"models/lb/kaan_redhats_v2/redhats_scp_v2.mdl","models/player/hazmat/hazmat1980.mdl"},
    description = [[.]],
    weapons = {"deployable_shield","clone_card_c3","weapon_flashlight", "tfa_ins2_cw_ar15", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","tfa_ins2_m590o", "riot_shield", "tfa_nam_rdg1"},
    command = "cj13",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Karl Hord",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ15 = DarkRP.createJob("SCP 0069 ( L'avarice )", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/nikout/darksouls2/characters/blackdragon.mdl"
    },
    description = [[ChrisCarer]],
    weapons = {"blink", "weapon_camo", "m9k_damascus"},
    command = "cj15",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(99999999)
        ply:SetArmor(250)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "ChrisCarer",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:179988221"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})
/*

--TEAM_CJ17 = DarkRP.createJob("SCP-6462", {
 --   color = Color(125, 50, 224, 255),
 --   model = {"models/lizards/lizardmanvd.mdl","models/lizards/lizardmanekinar.mdl","models/lizards/lizardmangarway.mdl","models/lizards/lizardmankazgulam.mdl","models/lizards/lizardmankeser.mdl","models/lizards/lizardmanshaman.mdl",
--"models/lizards/lizardmanverafim.mdl","models/lizards/lizardmanwarrior.mdl","models/lizards/lizardmanshark.mdl","models/lizards/lizardmansharkalt.mdl"},
 --   description = [[Mouloud Ziner]],
  --  weapons = {"weapon_752_m2_flamethrower", "weapon_noclip", "ae_superfists"},
 --   command = "cj17",
 --   max = 1,
 --   salary = 150,
--    admin = 0,
 --   vote = false,
  --  hasLicense = false,
 --   candemote = false,
  --  PlayerSpawn = function(ply)
 --       ply:SetJumpPower(190)
  --      ply:SetRunSpeed(250)
--        ply:SetHealth(100)
--        ply:SetArmor(250)
 --       ply:SetMaterial("")end,
 --   category = "Jobs personnalisés",
 --    customJob = true,
--    ownerName= "Mouloud Ziner",
--    customCheck = function(ply) return
--        table.HasValue({"STEAM_0:1:184332369"}, ply:SteamID())
 --   end,
 --   CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
--})

*/

TEAM_CJ18O = DarkRP.createJob("Opérateur Hydra", {
    color = Color(125, 50, 224, 255),
    model = {"models/mw2/skin_02/mw2_soldier_05.mdl","models/mw2/skin_02/mw2_soldier_05.mdl","models/mw2/skin_07/mw2_soldier_05.mdl","models/mw2/skin_07/mw2_soldier_06.mdl"},
    description = [[.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","weapon_extinguisher","tfa_l4d2_ctm200","parkourmod","deployable_shield"},
    command = "cj18o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "ADJC-UT-Mélios",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:124966713"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ18SO = DarkRP.createJob("Sous-Opérateur Hydra", {
    color = Color(125, 50, 224, 255),
    model = {"models/mw2/skin_11/mw2_soldier_05.mdl"},
    description = [[.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","weapon_extinguisher","tfa_l4d2_ctm200","parkourmod","deployable_shield"},
    command = "cj18so",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetArmor(100)
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "ADJC-UT-Mélios",
   mCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ18 = DarkRP.createJob("Escouade Hydra", {
    color = Color(125, 50, 224, 255),
    model = {"models/mw2/skin_11/mw2_soldier_05.mdl","models/mw2/skin_02/mw2_soldier_01.mdl","models/mw2/skin_02/mw2_soldier_02.mdl","models/mw2/skin_11/mw2_soldier_02.mdl",
    "models/mw2/skin_07/mw2_soldier_02.mdl","models/mw2/skin_07/mw2_soldier_01.mdl","models/mw2/skin_11/mw2_soldier_01.mdl","models/mw2/skin_02/mw2_soldier_03.mdl","models/mw2/skin_07/mw2_soldier_04.mdl",
     "models/mw2/skin_11/mw2_soldier_04.mdl"},
    description = [[.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","weapon_extinguisher","tfa_l4d2_ctm200","parkourmod","deployable_shield"},
    command = "cj18",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "ADJC-UT-Mélios",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


TEAM_CJ19 = DarkRP.createJob("SCP-073", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/player/scientist.mdl"
    },
    description = [[Jean Hord]],
    weapons = {"clone_card_c4", "weapon_flashlight", "weapon_scp073", "weapon_bur_magic"},
    command = "cj19",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(99999999)
        ply:SetArmor(250)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Jean Hord",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:116860550","STEAM_0:0:116860550","STEAM_0:0:116860550","STEAM_0:0:93908967"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

--TEAM_CJ21 = DarkRP.createJob("SCP-4913", {
 --   color = Color(125, 50, 224, 255),
 --   model = {
 --   "models/Samurai/Samurai_Player.mdl"
 --   },
 --   description = [[Mirzaro]],
  --  weapons = {"", "weapon_mse_katana", "blink", "", "clone_card_c3","weapon_healvial","","","darkmeditation","",""},
  --  command = "cj21",
  --  max = 1,
  --  salary = 150,
 --   admin = 0,
 --   vote = false,
 --   hasLicense = false,
 --   candemote = false,
  --  PlayerSpawn = function(ply)
  --      ply:SetJumpPower(190)
  --      ply:SetRunSpeed(250)
  --      ply:SetHealth(99999999)
   --     ply:SetArmor(250)
   --     ply:SetMaterial("")end,
  --  category = "Jobs personnalisés",
 --    customJob = true,
 --   ownerName= "Mirzaro",
 --   customCheck = function(ply) return
--        table.HasValue({"STEAM_0:1:532312829"}, ply:SteamID())
 --   end,
  --  CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
--})

TEAM_CJ22O = DarkRP.createJob("Opérateur Foxtrot", {
    color = Color(125, 50, 224, 255),
    model = {"models/Killzone 3/Capture/Capture Trooper_playermodel.mdl"},
    description = [[.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","ghosts_minigun","weapon_extinguisher","riot_shield","weapon_752_m2_flamethrower"},
    command = "cj22o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(200)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Ghost Brown | Jax",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:232991699"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


TEAM_CJ22 = DarkRP.createJob("Escouade Foxtrot", {
    color = Color(125, 50, 224, 255),
    model = {"models/kuma96/winterizedarmor/winterizedarmor_pm.mdl"},
    description = [[Cette  unité sert à la protection avancer et sophistiqué doué de conscience.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","ghosts_minigun","weapon_extinguisher","riot_shield","weapon_752_m2_flamethrower"},
    command = "cj22",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(200)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Ghost Brown | Jax",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ23 = DarkRP.createJob("SCP-423-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/player/suits/male_09_shirt_tie.mdl"
    },
    description = [[Mr.Lambert]],
    weapons = {"clone_card_c3", "weapon_physcannon"},
    command = "cj23",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(2000)
        ply:SetArmor(250)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Mr.Lambert",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:467588430"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

--TEAM_CJ25 = DarkRP.createJob("SCP-043-CC", {
--    color = Color(125, 50, 224, 255),
 --   model = {
 --   "models/player/player_simon_henriksson.mdl"
  --  },
 --   description = [[l'homme paranoïaque]],
 --   weapons = {"clone_card_c3", "weapon_035", "tfa_nmrih_kknife"},
 --   command = "cj25",
 --   max = 1,
 --   salary = 150,
 --   admin = 0,
 --   vote = false,
  --  hasLicense = false,
 --   candemote = false,
--    PlayerSpawn = function(ply)
  --      ply:SetJumpPower(190)
 --       ply:SetRunSpeed(250)
 --       ply:SetHealth(2000)
  --      ply:SetArmor(250)
 -- --      ply:SetMaterial("")end,
--    category = "Jobs personnalisés",
 --    customJob = true,
 --   ownerName= "l'homme paranoïaque",
--    customCheck = function(ply) return
--        table.HasValue({"STEAM_0:0:220227273"}, ply:SteamID())
 --   end,
 --   CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
--})


TEAM_CJ26 = DarkRP.createJob("SCP-0666-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/mailer/characters/diablosc2.mdl"
    },
    description = [[l'homme paranoïaque]],
    weapons = {"weapon_noclip", "blink", "weapon_camo"},
    command = "cj26",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Chris Carer",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:179988221"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})



TEAM_CJ27 = DarkRP.createJob("Opérateur S.N.S.C", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/kerry/policeru_05_omon.mdl","models/player/kerry/policeru_05.mdl"},
    description = [[.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","parkourmod","riot_shield", "ghosts_minigun","deployable_shield","heavy_shield","weapon_extinguisher",},
    command = "cj27o",
    max = 1,
    salary = 150, 
    admin = 0, 
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Lufos",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:215455805"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ27SO = DarkRP.createJob("Sous-Opérateur S.N.S.C", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/kerry/policeru_07_omon.mdl","models/player/kerry/policeru_07.mdl"},
    description = [[.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","parkourmod","riot_shield", "ghosts_minigun","deployable_shield","heavy_shield","weapon_extinguisher",},
    command = "cj27so",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Lufos",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


TEAM_CJ27 = DarkRP.createJob("Escouade S.N.S.C", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/kerry/police_02_female.mdl","models/player/kerry/policeru_03_patrol.mdl","models/player/kerry/policeru_05_patrol.mdl","models/player/kerry/policeru_02_patrol.mdl","models/player/kerry/policeru_04_patrol.mdl","models/player/kerry/policeru_07_patrol.mdl",
    "models/player/kerry/policeru_06_patrol.mdl","models/player/kerry/policeru_01_patrol.mdl","models/fear3/player/soldier_1.mdl",},
    description = [[Escouades spécialisée dans la négociation et sécurisation via des constructions]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","parkourmod","riot_shield", "ghosts_minigun","deployable_shield","heavy_shield","weapon_extinguisher",},
    command = "cj27",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(100)
        ply:SetArmor(100)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Lufos",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ28 = DarkRP.createJob("SCP-062-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/iffy/alienscm/alien/xeno_soldier_player.mdl"
    },
    description = [[Le prédateur Parfait]],
    weapons = {"weapon_scp049", "weapon_camo", "clone_card_c3","","weapon_scp096"},
    command = "cj28",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Mya Krastof",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:98519308"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


TEAM_CJ29 = DarkRP.createJob("SCP-1471-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/burd/scp1471/scp1471.mdl"
    },
    description = [[Le prédateur Parfait]],
    weapons = {"weapon_camo", "weapon_dogswep", "weapon_noclip"},
    command = "cj29",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Anonymous-boy",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:558498472"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ30 = DarkRP.createJob("SCP-909-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/TSBB/Animals/Dingo.mdl"
    },
    description = [[fri frize]],
    weapons = {"weapon_scp_011_fr", "defibrillator_advanced", "defibrillator_advanced"},
    command = "cj30",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "fri frize",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:492612094"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


--TEAM_CJ31 = DarkRP.createJob("SCP-3-14-CC", {
 --   color = Color(125, 50, 224, 255),
 --   model = {
 --   "models/kryptonite/inj2_cw_reverse/inj2_cw_reverse.mdl"
 --   },
 --   description = [[Christophe Whealer]],
 --   weapons = {"weapon_camo", "ae_superfists", "blink","weapon_flashlight","gmod_camera"},
 --   command = "cj31",
 --   max = 2,
 --   salary = 150,
 --   admin = 0,
 --   vote = false,
 --   hasLicense = false,
--    candemote = false,
 --   PlayerSpawn = function(ply)
  --      ply:SetJumpPower(190)
  --      ply:SetRunSpeed(250)
  --      ply:SetHealth(5000)
 --       ply:SetMaterial("")end,
 --   category = "Jobs personnalisés",
 --    customJob = true,
 --   ownerName= "Christophe Whealer",
 --   customCheck = function(ply) return
 --       table.HasValue({"STEAM_0:1:235406030","STEAM_0:0:501523256"}, ply:SteamID())
 --   end,
 --   CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
--})



TEAM_CJ32O = DarkRP.createJob("Opérateur I.P.R", {
    color = Color(125, 50, 224, 255),
    model = {"models/minson97/bo2/harper/harper.mdl","models/minson97/bo2/harper/harper_arm.mdl","models/minson97/bo2/harper/harper_colossus.mdl"},
    description = [[.]],
    weapons = {"weapon_hands","stungun","clone_card_c4","weapon_flashlight", "tfa_ins2_m9", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","tfa_ins2_m590o","tfa_ins2_cw_ar15","weapon_r_handcuffs","ghosts_minigun","iw_nv4","cross_arms_infront_swep"},
    command = "cj32o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Jean Hord",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:116860550"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ32SO = DarkRP.createJob("Sous-Opérateur I.P.R", {
    color = Color(125, 50, 224, 255),
    model = {"models/ninja/mgs4_haven_trooper.mdl"},
    description = [[Escouade d'Intervention Polyvalente Renforcée]],
    weapons = {"weapon_hands","stungun","clone_card_c3","weapon_flashlight", "tfa_ins2_m9", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","tfa_ins2_m590o","tfa_ins2_aug","weapon_r_handcuffs","ghosts_minigun","iw_nv4"},
    command = "cj32so",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Jean Hord",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ32E = DarkRP.createJob("Escouade I.P.R", {
    color = Color(125, 50, 224, 255),
    model = {"models/tfusion/playermodels/mw3/mp_delta_elite_a.mdl","models/tfusion/playermodels/mw3/mp_delta_elite_b.mdl","models/tfusion/playermodels/mw3/mp_delta_elite_c.mdl","models/tfusion/playermodels/mw3/mp_delta_elite_d.mdl","models/tfusion/playermodels/mw3/mp_ally_delta_sniper.mdl"},
    description = [[Escouade d'Intervention Polyvalente Renforcée]],
    weapons = {"weapon_hands","stungun","clone_card_c3","weapon_flashlight", "tfa_ins2_m9", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","tfa_ins2_m590o","tfa_ins2_aug","weapon_r_handcuffs","ghosts_minigun","iw_nv4"},
    command = "cj32e",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Jean Hord",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


--TEAM_CJ33 = DarkRP.createJob("SCP-215-CC", {
 --   color = Color(125, 50, 224, 255),
 --   model = {
 --       "models/player/kerry/class_scientist_1.mdl",
--		"models/player/kerry/class_scientist_2.mdl",
 --       "models/player/kerry/class_scientist_3.mdl",
 --       "models/bmscientistcits/p_female_01.mdl",
 --       "models/bmscientistcits/p_female_02.mdl",
 --       "models/dragontech/oeildudragon/05.mdl","models/bmscientistcits/p_female_06.mdl","models/hazmat/bmhaztechs.mdl"
 --   },
 --   description = [[Christophe Whealer]],
 --   weapons = {"weapon_noclip", "blink"},
 --   command = "cj33",
 --   max = 1,
  --  salary = 150,
  --  admin = 0,
 --   vote = false,
 --   hasLicense = false,
 --   candemote = false,
 --   PlayerSpawn = function(ply)
  --      ply:SetJumpPower(190)
  --      ply:SetRunSpeed(250)
  --      ply:SetHealth(250)
  --      ply:SetMaterial("")end,
  --  category = "Jobs personnalisés",
  --   customJob = true,
   -- ownerName= "Chercheur C Walker",
  --  customCheck = function(ply) return
  --      table.HasValue({"STEAM_0:0:128568350"}, ply:SteamID())
  --  end,
  --  CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
--})

--TEAM_CJ34O = DarkRP.createJob("Opérateur C.F.S", {
 --   color = Color(125, 50, 224, 255),
 --   model = {"models/mark2580/payday2/pd2_riot_shield_zeal_player.mdl"},
--    description = [[.]],
--    weapons = {"weapon_hands","","clone_card_c3","weapon_flashlight", "tfa_ins2_m9", "stunstick", "weapon_checker", "stungun", "tfa_ins2_hk416a5", "salute_swep","tfa_ins2_m590o","tfa_ins2_aug","weapon_r_handcuffs"},
 --   command = "cj34o",
--    max = 1,
 --   salary = 150,
 --   admin = 0,
--    vote = false,
--    hasLicense = false,
 --   candemote = false,
--    PlayerSpawn = function(ply)
  --      ply:SetJumpPower(150)
 --       ply:SetHealth(100)
  --      ply:SetArmor(100)
  --      ply:SetMaterial("")
--end,
 --   category = "Jobs personnalisés",
 --    customJob = true,
 --   ownerName= "Purple",
 --   customCheck = function(ply) return
 --       table.HasValue({"STEAM_0:0:428419795"}, ply:SteamID())
 --   end,
 --   CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
--})

--TEAM_CJ34E = DarkRP.createJob("ESCOUADE C.F.S", {
--    color = Color(125, 50, 224, 255),
 --   model = {"models/fear3/player/soldier_1.mdl"},
--    description = [[Escouade spécialisé dans des opérations sensible et service de renseignement.]],
--    weapons = {"weapon_hands","","clone_card_c3","weapon_flashlight", "tfa_ins2_m9", "stunstick", "weapon_checker", "stungun", "tfa_ins2_hk416a5", "salute_swep","tfa_ins2_m590o","tfa_ins2_aug","weapon_r_handcuffs"},
 --   command = "cj34e",
 --   max = 10,
 --   salary = 150,
 --   admin = 0,
 ----   vote = false,
  --  hasLicense = false,
  --  candemote = false,
 --   PlayerSpawn = function(ply)
  --      ply:SetJumpPower(150)
 --       ply:SetHealth(100)
  --      ply:SetArmor(100)
  --     ply:SetMaterial("")
--end,
 --   category = "Jobs personnalisés",
 --   customJob = true,
 --   ownerName= "Purple",
 --   CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
--})

TEAM_CJ35O = DarkRP.createJob("Opérateur Sierra", {
    color = Color(125, 50, 224, 255),
    model = {"models/mark2580/payday2/pd2_riot_shield_zeal_player.mdl",
    "models/player/humans/army/male_01.mdl"},
    description = [[.]],
    weapons = {"weapon_hands","","clone_card_c3","weapon_flashlight", "tfa_ins2_m9", "stunstick", "weapon_checker", "stungun", "tfa_ins2_hk416a5", "salute_swep","tfa_ins2_m590o","tfa_ins2_aug","weapon_r_handcuffs","med_kit_advanced","riot_shield"},
    command = "cj35o",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Robert mon bb",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:428419795","STEAM_0:1:461427913"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ35SO = DarkRP.createJob("Sous-Opérateur Sierra", {
    color = Color(125, 50, 224, 255),
    model = {"models/bloocobalt/resident evil/rerev_hunk.mdl","models/bloocobalt/resident evil/re6_agent.mdl","models/player/tfa_cso2/ct_helga.mdl",},
    description = [[Escouade spécialisé dans des opérations sensible et service de renseignement.]],
    weapons = {"weapon_hands","","clone_card_c3","weapon_flashlight", "tfa_ins2_m9", "stunstick", "weapon_checker", "stungun", "tfa_ins2_hk416a5", "salute_swep","tfa_ins2_m590o","tfa_ins2_aug","weapon_r_handcuffs","med_kit_advanced","riot_shield"},
    command = "cj35so",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Robert mon bb",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ35E = DarkRP.createJob("Escouade Sierra", {
    color = Color(125, 50, 224, 255),
    model = {"models/mw2/skin_03/MW2_Soldier_01.mdl","models/mw2/skin_03/MW2_Soldier_02.mdl","models/mw2/skin_03/MW2_Soldier_03.mdl","models/mw2/skin_03/MW2_Soldier_04.mdl",
    	"models/mw2/skin_03/MW2_Soldier_05.mdl","models/mw2/skin_03/MW2_Soldier_06.mdl","models/mw2/skin_04/MW2_Soldier_01.mdl","models/mw2/skin_04/MW2_Soldier_02.mdl",
    	"models/mw2/skin_04/MW2_Soldier_03.mdl","models/mw2/skin_04/MW2_Soldier_04.mdl","models/mw2/skin_04/MW2_Soldier_05.mdl","models/mw2/skin_04/MW2_Soldier_06.mdl",
    	"models/mw2/skin_05/MW2_Soldier_01.mdl","models/mw2/skin_05/MW2_Soldier_02.mdl","models/mw2/skin_05/MW2_Soldier_03.mdl","models/mw2/skin_05/MW2_Soldier_04.mdl",
    	"models/mw2/skin_05/MW2_Soldier_05.mdl","models/mw2/skin_05/MW2_Soldier_06.mdl","models/mw2/skin_09/MW2_Soldier_01.mdl","models/mw2/skin_09/MW2_Soldier_02.mdl",
    	"models/mw2/skin_09/MW2_Soldier_03.mdl","models/mw2/skin_09/MW2_Soldier_04.mdl","models/mw2/skin_09/MW2_Soldier_05.mdl","models/mw2/skin_09/MW2_Soldier_06.mdl",
    "models/mw2/skin_12/MW2_Soldier_01.mdl","models/mw2/skin_12/MW2_Soldier_02.mdl","models/mw2/skin_12/MW2_Soldier_03.mdl","models/mw2/skin_12/MW2_Soldier_04.mdl",
"models/mw2/skin_12/MW2_Soldier_05.mdl","models/mw2/skin_12/MW2_Soldier_06.mdl"},
    description = [[Escouade spécialisé dans des opérations sensible et service de renseignement.]],
    weapons = {"weapon_hands","","clone_card_c3","weapon_flashlight", "tfa_ins2_m9", "stunstick", "weapon_checker", "stungun", "tfa_ins2_hk416a5", "salute_swep","tfa_ins2_m590o","tfa_ins2_aug","weapon_r_handcuffs","med_kit_advanced","riot_shield"},
    command = "cj35e",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Robert mon bb",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

--TEAM_CJ36 = DarkRP.createJob("SCP-985-CC", {
 --   color = Color(125, 50, 224, 255),
--    model = {
--        "models/iffy/alienscm/alien/xeno_soldier_player.mdl"
 --   },
 --   description = [[Dietrich Eberhart]],
 --   weapons = {"weapon_scp939", "weapon_scp049","zombie_claws","parkourmod"},
--    command = "cj36",
 --   max = 2,
 --   salary = 150,
 --   admin = 0,
 --   vote = false,
 --   hasLicense = false,
 --   candemote = false,
 --   PlayerSpawn = function(ply)
 --       ply:SetJumpPower(190)
  --      ply:SetRunSpeed(250)
--        ply:SetHealth(250)
 --       ply:SetMaterial("")end,
--    category = "Jobs personnalisés",
 --    customJob = true,
 --   ownerName= "Dietrich Eberhart",
--    customCheck = function(ply) return
 --       table.HasValue({"STEAM_0:1:191633911","STEAM_0:0:196771293","STEAM_0:0:561249370"}, ply:SteamID())
 --   end,
 --   CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
--})

TEAM_CJ37O = DarkRP.createJob("Opérateur Girls", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/slow/amberlyn/sgt_stokes/slow.mdl"},
    description = [[.]],
    weapons = {"weapon_hands","clone_card_c3","weapon_flashlight", "m9k_damascus", "stunstick", "weapon_checker", "stungun", "salute_swep","tfa_ins2_m590o","tfa_ins2_minimi","weapon_r_handcuffs"},
    command = "cj37o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Ruby",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:558498472"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ37E = DarkRP.createJob("Escouade Girls", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/slow/amberlyn/sgt_stokes/slow.mdl","models/player/tfa/kss_hebe.mdl","models/player/tfa/kss_medusa.mdl","models/ninja/mgs4_Haven_trooper.mdl","models/dizcordum/dizcordum_masseffect.mdl","models/dizcordum/dizcordum_masseffect_casual.mdl"},
    description = [[Escouade spécialisé dans des opérations sensible et service de renseignement.]],
    weapons = {"weapon_hands","clone_card_c3","weapon_flashlight", "m9k_damascus", "stunstick", "weapon_checker", "stungun", "salute_swep","tfa_ins2_m590o","tfa_ins2_minimi","weapon_r_handcuffs"},
    command = "cj37e",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Ruby",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ38 = DarkRP.createJob("SCP-285-CC", {
    color = Color(125, 50, 224, 255),
    model = {
        "models/player/skeleton.mdl"
    },
    description = [[Tibicuit]],
    weapons = {"blink", "weapon_scp_011_fr","weapon_camo"},
    command = "cj38",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Tibicuit",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:113766562"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


TEAM_CJ39O = DarkRP.createJob("Opérateur Susano", {
    color = Color(125, 50, 224, 255),
    model = {"models/kuma96/gta5_specops/gta5_specops_pm.mdl"},
    description = [[Nous donneront nos vie pour protéger le site nous feront de notre mieux pour qu il y a moins d attaque et de deconfinment et améliorer le site  a faire de choses meilleur être riche pour changer le site est le rendre mieux.]],
    weapons = {"","weapon_hands","clone_card_c3","weapon_flashlight", "tfa_ins2_cw_ar15", "stunstick", "weapon_checker", "stungun", "salute_swep","weapon_r_handcuffs"},
    command = "cj39o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "S65-URLO-UT Robin",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:532945526"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ39E = DarkRP.createJob("Escouade Susano", {
    color = Color(125, 50, 224, 255),
    model = {"models/ratnik-3/ratnik-3.mdl"},
    description = [[Nous donneront nos vie pour protéger le site nous feront de notre mieux pour qu il y a moins d attaque et de deconfinment et améliorer le site  a faire de choses meilleur être riche pour changer le site est le rendre mieux.]],
    weapons = {"","weapon_hands","clone_card_c3","weapon_flashlight", "tfa_ins2_cw_ar15", "stunstick", "weapon_checker", "stungun", "salute_swep","weapon_r_handcuffs"},
    command = "cj39e",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "S65-URLO-UT Robin",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ40O = DarkRP.createJob("Opérateur Germa", {
    color = Color(125, 50, 224, 255),
    model = {"models/Killzone 3/Shock trooper/shock.mdl","models/player/ncrreddeathranger/RedDeathRanger/Red_Death_Ranger.mdl"},
    description = [[Troupe spécialisée dans la gestion stratégique, informatique et électronique.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "riot_shield","weapon_extinguisher","parkourmod","heavy_shield"},
    command = "cj40o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Raphaël(Cosmos)",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:553524252"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ40SO = DarkRP.createJob("Sous-Opérateur Germa", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/legion/3e_soldier.mdl"},
    description = [[Troupe spécialisée dans la gestion stratégique, informatique et électronique.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "riot_shield","weapon_extinguisher","parkourmod","heavy_shield"},
    command = "cj40so",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    candemote = false, 
    PlayerSpawn = function(ply) 
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Raphaël(Cosmos)", 
    CustomCheckFailMsg = "Vous n'êtes pas propriétaire du Job"         
})

TEAM_CJ40E = DarkRP.createJob("Escouade Germa", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/ncrreddeathranger/RedDeathRanger/Red_Death_Ranger.mdl"},
    description = [[Troupe spécialisée dans la gestion stratégique, informatique et électronique.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","riot_shield","weapon_extinguisher","parkourmod","heavy_shield"},
    command = "cj40e",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Raphaël(Cosmos)",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

--TEAM_CJ41 = DarkRP.createJob("SCP-903-CC", {
--    color = Color(125, 50, 224, 255),
--    model = {
--    "models/mailer/characters/bladewolf.mdl"
--    },
  --  description = [[]],
    --weapons = {"clone_card_c3", "weapon_dogswep"},
    --command = "cj41",
 --   max = 1,
 --   salary = 150,
  --  admin = 0,
--   vote = false,
 --   hasLicense = false,
 --   candemote = false,
 --   PlayerSpawn = function(ply)
  --      ply:SetJumpPower(190)
  --      ply:SetRunSpeed(250)
 --       ply:SetHealth(999999999)
  --      ply:SetMaterial("")end,
 --   category = "Jobs personnalisés",
 --    customJob = true,
  --  ownerName= "Akaraa",
  --  customCheck = function(ply) return
 --       table.HasValue({"STEAM_0:0:71759595"}, ply:SteamID())
 --   end,
 --   CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
--})

TEAM_CJ43 = DarkRP.createJob("SCP-023-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/jokergirl/jokergirl.mdl"
    },
    description = [[]],
    weapons = {"med_kit_advanced","weapon_noclip","ae_superfists"},
    command = "cj43",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(1500)
        ply:SetArmor(800)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "X-989",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:522259054"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

/*

TEAM_CJ44 = DarkRP.createJob("SCP-5641-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/thresh/thresh.mdl"
    },
    description = [[]],
    weapons = {"tfa_ins2_minimi","ae_superfists","tfa_nmrih_sledge","","defibrillator_advanced"},
    command = "cj44",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(1500)
        ply:SetArmor(800)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Axel Moaji",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:536168362"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

*/

TEAM_CJ45 = DarkRP.createJob("SCP-107-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/player/charple.mdl"
    },
    description = [[]],
    weapons = {"weapon_camo","weapon_scp939","weapon_752_m2_flamethrower"},
    command = "cj45",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "SCP-107",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:514228404","STEAM_0:1:464090508"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

/*
TEAM_CJ47 = DarkRP.createJob("Nami", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/player/R6S_Ela.mdl"
    },
    description = [[]],
    weapons = {"tfa_nmrih_kknife","parkourmod","stunstick","stungun",
    "weapon_flashlight","weapon_r_handcuffs","ae_superfists","tfa_ins2_vector","tfa_ins2_m590o","weapon_healvial","weapon_752_m2_flamethrower","clone_card_c4","weapon_flashlight"},
    command = "cj47",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetArmor(200)
        ply:SetHealth(200)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Nami",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:547911340"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})
*/

/*

TEAM_CJ48 = DarkRP.createJob("SCP-2256-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/mailer/wow_characters/wowanim_naga_male.mdl"
    },
    description = [[]],
    weapons = {"weapon_752_m2_flamethrower","weapon_scp_011_fr","blink","weapon_camo"},
    command = "cj48",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(6000)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Chercheur N James",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:86154944"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

*/

TEAM_CJ49 = DarkRP.createJob("SCP-490-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/kuma96/darksouls2/blackdragon/blackdragon_pm.mdl"
    },
    description = [[]],
    weapons = {"weapon_752_m2_flamethrower","weapon_scp_011_fr","ae_superfists","weapon_camo"},
    command = "cj49",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(9999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Moha Moaji",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:553525209","STEAM_0:0:536168362"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


TEAM_CJ50 = DarkRP.createJob("SCP-109-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/Revenant.mdl"
    },
    description = [[]],
    weapons = {"weapon_scp049","weapon_scp939","cross_arms_infront_swep"},
    command = "cj50",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(9999999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "SCP-109",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:561927051"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


/*
TEAM_CJ51 = DarkRP.createJob("SCP-108-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/player/dewobedil/chucky/chucky.mdl"
    },
    description = [[]],
    weapons = {"blink","weapon_scp939","weapon_camo"},
    command = "cj51",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(9999999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "SCP-108",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:464090508","STEAM_0:1:113766562"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})
*/

/*
TEAM_CJ52 = DarkRP.createJob("SCP-110-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/it/pennywise/pennywisev3/player/pennywisev3_player.mdl"
    },
    description = [[]],
    weapons = {"blink","weapon_scp096","weapon_camo"},
    command = "cj52",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(9999999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "SCP-110",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:464090508","STEAM_0:0:539061843"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})
*/

TEAM_CJ53 = DarkRP.createJob("SCP-769-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/Novux/023/Novux_SCP-023.mdl"
    },
    description = [[]],
    weapons = {"weapon_scp_011_fr","weapon_noclip","weapon_camo"},
    command = "cj53",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(900)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Hassani",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:198204295","STEAM_0:0:193945137","STEAM_0:0:457619553"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ54 = DarkRP.createJob("SCP-964-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/player/malacore/swtor_tulak_pm/swtor_tulak.mdl"
    },
    description = [[]],
    weapons = {"tfa_ins2_vector","weapon_noclip","couteau","weapon_camo","blink"},
    command = "cj54",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(999999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "l’occulteur",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:169740818"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ55 = DarkRP.createJob("SCP-509-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/player/reverse/savitar/savitar.mdl"
    },
    description = [[]],
    weapons = {"weapon_camo","weapon_scp096","blink","weapon_noclip"},
    command = "cj55",
    max = 4,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(999999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Moha",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:553525209","STEAM_0:0:536168362","STEAM_0:0:553680538","STEAM_0:1:499744543"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


TEAM_CJ56 = DarkRP.createJob("SCP-079-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/props/de_inferno/goldfish.mdl"
    },
    description = [[]],
    weapons = {"weapon_scp_011_fr"},
    command = "cj56",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    modelScale = 1.5,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(100)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Alex",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:184126955","STEAM_0:1:506406261"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


TEAM_CJ58 = DarkRP.createJob("Les Liches", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/player/dementor.mdl"
    },
    description = [[]],
    weapons = {"weapon_scp049","defibrillator_advanced"},
    command = "cj58",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    modelScale = 1.2,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(999999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Mya Krastof & Gaia Blazak",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:196219013","STEAM_0:0:98519308"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

/*
TEAM_CJ59 = DarkRP.createJob("SCP-111-CC", {
    color = Color(125, 50, 224, 255),
   model = {
    "models/kory/animals/lizard.mdl"
    },
    description = [[]],
    weapons = {"scp_939","weapon_camo","blink","cscp_999", "weapon_scp_011_fr"},
    command = "cj59",
    max = 4,
    salary = 150,
    admin = 0,
    vote = false,
    modelScale = 1.5,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(999999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "SCP-111",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:464090508","STEAM_0:0:528819541","STEAM_0:1:464090508","STEAM_0:0:528819541"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})
*/

TEAM_CJ60O = DarkRP.createJob("Opérateur Delta", {
    color = Color(125, 50, 224, 255),
    model = {"models/scp_mtf_russian/mtf_rus_02.mdl"},
    description = [[Escouade Spécialisé dans la recherche, la traque et l'interrogatoire d'individus visé ou contre la fondation.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","weapon_extinguisher","riot_shield","parkourmod"},
    command = "cj60o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Apoly",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:96367873"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ60SO = DarkRP.createJob("Sous-Opérateur Delta", {
    color = Color(125, 50, 224, 255),
    model = {"models/scp_mtf_russian/mtf_rus_02.mdl"},
    description = [[Escouade Spécialisé dans la recherche, la traque et l'interrogatoire d'individus visé ou contre la fondation.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","weapon_extinguisher","riot_shield","parkourmod"},
    command = "cj60so",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Apoly",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ60E = DarkRP.createJob("Escouade Delta", {
    color = Color(125, 50, 224, 255),
    model = {"Models/omonup/rus/gasomon.mdl","Models/omonup/rus/omon_a.mdl","Models/omonup/rus/omon_c.mdl","Models/omonup/rus/omon_d.mdl","Models/omonup/rus/omon_e.mdl","Models/omonup/rus/omon_f.mdl"},
    description = [[Escouade Spécialisé dans la recherche, la traque et l'interrogatoire d'individus visé ou contre la fondation.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","weapon_extinguisher","riot_shield","parkourmod"},
    command = "cj60e",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Apoly",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ61 = DarkRP.createJob("SCP-156-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/kanekimal/kanekimal_koro.mdl"},
    description = [[]],
    weapons = {"ae_superfists","weapon_camo", "weapon_scp_011_fr"},
    command = "cj61",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    modelScale = 0.8,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetHealth(1000)
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Kylian",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:460074144"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})



TEAM_CJ54bis = DarkRP.createJob("SCP-2318-CC", {
    color = Color(125, 50, 224, 255),
    model = {
    "models/suno/player/blackburn.mdl"
    },
    description = [[]],
    weapons = {"blink","weapon_camo","weapon_force_fists"},
    command = "cj54bis",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(100)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "L'assasin des neiges",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:462809449"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ62O = DarkRP.createJob("Opérateur UTXA", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/alexghost/triborg_pm/triborg_pm.mdl"},
    description = [[Escouade Spécialisé dans la recherche, la traque et l'interrogatoire d'individus visé ou contre la fondation.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","riot_shield"},
    command = "cj62o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "CMO-Hanck",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:118852977"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ62E = DarkRP.createJob("Escouade UTXA", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/t-882/t882.mdl"},
    description = [[Escouade Spécialisé dans la recherche, la traque et l'interrogatoire d'individus visé ou contre la fondation.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","riot_shield"},
    command = "cj62e",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "CMO-Hanck",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ63 = DarkRP.createJob("SCP-2006-CC (Le Daedra)", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/daedric.mdl"},
    description = [[]],
    weapons = {"weapon_mse_katana","weapon_752_m2_flamethrower","ae_superfists","weapon_dawnnope_sword"},
    command = "cj63",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "ZTS-SGT-UT Valentin{Charlie}",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:127811769"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


TEAM_CJ64 = DarkRP.createJob("SCP-520-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/mailer/characters/tesv_nightingale.mdl"},
    description = [[]],
    weapons = {"weapon_mse_katana","weapon_camo","blink","weapon_ninjaskunai","tfa_xiandagger","katana_sao","ae_superfists"},
    command = "cj64",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Mélios (D-3548)",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:124966713"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ65 = DarkRP.createJob("SCP-8-108-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/tfa_bc_mysteriousstranger.mdl"},
    description = [[]],
    weapons = {"ae_superfists","weapon_camo","weapon_noclip"},
    command = "cj65",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "fri frize",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:492612094"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ66 = DarkRP.createJob("SCP-4751-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/korka007/momiji.mdl"},
    description = [[]],
    weapons = {"weapon_scp_011_fr"},
    command = "cj66",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(1000)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Julien Escobar",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:196290606"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ67 = DarkRP.createJob("SCP-484-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/Lenoax_Natalie.mdl"},
    description = [[]],
    weapons = {"weapon_noclip","weapon_mse_katana","weapon_healvial","weapon_bur_magic","clone_card_c3","swep_flamethrower_d2k","swep_flamethrower_d2k","weapon_camo"},
    command = "cj67",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(99999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Sarah Snow",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:501523256"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ68O = DarkRP.createJob("Opérateur NightHawks", {
    color = Color(125, 50, 224, 255),
    model = {"models/payday2/units/russian_cloaker_player.mdl"},
    description = [[Escouade d'assaut furtife et de capture de VIP]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","tfa_l4d2_ctm200","parkourmod"},
    command = "cj68o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Sergent Charles",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:564189951"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ68SO = DarkRP.createJob("Sous-Opérateur NightHawks", {
    color = Color(125, 50, 224, 255),
    model = {"models/payday2/units/russian_cloaker_player.mdl"},
    description = [[Escouade d'assaut furtife et de capture de VIP]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","tfa_l4d2_ctm200","parkourmod"},
    command = "cj68so",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Sergent Charles",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ68E = DarkRP.createJob("Escouade NightHawks", { 
    color = Color(125, 50, 224, 255),
    model = {"models/kuma96/gta5_specops/gta5_specops_pm.mdl"},
    description = [[Escouade d'assaut furtife et de capture de VIP]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","tfa_l4d2_ctm200","parkourmod"},
    command = "cj68e",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Sergent Charles",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ69O = DarkRP.createJob("Opérateur U.A", {
    color = Color(125, 50, 224, 255),
    model = {"models/mark2580/payday2/pd2_cloaker_zeal_player.mdl"},
    description = [[Escouade d'assaut furtife et de capture de VIP]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","parkourmod","riot_shield","med_kit_advanced","ghosts_minigun","weapon_752_m2_flamethrower"},
    command = "cj69o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Invaders",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:63552310"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ69E = DarkRP.createJob("Escouade U.A", { 
    color = Color(125, 50, 224, 255),
    model = {"models/kuma96/gta5_splintercell/gta5_splintercell_pm.mdl"},
    description = [[Escouade d'assaut furtife et de capture de VIP]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","parkourmod","riot_shield","med_kit_advanced","ghosts_minigun","weapon_752_m2_flamethrower"},
    command = "cj69e",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Invaders",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ70O = DarkRP.createJob("Opérateur Wolf", {
    color = Color(125, 50, 224, 255),
    model = {"models/hunk_orc.mdl"},
    description = [[L'escouade  Wolf est une escouade discrète  et agressive .]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","parkourmod","riot_shield","med_kit_advanced","defibrillator_advanced","tfa_l4d2_ctm200","weapon_752_m2_flamethrower"},
    command = "cj70o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Wolfiz42",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:527755955"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ70SO = DarkRP.createJob("Sous-Opérateur Wolf", { 
    color = Color(125, 50, 224, 255),
    model = {"models/kuma96/zorskel/zorskel_pm.mdl"},
    description = [[L'escouade  Wolf est une escouade discrète  et agressive .]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","parkourmod","riot_shield","med_kit_advanced","defibrillator_advanced","tfa_l4d2_ctm200","weapon_752_m2_flamethrower"},
    command = "cj70so",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Wolfiz42",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ70E = DarkRP.createJob("Escouade Wolf", { 
    color = Color(125, 50, 224, 255),
    model = {"models/csgosas1pm.mdl","models/csgosas2pm.mdl","models/csgosas3pm.mdl","models/csgosas4pm.mdl"},
    description = [[L'escouade  Wolf est une escouade discrète  et agressive .]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","parkourmod","riot_shield","med_kit_advanced","defibrillator_advanced","tfa_l4d2_ctm200","weapon_752_m2_flamethrower"},
    command = "cj70e",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Wolfiz42",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ71O = DarkRP.createJob("Opérateur Inferno", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/suno/spectre/spectre.mdl"},
    description = [[Escouade d'assaut et de front]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","ghosts_minigun","riot_shield"},
    command = "cj71o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Shotaro",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:545125559"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


TEAM_CJ71SO = DarkRP.createJob("Sous-Opérateur Inferno", { 
    color = Color(125, 50, 224, 255),
    model = {"models/suno/player/dksleezy.mdl"},
    description = [[Escouade d'assaut et de front]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","ghosts_minigun","riot_shield"},
    command = "cj71so",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Shotaro",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})


TEAM_CJ71E = DarkRP.createJob("Escouade Inferno", { 
    color = Color(125, 50, 224, 255),
    model = {"models/suno/player/bulldog.mdl"},
    description = [[Escouade d'assaut et de front]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","ghosts_minigun","riot_shield"},
    command = "cj71e",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Shotaro",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ72O = DarkRP.createJob("Opérateur Mugiwara", {
    color = Color(125, 50, 224, 255),
    model = {"models/blacklist/spy1.mdl","models/blacklist/merc1.mdl"},
    description = [[Escouade d'intervention rapide et légère]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","riot_shield","tfa_l4d2_ctm200"},
    command = "cj72o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "ZTS-CPL-UT Akashi",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:582169920"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ72SO = DarkRP.createJob("Sous-Opérateur Mugiwara", {
    color = Color(125, 50, 224, 255),
    model = {"Models/mw2guy/BZ/bzgb01.mdl"},
    description = [[Escouade d'intervention rapide et légère]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","riot_shield","tfa_l4d2_ctm200"},
    command = "cj72so",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    candemote = false, 
    PlayerSpawn = function(ply) 
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "ZTS-CPL-UT Akashi", 
    CustomCheckFailMsg = "Vous n'êtes pas propriétaire du Job"
})

TEAM_CJ72E = DarkRP.createJob("Escouade Mugiwara", { 
    color = Color(125, 50, 224, 255),
    model = {"Models/CODMW2/CODMW2.mdl","Models/CODMW2/CODMW2H.mdl","Models/CODMW2/CODMW2HE.mdl","Models/CODMW2/CODMW2HEXE.mdl","Models/CODMW2/CODMW2M.mdl","Models/CODMW2/T_CODM.mdl","Models/CODMW2/T_CODMW2.mdl","Models/CODMW2/T_CODMW2H.mdl"},
    description = [[Escouade d'intervention rapide et légère]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","riot_shield","tfa_l4d2_ctm200"},
    command = "cj72e",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "ZTS-CPL-UT Akashi",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ73O = DarkRP.createJob("Opérateur Alpha", {
    color = Color(125, 50, 224, 255),
    model = {"models/steinman/bf4/us_01FIXED.mdl","models/steinman/bf4/us_02FIXED.mdl","models/steinman/bf4/us_03FIXED.mdl","models/steinman/bf4/us_04FIXED.mdl"},
    description = [[escouade spécialisée dans le positionnement stratégique des troupes et dans l’informatique]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "weapon_752_m2_flamethrower", "riot_shield", "defibrillator_advanced", "tfa_l4d2_ctm200", "weapon_extinguisher", "ghosts_minigun"},
    command = "cj73o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "mathislopesdu13",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:561249370"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ73SO = DarkRP.createJob("Sous-Opérateur Alpha", { 
    color = Color(125, 50, 224, 255),
    model = {"models/Dauge/BF3_GIGN.mdl"},
    description = [[escouade spécialisée dans le positionnement stratégique des troupes et dans l’informatique]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "weapon_752_m2_flamethrower", "riot_shield", "defibrillator_advanced", "tfa_l4d2_ctm200", "weapon_extinguisher", "ghosts_minigun"},
    command = "cj73so",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "mathislopesdu13",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ73E = DarkRP.createJob("Escouade Alpha", { 
    color = Color(125, 50, 224, 255),
    model = {"models/Dauge/BF3_GIGN.mdl","models/ninja/mgs4_praying_mantis_merc.mdl", "models/ninja/mgs4_praying_mantis_merc_short_sleeved.mdl",},
    description = [[escouade spécialisée dans le positionnement stratégique des troupes et dans l’informatique]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "weapon_752_m2_flamethrower", "riot_shield", "defibrillator_advanced", "tfa_l4d2_ctm200", "weapon_extinguisher", "ghosts_minigun"},
    command = "cj73e",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "mathislopesdu13",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ74O = DarkRP.createJob("Opérateur Sentinel", {
    color = Color(125, 50, 224, 255),
    model = {"models/kuma96/stealtharmor/stealtharmor_pm.mdl"},
    description = [[Escouade Spécialisée dans tout danger capable de ce répandre]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","riot_shield","weapon_extinguisher","ghosts_minigun","tfa_l4d2_ctm200","weapon_752_m2_flamethrower","defibrillator_advanced","parkourmod","med_kit_advanced"},
    command = "cj74o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "MXD",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:138726885"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ74SO = DarkRP.createJob("Sous-Opérateur Sentinel", { 
    color = Color(125, 50, 224, 255),
    model = {"models/arachnit/wolfenstein2/nazis/nazi_elite_atom_soldier_player.mdl"},
    description = [[Escouade Spécialisée dans tout danger capable de ce répandre]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","riot_shield","weapon_extinguisher","ghosts_minigun","tfa_l4d2_ctm200","weapon_752_m2_flamethrower","defibrillator_advanced","parkourmod","med_kit_advanced"},
    command = "cj74so",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "MXD",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ74E = DarkRP.createJob("Escouade Sentinel", { 
    color = Color(125, 50, 224, 255),
    model = {"models/arachnit/wolfenstein2/nazis/nazi_elite_atom_soldier_player.mdl"},
    description = [[Escouade Spécialisée dans tout danger capable de ce répandre]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","riot_shield","weapon_extinguisher","ghosts_minigun","tfa_l4d2_ctm200","weapon_752_m2_flamethrower","defibrillator_advanced","parkourmod","med_kit_advanced"},
    command = "cj74e",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "MXD",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ75O = DarkRP.createJob("Opérateur GHOSTS", {
    color = Color(125, 50, 224, 255),
    model = {"models/ghost/afgan.mdl","models/ghost/bz.mdl","models/ghost/mw2.mdl","models/ghost/diver.mdl","models/nova prospekt/group22/player/group22scientist.mdl"},
    description = [[rejoignez les meilleurs des meilleurs dès maintenant ! l'escouade ghosts est une escouade d'élite qui n'attend plus que vous alors rejoignez nous !]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "weapon_extinguisher", "weapon_752_m2_flamethrower"},
    command = "cj75o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "cooper standley",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:509720053"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ75SO = DarkRP.createJob("Sous-Opérateur GHOSTS", { 
    color = Color(125, 50, 224, 255),
    model = {"models/ghost/afgan.mdl","models/ghost/bz.mdl","models/ghost/mw2.mdl","models/ghost/diver.mdl","models/nova prospekt/group22/player/group22scientist.mdl"},
    description = [[rejoignez les meilleurs des meilleurs dès maintenant ! l'escouade ghosts est une escouade d'élite qui n'attend plus que vous alors rejoignez nous !]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "weapon_extinguisher", "weapon_752_m2_flamethrower"},
    command = "cj75so",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "cooper standley",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ75E = DarkRP.createJob("Escouade GHOSTS", { 
    color = Color(125, 50, 224, 255),
    model = {"models/jwk987/cod/ghost/keegan.mdl","models/jwk987/cod/ghost/keegan2.mdl","models/jwk987/cod/ghost/logan.mdl","models/jwk987/cod/ghost/Merrick.mdl","models/nova prospekt/group22/player/group22scientist.mdl"},
    description = [[rejoignez les meilleurs des meilleurs dès maintenant ! l'escouade ghosts est une escouade d'élite qui n'attend plus que vous alors rejoignez nous !]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "weapon_extinguisher", "weapon_752_m2_flamethrower"},
    command = "cj75e",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "cooper standley",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ76 = DarkRP.createJob("SCP-6000-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/TrueBobert/IC_Arcane_Harley.mdl"},
    description = [[]],
    weapons = {"weapon_scp_011_fr","weapon_camo","weapon_noclip"},
    command = "cj76",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(99999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Millidium Strice",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:165943576","STEAM_0:1:582886891"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ77 = DarkRP.createJob("SCP-013-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/combine/combinesniper.mdl","models/player/combine_super_soldier.mdl"},
    description = [[]],
    weapons = {"weapon_noclip","weapon_mse_katana","blink","gmod_tool","m9k_harpoon"},
    command = "cj77",
    max = 3,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(99999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Akuta",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:117316058","STEAM_0:1:63552310","STEAM_0:0:36197682"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ78 = DarkRP.createJob("SCP-1012-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/Griesmar_WorkShop/SMP/Penguin/Penguin_Player.mdl"},
    description = [[]],
    weapons = {"cscp_999","weapon_fists"},
    command = "cj78",
    max = 2,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(99999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Vladimir volkov  et Raphaël",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:508318524","STEAM_0:0:553524252"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ79 = DarkRP.createJob("SCP-5478-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/immigrant/outlast/walrider_pm.mdl"},
    description = [[]],
    weapons = {"weapon_noclip","weapon_scp_011_fr","weapon_camo","ae_superfists"},
    command = "cj79",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(99999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Maturi Tsukawi",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:499744543"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ80 = DarkRP.createJob("SCP-X02-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/bobert/AOHarley.mdl"},
    description = [[]],
    weapons = {"weapon_scp_011_fr","blink","weapon_752_m2_flamethrower"},
    command = "cj80",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(99999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Chris Carer",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:179988221"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ81 = DarkRP.createJob("SCP-007-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/terrorblade.mdl"},
    description = [[]],
    weapons = {"weapon_scp_011_fr","weapon_force_fists","weapon_ninjaskunai","clone_card_c3", "weapon_noclip"},
    command = "cj81",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(99999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Jean Hord",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:116860550"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ82 = DarkRP.createJob("SCP 049-J-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/plague_doktor/PLAYER_Plague_Doktor.mdl"},
    description = [[]],
    weapons = {"ae_superfists","m9k_harpoon","weapon_camo"},
    command = "cj82",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(999999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "WIll",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:555803921"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ83O = DarkRP.createJob("Opérateur Overwatch", {
    color = Color(125, 50, 224, 255),
    model = {"models/lb/anarchy_greyhats/scp_greyhats.mdl"},
    description = [[]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "cj83o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Heindrish",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:109849891"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ83SO = DarkRP.createJob("Sous-Opérateur Overwatch", { 
    color = Color(125, 50, 224, 255),
    model = {"models/lb/anarchy_greyhats/scp_greyhats.mdl"},
    description = [[]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "cj83so",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Heindrish",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ83E = DarkRP.createJob("Escouade Overwatch", { 
    color = Color(125, 50, 224, 255),
    model = {"models/lb/anarchy_greyhats/scp_greyhats.mdl"},
    description = [[]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep"},
    command = "cj83e",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Heindrish",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ84O = DarkRP.createJob("Opérateur U.D", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/n7legion/deadspace/legionary_soldier.mdl", "models/player/n7legion/deadspace/legionary_soldier_elite.mdl", "models/player/n7legion/deadspace/legionary_soldier_coop.mdl", 
"models/player/n7legion/deadspace/legionary_soldier_elite_coop.mdl", "models/models/konnie/blackopsmodel/blackopsmodel.mdl",},
    description = [[]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "parkourmod", "weapon_752_m2_flamethrower", "weapon_extinguisher", "ghosts_minigun", "riot_shield", "tfa_l4d2_ctm200","med_kit_advanced","defibrillator_advanced","deployable_shield","heavy_shield"},
    command = "cj84o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Lafleche",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:29812965"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ84SO = DarkRP.createJob("Sous-Opérateur U.D", { 
    color = Color(125, 50, 224, 255),
    model = {"models/player/cancsssp.mdl", "models/player/cancssnp.mdl", "models/player/canCssSoldier.mdl", "models/player/canCssSoldier2.mdl", "models/models/konnie/blackopsmodel/blackopsmodel.mdl",},
    description = [[]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "parkourmod", "weapon_752_m2_flamethrower", "weapon_extinguisher", "ghosts_minigun", "riot_shield", "tfa_l4d2_ctm200","med_kit_advanced","defibrillator_advanced","deployable_shield","heavy_shield"},
    command = "cj84so",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Lafleche",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ84E = DarkRP.createJob("Escouade U.D", { 
    color = Color(125, 50, 224, 255),
    model = {"models/vad36go_fbi/fbi.mdl", "models/models/konnie/blackopsmodel/blackopsmodel.mdl",},
    description = [[]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "parkourmod", "weapon_752_m2_flamethrower", "weapon_extinguisher", "ghosts_minigun", "riot_shield", "tfa_l4d2_ctm200","med_kit_advanced","defibrillator_advanced","deployable_shield","heavy_shield"},
    command = "cj84e",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Lafleche",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ85 = DarkRP.createJob("SCP-1994-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/players/ck_dr3_annie.mdl"},
    description = [[]],
    weapons = {"weapon_scp_011_fr","blink"},
    command = "cj85",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    modelScale = 0.8,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(99999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "La Sorciere",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:197254738"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ86 = DarkRP.createJob("SCP-789-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/dizcordum/reaper.mdl"},
    description = [[]],
    weapons = {"swep_flamethrower_d2k", "weapon_camo", "weapon_scp_011_fr", "weapon_noclip", "weapon_mse_katana",},
    command = "cj86",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(99999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Idora",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:545125559"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ87 = DarkRP.createJob("SCP-232-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/korka007/wick.mdl",},
    description = [[]],
    weapons = { "weapon_mse_katana","m9k_harpoon","weapon_noclip",},
    command = "cj87",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(1000)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Raspace",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:553680538"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ88 = DarkRP.createJob("SCP-314-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/11thdoctor/thedoctor.mdl",},
    description = [[]],
    weapons = {"weapon_noclip","ae_superfists","blink",},
    command = "cj88",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(99999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Arthur",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:531532814"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ89 = DarkRP.createJob("SCP-289-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/mailer/wow_characters/wowanim_sethrak.mdl", "models/mailer/wow_characters/wowanim_sethrak_2.mdl",},
    description = [[]],
    weapons = {"blink", "weapon_752_m2_flamethrower", "weapon_mse_katana", "weapon_noclip", "weapon_camo", "ae_superfists", },
    command = "cj89",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200)
        ply:SetRunSpeed(280)
        ply:SetHealth(99999)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "D-2974",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:77902210"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ90O = DarkRP.createJob("Opérateur Zéta Bulldozer", {
    color = Color(125, 50, 224, 255),
    model = {"models/alphawolf/pd2_bulldozer_player2.mdl","models/juegospablo/payday2/pd2_bulldozer_player.mdl"},
    description = [[Escouade Zeta Bulldozer est l'un des bras arméee du site et un rempart contre les assaillants ou les anomalies.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "parkourmod", "weapon_752_m2_flamethrower", "weapon_extinguisher", "riot_shield", "ghosts_minigun"},
    command = "cj90o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Sethrack",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:77902210"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ90E = DarkRP.createJob("Escouade Zéta Bulldozer", { 
    color = Color(125, 50, 224, 255),
    model = {"models/mark2580/payday2/pd2_bulldozer_zeal_player.mdl"},
    description = [[Escouade Zeta Bulldozer est l'un des bras arméee du site et un rempart contre les assaillants ou les anomalies.]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "parkourmod", "weapon_752_m2_flamethrower", "weapon_extinguisher", "riot_shield", "ghosts_minigun"},
    command = "cj90e",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Sethrack",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ91 = DarkRP.createJob("SCP-745-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/dizcordum/shadowscale_acolyte.mdl"},
    description = [[]],
    weapons = {"katana_sao", "ae_superfists", "blink"},
    command = "cj91",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999)
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Akira",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:479129466"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ92 = DarkRP.createJob("SCP-524-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/players/byzantine_lord.mdl"},
    description = [[]],
    weapons = {"weapon_noclip", "ae_superfists", "weapon_scp_011_fr"},
    command = "cj92",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(1000)
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Mika Belrose",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:537759147"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ93 = DarkRP.createJob("SCP-024-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/steampunkfoster/steampunkfoster_playermodel.mdl"},
    description = [[]],
    weapons = {"weapon_752_m2_flamethrower", "ae_superfists", "scpcouteau"},
    command = "cj93",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999)
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Hiro Hord",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:218374945"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ94O = DarkRP.createJob("Opérateur Cold Navesty", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/dascalamity/blackburn.mdl"},
    description = [[La Cold Navesty est prêt a mourir pour la fondation ]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","riot_shield","weapon_extinguisher","weapon_752_m2_flamethrower","ghosts_minigun",},
    command = "cj94o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Zeubio",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:435932851"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ94E = DarkRP.createJob("Escouade Cold Navesty", { 
    color = Color(125, 50, 224, 255),
    model = {"models/player/btb1.mdl","models/player/btb2.mdl","models/player/btb3.mdl","models/player/btb4.mdl","models/player/btb5.mdl","models/player/btb6.mdl","models/player/btb7.mdl","models/player/btb8.mdl"},
    description = [[La Cold Navesty est prêt a mourir pour la fondation ]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","riot_shield","weapon_extinguisher","weapon_752_m2_flamethrower","ghosts_minigun",},
    command = "cj94e",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Zeubio",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ95O = DarkRP.createJob("Opérateur Myriad", {
    color = Color(125, 50, 224, 255),
    model = {"models/payday2/units/hecu_soldier_player.mdl",},
    description = [[Nous somme une Unité pour les dèconf est les attaque IC]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "weapon_extinguisher", "med_kit_advanced", "ghosts_minigun", "defibrillator_advanced", "tfa_l4d2_ctm200", "weapon_752_m2_flamethrowe"},
    command = "cj95o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Diego Corleon",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:566232755"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ95SO = DarkRP.createJob("Sous-Opérateur Myriad", { 
    color = Color(125, 50, 224, 255),
    model = {"models/player/cell01.mdl", "models/player/cell02.mdl", "models/player/cell03.mdl", "models/player/cell04.mdl", "models/player/cell05.mdl", "models/player/cell06.mdl", "models/player/cell07.mdl", "models/player/cell08.mdl", "models/player/cell09.mdl", "models/player/cell10.mdl", "models/player/cell11.mdl", "models/player/cell12.mdl"},
    description = [[Nous somme une Unité pour les dèconf est les attaque IC]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "weapon_extinguisher", "med_kit_advanced", "ghosts_minigun", "defibrillator_advanced", "tfa_l4d2_ctm200", "weapon_752_m2_flamethrowe"},
    command = "cj95so",
    max = 0,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Diego Corleon",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ95E = DarkRP.createJob("Escouade Myriad", { 
    color = Color(125, 50, 224, 255),
    model = {"models/player/cell01.mdl", "models/player/cell02.mdl", "models/player/cell03.mdl", "models/player/cell04.mdl", "models/player/cell05.mdl", "models/player/cell06.mdl", "models/player/cell07.mdl", "models/player/cell08.mdl", "models/player/cell09.mdl", "models/player/cell10.mdl", "models/player/cell11.mdl", "models/player/cell12.mdl"},
    description = [[Nous somme une Unité pour les dèconf est les attaque IC]],
    weapons = {"clone_card_c3","weapon_flashlight", "tfa_ins2_glock_19", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep", "weapon_extinguisher", "med_kit_advanced", "ghosts_minigun", "defibrillator_advanced", "tfa_l4d2_ctm200", "weapon_752_m2_flamethrowe"},
    command = "cj95e",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
        ply:SetMaterial("")
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Diego Corleon",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ96 = DarkRP.createJob("SCP-1013-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/tsbb/homunculus_loxodontus.mdl"},
    description = [[]],
    weapons = {"weapon_camo","blink","weapon_scp_011_fr"},
    command = "cj96",
    max = 3,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(999999)
        ply:SetArmor(250)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Sasori",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:552549163","STEAM_0:1:439491785","STEAM_0:0:553524252"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ97 = DarkRP.createJob("SCP-1284-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/bobert/Shiva.mdl"},
    description = [[]],
    weapons = {"weapon_scp_011_fr","weapon_camo","weapon_noclip"},
    command = "cj97",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(1000)
        ply:SetArmor(250)
        ply:SetMaterial("")end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Ariana",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:550954635"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ98 = DarkRP.createJob("SCP-777-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/sw_player_ahri_tails.mdl"},
    description = [[]],
    weapons = {"weapon_camo","weapon_scp_011_fr","couteau"},
    command = "cj98",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(1000)
        ply:SetArmor(250)
    end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Taylor Quins",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:549791204"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ99 = DarkRP.createJob("SCP-666-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/pop_ww/dahaka.mdl"},
    description = [[.]],
    weapons = {"ae_superfists","weapon_camo","weapon_noclip"},
    command = "cj99",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(99999999)
        ply:SetArmor(250)
    end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Andrès Monier",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:1:453741620"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ100O = DarkRP.createJob("Opérateur Smoke", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/imc_blisk.mdl"},
    description = [[Escouades d'ingénieurs-mécanos & techniciens spécialistes du confinement et des installations en général.]],
    weapons = {"weapon_hands","stungun","clone_card_c4","weapon_flashlight", "tfa_ins2_m9", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","parkourmod","deployable_shield","weapon_752_m2_flamethrower","defibrillator_advanced","ghosts_minigun","tfa_l4d2_ctm200","med_kit_advanced","weapon_extinguisher"},
    command = "cj100o",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Saku Vinsmoke",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:188505775"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ100E = DarkRP.createJob("Escouade Smoke", {
    color = Color(125, 50, 224, 255),
    model = {"models/ninja/mw2_ruskie_arctic.mdl","models/ninja/mw2_ruskie_airborne.mdl","models/ninja/MW2_Ruskie_Ghillie.mdl"},
    description = [[Escouades d'ingénieurs-mécanos & techniciens spécialistes du confinement et des installations en général.]],
    weapons = {"weapon_hands","stungun","clone_card_c3","weapon_flashlight", "tfa_ins2_m9", "stunstick", "weapon_checker", "stungun", "weapon_r_handcuffs", "salute_swep","parkourmod","deployable_shield","weapon_752_m2_flamethrower","defibrillator_advanced","ghosts_minigun","tfa_l4d2_ctm200","med_kit_advanced","weapon_extinguisher"},
    command = "cj100e",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(150)
        ply:SetHealth(150)
        ply:SetArmor(200)
end,
    category = "Jobs personnalisés",
    customJob = true,
    ownerName= "Saku Vinsmoke",
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

TEAM_CJ101 = DarkRP.createJob("SCP-317-CC", {
    color = Color(125, 50, 224, 255),
    model = {"models/player/suits/male_09_open_waistcoat.mdl"},
    description = [[Gilbert]],
    weapons = {"weapon_noclip","weapon_scp_011_fr","weapon_752_m2_flamethrower"},
    command = "cj101",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerSpawn = function(ply)
        ply:SetJumpPower(190)
        ply:SetRunSpeed(250)
        ply:SetHealth(99999999)
        ply:SetArmor(250)
    end,
    category = "Jobs personnalisés",
     customJob = true,
    ownerName= "Gilbert",
    customCheck = function(ply) return
        table.HasValue({"STEAM_0:0:172741735"}, ply:SteamID())
    end,
    CustomCheckFailMsg = "Vous n'êtes pas le propriétaire du Job"
})

GAMEMODE.DefaultTeam = TEAM_CLASSED
---------------------------------------------------------------------------]]
GAMEMODE.CivilProtection = {
    [TEAM_RESECU_AGENT] = true,
    [TEAM_SECU_AGENT] = true,
    [TEAM_SECU_CAPORAL] = true,
    [TEAM_SECU_CAPORALCHEF] = true,
    [TEAM_SECU_SERGENT] = true,
    [TEAM_SECU_SERGENTCHEF] = true,
    [TEAM_SECU_ADJUDANT] = true,
    [TEAM_SECU_ADJUDANTCHEF] = true,
    [TEAM_SECU_MAJOR] = true,
    [TEAM_SECU_ELEVE] = true,
    [TEAM_SECU_ASPPP] = true,
    [TEAM_SECU_SLTN] = true,
    [TEAM_SECU_LTN] = true,
    [TEAM_SECU_CPT] = true,
    [TEAM_SECU_CMD] = true,
    [TEAM_SECU_LCLN] = true,
    [TEAM_SECU_CLN] = true,
    [TEAM_SECU_GNL] = true,
    [TEAM_SECU_MEDIC] = true,
    [TEAM_SECU_SPEC] = true,
    [TEAM_SECU_MTF] = true,
    [TEAM_SECU_LMTF] = true,
    [TEAM_SECU_UTRLE] = true,
    [TEAM_SECU_UTRLO] = true,
}
--[[---------------------------------------------------------------------------
Jobs that are hitmen (enables the hitman menu)
---------------------------------------------------------------------------]]
DarkRP.addHitmanTeam(TEAM_MOB)

hook.Add("playerGetSalary", "a", function(ply, amount) 
    if ply:GetNWString("usergroup") == "vip" then
      return false, "Vu que vous êtes VIP vous gagnez 2 fois votre salaire !", math.ceil(amount * 2) 
    elseif ply:GetNWString("usergroup") == "vip+"  then
      return false, "Vu que vous êtes VIP+ vous gagnez 3 fois votre salaire !", math.ceil(amount * 3) 
    elseif ply:GetNWString("usergroup") == "legende"  then
      return false, "Vu que vous êtes Légende vous gagnez 5 fois votre salaire !", math.ceil(amount * 5) 
    elseif ply:GetNWString("usergroup") == "cosmique" or ply:IsAdmin()  then
      return false, "Vu que vous êtes Cosmique vous gagnez 6 fois votre salaire !", math.ceil(amount * 6) 
    end 
end)