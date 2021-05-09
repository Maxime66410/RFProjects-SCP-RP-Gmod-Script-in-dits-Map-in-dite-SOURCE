--[[-------------------------------------------------------------------------
Setup
---------------------------------------------------------------------------]]

--Setup some basic language information.
local LANG = EdgeHUD.RegisterLanguage({
	Name = "Turkish",
	Author = "Mew",
	CompatibleVersion = "1.14.0",
})

--[[-------------------------------------------------------------------------
Phrases - Lower Left
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"IDENTITY", "Kimlik")
EdgeHUD.AddPhrase(LANG,"JOB", "Meslek")

--[[-------------------------------------------------------------------------
Phrases - Lower Right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_KPH","Km/S")
EdgeHUD.AddPhrase(LANG,"SPEEDOMETER_MPH","Mil/S")

--TAGS: %P = Amount of props.
EdgeHUD.AddPhrase(LANG,"PROPLIMIT","%P Prop")

EdgeHUD.AddPhrase(LANG,"GUNLICENSE","Silah Lisansi")

--[[-------------------------------------------------------------------------
Phrases - Top Left
---------------------------------------------------------------------------]]

--TAGS: %V = Number of votes
EdgeHUD.AddPhrase(LANG,"VOTE_QUEUE","Sırada bekleyen %V Eşyan Var!")

EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_VOTE","OYLAMA")
EdgeHUD.AddPhrase(LANG,"VOTE_TITLE_QUESTION","SORU")

--TAGS: %T = Time until expiration.
EdgeHUD.AddPhrase(LANG,"VOTE_EXPIRE","Sona Erecek %T")

EdgeHUD.AddPhrase(LANG,"VOTE_YES","Evet")
EdgeHUD.AddPhrase(LANG,"VOTE_NO","Hayır")

EdgeHUD.AddPhrase(LANG,"VOTE_PENDING","[EdgeHUD] Yeni Soru ya da Oylamanız bekleniyor. Tool Gun'ı kullanarak Oy Kullanın.")

--[[-------------------------------------------------------------------------
Phrases - Top right
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN_TITLE","Olağanüstü Hal")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_LOCKDOWN","Başkan Olağanüstü Hal ilan etti, Herkes evlerine geri dönsün!")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED_TITLE","ARANIYOR")
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_WANTED","Aranıyorsun! Polisler senin peşinde!")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED_TITLE","TUTUKLANDI")

--TAGS: %T = Time until release.
EdgeHUD.AddPhrase(LANG,"TOPRIGHT_ARRESTED","Beraat Kararına %T.")

EdgeHUD.AddPhrase(LANG,"TOPRIGHT_AGENDAHELP","/agenda <mesajınız> Komutuyla ajandayı güncelleyebilirsiniz.")

--[[-------------------------------------------------------------------------
Phrases - Time
---------------------------------------------------------------------------]]

--TAGS: %H = Hours, %M = Minutes
EdgeHUD.AddPhrase(LANG,"TIME_HOUR_MIN","%H saat ve %M dakika")

--TAGS: %M = Minutes, %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_MIN_SEC","%M dakika ve %S saniye")

--TAGS: %S = Seconds
EdgeHUD.AddPhrase(LANG,"TIME_SEC","%S saniye")

--[[-------------------------------------------------------------------------
Phrases - Arrested
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ARRESTED", "TUTUKLANDIN")

--TAGS: %C = Criminal Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_COP", "Belirtilen Sebeplerden Ötürü %C Tutuklandın %T.")

--TAGS: %P = Officer Name, %T = Time
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT", "Memur %P Tarafındna tutuklandın  %T.")
EdgeHUD.AddPhrase(LANG,"ARRESTED_SUSPECT2", "Hapiste geçireceğin süre %T.")

--[[-------------------------------------------------------------------------
Phrases - Released
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"RELEASED", "RELEASED")

--TAGS: %C = Criminal Name
EdgeHUD.AddPhrase(LANG,"RELEASED_COP", "Savcılık kararıyla %C Suçlarından aklandı.")

EdgeHUD.AddPhrase(LANG,"RELEASED_SUSPECT", "Savcılık kararıyla serbest bırakıldın.")

--[[-------------------------------------------------------------------------
Phrases - Wanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WANTED", "ARANIYOR")

--TAGS: %C = Criminal Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_COP", "%C Belirtilen sebeplerden ötürü aranıyor %R.")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT", "Memur %P Tarafından belirtilen sebeplerden %R Aranıyor.")
EdgeHUD.AddPhrase(LANG,"WANTED_SUSPECT2", "Belirtilen sebeplerden %R Aranıyorsun.")

--[[-------------------------------------------------------------------------
Phrases - Unwanted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWANTED", "UNWANTED")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWANTED_COP", "%S Aranma Emri Kaldırıldı.")

EdgeHUD.AddPhrase(LANG,"UNWANTED_SUSPECT", "Hakkınızda Aranma Emri Bulunmamakta.")

--[[-------------------------------------------------------------------------
Phrases - Warranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"WARRANTED", "WARRANTED")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"WARRANTED_COP", "Savcılık kararıyla %S Mülkünü Arayabilirsin.")

--TAGS: %P = Police Name, %R = Reason
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT", "Mülkün Memur %P tarafından %R. Sebepleriyle Aranıyor")
EdgeHUD.AddPhrase(LANG,"WARRANTED_SUSPECT2", "Belirtilen Sebeplerden Ötürü Mülkün Aranıyor %R.")

--[[-------------------------------------------------------------------------
Phrases - Unwarranted
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"UNWARRANTED", "ARANMA EMRİ KALDIRILDI")

--TAGS: %S = Suspect Name
EdgeHUD.AddPhrase(LANG,"UNWARRANTED_COP", "%S Mülkü Üzerinde Arama Emrini Kaldırdın.")

EdgeHUD.AddPhrase(LANG,"UNWARRANTED_SUSPECT", "Mülkündeki Arama Emri Sona Erdi.")

--[[-------------------------------------------------------------------------
Phrases - Vehicle Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE", "Araç")

--TAGS: %N = Name of owner
EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER", "Sahibi: %N")

--TAGS: %G = Groupname
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_GROUP", "Erişebilir: %G")

--TAGS: %J = Number of jobs
EdgeHUD.AddPhrase(LANG,"VEHICLE_ACCESS_JOBS", "Erişebilecek: %J Meslek(ler)")

EdgeHUD.AddPhrase(LANG,"VEHICLE_OWNER_UNKNOWN", "Sahibi: Bilinmiyor")

EdgeHUD.AddPhrase(LANG,"VEHICLE_NOTOWNABLE", "Sahiplenilemez")

EdgeHUD.AddPhrase(LANG,"VEHICLE_UNOWNED", "Sahipsiz")

EdgeHUD.AddPhrase(LANG,"VEHICLE_COOWNERS", "Kullanabilir:")

EdgeHUD.AddPhrase(LANG,"VEHICLE_ALLOWED_COOWNERS", "Izin verilen kişiler:")

--[[-------------------------------------------------------------------------
Phrases - Door Display
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOOR_SOLD", "Kapı Satıldı")
EdgeHUD.AddPhrase(LANG,"DOOR_FORSALE", "Satılık")
EdgeHUD.AddPhrase(LANG,"DOOR_F2PURCHASE", "F2 Tuşunu Kullanarak Kapıyı Satın Al")

EdgeHUD.AddPhrase(LANG,"DOOR_COOWNERS", "Ortaklar:")
EdgeHUD.AddPhrase(LANG,"DOOR_ALLOWED_COOWNERS", "İzin Verilen Ortaklar:")

--TAGS: %G = Name of group.
EdgeHUD.AddPhrase(LANG,"DOOR_GROUP_TITLE", "Grup Kapısı")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_GROUP", "Erişebilir: %G")

--TAGS: %J = Number of jobs.
EdgeHUD.AddPhrase(LANG,"DOOR_TEAM_TITLE", "Takım Kapısı")
EdgeHUD.AddPhrase(LANG,"DOOR_ACCESS_TEAM", "Erişebilecek: %J Meslek(ler)")

--TAGS: %N = Name of owner.
EdgeHUD.AddPhrase(LANG,"DOOR_OWNER", "Sahibi: %N")

EdgeHUD.AddPhrase(LANG,"DOOR_OWNER_UNKNOWN", "Sahibi: Bilinmiyor")

--[[-------------------------------------------------------------------------
Phrases - Situations
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"LOCKDOWN", "Olağanüstü Hal")

EdgeHUD.AddPhrase(LANG,"LOCKDOWN_INITIATED", "Başkan Olağanüstü Hal ilan etti, Herkes evlerine geri dönsün!")

--[[-------------------------------------------------------------------------
Phrases - Door Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_DOOR", "Kapıyı Satın Al")
EdgeHUD.AddPhrase(LANG,"DOORMENU_BUY_VEHICLE", "Aracı Satın Al")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_DOOR", "Kapıyı Sat")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SELL_VEHICLE", "Aracı Sat")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ADDOWNER", "Sahip Ekle")
EdgeHUD.AddPhrase(LANG,"DOORMENU_REMOVEOWNER", "Sahip Çıkar")

EdgeHUD.AddPhrase(LANG,"DOORMENU_ALLOWOWNERSHIP", "Sahip Olmasına İzin Ver")
EdgeHUD.AddPhrase(LANG,"DOORMENU_DISALLOWOWNERSHIP", "Sahiplikten At")

EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_DOOR", "Kapının Başlığını Ayarla")
EdgeHUD.AddPhrase(LANG,"DOORMENU_SETTITLE_VEHICLE", "Aracın Başlığını Ayarla")

EdgeHUD.AddPhrase(LANG,"DOORMENU_EDITGROUPS", "Grupların Erişilebilirliğini Ayarla")

--[[-------------------------------------------------------------------------
Phrases - Crash Screen
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TITLE", "Bağlantınız Kesildi")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT1", "Görünen o ki Sunucuyla Bağlantınız Koptu.")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_TEXT2", "Bağlantınız sağlanana kadar lütfen bekleyiniz.")

EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_RECONNECT", "Yeniden Bağlan")
EdgeHUD.AddPhrase(LANG,"CRASHSCREEN_LEAVE", "Çıkış Yap")

--[[-------------------------------------------------------------------------
Phrases - Gesture Menu
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"GESTURE_BOW", "Eğil")
EdgeHUD.AddPhrase(LANG,"GESTURE_SEXYDANCE", "Seksi Dans")
EdgeHUD.AddPhrase(LANG,"GESTURE_FOLLOWME", "Takip Et")
EdgeHUD.AddPhrase(LANG,"GESTURE_LAUGH", "Gül")
EdgeHUD.AddPhrase(LANG,"GESTURE_LIONPOSE", "Aslan Pozu")
EdgeHUD.AddPhrase(LANG,"GESTURE_NONVERBALNO", "Olumsuz")
EdgeHUD.AddPhrase(LANG,"GESTURE_THUMBSUP", "Olumlu")
EdgeHUD.AddPhrase(LANG,"GESTURE_WAVE", "El Salla")
EdgeHUD.AddPhrase(LANG,"GESTURE_DANCE", "Dans")

--[[-------------------------------------------------------------------------
Phrases - Vehicle warnings HUD.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXTERIORLIGHT", "[Vehicle] : Aracın Işıklandırma sisteminde sorun var. En kısa zamanda servise gidin.")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_EXHAUST", "[Vehicle] : Aracın Emisyon sisteminde sorun var. En kısa zamanda servise gidin.")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_ENGINE", "[Vehicle] : Aracın Güç Aktarım sisteminde sorun var. En kısa zamanda servise gidin.")

EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTLEFT", "Ön Sol")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_FRONTRIGHT", "Ön Sağ")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKLEFT", "Arka Sol")
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRE_BACKRIGHT", "Arka Sağ")

--TAGS: %T = Damaged tires.
EdgeHUD.AddPhrase(LANG,"VEHICLE_DMG_TIRES", "[Araç] : Lastik Basıncı (%T) Düşük!")

--[[-------------------------------------------------------------------------
Phrases - Battery Notifications.
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CHARGER_CONNECTED", "Şarj Takılı")
EdgeHUD.AddPhrase(LANG,"CHARGER_DISCONNECTED", "Şarj Çıkarıldı")
EdgeHUD.AddPhrase(LANG,"BATTERY_STATUS", "Şarj Durumu")

EdgeHUD.AddPhrase(LANG,"CHARGING_STARTED", "Bilgisayarınız Şarj Oluyor.")
EdgeHUD.AddPhrase(LANG,"CHARGING_ABORTED", "Bilgisayarınız Artık Şarj Olmuyor.")

--TAGS: %B = Battery precentage left.
EdgeHUD.AddPhrase(LANG,"BATTERY_NOTICE", "Pil Seviyeniz %B%. Oynamaya Devam Etmek İçin Şarja Takmanız Gerek")

--[[-------------------------------------------------------------------------
Phrases - Level bar
---------------------------------------------------------------------------]]

--TAGS: %L = Current Level, %P = Percentage to next level
EdgeHUD.AddPhrase(LANG,"LEVELBAR", "Seviye %L - %P%")

--[[-------------------------------------------------------------------------
Phrases - AdminTell
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"ADMINTELL_TITLE", "ADMİN BİLGİLENDİRME")
EdgeHUD.AddPhrase(LANG,"ADMINTELL_NOMSG", "Mesaj Belirtilmedi")

--[[-------------------------------------------------------------------------
Phrases - General
---------------------------------------------------------------------------]]

EdgeHUD.AddPhrase(LANG,"CLOSE","Kapat")