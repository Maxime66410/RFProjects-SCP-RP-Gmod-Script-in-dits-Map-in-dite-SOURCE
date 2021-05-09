
-----------------------------------------------------
--[[---------------------------------------------------------------------------
DarkRP custom shipments and guns
---------------------------------------------------------------------------

This file contains your custom shipments and guns.
This file should also contain shipments and guns from DarkRP that you edited.

Note: If you want to edit a default DarkRP shipment, first disable it in darkrp_config/disabled_defaults.lua
	Once you've done that, copy and paste the shipment to this file and edit it.

The default shipments and guns can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomShipmentFields


Add shipments and guns under the following line:
---------------------------------------------------------------------------]]


///////////////////////////////////////
///////////////////////////////////////
///////////////////////////////////////

DarkRP.createShipment("Radio", {
	model = "models/Items/BoxMRounds.mdl", -- The model of the item that hovers above the shipment
	entity = "dradio", -- the entity that comes out of the shipment
	price = 0, -- the price of one shipment
	amount = 1, -- how many of the item go in one purchased shipment
	separate = false, -- whether the item is sold separately (usually used for guns)
	pricesep = 100, -- the price of a separately sold item

	-- The following fields are OPTIONAL. If you do not need them, or do not need to change them from their defaults, REMOVE them.
	allowed = {TEAM_CHERCHEUR_NOVICE, TEAM_CHERCHEUR, TEAM_CHERCHEURCONF, TEAM_CHERCHEUR_EXP, TEAM_CHERCHEUR_PROF, TEAM_CHERCHEUR_SUP, TEAM_CHERCHEUR_SUPG, TEAM_CHERCHEUR_DADJ, TEAM_CHERCHEUR_ADJ}, -- OPTIONAL, which teams are allowed to buy this shipment/separate gun
})

DarkRP.createShipment("Lampe Torche", {
	model = "models/Items/BoxMRounds.mdl", -- The model of the item that hovers above the shipment
	entity = "weapon_flashlight", -- the entity that comes out of the shipment
	price = 0, -- the price of one shipment
	amount = 1, -- how many of the item go in one purchased shipment
	separate = false, -- whether the item is sold separately (usually used for guns)
	pricesep = 100, -- the price of a separately sold item

	-- The following fields are OPTIONAL. If you do not need them, or do not need to change them from their defaults, REMOVE them.
	allowed = {TEAM_CHERCHEUR_NOVICE, TEAM_CHERCHEUR, TEAM_CHERCHEURCONF, TEAM_CHERCHEUR_EXP, TEAM_CHERCHEUR_PROF, TEAM_CHERCHEUR_SUP, TEAM_CHERCHEUR_SUPG, TEAM_CHERCHEUR_DADJ, TEAM_CHERCHEUR_ADJ}, -- OPTIONAL, which teams are allowed to buy this shipment/separate gun
})