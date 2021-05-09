-- Check so we are clientside.
if CLIENT then

	EdgeScoreboard = EdgeScoreboard or {
		Owner = EDGESCOREBOARD_USER,
		Version = EDGESCOREBOARD_VERSION,
		Hash = EDGESCOREBOARD_HASH,
		Outdated = false,
		LatestVersion = EdgeScoreboard and EdgeScoreboard.LatestVersion or "",
	}

	-- Create a function to load the addon.
	function EdgeScoreboard.LoadAddon(  )

		EdgeScoreboard.FinishedLoading = false

		if GAMEMODE then
			GAMEMODE.ScoreboardShow = function(  ) end
			GAMEMODE.ScoreboardHide = function(  ) end
		end

		-- Remove the FAdmin scoreboard hooks.
		hook.Remove("ScoreboardShow", "FAdmin_scoreboard")
		hook.Remove("ScoreboardHide", "FAdmin_scoreboard")

		-- Call the hook for when edgescoreboard loads.
		hook.Run("EdgeScoreboard:Load")

		-- Request the configuration.
		net.Start("EdgeScoreboard:RequestConfiguration")
		net.SendToServer()

		-- Print that we requested the configuration.
		print("[EdgeScoreboard] : [" .. EdgeScoreboard.Version .. "] : Requested configuration from server.")

		-- Create a timer that requests the configuration form the server.
		timer.Create("EdgeScoreboard:RequestConfig",10,0,function (  )

			-- Request the configuration again.
			net.Start("EdgeScoreboard:RequestConfiguration")
			net.SendToServer()

			-- Print that we requested the configuration.
			print("[EdgeScoreboard] : [" .. EdgeScoreboard.Version .. "] : Requested configuration from server.")

		end)

	end

	-- Add a receiver for EdgeScoreboard:SendConfiguration.
	net.Receive("EdgeScoreboard:SendConfiguration",function( )

		-- Call the hook for when edgescoreboard loads.
		hook.Run("EdgeScoreboard:Load")

		local loadAddon = EdgeScoreboard.LoadAddon

		-- Create the workspace table.
		EdgeScoreboard = {
			Owner = EDGESCOREBOARD_USER,
			Version = EDGESCOREBOARD_VERSION,
			Hash = EDGESCOREBOARD_HASH,
			Outdated = false,
			LatestVersion = EdgeScoreboard and EdgeScoreboard.LatestVersion or "",
			LoadAddon = loadAddon,
		}

		EdgeScoreboard.FinishedLoading = false

		-- Remove the EdgeScoreboard:RequestConfig timer.
		timer.Remove("EdgeScoreboard:RequestConfig")

		local data = net.ReadTable()

		-- Print some startup information.
		print("[EdgeScoreboard] : [" .. EdgeScoreboard.Version .. "] : Received configuration from server.")
		print("[EdgeScoreboard] : [" .. EdgeScoreboard.Version .. "] : Starting up.")
		print("[EdgeScoreboard] : [" .. EdgeScoreboard.Version .. "] : Licensed to " .. EdgeScoreboard.Owner .. ".")

		-- Setup the configuration and languages.
		include("edgescoreboard/sh_language.lua")
		include("edgescoreboard/sh_configuration.lua")

		-- Cache the configuration.
		EdgeScoreboard.Configuration.Config = data.Config
		EdgeScoreboard.Configuration.Usergroups = data.Usergroups
		EdgeScoreboard.Configuration.HiddenTeams = data.Teams.Hidden
		EdgeScoreboard.Configuration.OrderedTeams = data.Teams.Ordered
		EdgeScoreboard.Configuration.Servers = data.Servers

		-- Include clientside files.
		include("edgescoreboard/cl_main.lua")
		include("edgescoreboard/cl_gamemodesettings.lua")
		include("edgescoreboard/sh_notify.lua")
		include("edgescoreboard/cl_graph.lua")
		include("edgescoreboard/cl_playerrow.lua")
		include("edgescoreboard/cl_serverlist.lua")
		include("edgescoreboard/cl_utilitiestab.lua")
		include("edgescoreboard/cl_dermahandler.lua")
		include("edgescoreboard/cl_scoreboard.lua")
		include("edgescoreboard/cl_datamodifier.lua")
		include("edgescoreboard/cl_configuration.lua")

		-- Request data from the server.
		net.Start("EdgeScoreboard:RequestInitialData")
		net.SendToServer()

		-- Print that we have finished loading
		print("[EdgeScoreboard] : [" .. EdgeScoreboard.Version .. "] : Finished loading.")

		EdgeScoreboard.FinishedLoading = true

	end)

else

	-- Create the workspace table.
	EdgeScoreboard = {
		Owner = EDGESCOREBOARD_USER,
		Version = EDGESCOREBOARD_VERSION,
		Hash = EDGESCOREBOARD_HASH,
		Outdated = false,
		LatestVersion = EdgeScoreboard and EdgeScoreboard.LatestVersion or "",
	}

	-- Download client files.
	AddCSLuaFile("edgescoreboard/sh_language.lua")
	AddCSLuaFile("edgescoreboard/sh_configuration.lua")
	AddCSLuaFile("edgescoreboard/cl_main.lua")
	AddCSLuaFile("edgescoreboard/cl_gamemodesettings.lua")
	AddCSLuaFile("edgescoreboard/sh_notify.lua")
	AddCSLuaFile("edgescoreboard/cl_graph.lua")
	AddCSLuaFile("edgescoreboard/cl_playerrow.lua")
	AddCSLuaFile("edgescoreboard/cl_serverlist.lua")
	AddCSLuaFile("edgescoreboard/cl_utilitiestab.lua")
	AddCSLuaFile("edgescoreboard/cl_dermahandler.lua")
	AddCSLuaFile("edgescoreboard/cl_scoreboard.lua")
	AddCSLuaFile("edgescoreboard/cl_datamodifier.lua")
	AddCSLuaFile("edgescoreboard/cl_configuration.lua")

	-- Create a function to load the addon.
	function EdgeScoreboard.LoadAddon( )

		-- Print some startup information.
		print("[EdgeScoreboard] : [" .. EdgeScoreboard.Version .. "] : Starting up.")
		print("[EdgeScoreboard] : [" .. EdgeScoreboard.Version .. "] : Licensed to " .. EdgeScoreboard.Owner .. ".")

		-- Include serverside files.
		include("edgescoreboard/sh_notify.lua")
		include("edgescoreboard/sh_language.lua")
		include("edgescoreboard/sh_configuration.lua")
		include("edgescoreboard/sv_configuration.lua")
		include("edgescoreboard/sv_scoreboard.lua")

		-- Get in which way the content should be downloaded.
		local downloadType = EdgeScoreboard.GetConfigValue("ContentDownload")

		-- Check if the content should be sent from the server to the client.
		if downloadType ==  "Login Download + Workshop (Recommended)" or downloadType == "Login Download" then

			-- Search for materials.
			local files, _ = file.Find("materials/edgescoreboard/*","THIRDPARTY")

			-- Add files for download.
			for k,v in pairs(files) do
				resource.AddFile("materials/edgescoreboard/" .. v)
			end

		end

		-- Check if the content should be downloaded from the workshop.
		if downloadType ==  "Login Download + Workshop (Recommended)" or downloadType == "Workshop" then

			-- Download workshop content
			resource.AddWorkshop("2013145825")

		end

		-- Print that we have finished loading
		print("[EdgeScoreboard] : [" .. EdgeScoreboard.Version .. "] : Finished loading.")

		-- Check if there is any new update available.
		timer.Simple(0,function(  )

			-- Ask the server if there is a newer version.
			http.Post("http://jompe.phy.sx/edgescoreboard/checkversion.php",{version = EdgeScoreboard.Version}, function( result )

				-- Check if we received the result successfully.
				if (result) then

					-- Attempt to convert the result to a boolean.
					local jsonTbl = util.JSONToTable(result or "")

					if !jsonTbl or jsonTbl["Outdated"] == nil or !jsonTbl["Latest"] then return end

					-- Check if there is an update available.
					if jsonTbl["Outdated"] == true then

						EdgeScoreboard.Outdated = true
						EdgeScoreboard.LatestVersion = jsonTbl["Latest"]

						print("")
						print("[EdgeScoreboard] : [" .. EdgeScoreboard.Version .. "] : Your server is using an outdated version of EdgeScoreboard. Visit https://www.gmodstore.com/market/view/7003 to download the latest version.")
						print("[EdgeScoreboard] : [" .. EdgeScoreboard.Version .. "] : Using an updated version of EdgeScoreboard is important as updates may include new features, bug fixes or even exploit fixes.")
						print("[EdgeScoreboard] : [" .. EdgeScoreboard.Version .. "] : Always make sure to use an updated version of EdgeScoreboard to make your server less vulnerable to any possible vulnerabilities or bugs.")
						print("")

					end

				end

			end)

		end)


	end

end

-- Add a hook for InitPostEntity to load the addon.
hook.Add("OnGamemodeLoaded","EdgeScoreboard:LoadAddon",EdgeScoreboard.LoadAddon)

-- Check if the gamemode already have loaded.
if GAMEMODE then

	-- Load the addon.
	EdgeScoreboard.LoadAddon()

end