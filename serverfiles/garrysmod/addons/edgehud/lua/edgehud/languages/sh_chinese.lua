--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeHUD.RegisterLanguage({
	Name = "Chinese",
	Author = "辉梦",
	CompatibleVersion = "1.14.0",
})

--[[-------------------------------------------------------------------------
Phrases - Lower Left
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"IDENTITY", "名称")
EdgeHUD.AddPhrase(LANG,"JOB", "职位")

--[[-------------------------------------------------------------------------
Phrases - Lower Right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_KPH","KPH")
EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_MPH","MPH")

--TAGS: %P = Amount of props.
EdgeHUD.AddPhrase(LANG,"PROPLIMIT","%P 实体")

EdgeHUD.AddPhrase(LANG,"GUNLICENSE","枪支许可证")

--[[-------------------------------------------------------------------------
Phrases - Top Left
---------------------------------------------------------------------------]]

--TAGS: %V = Number of votes
EdgeHUD.AddPhrase(LANG,"VOTE_QUEUE","有%V项目在队列中!")

EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_VOTE","投票")
EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_QUESTION","问题")

--TAGS: %T = Time until expiration.
EdgeHUD.AddPhrase(LANG,"VOTE_EXPIRE","%T后过期")

EdgeHUD.AddPhrase(LANG,"VOTE_YES","是")
EdgeHUD.AddPhrase(LANG,"VOTE_NO","否")

EdgeHUD.AddPhrase(LANG,"VOTE_PENDING","[EdgeHUD] 你有一个新的投票/问题待定。收起你的工具枪来投票。")

--[[-------------------------------------------------------------------------
Phrases - Top right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN_TITLE","全 境 封 锁")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN","市长已经启动了封锁，请大家回到家里去!")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED_TITLE","通 缉 令")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED","你被通缉了！警察正在寻找你！")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED_TITLE","被 逮 捕")

--TAGS: %T = Time until release.
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED","你将在%T后被释放。")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_AGENDAHELP","在聊天中输入 /agenda <message> 来修改议程。")

--[[-------------------------------------------------------------------------
Phrases - Time
---------------------------------------------------------------------------]]

--TAGS: %H = Hours, %M = Minutes
EdgeHUD.AddPhrase(LANG,"TIME_HOUR_MIN","%H小时%M分钟")

--TAGS: %M = Minutes, %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_MIN_SEC","%M分钟%S秒")

--TAGS: %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_SEC","%S秒")

--[[-------------------------------------------------------------------------
Phrases - Arrested
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ARRESTED", "逮捕")

--TAGS: %C = Criminal Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_COP", "你逮捕了%C并关了他%T.")

--TAGS: %P = Officer Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT", "你被%P逮捕了%T.")
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT2", "你被关了%T.")

--[[-------------------------------------------------------------------------
Phrases - Released
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"RELEASED", "释放")

--TAGS: %C = Criminal Name
EdgeHUD.AddPhrase(LANG,"RELEASED_COP", "你把%C从监狱里放出来了。")

EdgeHUD.AddPhrase(LANG,"RELEASED_SUSPECT", "你已经出狱了")

--[[-------------------------------------------------------------------------
Phrases - Wanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WANTED", "通缉")

--TAGS: %C = Criminal Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_COP", "你以%R的罪名通缉了%C。")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT", "你因为%R被%P通缉。")
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT2", "你因为犯了%R而被通缉！")

--[[-------------------------------------------------------------------------
Phrases - Unwanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWANTED", "取消通缉")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWANTED_COP", "你取消了%S的通缉令")

EdgeHUD.AddPhrase(LANG,"UNWANTED_SUSPECT", "你已经摆脱了警方的通缉！")

--[[-------------------------------------------------------------------------
Phrases - Warranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WARRANTED", "搜查令")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"WARRANTED_COP", "你现在可以搜索%S的建筑物了。")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT", "你收到了来自%P递交的搜查令，理由是%R。")
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT2", "你因为%R而收到了搜查令！")

--[[-------------------------------------------------------------------------
Phrases - Unwarranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWARRANTED", "取消搜查令")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWARRANTED_COP", "你取消了对%S下的搜查令。")

EdgeHUD.AddPhrase(LANG,"UNWARRANTED_SUSPECT", "你的搜查令被取消了。")

--[[-------------------------------------------------------------------------
Phrases - Vehicle Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE", "载具")

--TAGS: %N = Name of owner
EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER", "拥有者：%N")

--TAGS: %G = Groupname
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_GROUP", "授权于：%G")

--TAGS: %J = Number of jobs
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_JOBS", "授权于：%J职业")

EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER_UNKNOWN", "拥有者：未知")

EdgeHUD.AddPhrase(LANG,"VEHICLE_NOTOWNABLE", "无拥有者")

EdgeHUD.AddPhrase(LANG,"VEHICLE_UNOWNED", "未拥有")

EdgeHUD.AddPhrase(LANG,"VEHICLE_COOWNERS", "共同所有者：")

EdgeHUD.AddPhrase(LANG,"VEHICLE_ALLOWED_COOWNERS", "允许的共同拥有者：")

--[[-------------------------------------------------------------------------
Phrases - Door Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOOR_SOLD", "出售门")
EdgeHUD.AddPhrase(LANG,"DOOR_FORSALE", "待售")
EdgeHUD.AddPhrase(LANG,"DOOR_F2PURCHASE", "按F2键购买门")

EdgeHUD.AddPhrase(LANG,"DOOR_COOWNERS", "共同拥有者：")
EdgeHUD.AddPhrase(LANG,"DOOR_ALLOWED_COOWNERS", "允许的共同拥有者：")

--TAGS: %G = Name of group.
EdgeHUD.AddPhrase(LANG,"DOOR_GROUP_TITLE", "集团门")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_GROUP", "授权于：%G")

--TAGS: %J = Number of jobs.
EdgeHUD.AddPhrase(LANG,"DOOR_TEAM_TITLE", "团队门")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_TEAM", "授权于：%J职业")

--TAGS: %N = Name of owner.
EdgeHUD.AddPhrase(LANG,"DOOR_OWNER", "拥有者：%N")

EdgeHUD.AddPhrase(LANG,"DOOR_OWNER_UNKNOWN", "拥有者：未知")

--[[-------------------------------------------------------------------------
Phrases - Situations
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"LOCKDOWN", "全 境 封 锁")

EdgeHUD.AddPhrase(LANG,"LOCKDOWN_INITIATED", "市长已经启动了封锁，请大家回到家里去!")

--[[-------------------------------------------------------------------------
Phrases - Door Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_DOOR", "买门")
EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_VEHICLE", "购买车辆")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_DOOR", "卖门")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_VEHICLE", "出售车辆")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ADDOWNER", "添加拥有者")
EdgeHUD.AddPhrase(LANG,"DOORMENU_REMOVEOWNER", "移除拥有者")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ALLOWOWNERSHIP", "允许所有权")
EdgeHUD.AddPhrase(LANG,"DOORMENU_DISALLOWOWNERSHIP", "取消所有权")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_DOOR", "设置门的名称")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_VEHICLE", "设置车辆名称")

EdgeHUD.AddPhrase(LANG,"DOORMENU_EDITGROUPS", "编辑组访问")

--[[-------------------------------------------------------------------------
Phrases - Crash Screen
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TITLE", "连接丢失")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT1", "服务器的连接似乎被中断了。")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT2", "请稍候，我们尝试建立新的连接。")

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_RECONNECT", "重新连接")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_LEAVE", "离开")

--[[-------------------------------------------------------------------------
Phrases - Gesture Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"GESTURE_BOW", "鞠躬")
EdgeHUD.AddPhrase(LANG,"GESTURE_SEXYDANCE", "性感的舞蹈")
EdgeHUD.AddPhrase(LANG,"GESTURE_FOLLOWME", "跟我走")
EdgeHUD.AddPhrase(LANG,"GESTURE_LAUGH", "大笑")
EdgeHUD.AddPhrase(LANG,"GESTURE_LIONPOSE", "Lion pose")
EdgeHUD.AddPhrase(LANG,"GESTURE_NONVERBALNO", "Non-verbal no")
EdgeHUD.AddPhrase(LANG,"GESTURE_THUMBSUP", "竖起大拇指")
EdgeHUD.AddPhrase(LANG,"GESTURE_WAVE", "Wave")
EdgeHUD.AddPhrase(LANG,"GESTURE_DANCE", "舞蹈")

--[[-------------------------------------------------------------------------
Phrases - Vehicle warnings HUD.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXTERIORLIGHT", "[载具]：车辆外部照明灯坏了。继续行驶前请检查车灯。")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXHAUST", "[载具]：检测到排气管损坏，请立即维修车辆，防止发动机损坏。")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_ENGINE", "[载具]：发现发动机损坏，立即维修车辆，防止发动机进一步损坏。")

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTLEFT", "前-左")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTRIGHT", "前-右")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKLEFT", "后-左")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKRIGHT", "后-右")

--TAGS: %T = Damaged tires.
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRES", "[载具]：轮胎胎压损失（%T）。")

--[[-------------------------------------------------------------------------
Phrases - Battery Notifications.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CHARGER_CONNECTED", "充电器已连接")
EdgeHUD.AddPhrase(LANG,"CHARGER_DISCONNECTED", "充电器断线")
EdgeHUD.AddPhrase(LANG,"BATTERY_STATUS", "电池状态")

EdgeHUD.AddPhrase(LANG,"CHARGING_STARTED", "你的电脑现在正在充电。")
EdgeHUD.AddPhrase(LANG,"CHARGING_ABORTED", "电脑充电结束。")

--TAGS: %B = Battery precentage left.
EdgeHUD.AddPhrase(LANG,"BATTERY_NOTICE", "您目前还剩下%B%的电池。请连接充电器继续使用。")

--[[-------------------------------------------------------------------------
Phrases - Level bar
---------------------------------------------------------------------------]]

--TAGS: %L = Current Level, %P = Percentage to next level
EdgeHUD.AddPhrase(LANG,"LEVELBAR", "等级%L - %P%")

--[[-------------------------------------------------------------------------
Phrases - AdminTell
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ADMINTELL_TITLE", "管理通知")
EdgeHUD.AddPhrase(LANG,"ADMINTELL_NOMSG", "没有提供任何信息")

--[[-------------------------------------------------------------------------
Phrases - General
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CLOSE","关闭")