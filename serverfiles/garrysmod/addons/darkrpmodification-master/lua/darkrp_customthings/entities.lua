--[[---------------------------------------------------------------------------
DarkRP custom entities
---------------------------------------------------------------------------

This file contains your custom entities.
This file should also contain entities from DarkRP that you edited.

Note: If you want to edit a default DarkRP entity, first disable it in darkrp_config/disabled_defaults.lua
    Once you've done that, copy and paste the entity to this file and edit it.

The default entities can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua#L111

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomEntityFields

Add entities under the following line:
---------------------------------------------------------------------------]]

DarkRP.createEntity("Boite de munitions", {
    ent = "universal_ammo",
    model = "models/items/boxsrounds.mdl" ,
    price = 50,
    max = 1,
    cmd = "essennodep",
    category = "Autre"
})


DarkRP.createEntity("Kevlar", {
    ent = "medic_armorkit_50",
    model = "models/items/boxsrounds.mdl" ,
    price = 50,
    max = 3,
    cmd = "kevlarammo",
    category = "Autre",
    allowed = {TEAM_SECU_MEDIC,TEAM_SECU_MTF3,TEAM_IC_AGENTMDC}
})


DarkRP.createEntity("Burger Frites", {
    ent = "food_burger",
    model = "models/burgerplate01/burgerplate01.mdl",
    price = 0,
    max = 5,
    cmd = "fburger",
    allowed = {TEAM_COOK}
})

DarkRP.createEntity("Sushi Californien", {
    ent = "food_californiaroll",
    model = "models/sushipack/sushi03.mdl",
    price = 0,
    max = 5,
    cmd = "fscali",
    allowed = {TEAM_COOK}
})


DarkRP.createEntity("Pizza 4 Fromages", {
    ent = "food_cheesepizza",
    model = "models/cheesepizza01/cheesepizza01.mdl",
    price = 0,
    max = 5,
    cmd = "fcpizza",
    allowed = {TEAM_COOK}
})


DarkRP.createEntity("MilkShake Chocolat", {
    ent = "food_shake",
    model = "models/chocolateshake01/chocolateshake01.mdl",
    price = 0,
    max = 5,
    cmd = "foodshake",
    allowed = {TEAM_COOK}
})


DarkRP.createEntity("Nouilles", {
    ent = "food_alfredo",
    model = "models/alfredo01/alfredo01.mdl",
    price = 0,
    max = 5,
    cmd = "nouilles",
    allowed = {TEAM_COOK}
})


DarkRP.createEntity("Spaghetti aux boulettes", {
    ent = "food_spaghettinmeatballs",
    model = "models/spaghettiandmeatballs01/spaghettiandmeatballs01.mdl",
    price = 0,
    max = 5,
    cmd = "foodboulettes",
    allowed = {TEAM_COOK}
})


DarkRP.createEntity("Pizza Poivrons (pepperoni)", {
    ent = "food_pepperonipizza",
    model = "models/peppizza02/peppizza02.mdl",
    price = 0,
    max = 5,
    cmd = "foodpepperoni",
    allowed = {TEAM_COOK}
})