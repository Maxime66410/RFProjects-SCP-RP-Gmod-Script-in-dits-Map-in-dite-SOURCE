XeninDS = XeninDS or {}
XeninDS.Models = {}
XeninDS.Controllers = {}

XENINDS_TAG_PLAYER = 0
XENINDS_TAG_WORLD = 1
XENINDS_TAG_SUICIDE = 2
XENINDS_TAG_KILLFEED = 3

local function SelectActiveGamemode()
	local gm = engine.ActiveGamemode()
	for i, v in pairs(XeninDS.Gamemodes.gamemodes) do
		if (v.detect and v.detect()) then
			XeninDS.Gamemodes:setActive(i)

			break
		end
		if (v.match and table.HasValue(v.match, gm)) then
			XeninDS.Gamemodes:setActive(i)

			break
		end
	end

	if (!XeninDS.Gamemodes.active) then
		XeninDS.Gamemodes:setActive("base")
	end
end

local function Load()
	XeninDS.Tests = {}
	function XeninDS:AddTest(test)
		table.insert(XeninDS.Tests, test)
	end

	local l = XeninUI.Loader():setName("Xenin Death Screen"):setAcronym("XeninDS"):setDirectory("xenin_deathscreen"):setColor(XeninUI.Theme.Red):loadFile("classes/compatibility/currencies", XENINUI_SHARED):load("currencies", XENINUI_SHARED, true):loadFile("classes/compatibility/gamemodes", XENINUI_SHARED):load("gamemodes", XENINUI_SHARED, true):loadFile("classes/compatibility/levels", XENINUI_SHARED):load("levels", XENINUI_SHARED, true):loadFile("classes/compatibility/i18n", XENINUI_SHARED):loadFile("classes/core/config", XENINUI_SHARED):loadFile("configuration/config", XENINUI_SHARED):loadFile("classes/model/card", XENINUI_SHARED):loadFile("classes/model/animation", XENINUI_SHARED):load("classes/model", XENINUI_SHARED, true):load("classes/controller", XENINUI_SHARED, true):loadFile("classes/core/network", XENINUI_SHARED):load("classes/core", XENINUI_SERVER, true, {
	ignoreFiles = {
	validation = true
	}
	}):load("ui/deathscreen", XENINUI_CLIENT, true):load("ui/shop", XENINUI_CLIENT, true):loadFile("networking/client", XENINUI_CLIENT):loadFile("networking/server", XENINUI_SERVER):load("tests", XENINUI_SHARED, true):loadFile("classes/core/validation", XENINUI_SERVER):done()

	SelectActiveGamemode()
end

if XeninUI then
	Load()
else
	hook.Add("XeninUI.Loaded", "XeninDS", Load)
end

XeninDS.Version = "1211"

if SERVER then

	resource.AddWorkshop("1900562881")

	resource.AddWorkshop("2033827226")
end
