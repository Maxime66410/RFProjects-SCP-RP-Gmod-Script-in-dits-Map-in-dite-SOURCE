if SERVER then resource.AddFile( "resource/fonts/Lato-Light.ttf" ) return end
local config = {}
config.hudScale = 2
 
surface.CreateFont( "blurview_font16",
{
    font = "Lato Light",
    size = 16 * config.hudScale,
    weight = 250,
    antialias = true,
    strikeout = true,
    additive = true,
} )
 
surface.CreateFont( "blurview_font18",
{
    font = "Lato Light",
    size = 18 * config.hudScale,
    weight = 250,
    antialias = true,
    strikeout = true,
    additive = true,
} )
 
surface.CreateFont( "blurview_font24",
{
    font = "Lato Light",
    size = 24 * config.hudScale,
    weight = 250,
    antialias = true,
    strikeout = true,
    additive = true,
} )
 
surface.CreateFont( "blurview_font32",
{
    font = "Lato Light",
    size = 32 * config.hudScale,
    weight = 500,
    antialias = true,
    strikeout = true,
    additive = true,
} )
 
surface.CreateFont( "blurview_font48",
{
    font = "Lato Light",
    size = 48 * config.hudScale,
    weight = 250,
    antialias = true,
    strikeout = true,
    additive = true,
} )
 
surface.CreateFont( "Lato_20",
{
    font = "Lato Light",
    size = 20 * config.hudScale,
    weight = 250,
    antialias = true,
    strikeout = true,
    additive = true,
} )
 
local blur = Material( "pp/blurscreen" )
local function drawBlur( x, y, w, h, layers, density, alpha )
    surface.SetDrawColor( 255, 255, 255, alpha )
    surface.SetMaterial( blur )
 
    for i = 1, layers do
        blur:SetFloat( "$blur", ( i / layers ) * density )
        blur:Recompute()
 
        render.UpdateScreenEffectTexture()
        render.SetScissorRect( x, y, x + w, y + h, true )
            surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
        render.SetScissorRect( 0, 0, 0, 0, false )
    end
end
 
local function drawRectOutline( x, y, w, h, color )
    surface.SetDrawColor( color )
    surface.DrawOutlinedRect( x, y, w, h )
end
 
local postFormatText = {}
local lastDigitNum = 0
local function formatText( text, size )
    postFormatText = {}
    lastDigitNum = 0
 
    surface.SetFont( "blurview_font16" )
    for i = 0, string.len( text ) do
        local w = surface.GetTextSize( string.sub( text, lastDigitNum, i ) )
        if w > size then
            postFormatText[ #postFormatText + 1 ] = string.sub( text, lastDigitNum, i )
            lastDigitNum = i + 1
        end
    end
    return postFormatText
end
 
local colors = {
    backgroundColor = Color( 0, 0, 0, 150 ),
    black_fond = Color( 0, 0, 0, 125 ),
    health_fond = Color( 252, 87, 66, 255 ),
    blue_armor = Color( 44, 130, 201, 255 ),
    greenfaim = Color( 20, 165, 20, 255 ),
    black_fond2 = Color( 0, 0, 0, 75 ),
}
local currentHealth = 100
local currentArmor = 0
local agenda = ""
hook.Add( "HUDPaint", "blurview", function()
    local localplayer, scrh, scrw = LocalPlayer(), ScrH(), ScrW()
    if not localplayer:Alive() then draw.RoundedBox(0, 0, 0, scrw, scrh, color_black) return end
    localplayer.DarkRPVars = localplayer.DarkRPVars or {}
    localplayer.DarkRPVars.salary = localplayer.DarkRPVars.salary or 0
 
    if localplayer:Health() != currentHealth then
        currentHealth = Lerp( 0.025, currentHealth, LocalPlayer():Health() )
    end
    if localplayer:Armor() != currentArmor then
        currentArmor = Lerp( 0.025, currentArmor, LocalPlayer():Armor() )
    end

end )
 
local hideHUDElements = {
    ["DarkRP_LocalPlayerHUD"] = true,
    ["DarkRP_Agenda"] = true,
    ["DarkRP_Hungermod"] = true,
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudWeaponSelection"] = true,
}
local function initHudFunc()
    hook.Add("HUDShouldDraw", "HideDefaultDarkRPHudd", function(name)
        if hideHUDElements[name] then return false end
    end)
end
initHudFunc()
 
surface.CreateFont( "RPInfo", {
    font = "Roboto",
    size = 20,
    weight = 300,
})
 
surface.CreateFont( "RPInfo2", {
    font = "Roboto",
    size = 15,
    weight = 300,
})
 
local scale = (ScrW() >= 2560 and 2) or (ScrW() / 175 >= 6 and 1) or 0.8
local curTab, curSlot, alpha, lastAction, loadout, slide, newinv = 0, 1, 0, -math.huge, {}, {}
hook.Add("CreateMove", "RPInfo", function(cmd)
    if newinv then
        local wep = LocalPlayer():GetWeapon(newinv)
        if wep:IsValid() and LocalPlayer():GetActiveWeapon() ~= wep then
            cmd:SelectWeapon(wep)
        else
            newinv = nil
        end
    end
end)
 
local CWeapons = {}
for _, y in pairs(file.Find("scripts/weapon_*.txt", "MOD")) do
    local t = util.KeyValuesToTable(file.Read("scripts/" .. y, "MOD"))
    CWeapons[y:match("(.+)%.txt")] = {
        Slot = t.bucket,
        SlotPos = t.bucket_position,
        TextureData = t.texturedata
    }
end
 
local function findcurrent()
    if alpha <= 0 then
        table.Empty(slide)
        local class = IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass()
        for k1, v1 in pairs(loadout) do
            for k2, v2 in pairs(v1) do
                if v2.classname == class then
                curTab = k1
                    curSlot = k2
                    return
                end
            end
        end
    end
end
 
local function update()
    table.Empty(loadout)
 
    for k, v in pairs(LocalPlayer():GetWeapons()) do
        local classname = v:GetClass()
        local Slot = CWeapons[classname] and CWeapons[classname].Slot or v.Slot or 1
        loadout[Slot] = loadout[Slot] or {}
            table.insert(loadout[Slot], {
            classname = classname,
            name = v:GetPrintName(),
            new = (CurTime() - v:GetCreationTime()) < 60,
            slotpos = CWeapons[classname] and CWeapons[classname].SlotPos or v.SlotPos or 1
        })
    end
    for k, v in pairs(loadout) do
        table.sort(v, function(a, b) return a.slotpos < b.slotpos end)
    end
end
 
hook.Add("PlayerBindPress", "overrideGMFunction", function(ply, bind, pressed)
    if not pressed or ply:InVehicle() then return end
    bind = bind:lower()
    if bind:sub(1, 4) == "slot" then
        local n = tonumber(bind:sub(5, 5) or 1) or 1
        if n < 1 or n > 6 then return true end
        n = n - 1
        update()
        if not loadout[n] then return true end
        findcurrent()
        if curTab == n and loadout[curTab] and (alpha > 0 or GetConVarNumber("hud_fastswitch") > 0) then
            curSlot = curSlot + 1
            if curSlot > #loadout[curTab] then
                curSlot = 1
            end
        else
            curTab = n
            curSlot = 1
        end
        if GetConVarNumber("hud_fastswitch") > 0 then
            newinv = loadout[curTab][curSlot].classname
        else
            alpha = 1
            lastAction = RealTime()
        end
        return true
    elseif bind:find("invnext", nil, true) and not (ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon():GetClass() == "weapon_physgun" and ply:KeyDown(IN_ATTACK)) then
        update()
        if #loadout < 1 then return true end
        findcurrent()
        curSlot = curSlot + 1
        if curSlot > (loadout[curTab] and #loadout[curTab] or -1) then
            repeat
                curTab = curTab + 1
                if curTab > 5 then
                    curTab = 0
                end
            until loadout[curTab]
                curSlot = 1
        end
        if GetConVarNumber("hud_fastswitch") > 0 then
            newinv = loadout[curTab][curSlot].classname
        else
            lastAction = RealTime()
            alpha = 1
        end
        return true
    elseif bind:find("invprev", nil, true) and not (ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon():GetClass() == "weapon_physgun" and ply:KeyDown(IN_ATTACK)) then
        update()
        if #loadout < 1 then return true end
        findcurrent()
        curSlot = curSlot - 1
        if curSlot < 1 then
            repeat
                curTab = curTab - 1
                if curTab < 0 then
                    curTab = 5
                end
            until loadout[curTab]
            curSlot = #loadout[curTab]
        end
            if GetConVarNumber("hud_fastswitch") > 0 then
            newinv = loadout[curTab][curSlot].classname
        else
            lastAction = RealTime()
            alpha = 1
        end
            return true
    elseif bind:find("+attack", nil, true) and alpha > 0 then
        if loadout[curTab] and loadout[curTab][curSlot] and not bind:find("+attack2", nil, true) then
            newinv = loadout[curTab][curSlot].classname
        end
        alpha = 0
        return true
    end
end)
 
local intW, intH = 175 * scale, 22 * scale
local intM = (intH / 4) * scale
local color_blackbg, color_selected = Color(50, 50, 50, 120), Color(160, 30, 219, 200)
 
hook.Add("HUDPaint", "wepsel", function()
    if not IsValid(LocalPlayer()) then return end
 
    if alpha < 1e-02 then
        if alpha ~= 0 then
            alpha = 0
        end
        return
    end
 
    update()
 
    if RealTime() - lastAction > 2 then
        alpha = Lerp(FrameTime() * 4, alpha, 0)
    end
 
    surface.SetAlphaMultiplier(alpha)
 
    surface.SetDrawColor(color_blackbg)
    surface.SetTextColor(color_white)
    surface.SetFont("RPInfo")
 
    local thisWidth = 10
 
    local offx = thisWidth
 
    for i, v in pairs(loadout) do
        local offy = intM + 10
 
        for j, wep in pairs(v) do
            local selected = curTab == i and curSlot == j
            local intH = intH + (intH + intM) * (slide[wep.classname] or 0)
 
            slide[wep.classname] = Lerp(FrameTime() * 12, slide[wep.classname] or 0, selected and .5 or 0)
 
            surface.SetDrawColor(selected and color_selected or color_blackbg)
            surface.DrawRect(offx, offy, intW, intH)
 
            surface.SetFont("RPInfo")
            local w, h = surface.GetTextSize(wep.name)
            if w > intW - 5 then
                surface.SetFont("RPInfo2")
                w, h = surface.GetTextSize(wep.name)
            end
            surface.SetTextPos(offx + (intW - w) / 2, offy + (intH - h) / 2)
            surface.DrawText(wep.name)
 
            offy = offy + intH + intM
        end
 
        offx = offx + intW + intM
    end
 
    surface.SetAlphaMultiplier(1)
end)