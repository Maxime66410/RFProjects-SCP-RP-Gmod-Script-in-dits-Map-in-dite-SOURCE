--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeScoreboard.RegisterLanguage({
	Name = "Chinese",
	Author = "辉梦",
	CompatibleVersion = "1.5.2",
})

--[[-------------------------------------------------------------------------
Left Sidebar
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_PLAYERS", "玩家")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SERVERS", "服务器")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WEBSITE", "官网")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_DONATE", "赞助")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_UTILITIES", "实用工具")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_WORKSHOP", "创意工坊")
EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_REQUESTSTAFF", "联系管理员")

EdgeScoreboard.AddPhrase(LANG,"SIDEBARLEFT_SEARCHFIELD", "搜索")

EdgeScoreboard.AddPhrase(LANG,"WEBSITE_URL_COPIED", "URL已被复制到你的剪贴板。")

--[[-------------------------------------------------------------------------
Statistics
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_SERVER", "服务器数据")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLYCOUNT", "玩家人数")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_STAFF", "管理员在线")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_UPTIME", "正常运行时间")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_AVGPING", "平均延迟")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_GAME", "目前游玩数据")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PLAYTIME", "游玩时间")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_SESSION", "会话时间")
EdgeScoreboard.AddPhrase(LANG,"STATS_PREFIX_PING", "延迟")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT", "玩家人数")
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_PLYCOUNT_SUFFIX", "3h") -- Stands for 3 hours
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_LOWEST", "最低玩家数")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_HIGHEST", "最高玩家数")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_AVERAGE", "平均玩家数")
EdgeScoreboard.AddPhrase(LANG,"STATS_PLYCOUNT_CURRENT", "当前玩家数")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD", "K/D") -- Stands for Kills (Divided by) Deaths 
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_KD_SUFFIX", "1h") -- Stands for 1 hour
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_KILLS", "击杀数")
EdgeScoreboard.AddPhrase(LANG,"STATS_KD_DEATHS", "死亡数")

EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS", "FPS") -- Stands for "Frames Per Second"
EdgeScoreboard.AddPhrase(LANG,"STATS_TITLE_FPS_SUFFIX", "30m") -- Stands for 30 minutes
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_KILLS", "FPS")
EdgeScoreboard.AddPhrase(LANG,"STATS_FPS_DEATHS", "平均FPS") -- Stands for "Average FPS"

--[[-------------------------------------------------------------------------
Server Browser
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SERVERS_MAP_PREFIX", "地图")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_GM_PREFIX", "游戏模式")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_PS_PREFIX", "玩家容量")
EdgeScoreboard.AddPhrase(LANG,"SERVERS_IP_PREFIX", "IP地址")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD", "无附加服务器")
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_NOADD_SUBTIT", "看来这个社区的管理员好像还没有添加任何额外的服务器。")

EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_CONNECT", "加入")

-- TAGS: %S = Server Name or IP
EdgeScoreboard.AddPhrase(LANG,"SERVERLIST_VERIFY_CONNECT", "你确定你要连接到%S吗？")

--[[-------------------------------------------------------------------------
Player Row
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PING", "延迟")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_DEATHS", "死亡数")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KILLS", "击杀数")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_SCORE", "分数")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_KARMA", "人品值")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_PLAYTIME", "游戏时间")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_NAME", "名称")

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_RANK", "权限组")
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_JOB", nil) -- English: Job
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_LEVEL", nil) -- English: Level
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_WALLET", nil) -- English: Money
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_PREFIX_STATUS", nil) -- English: Status

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_WANTED", nil) -- English: Wanted
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ARRESTED", nil) -- English: Arrested
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_ALIVE", nil) -- English: Alive 
EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_STATUS_DEAD", nil) -- English: Dead

EdgeScoreboard.AddPhrase(LANG,"PLAYERLIST_MURDER_JOINTEAM", "加入")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_COPIED", "信息已被复制到你的剪贴板上。")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAM", "访问Steam简介")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_MUTE", "静音玩家")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_UNMUTE", "取消禁言玩家")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_INFO", "信息")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_USERNAME", "复制用户名")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_GROUP", "复制用户组")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TEAM", "复制团队名称")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID", "复制SteamID")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_STEAMID64", "复制Steam64ID")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_ACT_TRANSFER", "转移玩家")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP", "输入IP")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_ENTERIP_LONG", "输入你要让玩家连接的服务器的IP地址和端口。")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_INVALIDIP", "你输入的IP地址不是有效的IP地址。")

-- Tags: %N = Server Name
EdgeScoreboard.AddPhrase(LANG,"PLYROW_TRANSFER_VERIFY", "你确定要把这个玩家转到%N吗？")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_RANK_NONE", "无")

-- Tags: %M = Number (Money)
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_THOUSAND", nil) -- English: %MK
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_MILLION", nil) -- English: %MM
EdgeScoreboard.AddPhrase(LANG,"PLYROW_MONEY_BILLION", nil) -- English: %MB

--[[-------------------------------------------------------------------------
Admin Player Actions
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOTO", "传送至该玩家身边")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BRING", "将玩家传送到你身边")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_RETURN", "返回")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETTEAM", "切换队伍")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGFREEZE", "切换冻结")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_FREEZE", "冻结")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNFREEZE", "解冻")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_BAN", "封禁")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_KICK", "踢出")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGJAIL", "切换监狱")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_JAIL", "关入监狱")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNJAIL", "释放")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCHATMUTE", "切换聊天静音")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATMUTE", "禁言")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CHATUNMUTE", "解除")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGVOICEMUTE", "切换语音静音")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEMUTE", "禁言")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_VOICEUNMUTE", "解除")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SPECTATE", "监视")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_STRIP", "没收武器")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SETHP", "设定生命值")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGGOD", "切换无敌模式")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_GOD", "开启无敌")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_UNGOD", "关闭无敌")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAY", "处死")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGIGNITE", "切换燃烧")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SLAP", "扇巴掌")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_TOGCLOAK", "隐身")

EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_REASON", "输入执行这一行动的原因。")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_SECONDS", "你希望这个操作能应用多少秒？")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_MINUTES", "你希望这个操作能应用多少分钟？")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_HOURS", "你希望这个操作能应用多少小时？")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_CONFIRM", "你确定你要执行这个操作吗？")
EdgeScoreboard.AddPhrase(LANG,"PLYROW_AACT_NUMBER", "输入与此命令相关的值。")

--[[-------------------------------------------------------------------------
Utilities
---------------------------------------------------------------------------]]

-- Tags: // = Put this between the two words that are closest to the center of the text.
EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL", "个人//行动")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD", "记分板//行动")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER", "服务器//行动")

EdgeScoreboard.AddPhrase(LANG,"UTIL_PERSONAL_DESC", "使用此菜单可以轻松地对玩家执行不同的操作，而不需要输入长的命令。")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SCOREBOARD_DESC", "利用这个菜单，可以将自己隐藏在记分板上，控制自己在记分板上的假身份。")
EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_DESC", "使用此菜单可轻松更改服务器设置或在服务器上执行操作。")

EdgeScoreboard.AddPhrase(LANG,"UTIL_GOBACK", "返回至实用工具")

EdgeScoreboard.AddPhrase(LANG,"UTIL_SERVER_NOPERMISSION", "你没有权限在这个类别中进行任何操作。")

--[[-------------------------------------------------------------------------
Personal Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY", "自杀")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME", "更改RP名称")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY", "扔钱")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE", nil) -- English: Create Cheque
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS", "卖出所有门")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM", "加入对立团队")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS", "移除所有实体")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SLAY_DESC", "你 杀 你 自 己")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_RPNAME_DESC", "改变你在角色扮演的名称。")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_DROPMONEY_DESC", "把钱丢在你面前的地上。")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_CHEQUE_DESC", nil) -- English: Creates a money cheque on the ground in front of you.
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_SELLALLDOORS_DESC", "卖掉你目前拥有的所有门。")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_MURDER_JOINOPPOSITETEAM_DESC", "在玩家和观察者之间的切换。")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_REMOVEPROPS_DESC", "移除你拥有的所有实体")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SLAY", "你确定要自杀吗？")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RPNAME", "你想给你的角色起什么名字？")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_DROPMONEY", "你想扔多少钱？")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_CHEQUE", nil) -- English: Who should be able to pick up the money?
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_SELLALLDOORS", "你确定你要把你现在拥有的门都卖掉吗？")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_REMOVEALLPROPS", "你确定要把你所有的实体都移除吗？")

--[[-------------------------------------------------------------------------
Scoreboard Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET", "重置身份")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW", "显示自己")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE", "隐藏自己")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME", "偽造用戶名")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR", "恶搞头像")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SPOOF", "恶搞权限组")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE", "隐藏权限组")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW", "显示权限组")

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESET_DESC", "重置你的身份。")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SHOW_DESC", "再次在记分牌上显示你。")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_HIDE_DESC", "把你从记分板上删除。")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_USERNAME_DESC", "在记分牌上伪造你的用户名。")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_AVATAR_DESC", "伪装自己的头像上的记分牌。")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_FAKE_DESC", "在记分牌上伪造自己的权限组。")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_HIDE_DESC", "将你的权限组隐藏。")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RANK_SHOW_DESC", "将你的权限组显示。")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RESET", "你确定要把你的假身份设置成默认吗？")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_VISIBILITY", "你确定要改变你在记分牌的可见度吗？")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_USERNAME", "输入你想冒充的用户名，或者什么都不输则重置。")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_AVATAR", "输入Steam用户的SteamID来使用他们的Steam头像，或者什么都不输则重置。")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANK", "输入你想冒充的等级，或者什么都不输则重置。")
EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_QUERY_RANKVISIBILITY", "你确定要改变你的权限组可见度吗？")

EdgeScoreboard.AddPhrase(LANG,"PERS_UTIL_INVALIDSTEAMID", "你输入的SteamID格式无效。")

--[[-------------------------------------------------------------------------
Server Utilities
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP", "重启地图")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS", "移除所有实体")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT", "服务器公告")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG", "EdgeScoreboard配置")

EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_RESTARTMAP_DESC", "重启地图，让所有玩家重新连接。")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_CLEANSERVERPROPS_DESC", "删除服务器上所有人的实体。")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SERVERANNOUNCEMENT_DESC", "在所有玩家的屏幕上显示公告。")
EdgeScoreboard.AddPhrase(LANG,"SCRB_UTIL_SCCONFIG_DESC", "打开EdgeScoreboard配置。")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_FADMIN_DESC", "[FAdmin] 设置/行动。")

-- %Q = Math Question (2+2, 1+2, etc)
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHQUESTION", "请输入%Q的答案来执行此操作。")

EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_MATHWRONG", "请正确回答数学题来执行此操作。")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_TITLE", "服务器公告的标题是什么？")
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_ANNOUNCEMENT_MESSAGE", "服务器公告的内容应该写什么？")

-- Tags: %N = Name of player.
EdgeScoreboard.AddPhrase(LANG,"SERV_UTIL_REMOVEDPROPS", "%N删除了所有人的实体。")

--[[-------------------------------------------------------------------------
Misc
---------------------------------------------------------------------------]]

EdgeScoreboard.AddPhrase(LANG,"UNCATEGORIZED", "未分类的队伍")

EdgeScoreboard.AddPhrase(LANG,"LOADING_WEBSITE", "正在加载网站.....")
EdgeScoreboard.AddPhrase(LANG,"HOME_WEBSITE", "返回首页")

EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CONFIRM", "确认")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_CANCEL", "取消")
EdgeScoreboard.AddPhrase(LANG,"DERMAQUERY_AFFIRM", "明白了")

-- Tags: %S = Server Name or IP.
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_NOTIFY", "你将在10秒内按照管理员的命令转到%S。")
EdgeScoreboard.AddPhrase(LANG,"TRANSFER_ADMINNOTIFY", "玩家将被瞬间转移到%S。")

EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RESET", "你的假身份已被重置。")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_HIDDEN", "你已经从记分牌上隐身了。")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_VISIBLE", "你在计分板上现形了")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_NAME", "你篡改了你的用户名。")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_AVATAR", "你篡改了你的头像。")
EdgeScoreboard.AddPhrase(LANG,"FAKEIDENTITY_RANK", "你篡改了你的权限组。")

EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_NOTSUPPORTED", "EdgeScoreboard不支持现在的管理插件。提交工单让我们兼容它！")
EdgeScoreboard.AddPhrase(LANG,"ADMINSYS_CANNOTDO", "你现在不能这样做! 请联系服务器管理员!")

EdgeScoreboard.AddPhrase(LANG,"REQUESTSTAFF_QUERY", "请输入你想发送给管理员的信息。")

--[[-------------------------------------------------------------------------
Formatted Time
---------------------------------------------------------------------------]]

-- Tags: %H = Hours, %M = Minutes
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_HM", "%H小时%M分钟")
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_H", "%H小时")

-- Tags: %M = Minutes, %S = Seconds
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_MS", "%M分钟%S秒")
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_M", "%M分钟")

-- Tags: %S = Seconds
EdgeScoreboard.AddPhrase(LANG,"FORMATTEDTIME_S", "%S秒")