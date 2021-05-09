CH_Armory_Locker = CH_Armory_Locker or {}
CH_Armory_Locker.Config = CH_Armory_Locker.Config or {}
CH_Armory_Locker.Design = CH_Armory_Locker.Design or {}

-- TEAM CONFIGURATION
CH_Armory_Locker.Config.GovernmentTeams = { -- These are your government teams. They will receive messages of robbery and can access the police locker. Use the actual team name, as shown below.
	"Police Officer",
	"Police Chief",
	"Secret Service",
	"FBI Agent",
	"S.W.A.T",
	"S.W.A.T Sniper",
	"Vault Guard",
	"Mayor" -- THE LAST LINE SHOULD NOT HAVE A COMMA AT THE END. BE AWARE OF THIS WHEN EDITING THIS!
}

CH_Armory_Locker.Config.AllowedTeams = { -- These are the teams that are allowed to rob the armory.
	"Citizen",
	"Gangster",
	"Mob boss",
	"Gun Dealer",
	"Medic",
	"Hobo" -- THE LAST LINE SHOULD NOT HAVE A COMMA AT THE END. BE AWARE OF THIS WHEN EDITING THIS!
}

CH_Armory_Locker.Config.RequiredTeams = { -- These are your government teams that count towards the CH_Armory_Locker.Config.RequiredGovTeams amount.
	"Police Officer",
	"Police Chief",
	"Sheriff",
	"FBI Agent",
	"S.W.A.T",
	"S.W.A.T Sniper" -- THE LAST LINE SHOULD NOT HAVE A COMMA AT THE END. BE AWARE OF THIS WHEN EDITING THIS!
}

-- General Config
CH_Armory_Locker.Config.WeaponsArmoryEnabled = true -- Should the weapon armory for police jobs be enabled or not? true/false option. [Default = true]
CH_Armory_Locker.Config.RetrieveCooldown = 5 -- Amount of minutes between being able to retrieve a weapon from the police armory as a government official. [Default = 5]
CH_Armory_Locker.Config.PoliceKillRobberReward = 1250 -- Amount of money police officers get when killing someone that is lockpicking the armory. [Default = 1250]
CH_Armory_Locker.Config.KillRobberReward = 250 -- Amount of money anyone else get when killing someone that is lockpicking the armory. [Default = 250]

-- Lockpicking Config
CH_Armory_Locker.Config.LockpickTime = 15 -- Amount of seconds to lockpick the armory. [Default = 15]
CH_Armory_Locker.Config.LockpickCooldown = 60 -- Amount of seconds after having lockpicked a door, before being able to lockpick another door. [Default = 60]
CH_Armory_Locker.Config.DoorCooldown = 120 -- Amount of seconds a door is on a cooldown after being lockpicked. The above config still applies for the individual user. [Default = 120]
CH_Armory_Locker.Config.NotifyPolice = true -- Should police jobs be notified when someone has lockpicked the armory and leaves? true/false.
CH_Armory_Locker.Config.RequiredGovTeams = 0 -- Amount of required teams from the CH_Armory_Locker.Config.RequiredTeams table before being able to lockpick. [Default = 3]

-- Display 3D2D Config
CH_Armory_Locker.Config.DisplayHeaderText = true -- Should the text above the armory be displayed?
CH_Armory_Locker.Config.HeaderText = "Police Armory" -- Header text above armory/locker.
CH_Armory_Locker.Config.DistanceToHeader = 1000 -- Distance between player and police locker before the title appears.
CH_Armory_Locker.Config.DistanceToIcons = 500 -- Distance before lockpick/cooldown icons appear.

CH_Armory_Locker.Design.ArmoryHeaderColor = Color( 48, 151, 209, 255 ) -- Header text color (gmodstore blue color)
CH_Armory_Locker.Design.ArmoryHeaderBoarder = Color( 0, 0, 0, 255 ) -- Header text boarder color

-- XP System Support
CH_Armory_Locker.Config.DarkRPLevelSystemEnabled = false -- DARKRP LEVEL SYSTEM BY vrondakis https://github.com/uen/Leveling-System
CH_Armory_Locker.Config.SublimeLevelSystemEnabled = false -- Sublime Levels by HIGH ELO CODERS https://www.gmodstore.com/market/view/6431

CH_Armory_Locker.Config.XPSuccessfulLockpick = 25 -- Amount of experience to give on successfully lockpicking into the armory.

-- DEFAULT ARMORY WEAPONS
--[[ CATEGORIES:
The categories are in place to decide what code is ran upon retrieving an item.
So for example the categories pistol, rifle, shotgun tells the code to give a weapon plus ammo, where the category health tells the code to give the player a certain amount of health based upon the configuration.

As for you adding a new weapon, you should simply use one of the pre-defined categories.
The categories are not displayed anywhere! So if your weapon doesn't technically fit into either of the categories, don't worry, it won't be displayed anywhere.
--]]

CH_Armory_Locker.Weapons = {
	-- Default Weapons
	
	----- M9K Rifles
	{ Weapon = "m9k_ak47", Name = "AK47 Rifle", Desc = "Officially known as the Avtomat Kalashnikova is an assault rifle, developed in the Soviet Union.", Category = "rifle", Model = "models/weapons/w_ak47_m9k.mdl", AmmoType = "m9k_ammo_ar2", AmmoAmt = 60 },
	{ Weapon = "m9k_acr", Name = "ACR Rifle", Desc = "A semi-automatic rifle. Officials of the U.S Army often use this weapon.", Category = "rifle", Model = "models/weapons/w_masada_acr.mdl", AmmoType = "m9k_ammo_ar2", AmmoAmt = 60 },
	{ Weapon = "m9k_m416", Name = "M4-16 Rifle", Desc = "The United States Army's Delta Forco developed the new carbine in the early 1990s in a collaboration with Heckler & Koch.", Category = "rifle", Model = "models/weapons/w_hk_416.mdl", AmmoType = "m9k_ammo_ar2", AmmoAmt = 60 },
	{ Weapon = "m9k_scar", Name = "SCAR Rifle", Desc = "The FN SCAR is a gas-operated (short-stroke gas piston) self-loading rifle with a rotating bolt.", Category = "rifle", Model = "models/weapons/w_fn_scar_h.mdl", AmmoType = "m9k_ammo_ar2", AmmoAmt = 60 },
	
	----- M9K Shotguns
	{ Weapon = "m9k_jackhammer", Name = "Jack Hammer", Desc = "A 12-gauge, blow-forward gas-operated bullpup automatic shotgun.", Category = "shotgun", Model = "models/weapons/w_pancor_jackhammer.mdl", AmmoType = "buckshot", AmmoAmt = 16 },
	{ Weapon = "m9k_ithacam37", Name = "Ithaca M37", Desc = "Pump-action shotgun made in large numbers for the civilian, military, and police markets.", Category = "shotgun", Model = "models/weapons/w_ithaca_m37.mdl", AmmoType = "buckshot", AmmoAmt = 16 },
	{ Weapon = "m9k_mossberg590", Name = "Mossberg", Desc = "The name Mossberg covers an entire family of pump shotguns designed to chamber 3-inch (76 mm) magnum shells.", Category = "shotgun", Model = "models/weapons/w_mossberg_590.mdl", AmmoType = "buckshot", AmmoAmt = 16 },
	
	----- M9K Pistols
	{ Weapon = "m9k_m92beretta", Name = "M29 Baretta", Desc = "A strong semi-automatic pistol from Italy.", Category = "pistol", Model = "models/weapons/w_beretta_m92.mdl", AmmoType = "m9k_ammo_ar2", AmmoAmt = 30 },
	{ Weapon = "m9k_hk45", Name = "HK45-C", Desc = "A very powerful semi-automatic pistol.", Category = "pistol", Model = "models/weapons/w_hk45c.mdl", AmmoType = "m9k_ammo_ar2", AmmoAmt = 30 },
	{ Weapon = "m9k_ragingbull", Name = "Raging Bull", Desc = "In its larger calibers it is marketed as a hunter's sidearm because it is a potent weapon with plenty of stopping power.", Category = "pistol", Model = "models/weapons/w_taurus_raging_bull.mdl", AmmoType = "m9k_ammo_ar2", AmmoAmt = 30 },
	
	----- CW Rifles
	{ Weapon = "cw_g4p_xm8", Name = "XM8", Desc = "A lightweight assault rifle system from the late 1990s to early 2000s. The rifle was designed by German small arms manufacturer Heckler & Koch.", Category = "rifle", Model = "models/weapons/v_cstm_xm8.mdl", AmmoType = "5.56x45MM", AmmoAmt = 60 },
	{ Weapon = "cw_g36gsm", Name = "G36C", Desc = "The G36 is a 5.56×45mm assault rifle, designed in the early 1990s by Heckler & Koch in Germany", Category = "rifle", Model = "models/cw2/gsm/v_gsm_g36c.mdl", AmmoType = "5.56x45MM", AmmoAmt = 60 },
	{ Weapon = "cw_ar15", Name = "AR-15", Desc = "An AR-15 style rifle is a lightweight semi-automatic rifle based on the ArmaLite AR-15 design.", Category = "rifle", Model = "models/cw2/rifles/ar15.mdl", AmmoType = "5.56x45MM", AmmoAmt = 60 },
	{ Weapon = "cw_ak74", Name = "AK-74", Desc = "The AK-74 is an assault rifle developed in the early 1970s by Russian weapons designer Mikhail Kalashnikov to replace the earlier AKM.", Category = "rifle", Model = "models/cw2/rifles/ak74.mdl", AmmoType = "5.45x39MM", AmmoAmt = 60 },
	{ Weapon = "cw_scarh", Name = "SCAR H", Desc = "The FN SCAR is a gas-operated self-loading rifle with a rotating bolt.", Category = "rifle", Model = "models/cw2/rifles/scarh.mdl", AmmoType = "7.62x51MM", AmmoAmt = 60 },
	{ Weapon = "cw_g3a3", Name = "G3A3", Desc = "The G3 is a 7.62×51mm NATO, select-fire battle rifle developed in the 1950s by the German armament manufacturer (Heckler & Koch in collaboration with the Spanish)", Category = "rifle", Model = "models/cw2/rifles/g3a3.mdl", AmmoType = "7.62x51MM", AmmoAmt = 60 },
	{ Weapon = "cw_ump45", Name = "UMP 45", Desc = "The Heckler & Koch UMP is a submachine gun developed and manufactured by Heckler & Koch.", Category = "rifle", Model = "models/cw2/smgs/ump.mdl", AmmoType = ".45 ACP", AmmoAmt = 60 },
	{ Weapon = "cw_mp5", Name = "MP5", Desc = "The MP5 is a 9x19mm Parabellum submachine gun, developed in the 1960s by a team of engineers from the German small arms manufacturer Heckler & Koch GmbH of Oberndorf am Neckar.", Category = "rifle", Model = "models/cw2/smgs/mp5.mdl", AmmoType = "9x19MM", AmmoAmt = 60 },
	{ Weapon = "cw_l85a2", Name = "L85A2", Desc = "Gas-operated assault rifle. The L85 Rifle variant has been the standard issue service rifle of the British Armed Forces since 1987, replacing the L1A1FAL.", Category = "rifle", Model = "models/cw2/rifles/l85a2.mdl", AmmoType = "5.56x45MM", AmmoAmt = 60 },
	{ Weapon = "cw_m14", Name = "M14 EBR", Desc = "The Mk 14 Enhanced Battle Rifle is an American selective fire military designated marksman rifle chambered for the 7.62×51mm NATO cartridge.", Category = "rifle", Model = "models/cw2/rifles/m14.mdl", AmmoType = "7.62x51MM", AmmoAmt = 60 },
	{ Weapon = "cw_m249_official", Name = "M249", Desc = "Formerly designated the M249 Squad Automatic Weapon and formally written as Light Machine Gun, 5.56 mm, M249, is the American adaptation of the Belgian FN Minimi.", Category = "rifle", Model = "models/cw2/machineguns/m249.mdl", AmmoType = "5.56x45MM", AmmoAmt = 60 },
	{ Weapon = "cw_g4p_m16a2", Name = "M16A2", Desc = "Caliber 5.56 mm, M16, is a family of military rifles adapted from the ArmaLite AR-15 rifle for the United States military. The original M16 rifle was a 5.56mm automatic rifle with a 20-round magazine.", Category = "rifle", Model = "models/weapons/v_cstm_m16a4.mdl", AmmoType = "5.56x45MM", AmmoAmt = 60 },
	{ Weapon = "cw_g4p_m16a4", Name = "M16A4", Desc = "Caliber 5.56 mm, M16, is a family of military rifles adapted from the ArmaLite AR-15 rifle for the United States military. The original M16 rifle was a 5.56mm automatic rifle with a 20-round magazine.", Category = "rifle", Model = "models/weapons/v_cstm_m16a4.mdl", AmmoType = "5.56x45MM", AmmoAmt = 60 },
	{ Weapon = "cw_g4p_an94", Name = "AN-94", Desc = "The AN-94 is a rifle of Russian origin. The initials stand for Avtomat Nikonova model of 1994, after its chief designer Gennadiy Nikonov who previously worked on the Nikonov machine gun.", Category = "rifle", Model = "models/weapons/v_cstm_an94.mdl", AmmoType = "5.45x39MM", AmmoAmt = 60 },
	{ Weapon = "cw_g4p_m98b", Name = "Barett M98 Bravo", Desc = "Jump to navigation Jump to search. The Barrett Model 98B (also known as the 98 Bravo) is a bolt-action sniper rifle chambered in .338 Lapua Magnum", Category = "rifle", Model = "models/weapons/v_snip_m98.mdl", AmmoType = "", AmmoAmt = 60 },
	{ Weapon = "cw_g4p_m4a1", Name = "M4A1", Desc = "The M4 carbine is a shorter and lighter variant of the M16A2 assault rifle. The M4 is a 5.56×45mm NATO, air-cooled, Stoner expanding gas system (commonly misidentified as direct impingement)", Category = "rifle", Model = "models/weapons/view/rifles/m4a1.mdl", AmmoType = "5.56x45MM", AmmoAmt = 60 },
	{ Weapon = "cw_g4p_magpul_masada", Name = "Magpul Masada", Desc = "lightweight, modular rifle. Design features from the Armalite AR-18 (short-stroke gas system), the FN SCAR (upper receiver, charging handle location)", Category = "rifle", Model = "models/weapons/v_rif_masada.mdl", AmmoType = "5.56x45MM", AmmoAmt = 60 },

	----- CW Shotguns
	{ Weapon = "cw_m3super90", Name = "M3 Super 90", Desc = "The Benelli M3 is a dual-mode shotgun designed and manufactured by Italian firearms manufacturer Benelli Armi SpA.", Category = "shotgun", Model = "models/weapons/w_cstm_m3super90.mdl", AmmoType = "12 Gauge", AmmoAmt = 60 },
	{ Weapon = "cw_shorty", Name = "Serbu Shorty", Desc = "The Super-Shorty is a compact, stockless, pump-action AOW chambered in 12-gauge, The basic architecture of most of the production models is based on the Mossberg Maverick shotgun", Category = "shotgun", Model = "models/cw2/shotguns/serbu_super_shorty.mdl", AmmoType = "12 Gauge", AmmoAmt = 16 },

	----- CW Pistols
	{ Weapon = "cw_deagle", Name = "Desert Eagle", Desc = "The Desert Eagle is a semi-automatic handgun notable for chambering the largest centerfire cartridge of any magazine-fed, self-loading pistol.", Category = "pistol", Model = "models/cw2/pistols/deagle.mdl", AmmoType = ".50 AE", AmmoAmt = 120 },
	{ Weapon = "cw_p99", Name = "P99", Desc = "The Walther P99 is a semi-automatic pistol developed by the German company Carl Walther GmbH Sportwaffen of Ulm for law enforcement, security forces and the civilian shooting market as a replacement for the Walther P5 and the P88.", Category = "pistol", Model = "models/cw2/pistols/p99.mdl", AmmoType = "", AmmoAmt = 60 },
	{ Weapon = "cw_m1911", Name = "M1911", Desc = "The M1911, also known as the Colt Government is a single-action, semi-automatic, magazine-fed, recoil-operated pistol chambered for the .45 ACP cartridge.", Category = "pistol", Model = "models/weapons/view/pistols/m1911.mdl", AmmoType = "", AmmoAmt = 60 },
	{ Weapon = "cw_mac11", Name = "MAC-11", Desc = "The Ingram MAC-11 is a subcompact machine pistol developed by American gun designer Gordon Ingram at the Military Armament Corporation during the 1970s in Powder Springs, Georgia.", Category = "pistol", Model = "models/weapons/w_cst_mac11.mdl", AmmoType = "cw_ammo_9x17", AmmoAmt = 60 },
	{ Weapon = "cw_g4p_glock17", Name = "Glock 17", Desc = "Designed for professionals, the GLOCK 17 is trusted by law enforcement officers and military personnel around the globe because of its unsurpassed reliability, optimal magazine capacity of 17 rounds.", Category = "pistol", Model = "models/weapons/v_pist_glock17.mdl", AmmoType = "9x19MM", AmmoAmt = 16 },
	{ Weapon = "cw_mr96", Name = "MR96", Desc = "The Manurhin MR-96 appeared as a replacement for the unsuccessful MR93. The main visual differences between the two revolvers is a squared barrel with a vent rib on all but the 3 barrel length, rubber grips, simpler cylinder shield, and more traditional cylinder grooves on MR-96.", Category = "pistol", Model = "models/cw2/pistols/mr96.mdl", AmmoType = ".44 Magnum", AmmoAmt = 60 },
	{ Weapon = "cw_g4p_mp412_rex", Name = "MP-412 REX", Desc = "The MP-412 REX is a Russian double-action/single-action revolver designed by the state-owned Izhevsk Mechanical Plant, with a break-action chamber and an automatic ejector, chambered for the.357 Magnum round.", Category = "pistol", Model = "models/weapons/v_pist_mp412.mdl", AmmoType = "cw_ammo_357magnum", AmmoAmt = 16 },
	
	----- FAS:2 Rifles
	{ Weapon = "fas2_ak12", Name = "AK-12", Desc = "The AK-12 is a Russian assault rifle chambered in 5.45×39mm. It is designed and manufactured by Kalashnikov Concern and is currently the latest of the Russian AK-Pattern series of assault rifles", Category = "rifle", Model = "models/weapons/tfa/_ins2/w/_ak12.mdl", AmmoType = "fas2_ammo_545x39", AmmoAmt = 0 },
	{ Weapon = "fas2_ak47", Name = "AK-47", Desc = "The AK-47, officially known as the Avtomat Kalashnikova, is a gas-operated, 7.62x39mm assault rifle, developed in the Soviet Union by Mikhail Kalashnikov.", Category = "rifle", Model = "models/weapons/w/_rif/_ak47.mdl", AmmoType = "fas2_ammo_762x51", AmmoAmt = 0 },
	{ Weapon = "fas2_ak74", Name = "AK-74", Desc = "The AK-74 is an assault rifle developed in the early 1970s by Russian weapons designer Mikhail Kalashnikov to replace the earlier AKM. It uses a smaller 5.45×39mm cartridge, replacing the 7.62×39mm chambering of earlier Kalashnikov-pattern weapons.", Category = "rifle", Model = "models/weapons/w/_rif/_ak47.mdl", AmmoType = "fas2_ammo_545x39", AmmoAmt = 0 },
	{ Weapon = "fas2_an94", Name = "AN-94", Desc = "Officially known as the Avtomat Kalashnikova is an assault rifle, developed in the Soviet Union.", Category = "rifle", Model = "models/weapons/world/rifles/an94.mdl", AmmoType = "fas2_ammo_545x39", AmmoAmt = 0 },
	{ Weapon = "fas2_famas", Name = "Famas", Desc = "The FAMAS is a bullpup-styled assault rifle designed and manufactured in France by MAS located in Saint-Etienne", Category = "rifle", Model = "models/weapons/w/_rif/_famas.mdl", AmmoType = "fas2_ammo_762x39", AmmoAmt = 0 },
	{ Weapon = "fas2_g36c", Name = "G36C", Desc = "The G36 is a 5.56×45mm assault rifle, designed in the early 1990s by Heckler & Koch in Germany.", Category = "rifle", Model = "models/weapons/w/_hk/_g36c.mdl", AmmoType = "fas2_ammo_762x39", AmmoAmt = 0 },
	{ Weapon = "fas2_g3", Name = "G3A3", Desc = "The G3 is a 7.62×51mm NATO, select-fire battle rifle developed in the 1950s by the German armament manufacturer Heckler & Koch in collaboration with the Spanish", Category = "rifle", Model = "models/weapons/w/_g3a3.mdl", AmmoType = "fas2_ammo_762x51", AmmoAmt = 0 },
	{ Weapon = "fas2_galil", Name = "Galil", Desc = "The Galil is a family of Israeli made automatic rifles designed by Yisrael Galil and Yaacov Lior in the late 1960s, and produced by Israel Military Industries", Category = "rifle", Model = "models/weapons/w/_rif/_galil.mdl", AmmoType = "fas2_ammo_545x39", AmmoAmt = 0 },
	{ Weapon = "fas2_m14", Name = "M14", Desc = "The M14 rifle, officially the United States Rifle, Caliber 7.62 mm, M14, is an American select-fire battle rifle that fires 7.62×51mm NATO ammunition.", Category = "rifle", Model = "models/weapons/w/_snip/_m14sp.mdl", AmmoType = "fas2_ammo_762x51", AmmoAmt = 0 },
	{ Weapon = "fas2_m4a1", Name = "M4A1", Desc = "The M4 carbine is a shorter and lighter variant of the M16A2 assault rifle. The M4 is a 5.56×45mm", Category = "rifle", Model = "models/weapons/w/_rif/_m4a1.mdl", AmmoType = "fas2_ammo_762x39", AmmoAmt = 0 },
	{ Weapon = "fas2_rpk", Name = "RPK-74", Desc = "The RPK is a 7.62×39mm light machine gun of Soviet design, developed by Mikhail Kalashnikov in the early 1960s, parallel with the AKM assault rifle", Category = "rifle", Model = "models/weapons/w/_rif/_ak47.mdl", AmmoType = "fas2_ammo_762x39", AmmoAmt = 0 },
	{ Weapon = "fas2_rk95", Name = "RK-95", Desc = "The RK 95 TP, commercially known as the M95, is a 7.62×39mm Finnish assault rifle adopted in relatively small numbers by the Finnish Defence Forces in the 1990s", Category = "rifle", Model = "models/weapons/world/rifles/rk95.mdl", AmmoType = "fas2_ammo_762x39", AmmoAmt = 0 },
	{ Weapon = "fas2_sg550", Name = "SG 550", Desc = "The SG 550 is an assault rifle manufactured by Swiss Arms AG in Switzerland.", Category = "rifle", Model = "models/weapons/w/_sg550.mdl", AmmoType = "fas2_ammo_762x39", AmmoAmt = 0 },
	{ Weapon = "fas2_sg552", Name = "SG 552", Desc = "The SIG-552 Commando is the most compact model in the SIG-550 range of Swiss assault rifles", Category = "rifle", Model = "models/weapons/w/_rif/_sg552.mdl", AmmoType = "fas2_ammo_762x39", AmmoAmt = 0 },

	----- FAS:2 Shotguns
	{ Weapon = "fas2_ks23", Name = "KS 23", Desc = "The KS-23 is a Russian shotgun, although because it uses a rifled barrel it is officially designated by the Russian military as a carbine. KS stands for Karabin Spetsialniy.", Category = "shotgun", Model = "models/weapons/world/shotguns/ks23.mdl", AmmoType = "fas2_ammo_762x39", AmmoAmt = 0 },
	{ Weapon = "fas2_m3s90", Name = "Bennelli M3 Super 90", Desc = "The Benelli M3 is a dual-mode shotgun designed and manufactured by Italian firearms manufacturer Benelli Armi SpA.", Category = "shotgun", Model = "models/weapons/w/_shot/_m3super90.mdl", AmmoType = "fas2_ammo_12gauge", AmmoAmt = 0 },
	{ Weapon = "fas2_rem870", Name = "Remington 870", Desc = "The Remington Model 870 is a pump-action shotgun manufactured by Remington Arms Company, LLC.", Category = "shotgun", Model = "models/weapons/w/_remington/_870/_tact.mdl", AmmoType = "fas2_ammo_12gauge", AmmoAmt = 0 },
	{ Weapon = "fas2_toz34", Name = "Toz-34", Desc = "TOZ-34 is produced and sold by Tulsky Oruzheiny Zavod since 1964. In 1965, the shotgun was awarded the golden medal of the Leipzig Trade Fair. In 1970, TOZ-34 received the State quality mark of the USSR.", Category = "shotgun", Model = "models/weapons/world/rifles/ak12.mdl", AmmoType = "fas2_ammo_12gauge", AmmoAmt = 0 },

	----- FAS:2 SMG
	{ Weapon = "fas2_uzi", Name = "Uzi", Desc = "The Uzi is a family of Israeli open-bolt, blowback-operated submachine guns.", Category = "smg", Model = "models/weapons/w_uzi_imi.mdl", AmmoType = "fas2_ammo_9x19", AmmoAmt = 0 },
	{ Weapon = "fas2_mp5a5", Name = "MP5A5", Desc = "The MP5 is a 9x19mm Parabellum submachine gun, developed in the 1960s by a team of engineers from the German small arms manufacturer Heckler & Koch GmbH.", Category = "smg", Model = "models/weapons/w_smg_mp5.mdl", AmmoType = "fas2_ammo_9x19", AmmoAmt = 0 },
	{ Weapon = "fas2_mp5k", Name = "MP5K", Desc = "The MP5 is a 9x19mm Parabellum submachine gun, developed in the 1960s by a team of engineers from the German small arms manufacturer Heckler & Koch GmbH.", Category = "smg", Model = "models/weapons/w_smg_mp5.mdl", AmmoType = "fas2_ammo_9x19", AmmoAmt = 0 },
	{ Weapon = "fas2_mp5sd6", Name = "MP5SD6", Desc = "The MP5 is a 9x19mm Parabellum submachine gun, developed in the 1960s by a team of engineers from the German small arms manufacturer Heckler & Koch GmbH.", Category = "smg", Model = "models/weapons/w_smg_mp5.mdl", AmmoType = "fas2_ammo_9x19", AmmoAmt = 0 },
	{ Weapon = "fas2_pp19", Name = "PP Bizon-19", Desc = "The Bizon is a 9mm submachine gun developed in 1993 at Izhmash by a team of engineers headed by Victor Kalashnikov.", Category = "smg", Model = "models/weapons/w_pp19_bizon.mdl", AmmoType = "fas2_ammo_9x18", AmmoAmt = 0 },

	----- FAS:2 Pistols
	{ Weapon = "fas2_glock20", Name = "Glock 20", Desc = "The Glock is a series of polymer-framed, short recoil-operated, locked-breech semi-automatic pistols designed and produced by Austrian manufacturer Glock Ges.m.b.H. It entered Austrian military and police service by 1982 after it was the top performer in reliability and safety tests.", Category = "pistol", Model = "models/weapons/w/_pist/_glock18.mdl", AmmoType = "fas2_ammo_10x25", AmmoAmt = 0 },
	{ Weapon = "fas2_deagle", Name = "Desert Eagle", Desc = "The Desert Eagle is a semi-automatic handgun notable for chambering the largest centerfire cartridge of any magazine-fed, self-loading pistol.", Category = "pistol", Model = "models/weapons/w/_pist/_glock18.mdl", AmmoType = "fas2_ammo_50ae", AmmoAmt = 0 },
	{ Weapon = "fas2_m1911", Name = "M1911", Desc = "The M1911, also known as the Colt Government or Government´, is a single-action, semi-automatic, magazine-fed, recoil-operated pistol chambered for the .45 ACP cartridge. ", Category = "pistol", Model = "models/weapons/w/_pist/_glock18.mdl", AmmoType = "fas2_ammo_45acp", AmmoAmt = 0 },
	{ Weapon = "fas2_ots33", Name = "OTS-33", Desc = "The OTs-33 Pernach is a Russian 9x18 Makarov machine pistol, derived from the 5.45 mm OTs-23 Drotik machine pistol.", Category = "pistol", Model = "models/weapons/w/_pist/_glock18.mdl", AmmoType = "fas2_ammo_9x18", AmmoAmt = 0 },
	{ Weapon = "fas2_p226", Name = "P226", Desc = "The SIG Sauer P226 is a full-sized, service-type pistol made by SIG Sauer. This model is sold with a choice of four chambers to choose from: the 9×19mm Parabellum, .40 S&W, .357 SIG, or .22 Long Rifle.", Category = "pistol", Model = "models/weapons/w/_pist/_glock18.mdl", AmmoType = "fas2_ammo_357sig", AmmoAmt = 0 },
	{ Weapon = "fas2_ragingbull", Name = "Raging Bull", Desc = "The Raging Bull is a revolver manufactured by the Brazilian Taurus International firearm company.", Category = "pistol", Model = "models/weapons/w/_pist/_glock18.mdl", AmmoType = "fas2_ammo_454casull", AmmoAmt = 0 },

	----- Ammo
	{ Weapon = "ammo_pistol", Name = "Pistol Rounds", Desc = "Pistol ammunition.", Category = "ammo", Model = "models/Items/357ammo.mdl", AmmoType = "pistol", AmmoAmt = 50 },
	{ Weapon = "ammo_buckshot", Name = "Buckshots", Desc = "Shotgun & Pump-shotun ammunition.", Category = "ammo", Model = "models/Items/BoxBuckshot.mdl", AmmoType = "buckshot", AmmoAmt = 24 },
	{ Weapon = "ammo_smg1", Name = "SMG Rounds", Desc = "Submachine gun ammunition.", Category = "ammo", Model = "models/Items/BoxMRounds.mdl", AmmoType = "smg1", AmmoAmt = 25 },
	{ Weapon = "ammo_ar2", Name = "Rifle Rounds", Desc = "Automatic & semi-automatic rifle ammunition.", Category = "ammo", Model = "models/Items/BoxSRounds.mdl", AmmoType = "ar2", AmmoAmt = 50 },
	{ Weapon = "ammo_rpg", Name = "RPG Rounds", Desc = "Rocket Launcher ammunition.", Category = "ammo", Model = "models/weapons/w_missile_closed.mdl", AmmoType = "rpg_round", AmmoAmt = 2 },
	
	----- Health
	{ Weapon = "health_50", Name = "Health Kit", Desc = "This medkit partly restores your health when used.", Category = "health", Model = "models/craphead_scripts/ocrp2/props_meow/weapons/w_medpack.mdl", AmmoType = "none", AmmoAmt = 50 },
	{ Weapon = "health_75", Name = "Health Kit", Desc = "This medkit partly restores your health when used.", Category = "health", Model = "models/craphead_scripts/ocrp2/props_meow/weapons/w_medpack.mdl", AmmoType = "none", AmmoAmt = 75 },
	{ Weapon = "health_100", Name = "Health Kit", Desc = "This medkit fully restores your health when used.", Category = "health", Model = "models/craphead_scripts/ocrp2/props_meow/weapons/w_medpack.mdl", AmmoType = "none", AmmoAmt = 100 },
	
	----- Armor
	{ Weapon = "armor_100", Name = "Full Body Armor", Desc = "Protective clothing designed to absorb or deflect physical attacks.", Category = "armor", Model = "models/Items/combine_rifle_ammo01.mdl", AmmoType = "none", AmmoAmt = 100 },
	{ Weapon = "armor_50", Name = "Half Armor", Desc = "Protective clothing designed to absorb or deflect physical attacks.", Category = "armor", Model = "models/Items/combine_rifle_ammo01.mdl", AmmoType = "none", AmmoAmt = 50 },
	
}

CH_Armory_Locker.Config.UseJobRestrictions = true -- Should the restriction system be enabled?
CH_Armory_Locker.Config.HideRestrictedItems = false -- Enable this if you want to hide items that are restricted to another job than the players.

CH_Armory_Locker.TeamCategories = CH_Armory_Locker.TeamCategories or {}
-- You are supposed to use team actual names such as "Citizen" and not TEAM_CITIZEN. After the last team there should NOT be a comma!
---- General

CH_Armory_Locker.TeamCategories[ "ammo_pistol" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "ammo_buckshot" ] = 	{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "ammo_smg1" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "ammo_ar2" ] = 		{ "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "ammo_rpg" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "health_50" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "health_75" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "health_100" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "armor_100" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "armor_50" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }

---- M9K Weapons
CH_Armory_Locker.TeamCategories[ "m9k_ak47" ] = 		{ "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "m9k_acr" ] = 			{ "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "m9k_m416" ] = 		{ "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "m9k_scar" ] = 		{ "Police Chief", "SWAT", "Secret Service" }
---- Pistols
CH_Armory_Locker.TeamCategories[ "m9k_m92beretta" ] = 	{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "m9k_hk45" ] = 		{ "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "m9k_ragingbull" ] = 	{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
---- Shotguns
CH_Armory_Locker.TeamCategories[ "m9k_jackhammer" ] = 	{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "m9k_ithacam37" ] = 	{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "m9k_mossberg590" ] = 	{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
---- CW Weapons
---- Rifles
CH_Armory_Locker.TeamCategories[ "cw_g4p_xm8" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_g36gsm" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_ar15" ] = 			{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_ak74" ] = 			{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_scarh" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_g3a3" ] = 			{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_ump45" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_mp5" ] = 			{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_l85a2" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_m14" ] = 			{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_m249_official" ] = { "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_g4p_m16a2" ] = 	{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_g4p_m16a4" ] = 	{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_g4p_an94" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_g4p_m98b" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_g4p_m4a1" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_g4p_magpul_masada" ] = { "Police Officer", "Police Chief", "SWAT", "Secret Service" }
---- Shotguns
CH_Armory_Locker.TeamCategories[ "cw_m3super90" ] = 	{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_shorty" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
---- Pistols
CH_Armory_Locker.TeamCategories[ "cw_deagle" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_p99" ] = 			{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_m1911" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_mac11" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_g4p_glock17" ] = 	{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_mr96" ] = 			{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "cw_g4p_mp412_rex" ] = { "Police Officer", "Police Chief", "SWAT", "Secret Service" }
---- FAS:2 Weapons
---- Rifles
CH_Armory_Locker.TeamCategories[ "fas2_ak12" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_ak47" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_ak74" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_an94" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_famas" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_g36c" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_g3" ] = 			{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_galil" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_m14" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_m4a1" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_rpk" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_rk95" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_sg550" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_sg552" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
---- Shotguns
CH_Armory_Locker.TeamCategories[ "fas2_ks23" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_m3s90" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_rem870" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_toz34" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
---- SMG
CH_Armory_Locker.TeamCategories[ "fas2_uzi" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service"}
CH_Armory_Locker.TeamCategories[ "fas2_mp5a5" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_mp5k" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_mp5sd6" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_pp19" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
---- Pistols
CH_Armory_Locker.TeamCategories[ "fas2_glock20" ] = 	{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_deagle" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_m1911" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_ots33" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_p226" ] = 		{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }
CH_Armory_Locker.TeamCategories[ "fas2_ragingbull" ] = 	{ "Police Officer", "Police Chief", "SWAT", "Secret Service" }