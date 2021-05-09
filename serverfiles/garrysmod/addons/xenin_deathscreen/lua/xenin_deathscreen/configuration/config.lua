----------- NO TOUCHIE -----------
local cfg = XeninDS.ConfigWrapper()
----------- NO TOUCHIE -----------

------------------------------
-- Add chat commands to open the shop with
-- If you don't want chat commands, simply just don't add commands
cfg:addChatCommand("!deathscreen")
cfg:addChatCommand("/deathscreen")
cfg:addChatCommand("!ds")
cfg:addChatCommand("/ds")
------------------------------


------------------------------
-- What language to use?
-- You can find the languages you can use here: https://gitlab.com/sleeppyy/xenin-languages/-/tree/master/deathscreen
-- You don't need to write the .json part
--
-- If you want to add your own language you can
-- 1. Create a pull request (create new file) that will be uploaded to that website with the language
-- 2. Use a second argument in the :setLanguage function
--
-- How to do now #2. This will set the language without needing to use the version from a website. 
-- cfg:SetLanguage("french", [[
--   {
--	   "phrases": {
--		 "dashboard": {
--	
--			}
--		}
--	}
-- ]])
-- So for example
-- cfg:setLanguage("russian", [[
--     YOUR TRANSLATION HERE
-- ]])
-- copy the contents of english.json and translate it here
--
cfg:setLanguage("english")
------------------------------

------------------------------
-- What currency to use?
-- You can look at the "currencies" folder to see all available currencies.
cfg:setCurrency("darkrp")
------------------------------

------------------------------
-- How should the sort be ordered?
-- If you want to remove a sort, just remove the "text", part here
-- If you want something to be the default sort for the shop, just move it to be the first element in this table
cfg:setSortOrder({
	"priceAscending", "priceDescending", "alphabetical"
})
------------------------------

------------------------------
-- What level system to use?
-- Comment this out if you don't want to use, and uncomment if you want to use.
-- You can look at the "levels" folder to see all available levels.
--
-- cfg:setLevelSystem("vrondakis")
------------------------------

------------------------------
-- Should the respawn countdown show?
-- Some other addons might have a countdown, so perhaps you don't want it here
cfg:setRespawnUIEnabled(true)
------------------------------

------------------------------
-- How thick should the outline around cards be? In pixels
cfg:setOutline(1)
------------------------------

------------------------------
-- Should there be a grey filter on top of screen when you die?
cfg:setGreyFilterOn(true)
------------------------------

------------------------------
-- What colour should the outline for the killcam on the player be?
-- If set to "inventory" along with Xenin Inventory installed it'll use the weapons colour from Xenin Inventory
-- If not, just use a color, like Color(255, 0, 0)
cfg:setPlayerOutlineColor("inventory")
------------------------------

------------------------------
-- Should the player cam smoothly animate when reviewing after being killed by a player?
-- This will increase the respawn time to 2 seconds instead of 0.8 seconds.
cfg:setSmoothRespawnCam(true)
------------------------------

------------------------------
-- What's the title of the menu?
cfg:setMenuTitle("Xenin Deathscreen")
------------------------------

------------------------------
-- What title should the NPC have?
cfg:setNPCTitle("Deathscreen Cards")
------------------------------

------------------------------
-- What colour should the outline on the NPC be?
-- You can use Color(r, g, b) on this, but default is a variable
cfg:setNPCColor(XeninUI.Theme.Blue)
------------------------------

------------------------------
-- What model should the NPC use?
cfg:setNPCModel("models/humans/group02/female_01.mdl")
------------------------------

-- Should armor be shown in the deathscreen?
cfg:setArmorEnabled(true)
------------------------------

------------------------------
-- How long till they can respawn again. In seconds.
-- Set to 0 to disable it
cfg:setRespawnTime(0)
------------------------------

------------------------------
-- You're able to adjust a usergroups respawn time independently of the normal respawn time
-- This means you can have certain usergroups have higher/lower respawn time.
-- ["usergroup_name"] = time,
cfg:setRespawnTimeUsergroups({
	["superadmin"] = 0,
})
------------------------------

------------------------------
-- Should the deathscreen go away when the respawn countdown is over?
-- By activating this you'll also be disabling the "lock" on respawn. Meaning if this is enabled people can always respawn, no matter the countdown.
-- This is very good for gamemodes like TTT where you have spectating.
cfg:setRespawnTimerEnabled(false)

------------------------------
-- Is the killfeed enabled?
-- If enabled every time you kill someone it'll show a mini deathscreen, similar to Call of Duty
cfg:setKillfeedEnabled(true)
------------------------------

------------------------------
-- How long should the killfeed stay on screen for?
cfg:setKillfeedTime(3)
------------------------------

------------------------------
-- When a player dies, should the player's camera follow the killer?
-- This is essentially ghosting, so disable if you find it a problem.
cfg:setFollowKiller(true)
------------------------------

------------------------------
-- Where should the deathscreen be located?
-- Possible options:
-- "top"
-- "middle"
-- "bottom"
cfg:setPosition("bottom")
------------------------------

------------------------------
-- The amount of pixels offset from the top/bottom of the screen.
-- If position is set to middle this does nothing
cfg:setMargin(32)
------------------------------

------------------------------
-- What card should users by default use?
-- This is a imgur direct link id, and cannot be animated.
cfg:setDefaultCard("QxH0874")
------------------------------

------------------------------
-- Instead of showing a team, should it show usergroup?
cfg:setUsergroupEnabled(false)
-- If usergroups are enabled, add your usergroup here
-- cfg:addUsergroup("rank_name", "display_name", color)
-- Example:
-- cfg:addUsergroup("tmod", "Trial Moderator", Color(255, 0, 0))
cfg:addUsergroup("superadmin", "Superadmin", XeninUI.Theme.Green)
------------------------------

------------------------------
-- Should the price of a card be hidden if the player already owns the card?
cfg:setHidePriceIfOwned(true)
------------------------------

------------------------------
-- Adds a card to the "suicide" deathscreen.
-- Use an imgur direct image ID.
-- It'll choose a random one every time
cfg:addSuicideCard("OaHa1fJ")
cfg:addSuicideCard("ZTH3VDQ")
------------------------------

------------------------------
-- Adds a card to the "world" deathscreen.
-- Same principle as suicide card
cfg:addWorldCard("OaHa1fJ")
------------------------------

-- You can add normal cards, and animated cards here.
-- Lets start off with a normal card.
-- If you want this in voice, here's a YouTube video explaining it:  https://www.youtube.com/watch?v=tb6mfW5FErA
-- The first part after :addCard is the "id" of the card.
-- This ID HAS to be unique.
-- Inside the { } table, there's several options.
------------------------------
-- name = "Displayed name"
------------------------------
-- price = priceInCurrency
------------------------------
-- src = "imgur_direct_id"
------------------------------
-- category = "Category name"
------------------------------
-- unpurchasable = true (optional)
------------------------------
-- This will make it a requirement to be X level with your enabled level system
-- levelRequirement = number (optional)
------------------------------
-- steamids = { 
--   ["76561198202328247"] = true,
-- }
-- This will lock the card to all the specific steamids
------------------------------
-- You can add a currency, which will overwrite the default currency.
-- Say if you have Pointshop 2 installed, you can defaault to "ps2" and use "ps2_premium" for specific cards
-- currency = "ps2_premium" (optional)
------------------------------
-- usergroupRestriction = {
--   ["superadmin"] = true,
-- } (optional)
-- This makes it so only those usergroups can buy it
-- Don't mix unpurchasable with usergroupRestriction, unpurchasable will overwrite this
------------------------------
-- Now lets move onto animated cards. All the previous fields are the same except for one.
-- For src you have to put a folder relative to "xenin/deathscreen/"
-- src = "animated/my_card"
-- I recommend you watch the tutorial here: https://www.youtube.com/watch?v=tb6mfW5FErA
------------------------------
-- Animated cards also have timing. This is the delay between frames.
-- times = { 0.08, 1 } (optional, defaults to { 0.05, 0.05 })
-- This will make it so that there's a 0.08 second delay between each frame, except for after the last.
-- After the last frame there'll be 1 second delay. It's essentially a "restart delay"
-- If you don't want this delay, just set the frame delay, and restart delay to the same value
cfg:addCard("cod_bo3_survialist", {
	name = "Survialist",
	price = 50000,
	src = "aAuAoV0",
	category = "Call of Duty"
})

cfg:addCard("cod_bo3_shadows", {
	name = "Shadows",
	price = 35000,
	src = "27zp0Ht",
	category = "Call of Duty",
	usergroupRestriction = {
		["my_vip_group"] = true,
		["another_donator"] = true
	}
})

cfg:addCard("cod_bo3_dead_aim", {
	name = "Dead Aim",
	price = 50000,
	src = "7vGBEXs",
	category = "Call of Duty"
})

cfg:addCard("cod_bo3_tango_down", {
	name = "Tango Down",
	price = 50000,
	src = "UP4J6pl",
	category = "Call of Duty"
})

cfg:addCard("cod_bo3_fractal", {
	name = "Fractal",
	price = 50000,
	src = "HWy4NM4",
	category = "Call of Duty"
})

cfg:addCard("cod_bo3_squid", {
	name = "Squid. 45",
	price = 5000,
	src = "ctNWbnq",
	unpurchasable = true,
	category = "Call of Duty"
})

cfg:addCard("tf2_titan", {
	name = "Titan",
	price = 45000,
	src = "XShEv2i",
	category = "Art"
})

cfg:addCard("cod_mw_covering", {
	name = "Covering",
	price = 38500,
	src = "BEqVbEG",
	category = "Call of Duty"
})

cfg:addCard("custom_unnamed_goose", {
	name = "Unnamed goose",
	price = 45000,
	src = "7uBXBAO",
	category = "Funny"
})

cfg:addCard("custom_cat", {
	name = "Cat",
	price = 1,
	src = "jqSeKUp",
	category = "Relaxing"
})

cfg:addCard("custom_temple", {
	name = "Temple",
	price = 55000,
	src = "FUM8hEV",
	category = "Relaxing"
})

cfg:addCard("custom_elephant", {
	name = "Letter",
	price = 25000,
	src = "8A9k2BZ",
	category = "Others"
})

cfg:addCard("custom_stare", {
	name = "Bruh moment",
	price = 45000,
	src = "LbT2qda",
	category = "Funny"
})

cfg:addCard("custom_george", {
	name = "George the Goose",
	price = 1500000,
	src = "Lo90f0T",
	category = "Funny"
})

-- Anime/cartoon related images
cfg:addCard("custom_anime_ghost_in_the_shell", {
	name = "Ghost in the Shell",
	price = 85000,
	src = "x17fhlx",
	category = "Anime"
})

cfg:addCard("custom_anime_smile", {
	name = "Smiling couple",
	price = 100000,
	src = "l3dBolA",
	category = "Relaxing"
})

cfg:addCard("custom_anime_food", {
	name = "The Menu",
	price = 75000,
	src = "WCPUTx4",
	category = "Anime"
})

cfg:addCard("custom_anime_magician", {
	name = "The Magician",
	price = 72000,
	src = "j9IoQoH",
	category = "Anime"
})

cfg:addCard("custom_anime_spongebob", {
	name = "Spongebob t-shirt",
	price = 58000,
	src = "HY1dViW",
	category = "Anime"
})

cfg:addCard("custom_anime_over_the_shoulder", {
	name = "Over the shoulder",
	price = 125000,
	src = "ERwsTy2",
	category = "Anime"
})

cfg:addCard("custom_art_garden", {
	name = "Garden",
	price = 80000,
	src = "SxSlnjg",
	category = "Art"
})

cfg:addCard("custom_art_towersofdoom", {
	name = "Towers of Doom",
	price = 60000,
	src = "9aVlQTm",
	category = "Art",
})

cfg:addCard("custom_shattered", {
	name = "Shattered",
	price = 50000,
	src = "PZDSzvr",
	category = "Art",
})

cfg:addCard("custom_art_pathway", {
	name = "Pathway",
	price = 100000,
	src = "g4t9POh",
	category = "Art",
})

cfg:addCard("custom_art_rogue", {
	name = "Rogue",
	price = 82500,
	src = "SulO6fP",
	category = "Art"
})

cfg:addCard("custom_art_lucifer", {
	name = "Lord Lucifer",
	price = 225000,
	src = "dVWzWTK",
	category = "Art"
})

cfg:addCard("custom_art_werewolf", {
	name = "Werewolf",
	price = 80000,
	src = "soz0rA6",
	category = "Art"
})

cfg:addCard("custom_art_swamp", {
	name = "Swamp",
	price = 73000,
	src = "wWGRI2D",
	category = "Art"
})

cfg:addCard("custom_art_game_time", {
	name = "Game time",
	price = 45000,
	src = "ixl4bgo",
	category = "Art"
})

cfg:addCard("custom_art_project_hero", {
	name = "Project Hero",
	price = 182500,
	src = "PpUWG6N",
	category = "Art"
})
cfg:addCard("custom_art_mario", {
	name = "Mario",
	price = 42000,
	src = "sAZ3sVv",
	category = "Art"
})
cfg:addCard("custom_art_anessix", {
	name = "Anessix",
	price = 69000,
	src = "URuZdOn",
	category = "Art"
})
cfg:addCard("custom_art_stadium", {
	name = "Stadium",
	price = 58300,
	src = "GKm8HTl",
	category = "Art"
})
cfg:addCard("custom_relaxing_sunset", {
	name = "Sunset",
	price = 125000,
	src = "eRU3Ddi",
	category = "Relaxing"
})
cfg:addCard("custom_anime_pikapika", {
	name = "Pika pika",
	price = 33333,
	src = "OIvWJi5",
	category = "Anime",
	--levelRequirement = 5
})
cfg:addCard("custom_art_akali_lol", {
	name = "Akali",
	price = 52000,
	src = "nhQHDgb",
	category = "Art"
})
cfg:addCard("custom_art_tomb_raider_lara", {
	name = "Lara Croft",
	price = 55000,
	src = "vrg9gbi",
	category = "Art"
})
cfg:addCard("custom_art_anonymous", {
	name = "Anonymous",
	price = 133700,
	src = "TvbSbDT",
	category = "Art"
})
cfg:addCard("custom_2020_be_like", {
	name = "2020 be like",
	price = 50000,
	src = "0vJ2ckt",
	category = "Others"
})

-- Animated cards --
cfg:addAnimatedCard("custom_fatally_wounded", {
	name = "Fatally wounded",
	price = 250000,
	src = "animated/wounded",
	times = { 0.05, 0.05 },
	category = "Others"
})

cfg:addAnimatedCard("custom_machinegun", {
	name = "Machine gun",
	price = 350000,
	src = "animated/machinegun",
	times = { 0.03, 0.03 },
	category = "Others"
})