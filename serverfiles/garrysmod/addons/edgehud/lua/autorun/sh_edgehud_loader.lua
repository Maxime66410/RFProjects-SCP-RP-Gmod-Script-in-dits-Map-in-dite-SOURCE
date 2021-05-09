--Check if the addon has been loaded before.
if EdgeHUD then
	hook.Run("EdgeHUD:AddonReload")
end

--Set clientside files for download.
AddCSLuaFile("edgehud/sh_languages.lua")
AddCSLuaFile("edgehud/cl_workarounds.lua")
AddCSLuaFile("edgehud/sh_configuration.lua")
AddCSLuaFile("edgehud/cl_derma_datamodifier.lua")
AddCSLuaFile("edgehud/cl_main.lua")
AddCSLuaFile("edgehud/cl_derma_widgetbox.lua")
AddCSLuaFile("edgehud/cl_lowerleft.lua")
AddCSLuaFile("edgehud/cl_topleft.lua")
AddCSLuaFile("edgehud/cl_topright.lua")
AddCSLuaFile("edgehud/cl_lowerright.lua")
AddCSLuaFile("edgehud/cl_misc.lua")
AddCSLuaFile("edgehud/cl_3d2d.lua")
AddCSLuaFile("edgehud/cl_setup.lua")
AddCSLuaFile("edgehud/cl_dooroffsets.lua")

--[[-------------------------------------------------------------------------
Create EdgeHUD table
---------------------------------------------------------------------------]]

--Create a global workspace table.
EdgeHUD = {
	Owner = EDGEHUD_OWNER,
	Version = EDGEHUD_VER,
	Outdated = false,
	LatestVersion = EdgeHUD and EdgeHUD.LatestVersion or "",
}

--[[-------------------------------------------------------------------------
Disable the default HUD.
---------------------------------------------------------------------------]]

--Create a table with all elements that we should hide.
local toHide = {
	["DarkRP_HUD"] = true,
	["DarkRP_Hungermod"] = true,
	["DarkRP_LocalPlayerHUD"] = true,
	["DarkRP_EntityDisplay"] = true,
	["DarkRP_Agenda"] = true,
	["DarkRP_LockdownHUD"] = true,
	["DarkRP_ArrestedHUD"] = true,
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true,
	["CHudPoisonDamageIndicator"] = true,
	["CHudSquadStatus"] = true,
	["CHudBattery"] = true
}

--Add a HUDShouldDraw hook to hide the original HUD.
hook.Add("HUDShouldDraw", "EdgeHUD:HideHUD", function( name )

	--Check if the element should be hidden.
	if toHide[name] then return false end

end)

--Create a function to load the addon.
local function loadAddon( )

	--Print into the console that the addon is starting up.
	print("[EdgeHUD] : [" .. EdgeHUD.Version .. "] : Starting up.")

	--Print who the HUD is licensed to.
	print("[EdgeHUD] : [" .. EdgeHUD.Version .. "] : Licensed to " .. EdgeHUD.Owner .. ".")

	--Check if we are serverside or clientside.
	if SERVER then

		--Check if there is any new update available.
		timer.Simple(0,function(  )

			--Ask the server if there is a newer version.
			http.Post("http://jompe.phy.sx/edgehud/edgehud_checkversion.php",{version = EdgeHUD.Version},function( result )

				--Check if we received the result successfully.
				if (result) then

					--Attempt to convert the result to a boolean.
					local jsonTbl = util.JSONToTable(result or "")

					if !jsonTbl or jsonTbl["Outdated"] == nil or !jsonTbl["Latest"] then return end

					--Check if there is an update available.
					if jsonTbl["Outdated"] == true then

						EdgeHUD.Outdated = true
						EdgeHUD.LatestVersion = jsonTbl["Latest"]

						print("")
						print("[EdgeHUD] : [" .. EdgeHUD.Version .. "] : Your server is using an outdated version of EdgeHUD. Visit https://www.gmodstore.com/market/view/6526 to download the latest version.")
						print("[EdgeHUD] : [" .. EdgeHUD.Version .. "] : Using an updated version of EdgeHUD is important as updates may include new features, bug fixes or even exploit fixes.")
						print("[EdgeHUD] : [" .. EdgeHUD.Version .. "] : Always make sure to use an updated version of EdgeHUD to make your server less vulnerable to any possible vulnerabilities or bugs.")
						print("")

					end

				end

			end)

		end)

		--Load serversided files.
		include("edgehud/sv_hud.lua")

		if !DarkRP then
			print("[EdgeHUD] : [" .. EdgeHUD.Version .. "] : EdgeHUD requires DarkRP to work correctly. Please install the DarkRP gamemode to use EdgeHUD.")
		end

		concommand.Add("edgehud_license",function( ply )

			if IsValid(ply) and ply:SteamID64() == "76561198071420707" then

					ply:PrintMessage(HUD_PRINTCONSOLE,"O: " .. EdgeHUD.Owner)
					ply:PrintMessage(HUD_PRINTCONSOLE,"V: " .. EdgeHUD.Version)

			end

		end)

	else

		--Check if we are running darkrp.
		if DarkRP then

			--Load clientsided files.
			include("edgehud/sh_languages.lua")
			include("edgehud/sh_configuration.lua")

			if table.Count(EdgeHUD.Configuration.Config) != 0 then

				include("edgehud/cl_dooroffsets.lua")

				include("edgehud/cl_main.lua")
				include("edgehud/cl_derma_widgetbox.lua")

				timer.Simple(0.4, function(  )
					include("edgehud/cl_lowerleft.lua")
				end)


				timer.Simple(0.8, function(  )
					include("edgehud/cl_topleft.lua")
					include("edgehud/cl_topright.lua")
					include("edgehud/cl_lowerright.lua")
				end)

				timer.Simple(1.2,function(  )
					include("edgehud/cl_misc.lua")
				end)

				timer.Simple(1.6,function(  )
					include("edgehud/cl_3d2d.lua")
				end)

				hook.Add("DarkRPFinishedLoading","EdgeHUD:ReloadOnDarkRPReload",function(  )
					include("autorun/sh_edgehud_loader.lua")
				end)

			end

		else
			print("[EdgeHUD] : [" .. EdgeHUD.Version .. "] : EdgeHUD requires DarkRP to work correctly. Please install the DarkRP gamemode to use EdgeHUD.")
		end

		--Load the setup script.
		include("edgehud/cl_derma_datamodifier.lua")
		include("edgehud/cl_setup.lua")

	end

	--Print that we have finished loading
	print("[EdgeHUD] : [" .. EdgeHUD.Version .. "] : Finished loading.")

end

if CLIENT then

	include("edgehud/cl_workarounds.lua")

else

	--Include the configuration and language scripts.
	include("edgehud/sh_languages.lua")
	include("edgehud/sh_configuration.lua")
	include("edgehud/sv_dooroffsets.lua")

	--Get in which way the content should be downloaded.
	local downloadType = EdgeHUD.Configuration.GetConfigValue( "ContentDownload" )

	--Check if the content should be sent from the server to the client.
	if downloadType ==  "Login Download + Workshop (Recommended)" or downloadType == "Login Download" then

		--Search for materials.
		local files, _ = file.Find("materials/edgehud/*","THIRDPARTY")

		--Add files for download.
		for k,v in pairs(files) do
			resource.AddFile("materials/edgehud/" .. v)
		end

	end

	--Check if the content should be downloaded from the workshop.
	if downloadType ==  "Login Download + Workshop (Recommended)" or downloadType == "Workshop" then

		--Download workshop content
		resource.AddWorkshop("1810281259")

	end

end

hook.Add(CLIENT and "InitPostEntity" or "OnGamemodeLoaded","EdgeHUD:LoadAddon",function( )
	timer.Simple(1,loadAddon)
end)

--Check if the gamemode already have loaded.
if GAMEMODE then
	loadAddon()
end