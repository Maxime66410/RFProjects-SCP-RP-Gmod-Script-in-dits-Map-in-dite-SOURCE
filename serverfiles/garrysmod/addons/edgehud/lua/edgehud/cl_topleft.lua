if EdgeHUD.Configuration.GetConfigValue( "TopLeft" ) then

	--Create a variable for the local player.
	local ply = LocalPlayer()

	--Create a copy of the colors and vars table.
	local COLORS = table.Copy(EdgeHUD.Colors)
	local VARS = table.Copy(EdgeHUD.Vars)

	--[[-------------------------------------------------------------------------
	Salary
	---------------------------------------------------------------------------]]

	local MAT_Salary = Material("edgehud/icon_salary.png","smooth")

	--Create the salaryWidget.
	local salaryWidget = vgui.Create("EdgeHUD:WidgetBox")
	salaryWidget:SetPos(VARS.ScreenMargin + EdgeHUD.LeftOffset,VARS.ScreenMargin + EdgeHUD.TopOffset)
	salaryWidget:SetWide(VARS.salaryWidgetWidth)

	--Register the derma element.
	EdgeHUD.RegisterDerma("InfoWidget_Salary", salaryWidget)

	--Create the salaryIcon.
	local salaryIcon = vgui.Create("DImage",salaryWidget)
	salaryIcon:SetSize(VARS.iconSize,VARS.iconSize)
	salaryIcon:SetMaterial(MAT_Salary)

	--Create the salaryLabel.
	local salaryLabel = vgui.Create("DLabel",salaryWidget)
	salaryLabel:SetFont("EdgeHUD:Small")
	salaryLabel:SetTextColor(COLORS["White"])
	salaryLabel:SetText("+" .. DarkRP.formatMoney(ply:getDarkRPVar("salary") or 0))
	salaryLabel:SizeToContents()

	--Create a UpdateInfo function for the salaryWidget.
	salaryWidget.UpdateInfo = function (  )

		--CHeck if the data is changed.
		if "+" .. DarkRP.formatMoney(ply:getDarkRPVar("salary") or 0) != salaryLabel:GetText() then

			--Update the label.
			salaryLabel:SetText("+" .. DarkRP.formatMoney(ply:getDarkRPVar("salary") or 0))
			salaryLabel:SizeToContents()

			--Calculate the IconPos.
			local iconPos = salaryWidget:GetWide() / 2 - (salaryIcon:GetWide() + VARS.labelMargin + salaryLabel:GetWide()) / 2

			--Set the positions
			salaryIcon:SetPos(iconPos,VARS.iconMargin)
			salaryLabel:SetPos(iconPos + salaryIcon:GetWide() + VARS.labelMargin, salaryWidget:GetTall() / 2 - salaryLabel:GetTall() / 2)

		end

	end

	--Calculate the IconPos.
	local iconPos = salaryWidget:GetWide() / 2 - (salaryIcon:GetWide() + VARS.labelMargin + salaryLabel:GetWide()) / 2

	salaryIcon:SetPos(iconPos,VARS.iconMargin)
	salaryLabel:SetPos(iconPos + salaryIcon:GetWide() + VARS.labelMargin, salaryWidget:GetTall() / 2 - salaryLabel:GetTall() / 2)

	--[[-------------------------------------------------------------------------
	Money
	---------------------------------------------------------------------------]]

	local MAT_Money = Material("edgehud/icon_money.png","smooth")

	--Create the moneyWidget.
	local moneyWidget = vgui.Create("EdgeHUD:WidgetBox")
	moneyWidget:SetPos(VARS.ScreenMargin + VARS.ElementsMargin + VARS.salaryWidgetWidth + EdgeHUD.LeftOffset,VARS.ScreenMargin + EdgeHUD.TopOffset)
	moneyWidget:SetWide(VARS.moneyWidgetWidth)

	--Register the derma element.
	EdgeHUD.RegisterDerma("InfoWidget_Money", moneyWidget)

	--Create the moneyIcon.
	local moneyIcon = vgui.Create("DImage",moneyWidget)
	moneyIcon:SetSize(VARS.iconSize,VARS.iconSize)
	moneyIcon:SetPos(VARS.iconMargin,VARS.iconMargin)
	moneyIcon:SetMaterial(MAT_Money)

	--Create a variable that holds the lerped money.
	local lerpedMoney = ply:getDarkRPVar("money") or 0

	--Create the moneyLabel.
	local moneyLabel = vgui.Create("DLabel",moneyWidget)
	moneyLabel:SetFont("EdgeHUD:Small")
	moneyLabel:SetTextColor(COLORS["White"])
	moneyLabel:SetText(DarkRP.formatMoney(lerpedMoney))
	moneyLabel:SizeToContents()

	--Create a think function for the MOneyLabel.
	moneyLabel.Think = function(  )

		--Cache the current money.
		local curMoney = ply:getDarkRPVar("money") or 0

		--Check if the money has changed.
		if math.Round(lerpedMoney) != curMoney then

			--Lerp the money.
			lerpedMoney = Lerp(FrameTime() * 8,lerpedMoney,curMoney)

			--Update the EdgeHUD.calcData.
			moneyLabel:SetText(DarkRP.formatMoney(math.Round(lerpedMoney)))
			moneyLabel:SizeToContents()

			--Calculate the IconPos.
			iconPos = moneyWidget:GetWide() / 2 - (moneyIcon:GetWide() + VARS.labelMargin + moneyLabel:GetWide()) / 2

			--Set the positions.
			moneyIcon:SetPos(iconPos,VARS.iconMargin)
			moneyLabel:SetPos(iconPos + moneyIcon:GetWide() + VARS.labelMargin, moneyWidget:GetTall() / 2 - moneyLabel:GetTall() / 2)

		end

	end

	--Calculate the IconPos.
	iconPos = moneyWidget:GetWide() / 2 - (moneyIcon:GetWide() + VARS.labelMargin + moneyLabel:GetWide()) / 2

	moneyIcon:SetPos(iconPos,VARS.iconMargin)
	moneyLabel:SetPos(iconPos + moneyIcon:GetWide() + VARS.labelMargin, moneyWidget:GetTall() / 2 - moneyLabel:GetTall() / 2)

	--[[-------------------------------------------------------------------------
	Misc
	---------------------------------------------------------------------------]]

	--Create a var that holds if the panels should be made visible or invisible.
	local visibility = true

	--Create a hook for when the player changes weapon.
	hook.Add("PlayerSwitchWeapon","EdgeHUD:HideTopLeft",function( _, _, newWeapon )

		visibility = true

		--Check if the hud should be hidden.
		if IsValid(newWeapon) and newWeapon:GetClass() == "gmod_tool" then
			visibility = false
		end

		salaryWidget:SetVisible(visibility)
		moneyWidget:SetVisible(visibility)

	end)

	local old_spawnmenuActivateTool = spawnmenu.ActivateTool

	--Overrride spawnmenu.ActivateTool.
	function spawnmenu.ActivateTool( ... )

		local weapon = LocalPlayer():GetActiveWeapon()

		if IsValid(weapon) and weapon:GetClass() == "gmod_tool" and IsValid(salaryWidget) and IsValid(moneyWidget) then
			visibility = false
			salaryWidget:SetVisible(false)
			moneyWidget:SetVisible(false)
		end

		return old_spawnmenuActivateTool(...)

	end

	-- Create a timer as the playerSwitchWeapon hook isnt called sometimes.
	timer.Create("EdgeHUD:FixTopLeft",0.5,0,function(  )

		-- Get the player's weapon.
		local curWeapon = ply:GetActiveWeapon()

		if IsValid(curWeapon) and curWeapon:GetClass() == "gmod_tool" then
			visibility = false
		else
			visibility = true
		end

		salaryWidget:SetVisible(visibility)
		moneyWidget:SetVisible(visibility)

	end)

	hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_HideTopLeft",function(  )
		hook.Remove("PlayerSwitchWeapon","EdgeHUD:HideTopLeft")
		timer.Remove("EdgeHUD:FixTopLeft")
	end)


	--[[-------------------------------------------------------------------------
	DarkRP Vote & Question.
	---------------------------------------------------------------------------]]

	if EdgeHUD.Configuration.GetConfigValue( "VoteHUD" ) then

		local oldUsrMsgFunc_vote
		local oldUsrMsgFunc_question
		local curVote

		timer.Create("EdgeHUD:LoadVoteHUD",0.5,60,function(  )

			local userMsgs = usermessage.GetTable()

			if !userMsgs["DoVote"] or !userMsgs["DoQuestion"] then return end

			oldUsrMsgFunc_vote = userMsgs["DoVote"]["Function"]
			oldUsrMsgFunc_question = userMsgs["DoQuestion"]["Function"]

			--Override default vote userMsghook.
			usermessage.Hook("DoVote", function(  )	end)

			--Create a table for all derma panels.
			local voteQueue = {}

			--Create a queueWidget.
			local queueWidget = vgui.Create("EdgeHUD:WidgetBox")
			queueWidget:SetWide(VARS.voteWindowWidth)
			queueWidget:SetPos(VARS.ScreenMargin + EdgeHUD.LeftOffset, VARS.ScreenMargin + VARS.WidgetHeight + VARS.ElementsMargin * 2 + VARS.voteWindowHeight + EdgeHUD.TopOffset)
			queueWidget:SetVisible(false)
			queueWidget.renderBehind = false
			queueWidget:MoveToFront()

			queueWidget.Think = function(  )
				queueWidget:SetAlpha(visibility == true and EdgeHUD.shouldDraw == true and 255 or 0)
			end

			--Register the derma element.
			EdgeHUD.RegisterDerma("queueWidget", queueWidget)

			--Create a queueLabel.
			local queueLabel = vgui.Create("DLabel",queueWidget)
			queueLabel:SetFont("EdgeHUD:Small")
			queueLabel:SetTextColor(COLORS["White"])

			--Create a function for the queueLabel.
			queueLabel.updateQueue = function(  )

				queueLabel:SetText(string.Replace(EdgeHUD.GetPhrase("VOTE_QUEUE"), "%V", #voteQueue))
				queueLabel:SizeToContents()
				queueLabel:SetPos(queueWidget:GetWide() / 2 - queueLabel:GetWide() / 2, queueWidget:GetTall() / 2 - queueLabel:GetTall() / 2)

				queueWidget:SetVisible(#voteQueue != 0)

			end

			--Update the text.
			queueLabel.updateQueue()

			--Add a timer that looks for votes that have timed out.
			timer.Create("EdgeHUD:VoteQueue_Cleaner",1,0,function(  )

				--Loop through all the votes.
				for i = 1,#voteQueue do

					--Make a variable for the current vote.
					local voteObject = voteQueue[i]

					--Check if the time is up.
					if voteObject.ending < CurTime() then

						--Remove the current one from the table.
						voteQueue[i] = nil

						--Update the queueLabel.
						queueLabel.updateQueue()

					end

				end

				--Clear the keys.
				voteQueue = table.ClearKeys(voteQueue)

			end)

			--Create a function to start a vote.
			local function startVote( id, question, time, isVote )

				--Create the window.
				local window = vgui.Create("EdgeHUD:WidgetBox")
				window:SetSize(VARS.voteWindowWidth,VARS.voteWindowHeight)
				window:SetPos(VARS.ScreenMargin + EdgeHUD.LeftOffset, VARS.ScreenMargin + VARS.WidgetHeight + VARS.ElementsMargin + EdgeHUD.TopOffset)
				window.renderBehindOther = false
				window:MoveToFront()

				window.Think = function(  )
					window:SetAlpha(visibility == true and EdgeHUD.shouldDraw == true and 255 or 0)
				end

				--Set curVote.
				curVote = window

				--Add a OnRemove function for the window.
				window.OnRemove2 = function(  )

					--Reset curVote.
					curVote = nil

					--Check if there is another vote in queue.
					if #voteQueue == 0 then return end

					--Create a var for the new vote.
					local newVote = voteQueue[1]

					--STart the new vote.
					startVote(newVote.id, newVote.question, newVote.ending - CurTime(),newVote.isVote)

					--Remove the item from queue.
					voteQueue[1] = nil

					--Reset the table keys.
					voteQueue = table.ClearKeys(voteQueue)

					--Update the queueLabel.
					queueLabel.updateQueue()

				end

				--Check so the vote haven't expired.
				if time < 0 then window:Remove() return end

				--Remove the window if the time runs out.
				timer.Simple(time,function(  )

					--Check if the window exists.
					if IsValid(window) then
						window:Remove()
					end

				end)

				local voteTitle = ""

				if isVote then
					voteTitle = EdgeHUD.GetPhrase("VOTE_TITLE_VOTE")
				else
					voteTitle = EdgeHUD.GetPhrase("VOTE_TITLE_QUESTION")
				end

				--Create the titleLabel.
				local titleLabel = vgui.Create("DLabel",window)
				titleLabel:SetFont("EdgeHUD:Medium")
				titleLabel:SetTextColor(COLORS["Red"])
				titleLabel:SetText(string.upper(voteTitle))
				titleLabel:SizeToContents()
				titleLabel:SetPos(VARS.ElementsMargin, VARS.ElementsMargin)

				--Create the question.
				local questionLabel = vgui.Create("RichText",window)
				questionLabel:SetSize(window:GetWide() - VARS.ElementsMargin * 2,window:GetTall() * 0.4)
				questionLabel:SetPos(VARS.ElementsMargin - 3,VARS.ElementsMargin + titleLabel:GetTall())
				questionLabel:SetVerticalScrollbarEnabled(false)
				questionLabel:InsertColorChange(255,255,255,255)
				questionLabel:AppendText(DarkRP.deLocalise(question))
				questionLabel:SetContentAlignment(5)

				--Set the font.
				questionLabel.PerformLayout = function(  )
					questionLabel:SetFontInternal("EdgeHUD:Small")
				end

				--Create a variable from when the vote started.
				local voteStarted = CurTime()

				--Create the timelabel.
				local timeLabel = vgui.Create("DLabel",window)
				timeLabel:SetFont("EdgeHUD:Small")
				timeLabel:SetTextColor(COLORS["White"])

				--Update the timeLabel.
				timeLabel.Think = function(  )

					--Calculate the time.
					local calcTime = math.max(math.floor(time - (CurTime() - voteStarted)),0)

					--Check if the timeLabel needs to be updated.
					if timeLabel:GetValue() != tostring(calcTime) then

						timeLabel:SetText(string.Replace(EdgeHUD.GetPhrase("VOTE_EXPIRE"), "%T", EdgeHUD.FormatTime( calcTime )))
						timeLabel:SizeToContents()
						timeLabel:SetPos(window:GetWide() / 2 - timeLabel:GetWide() / 2, window:GetTall() * 0.65)

					end

				end

				--Calculate the size of the buttons.
				local buttonSize = (window:GetWide() - VARS.ElementsMargin * 3) / 2

				--Create a draw function for the buttons.
				local drawFunction = function( s, w, h )

					--Draw the background.
					surface.SetDrawColor(s:IsHovered() and COLORS["Gray_Transparent"] or COLORS["Black_Transparent"])
					surface.DrawRect(0,0,w,h)

					--Draw the white outline.
					surface.SetDrawColor(COLORS["White_Outline"])
					surface.DrawOutlinedRect(0,0,w,h)

					--Draw the corners.
					surface.SetDrawColor(COLORS["White_Corners"])
					EdgeHUD.DrawEdges(0,0,w,h, 8)

				end

				--Create the yesButton.
				local yesButton = vgui.Create("DButton",window)
				yesButton:SetSize(buttonSize,titleLabel:GetTall())
				yesButton:SetPos(VARS.ElementsMargin,window:GetTall() - VARS.ElementsMargin - yesButton:GetTall())
				yesButton:SetFont("EdgeHUD:Small")
				yesButton:SetText(EdgeHUD.GetPhrase("VOTE_YES"))
				yesButton:SetTextColor(COLORS["White"])
				yesButton.Paint = drawFunction
				yesButton.DoClick = function(  )

					if isVote then
						ply:ConCommand("vote " .. id .. " yea\n")
					else
						ply:ConCommand("ans " .. id .. " 1")
					end

					window:Remove()
					surface.PlaySound("buttons/lightswitch2.wav")
				end

				yesButton.OnCursorEntered = function(  )
					surface.PlaySound("UI/buttonrollover.wav")
				end

				--Create the noButton.
				local noButton = vgui.Create("DButton",window)
				noButton:SetSize(buttonSize,titleLabel:GetTall())
				noButton:SetPos(VARS.ElementsMargin * 2 + buttonSize,window:GetTall() - VARS.ElementsMargin - noButton:GetTall())
				noButton:SetFont("EdgeHUD:Small")
				noButton:SetText(EdgeHUD.GetPhrase("VOTE_NO"))
				noButton:SetTextColor(COLORS["White"])
				noButton.Paint = drawFunction
				noButton.DoClick = function(  )

					if isVote then
						ply:ConCommand("vote " .. id .. " nay\n")
					else
						ply:ConCommand("ans " .. id .. " 2")
					end

					window:Remove()
					surface.PlaySound("buttons/lightswitch2.wav")

				end

				noButton.OnCursorEntered = function(  )
					surface.PlaySound("UI/buttonrollover.wav")
				end

			end

			--Add a receiver for EdgeHUD:DarkRP_Vote.
			net.Receive("EdgeHUD:DarkRP_Vote",function()

				if visibility == false then
					notification.AddLegacy(EdgeHUD.GetPhrase("VOTE_PENDING"),NOTIFY_HINT,5)
				end

				--Read the data.
				local id = net.ReadUInt(10)
				local question = net.ReadString()
				local time = net.ReadUInt(8)

				--Play sound.
				surface.PlaySound("plats/elevbell1.wav")

				--Check if there is a vote in progress.
				if IsValid(curVote) then

					--Insert the vote into queue.
					table.insert(voteQueue,{id = id, question = question, ending = CurTime() + time, isVote = true})

					--Update the queueLabel.
					queueLabel.updateQueue()

					--Make the queueWidget visible.
					queueWidget:SetVisible(true)

				else
					--Start the vote.
					startVote(id, question, time, true)
				end

			end)

			usermessage.Hook("DoQuestion", function( msg )

				if visibility == false then
					notification.AddLegacy(EdgeHUD.GetPhrase("VOTE_PENDING"),NOTIFY_HINT,5)
				end

				local question = msg:ReadString()
				local quesid = msg:ReadString()
				local timeleft = msg:ReadFloat()

				--Play sound.
				surface.PlaySound("plats/elevbell1.wav")

				--Check if there is a vote in progress.
				if IsValid(curVote) then

					--Insert the vote into queue.
					table.insert(voteQueue,{id = quesid, question = question, ending = CurTime() + timeleft, isVote = false})

					--Update the queueLabel.
					queueLabel.updateQueue()

					--Make the queueWidget visible.
					queueWidget:SetVisible(true)

				else
					--Start the vote.
					startVote(quesid, question, timeleft, false)
				end

			end)

			timer.Remove("EdgeHUD:LoadVoteHUD")

		end)


		hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_VoteUI",function(  )

			net.Receive("EdgeHUD:DarkRP_Vote",function(  ) end)

			timer.Remove("EdgeHUD:VoteQueue_Cleaner")
			timer.Remove("EdgeHUD:LoadVoteHUD")

			if curVote and IsValid(curVote) and ispanel(curVote) then
				curVote.OnRemove2 = function(  ) end
				curVote:Remove()
			end

			if (oldUsrMsgFunc_vote and oldUsrMsgFunc_question) and (isfunction(oldUsrMsgFunc_vote) and isfunction(oldUsrMsgFunc_question)) then
				usermessage.Hook("DoVote", oldUsrMsgFunc_vote)
				usermessage.Hook("DoQuestion", oldUsrMsgFunc_question)
			end

		end)

	end

end