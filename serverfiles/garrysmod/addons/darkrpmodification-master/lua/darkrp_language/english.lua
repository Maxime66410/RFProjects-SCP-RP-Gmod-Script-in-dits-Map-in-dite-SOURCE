 /*---------------------------------------------------------------------------
English (example) language file
---------------------------------------------------------------------------

This is the english language file. The things on the left side of the equals sign are the things you should leave alone
The parts between the quotes are the parts you should translate. You can also copy this file and create a new language.

= Warning =
Sometimes when DarkRP is updated, new phrases are added.
If you don't translate these phrases to your language, it will use the English sentence.
To fix this, join your server, open your console and enter darkp_getphrases yourlanguage
For English the command would be:
	darkrp_getphrases "en"
because "en" is the language code for English.

You can copy the missing phrases to this file and translate them.

= Note =
Make sure the language code is right at the bottom of this file

= Using a language =
Make sure the convar gmod_language is set to your language code. You can do that in a server CFG file.
---------------------------------------------------------------------------*/

local my_language = {
	-- Admin things
	need_admin = "Vous devez etre un admin pour faire la commande %s",
	need_sadmin = "Vous devez etre un Fondateur pour faire la commande %s",
	no_privilege = "Vous n'avez pas le rang requis",
	no_jail_pos = "Il n'y a pas de prison",
	invalid_x = "Invalide %s! %s",

	-- F1 menu
	f1ChatCommandTitle = "Chat commandes",
	f1Search = "Recherche ...",

	-- Money things:
	price = "Prix: %s%d",
	priceTag = "Prix: %s",
	reset_money = "%s has reset all players' money!",
	has_given = "%s vous a donné %s",
	you_gave = "Vous avez donné %s %s",
	npc_killpay = "%s pour avoir tué un NPC!",
	profit = "profit",
	loss = "loss",

	-- backwards compatibility
	deducted_x = "Vous avez perdu %s%d",
	need_x = "Besoin de %s%d",

	deducted_money = "Vous avez perdu %s",
	need_money = "Besoin de %s",

	payday_message = "Jour de paye! Vous recevez %s!",
	payday_unemployed = "Vous ne recevez rien car vous n'avez pas de salaire!",
	payday_missed = "Jour de paye manqué! (Vous etes en prison)",

	property_tax = "Taxe habitation: %s",
	property_tax_cant_afford = "You couldn't pay the taxes! Your property has been taken away from you!",
	taxday = "Tax Day! %s%% of your income was taken!",

	found_cheque = "You have found %s%s in a cheque made out to you from %s.",
	cheque_details = "This cheque is made out to %s.",
	cheque_torn = "You have torn up the cheque.",
	cheque_pay = "Pay: %s",
	signed = "Signed: %s",

	found_cash = "Vous avez trouvé %s%d!", -- backwards compatibility
	found_money = "Vous avez trouvé %s!",

	owner_poor = "The %s owner is too poor to subsidize this sale!",

	-- Police
	wanted = "Rechercher par la police!\nRaison: %s",
	youre_arrested = "Vous avez été arreté pendant %d secondes!",
	youre_arrested_by = "Vous avez été arreté par %s.",
	youre_unarrested_by = "Vous avez été libéré par %s.",
	hes_arrested = "%s a été arreté pour %d secondes!",
	hes_unarrested = "%s est sortis de prison!",
	warrant_ordered = "%s a mis un mandat sur %s. Raison: %s",
	warrant_request = "%s demande un mandat sur %s\nRaison: %s",
	warrant_request2 = "Votre demande a été envoyé au Maire %s!",
	warrant_approved = "Demande de mandat approuvé pour %s!\nRaison: %s\nOrdered par: %s",
	warrant_approved2 = "Vous avez maintenant le droit de fouillez sa maison.",
	warrant_denied = "Le maire %s a refusé votre demande de mandat.",
	warrant_expired = "La demande de mandat pour %s a expiré!",
	warrant_required = "Vous avez besoin d'un mandat pour ouvrir cette porte.",
	warrant_required_unfreeze = "Vous avez besoin d'un mandat.",
	warrant_required_unweld = "Vous avez besoin d'un mandat.",
	wanted_by_police = "%s est recherché par la police!\nRaison: %s\nOrdered par: %s",
	wanted_by_police_print = "%s a mis un avis de recherche sur %s, raison: %s",
	wanted_expired = "%s n'est plus recherché.",
	wanted_revoked = "%s n'est plus recherché.\nEnlevé par: %s",
	cant_arrest_other_cp = "Vous ne pouvez arreter d'autre policier!",
	must_be_wanted_for_arrest = "The player must be wanted in order to be able to arrest them.",
	cant_arrest_fadmin_jailed = "You cannot arrest a player who has been jailed by an admin.",
	cant_arrest_no_jail_pos = "Vous ne pouvez pas arreter quelqu'un tant qu'il n'y a pas de prison!",
	cant_arrest_spawning_players = "You cannot arrest players who are spawning.",

	suspect_doesnt_exist = "Le suspect n'existe pas.",
	actor_doesnt_exist = "L'auteur n'existe pas.",
	get_a_warrant = "obtenir un mandat",
	make_someone_wanted = "mettre un avis de recherche",
	remove_wanted_status = "enlever un avis de recherche",
	already_a_warrant = "Le suspect a deja un mandat sur lui.",
	already_wanted = "Le suspect est déja recherché.",
	not_wanted = "Le suspect n'est pas recherché.",
	need_to_be_cp = "Vous devez être policier.",
	suspect_must_be_alive_to_do_x = "Le suspect doit etre vivant %s.",
	suspect_already_arrested = "Le suspect est déja en prison.",

	-- Players
	health = "Vie: %s",
	job = "Métier: %s",
	salary = "Salaire: %s%s",
	wallet = "Argent: %s%s",
	weapon = "Arme: %s",
	kills = "Tué: %s",
	deaths = "Mort: %s",
	rpname_changed = "%s à changer son nom pour %s",
	disconnected_player = "Joueur déconnecté",

	-- Teams
	need_to_be_before = "Vous devez etes %s avant de devenir %s",
	need_to_make_vote = "Vous avez besoin de faire un vote pour devenir %s!",
	team_limit_reached = "Vous ne pouvez pas devenir %s, il y en as trop",
	wants_to_be = "%s\nveux être\n%s",
	has_not_been_made_team = "%s n'est pas devenu %s!",
	job_has_become = "%s a changé d'emploi",


	-- Disasters
	meteor_approaching = "ATTENTION! Une tempete approche! Cachez vous",
	meteor_passing = "La tempete est passé.",
	meteor_enabled = "Tempete activé.",
	meteor_disabled = "La tempete a disparu.",
	earthquake_report = "Tremblement de terre d'une magnitude de %sMw",
	earthtremor_report = "Tremblement de terre de magnetude %sMw",

	-- Keys, vehicles and doors
	keys_allowed_to_coown = "Vous avez le droit de devenir co-propriétaire\n(Appuyer sur F2 pour le devenir)\n",
	keys_other_allowed = "Autorisé a co-habiter:",
	keys_allow_ownership = "(Appuyer sur F2 pour autorisé ou non l'achat)",
	keys_disallow_ownership = "(Press Reload with keys or press F2 to disallow ownership)",
	keys_owned_by = "Propriétaire:",
	keys_unowned = "Acheter\n(Appuyer sur F2 pour acheter)",
	keys_everyone = "(Appuyer sur F2 pour autorisé l'acces a tout le monde)",
	door_unown_arrested = "You can not own or unown things while arrested!",
	door_unownable = "Cette porte ne peut pas etre acheter!",
	door_sold = "Vous avez vendu cette porte %s",
	door_already_owned = "La porte appartient déja a quelqu'un!",
	door_cannot_afford = "You can not afford this door!",
	door_hobo_unable = "Vous ne pouvez pas avoir de maison en étant un SDF!",
	vehicle_cannot_afford = "You can not afford this vehicle!",
	door_bought = "Vous avez acheté cette porte pour %s%s",
	vehicle_bought = "Vous avez acheté ce véhicule pour %s%s",
	door_need_to_own = "Vous avez besoin d'etre propriétraire pour %s",
	door_rem_owners_unownable = "You can not remove owners if a door is non-ownable!",
	door_add_owners_unownable = "You can not add owners if a door is non-ownable!",
	rp_addowner_already_owns_door = "%s possede deja cette porte!",
	add_owner = "Ajouter un propriétaire",
	remove_owner = "Enlever un propriétaire",
	coown_x = "Co-propriétaire %s",
	allow_ownership = "Autorisé l'achat",
	disallow_ownership = "Ne pas autorisé l'achat",
	edit_door_group = "Porte de groupe",
	door_groups = "Porte de groupe",
	door_group_doesnt_exist = "Le groupe n'existe pas!",
	door_group_set = "La porte appartient maintenant a un groupe.",
	sold_x_doors_for_y = "Vous avez vendu %d portes pour %s%d!", -- backwards compatibility
	sold_x_doors = "Vous avez vendu %d portes pour %s!",

	-- Entities
	drugs = "Drogue",
	drug_lab = "Laboratoire de drogue",
	gun_lab = "Labortoire de pistolet",
	gun = "pistolet",
	microwave = "Micro-Onde",
	food = "Nourriture",
	money_printer = "Money Printer",

	sign_this_letter = "Signer la lettre",
	signed_yours = "Votre,",

	money_printer_exploded = "Votre money printer a explosé!",
	money_printer_overheating = "Votre money printer surchauffe !",

	contents = "Contenu: ",
	amount = "Nombre: ",

	picking_lock = "Crochetage",

	cannot_pocket_x = "Vous ne pouvez pas mettre ça dans votre poche!",
	object_too_heavy = "Cette objet est trop gros.",
	pocket_full = "Vos poches sont pleine!",
	pocket_no_items = "Vos poches sont vide.",
	drop_item = "Vous avez ramasser l'objet",

	bonus_destroying_entity = "bonus pour avoir detruit cet ojet illégal.",

	switched_burst = "Switched to burst-fire mode.",
	switched_fully_auto = "Switched to fully automatic fire mode.",
	switched_semi_auto = "Switched to semi-automatic fire mode.",

	keypad_checker_shoot_keypad = "Shoot a keypad to see what it controls.",
	keypad_checker_shoot_entity = "Shoot an entity to see which keypads are connected to it",
	keypad_checker_click_to_clear = "Right click to clear.",
	keypad_checker_entering_right_pass = "Entering the right password",
	keypad_checker_entering_wrong_pass = "Entering the wrong password",
	keypad_checker_after_right_pass = "after having entered the right password",
	keypad_checker_after_wrong_pass = "after having entered the wrong password",
	keypad_checker_right_pass_entered = "Right password entered",
	keypad_checker_wrong_pass_entered = "Wrong password entered",
	keypad_checker_controls_x_entities = "This keypad controls %d entities",
	keypad_checker_controlled_by_x_keypads = "This entity is controlled by %d keypads",
	keypad_on = "ON",
	keypad_off = "OFF",
	seconds = "seconds",

	persons_weapons = "%s possède des armes illégal:",
	returned_persons_weapons = "Vous avez pris %s's arme confisqué.",
	no_weapons_confiscated = "%s n'avaient pas d'armes a confisquées!",
	no_illegal_weapons = "%s n'a pas d'arme illégal sur lui.",
	confiscated_these_weapons = "Vous avez confisqué:",
	checking_weapons = "Fouille en cours",

	shipment_antispam_wait = "Attendez avant de spawn quelque chose d'autre.",

	-- Talking
	hear_noone = "Personne ne vous entend %s!",
	hear_everyone = "Tout le monde vous entend!",
	hear_certain_persons = "Joueur qui vous entende",

	whisper = "whisper",
	yell = "yell",
	advert = "[Annonce]",
	broadcast = "[Annonce Du Maire]",
	radio = "radio",
	request = "(Requete!)",
	group = "(Groupe)",
	demote = "(DEMOTE)",
	ooc = "Hors-RP",
	radio_x = "Radio %d",

	talk = "talk",
	speak = "speak",

	speak_in_ooc = "parler en OOC",
	perform_your_action = "perform your action",
	talk_to_your_group = "parler a votre groupe",

	channel_set_to_x = "Chaine mise sur %s!",

	-- Notifies
	disabled = "%s est désactivé! %s",
	limit = "Vous avez atteint la limite de %s!",
	have_to_wait = "Vous devez attendre %d secondes avant d'utiliser %s!",
	must_be_looking_at = "Vous devez regarder le %s!",
	incorrect_job = "Vous n'avez pas le bon métier pour %s",
	unavailable = "Ce %s n'est pas disponible",
	unable = "Problème dans la commande entré",
	cant_afford = "Vous ne pouvez pas offrir ce %s",
	created_x = "%s a crée un(e) %s",
	cleaned_up = "Vos %s ont été éffacé.",
	you_bought_x = "Vous avez acheté %s pour %s%d.", -- backwards compatibility
	you_bought = "Vous avez acheté %s pour %s.",
	you_received_x = "Vous avez recu %s pour %s.",

	created_first_jailpos = "Vous avez crée la premiere prison!",
	added_jailpos = "Vous avez ajouté une prison!",
	reset_add_jailpos = "Vous avez supprimé tout les prisons et avez ajouté celle ci.",
	created_spawnpos = "%s's spawn position created.",
	updated_spawnpos = "%s's spawn position updated.",
	do_not_own_ent = "Vous ne possedé pas cette objet!",
	cannot_drop_weapon = "Vous ne pouvez pas déposer cette arme!",
	job_switch = "Vous avez changé de métier!",
	job_switch_question = "Echanger de métier avec %s?",
	job_switch_requested = "Requete de changement de métier.",

	cooks_only = "Cooks only.",

	-- Misc
	unknown = "Inconnu",
	arguments = "arguments",
	no_one = "no one",
	door = "porte",
	vehicle = "vehicule",
	door_or_vehicle = "porte/vehicule",
	driver = "Conducteur: %s",
	name = "Nom: %s",
	locked = "Fermé.",
	unlocked = "Ouvert.",
	player_doesnt_exist = "Joueur inexistant.",
	job_doesnt_exist = "Métier inexistant!",
	must_be_alive_to_do_x = "Vous devez etre vivant pour %s.",
	banned_or_demoted = "Banni/Licensié",
	wait_with_that = "Wait with that.",
	could_not_find = "Impossible de trouver %s",
	f3tovote = "Hit F3 to vote",
	listen_up = "Annonce:", -- In rp_tell or rp_tellall
	nlr = "New Life Rule: Do Not Revenge Arrest/Kill.",
	reset_settings = "You have reset all settings!",
	must_be_x = "Vous devez etre %s pour %s.",
	agenda_updated = "L'agenda a été mis a jour",
	job_set = "%s a modifié son métier pour '%s'",
	demoted = "%s a été licensié",
	demoted_not = "%s n'a pas été licensié",
	demote_vote_started = "%s a lancé un vote pour licensié %s",
	demote_vote_text = "Raison:\n%s", -- '%s' is the reason here
	cant_demote_self = "Vous ne pouvez pas vous licensié.",
	i_want_to_demote_you = "Je veux te licensié. Raison: %s",
	tried_to_avoid_demotion = "Vous avez tenté d'évité le licensiment. Vous avez échoué.", -- naughty boy!
	lockdown_started = "Le couvre feu a été lancé, rentrez chez vous!",
	lockdown_ended = "Couvre-feu terminé",
	gunlicense_requested = "%s a demandé à  %s une gun license",
	gunlicense_granted = "%s a donné à %s une gun license",
	gunlicense_denied = "%s a refusé de donné à %s une gun license",
	gunlicense_question_text = "Donné à %s une gun license?",
	gunlicense_remove_vote_text = "%s a crée un vote pour enlever la gun license de %s",
	gunlicense_remove_vote_text2 = "Supprimé Gunlicense:\n%s", -- Where %s is the reason
	gunlicense_removed = "%s a perdu sa gunlicense!",
	gunlicense_not_removed = "%s a garder sa gunlicense!",
	vote_specify_reason = "Il faut une raison!",
	vote_started = "Le vote est crée",
	vote_alone = "Il n'y a personne, vous avez gagné le vote.",
	you_cannot_vote = "Vous ne pouvez pas voter!",
	x_cancelled_vote = "%s a annuler le vote.",
	cant_cancel_vote = "Il n'y a pas de vote a annuler!",
	jail_punishment = "Punition pour déconnexion! Emprisonné pour: %d secondes.",
	admin_only = "Admin seulement!", -- When doing /addjailpos
	chief_or = "Chef seulement ",-- When doing /addjailpos
	frozen = "Immobilisé.",

	dead_in_jail = "Vous etes mort avant la fin!",
	died_in_jail = "%s est mort en prison!",

	credits_for = "CREDITS FOR %s\n",
	credits_see_console = "DarkRP credits printed to console.",

	rp_getvehicles = "Available vehicles for custom vehicles:",

	data_not_loaded_one = "Your data has not been loaded yet. Please wait.",
	data_not_loaded_two = "If this persists, try rejoining or contacting an admin.",

	cant_spawn_weapons = "Vous ne pouvez pas faire apparaitre des armes.",
	drive_disabled = "Drive disabled for now.",
	property_disabled = "Property disabled for now.",

	not_allowed_to_purchase = "Vous ne pouvez pas acheter cet objet.",

	rp_teamban_hint = "rp_teamban [player name/ID] [team name/id]. Use this to ban a player from a certain team.",
	rp_teamunban_hint = "rp_teamunban [player name/ID] [team name/id]. Use this to unban a player from a certain team.",
	x_teambanned_y = "%s has banned %s from being a %s.",
	x_teamunbanned_y = "%s has unbanned %s from being a %s.",

	-- Backwards compatibility:
	you_set_x_salary_to_y = "You set %s's salary to %s%d.",
	x_set_your_salary_to_y = "%s set your salary to %s%d.",
	you_set_x_money_to_y = "You set %s's money to %s%d.",
	x_set_your_money_to_y = "%s set your money to %s%d.",

	you_set_x_salary = "You set %s's salary to %s.",
	x_set_your_salary = "%s set your salary to %s.",
	you_set_x_money = "You set %s's money to %s.",
	x_set_your_money = "%s set your money to %s.",
	you_set_x_name = "You set %s's name to %s",
	x_set_your_name = "%s set your name to %s",

	someone_stole_steam_name = "Someone is already using your Steam name as their RP name so we gave you a '1' after your name.", -- Uh oh
	already_taken = "Already taken.",

	job_doesnt_require_vote_currently = "This job does not require a vote at the moment!",

	x_made_you_a_y = "%s has made you a %s!",

	cmd_cant_be_run_server_console = "This command cannot be run from the server console.",

	-- The lottery
	lottery_started = "Il y a une lotterie, participer pour %s%d?", -- backwards compatibility
	lottery_has_started = "Il y a une lotterie, participer pour %s?",
	lottery_entered = "Vous participer a la lotterie avec %s",
	lottery_not_entered = "%s ne participe pas pas a la lotterie",
	lottery_noone_entered = "Personne n'a participer a la lotterie",
	lottery_won = "%s a gagné la lotterie! Il remporte %s",

	-- Animations
	custom_animation = "Animation personnalisé!",
	bow = "Saluer",
	dance = "Danser",
	follow_me = "Suivez moi!",
	laugh = "Rire",
	lion_pose = "Pose du Lion",
	nonverbal_no = "Non",
	thumbs_up = "Pouce vers le haut",
	wave = "Vague",

	-- Hungermod
	starving = "Affamé!",

	-- AFK
	afk_mode = "AFK Mode",
	salary_frozen = "Ton salaire à été gelée.",
	salary_restored = "Te revoila, ton salaire est dégelée.",
	no_auto_demote = "Tu ne sera pas licensié.",
	youre_afk_demoted = "Vous avez été licensié pour avoir été afk trop longtemps, la prochaine fois fait /afk.",
	hes_afk_demoted = "%s à été licensié pour avoir été AFK trop longtemps.",
	afk_cmd_to_exit = "Tape /afk pour quitté le mode AFK.",
	player_now_afk = "%s est AFK.",
	player_no_longer_afk = "%s n'est plus AFK.",

	-- Hitmenu
	hit = "contrat",
	hitman = "Assassin",
	current_hit = "Contrat: %s",
	cannot_request_hit = "Vous ne pouvez pas faire de contrat! %s",
	hitmenu_request = "Requete",
	player_not_hitman = "Ce joueur n'est pas un assassin!",
	distance_too_big = "Vous etes trop loin de l'assassin.",
	hitman_no_suicide = "L'assassin ne peut pas se tuer lui meme.",
	hitman_no_self_order = "Un assassin ne peut pas mettre sa tête a prix",
	hitman_already_has_hit = "L'assassin a déja un contrat en cours.",
	price_too_low = "Prix trop faible!",
	hit_target_recently_killed_by_hit = "La cible a déja été tué recemment,",
	customer_recently_bought_hit = "Le client a demandé un contrat recemment.",
	accept_hit_question = "Accepeté le contrat pour %s\nregarding %s pour %s%d?", -- backwards compatibility
	accept_hit_request = "Accepter le contrat pour %s\nregarding %s pour %s?",
	hit_requested = "Contrat en cours d'attente.",
	hit_aborted = "Contrat annulé! %s",
	hit_accepted = "Contrat accepté!",
	hit_declined = "Contrat refusé!",
	hitman_left_server = "L'assassin a quitté la ville!",
	customer_left_server = "Le client a quitté la ville!",
	target_left_server = "La cible a quitté la ville!",
	hit_price_set_to_x = "Le prix de contrat est de %s%d.", -- backwards compatibility
	hit_price_set = "Le prix d'un contrat est de %s.",
	hit_complete = "Contrat par %s complet!",
	hitman_died = "L'assassin est mort!",
	target_died = "La cible est morte!",
	hitman_arrested = "L'assassin s'est fait prendre!",
	hitman_changed_team = "L'assassin a changé de metier!",
	x_had_hit_ordered_by_y = "%s a un contrat en cours par %s",

	-- Vote Restrictions
	hobos_no_rights = "Les SDF ne peuvent pas voté!",
	gangsters_cant_vote_for_government = "Les gangsters ne peuvent pas voté pour les affaires du gouvernement!",
	government_cant_vote_for_gangsters = "Le gouvernement ne peut pas voté pour les affaires des gangsters!",

	-- VGUI and some more doors/vehicles
	vote = "Vote",
	time = "Temps: %d",
	yes = "Oui",
	no = "Non",
	ok = "Okay",
	cancel = "Annulé",
	add = "Ajouté",
	remove = "Enlevé",
	none = "Aucun",

	x_options = "%s options",
	sell_x = "Vendre %s",
	set_x_title = "Mettre %s un titre",
	set_x_title_long = "Donner un nom a %s que vous regarder.",
	jobs = "Métier",
	buy_x = "Acheté %s",

	-- F4menu
	no_extra_weapons = "Ce métier ne possede pas d'armes.",
	become_job = "Devenir",
	create_vote_for_job = "Crée un vote",
	shipments = "Caisses",
	F4guns = "Armes",
	F4entities = "Objets",
	F4ammo = "Munitions",
	F4vehicles = "Vehicules",

	-- Tab 1
	give_money = "Donner de l'argent au joueur que vous regarder",
	drop_money = "Jeter de l'argent",
	change_name = "Changer de nom",
	go_to_sleep = "S'endormir/Se reveiller",
	drop_weapon = "Jeter l'arme actuelle",
	buy_health = "Acheté des soins(%s)",
	request_gunlicense = "Demander un gun license",
	demote_player_menu = "Licensié un joueur",


	searchwarrantbutton = "Lancer un mandat",
	unwarrantbutton = "Annuler un mandat",
	noone_available = "No one available",
	request_warrant = "Demander un mandat",
	make_wanted = "Mettre un avis de recherche",
	make_unwanted = "Annuler un avis de recherche",
	set_jailpos = "Mettre les position de la prison",
	add_jailpos = "Ajouté un postion de prison",

	set_custom_job = "Mettre un nom de métier personnalisé (Appuyer sur Enter pour activer)",

	set_agenda = "Set the agenda (press enter to activate)",

	initiate_lockdown = "Lancer le couvre feu",
	stop_lockdown = "Arreter le couvre feu",
	start_lottery = "Lancer une lotterie",
	give_license_lookingat = "Donner <lookingat> une gun license",

	laws_of_the_land = "Lois de la Ville",
	law_added = "Loi ajouté.",
	law_removed = "Loi supprimé.",
	law_too_short = "Loi trop courte.",
	laws_full = "Les lois sont pleine.",
	default_law_change_denied = "Vous ne pouvez pas changer la loi.",

	-- Second tab
	job_name = "Nom: ",
	job_description = "Description: ",
	job_weapons = "Armes: ",

	-- Entities tab
	buy_a = "Acheter %s: %s",

	-- Licenseweaponstab
	license_tab = [[License weapons

	Tick the weapons people should be able to get WITHOUT a license!
	]],
	license_tab_other_weapons = "Other weapons:",

	zombie_spawn_removed = "You have removed this zombie spawn.",
	zombie_spawn = "Zombie Spawn",
	zombie_disabled = "Zombies are now disabled.",
	zombie_enabled = "Zombies are now enabled.",
	zombie_maxset = "Maximum amount of zombies is now set to %s",
	zombie_spawn_added = "You have added a zombie spawn.",
	zombie_spawn_not_exist = "Zombie Spawn %s does not exist.",
	zombie_leaving = "Zombies are leaving.",
	zombie_approaching = "WARNING: Zombies are approaching!",
	zombie_toggled = "Zombies toggled.",
}

-- The language code is usually (but not always) a two-letter code. The default language is "en".
-- Other examples are "nl" (Dutch), "de" (German)
-- If you want to know what your language code is, open GMod, select a language at the bottom right
-- then enter gmod_language in console. It will show you the code.
-- Make sure language code is a valid entry for the convar gmod_language.
DarkRP.addLanguage("en", my_language)
