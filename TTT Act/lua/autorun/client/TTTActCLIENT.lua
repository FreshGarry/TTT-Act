-- Please ask me if you want to use parts of this code!

hook.Add("Think", "TTT_ShowOthersAnimations", function()

for k, v in pairs( player.GetAll() ) do
	local anim = v:GetNWInt("TTTActivity")
	if anim != v.lastTTTActivity && v != LocalPlayer() then
		if(anim == ACT_IDLE) then
			v:AnimRestartGesture(GESTURE_SLOT_CUSTOM, ACT_IDLE, true)
		else
			v:AnimRestartGesture(GESTURE_SLOT_CUSTOM, anim, true)
		end
		
		v.lastTTTActivity = anim 
	end
end

end)

hook.Add("PlayerButtonDown", "TTTAct_Cancel", function(ply, key)
	if(ply.TTTActivity != nil) then
		ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, ACT_IDLE, true)
	end
end)

hook.Add("StartCommand", "TTTAct_MovementCancel", function(ply, ucmd)
	if(ply.TTTActivity != nil) then
		ucmd:ClearMovement()
	end
end)

--TODO: dance unendlich
-- FG Addons Table
local Version = "1.0"
if not TTTFGAddons then
	TTTFGAddons = {}
end
table.insert(TTTFGAddons, "TTT Act")

--ConVar
local ChatMessage = CreateClientConVar( "ttt_fgaddons_textmessage", "1", true, false, "Enables or disables the message in the chat. Def:1")

-- Text writing Hook
hook.Add("TTTBeginRound", "TTTBeginRound4TTTFGAddons", function()
	local String = ""
	for i = 1, #TTTFGAddons do
		if String == "" then
			String = TTTFGAddons[i]
		else
			String = String..", "..TTTFGAddons[i]
		end
	end
	if ChatMessage:GetBool() then
		chat.AddText("TTT FG Addons: ", Color( 255, 255, 255 ), "You are running "..String..".")
		chat.AddText("TTT FG Addons: ", Color( 255, 255, 255 ), "Be sure to check out the Settings in the ", Color( 255, 0, 0 ),"F1", Color( 255, 255, 255 )," menu.")
		chat.AddText("TTT FG Addons: ", Color( 255, 255, 255 ), "You can disable this message in the Settings (", Color( 255, 0, 0 ),"F1", Color( 255, 255, 255 ),").")
	end
end)

-- Tables
local Time = {
	["dance"] = 9;
	["robot"] = 11;
	["muscle"] = 13;
	["laugh"] = 6;
	["bow"] = 3;
	["cheer"] = 3;
	["wave"] = 3;
	["zombie"] = 3;
	["agree"] = 3;
	["disagree"] = 3;
	["halt"] = 1;
	["becon"] = 4;
	["forward"] = 1;
	["group"] = 1;
	["pers"] = 3;
	["close"] = 0;
}
local Acts = {
	[1] = "dance";
	[2] = "robot";
	[3] = "muscle";
	[4] = "laugh";
	[5] = "bow";
	[6] = "cheer";
	[7] = "wave";
	[8] = "zombie";
	[9] = "agree";
	[10] = "disagree";
	[11] = "halt";
	[12] = "becon";
	[13] = "forward";
	[14] = "group";
	[15] = "pers";
	[16] = "close"
}

local Acts_ACT_ENUMS = {
	[1] = ACT_GMOD_TAUNT_DANCE;
	[2] = ACT_GMOD_TAUNT_ROBOT;
	[3] = ACT_GMOD_TAUNT_MUSCLE;
	[4] = ACT_GMOD_TAUNT_LAUGH;
	[5] = ACT_GMOD_GESTURE_BOW;
	[6] = ACT_GMOD_TAUNT_CHEER;
	[7] = ACT_GMOD_GESTURE_WAVE;
	[8] = ACT_GMOD_GESTURE_TAUNT_ZOMBIE;
	[9] = ACT_GMOD_GESTURE_AGREE;
	[10] = ACT_GMOD_GESTURE_DISAGREE;
	[11] = ACT_SIGNAL_HALT;
	[12] = ACT_GMOD_GESTURE_BECON;
	[13] = ACT_SIGNAL_FORWARD;
	[14] = ACT_SIGNAL_GROUP;
	[15] = ACT_GMOD_TAUNT_PERSISTENCE;
	[16] = ACT_IDLE
}
local Sounds = {}

local function AddSound(ActNr, path)
	if not Sounds[ActNr] then
		Sounds[ActNr] = {}
	end
	local name = "ttt_act_"..Acts[ActNr].."_"..#Sounds[ActNr]+1
	
	Sounds[ActNr][#Sounds[ActNr]+1] = name
	
	sound.Add( {
		name = name,
		channel = CHAN_BODY,
		volume = 1,
		level = 75,
		pitch = { 95, 110 },
		sound = path
	} )
end


AddSound(1, "music/HL1_song10.mp3")
AddSound(1, "music/HL1_song17.mp3")
AddSound(1, "music/HL1_song25_REMIX3.mp3")
AddSound(1, "music/HL2_song12_long.mp3")
AddSound(1, "music/HL2_song15.mp3")
AddSound(1, "music/HL2_song20_submix0.mp3")
AddSound(1, "music/HL2_song20_submix4.mp3")
AddSound(1, "music/HL2_song31.mp3")
AddSound(1, "music/HL2_song4.mp3")

AddSound(2, "HL1/ambience/techamb2.wav")

AddSound(3, "music/HL1_song25_REMIX3.mp3")
AddSound(3, "music/HL2_song15.mp3")
AddSound(3, "music/HL2_song3.mp3")

AddSound(4, "vo/Citadel/br_laugh01.wav")
AddSound(4, "vo/eli_lab/al_laugh01.wav")
AddSound(4, "vo/eli_lab/al_laugh02.wav")
AddSound(4, "vo/npc/Barney/ba_laugh01.wav")
AddSound(4, "vo/npc/Barney/ba_laugh02.wav")
AddSound(4, "vo/npc/Barney/ba_laugh04.wav")
AddSound(4, "vo/ravenholm/madlaugh01.wav")
AddSound(4, "vo/ravenholm/madlaugh02.wav")
AddSound(4, "vo/ravenholm/madlaugh03.wav")
AddSound(4, "vo/ravenholm/madlaugh04.wav")

AddSound(6, "vo/coast/odessa/female01/nlo_cheer01.wav")
AddSound(6, "vo/coast/odessa/female01/nlo_cheer02.wav")
AddSound(6, "vo/coast/odessa/female01/nlo_cheer03.wav")
AddSound(6, "vo/coast/odessa/male01/nlo_cheer01.wav")
AddSound(6, "vo/coast/odessa/male01/nlo_cheer02.wav")
AddSound(6, "vo/coast/odessa/male01/nlo_cheer04.wav")


AddSound(8, "ambient/creatures/town_zombie_call1.wav")
AddSound(8, "ambient/levels/prison/inside_battle_zombie1.wav")
AddSound(8, "ambient/levels/prison/inside_battle_zombie2.wav")

AddSound(9, "vo/Citadel/al_yes.wav")
AddSound(9, "vo/Citadel/al_yes_nr.wav")

AddSound(10, "vo/Citadel/br_no.wav")
AddSound(10, "vo/Streetwar/Alyx_gate/al_no.wav")
AddSound(10, "vo/Citadel/al_fail_no.wav")
AddSound(10, "vo/Citadel/br_no.wav")

AddSound(11, "vo/npc/vortigaunt/halt.wav")

AddSound(12, "vo/NovaProspekt/al_overhere.wav")
AddSound(12, "vo/npc/female01/overhere01.wav")
AddSound(12, "vo/npc/male01/overhere01.wav")
AddSound(12, "vo/ravenholm/monk_overhere.wav")
AddSound(12, "vo/trainyard/al_overhere.wav")

AddSound(13, "vo/npc/vortigaunt/forward.wav")
AddSound(13, "vo/npc/vortigaunt/yesforward.wav")
AddSound(13, "vo/npc/Barney/ba_letsgo.wav")
AddSound(13, "vo/npc/female01/letsgo01.wav")
AddSound(13, "vo/npc/female01/letsgo02.wav")
AddSound(13, "vo/npc/male01/letsgo02.wav")



-- Vars
local Timer = false
local Act = false
local IsActing = false
local MenuOpen = false
local Sel = 0
local AnglePerEntry = 360/#Acts
local MidW = ScrW()/2
local MidH = ScrH()/2
local CrosshairSize = 1
local Key_box2 = 0
local KeySelected2 = ""
local Segments = #Acts
local Resolution = 10
local RadIn = 0.1666666666666666
local space = 75
local Scale = 300

-- ConVars
local PreviewRendering = CreateClientConVar( "ttt_act_hud_preview", "0", true, false, "Renders the HUD. Def: 0")
local xPos = CreateClientConVar( "ttt_act_hud_offset_x", "265", true, false, "The x offset of the HUD. Def: 265")
local yPos = CreateClientConVar( "ttt_act_hud_offset_y", "60", true, false, "The y offset of the HUD. Def: 60")
local allignment = CreateClientConVar( "ttt_act_hud_allignment", "0", true, false, "The allignment of the hud. (0 = bottom, left; 1 = top, left; 2 = top, right; 3 = bottom, right) Def: 0")
local CrosshairDebugSize = CreateClientConVar( "ttt_act_crosshairdebugsize", "1", true, false, "The size of the crosshair used to prevent no crosshair while it should be there. (Disabled = 0) Def:1")

surface.CreateFont("HUDFont", {font = "Trebuchet24", size = 24, weight = 750})
function draw.Circle( x, y, radius, seg ) -- https://wiki.garrysmod.com/page/surface/DrawPoly - this is not my code
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is needed for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	surface.DrawPoly( cir )
end-- until here


local function InSegment(x, y)
	local SqrDistToMid = (x-MidW)*(x-MidW) + (y-MidH)*(y-MidH)
	if SqrDistToMid < Scale*Scale and SqrDistToMid > Scale*Scale*RadIn*RadIn then
		local MidAngle = math.acos((y-MidH)/math.sqrt(SqrDistToMid))*-1
		if x-MidW > 0 then
			MidAngle = -2*math.pi-MidAngle
		end
		for i = 0, #Acts-1, 1 do 
			if (math.rad((i+1)/Segments*-360) < MidAngle) and (math.rad((i)/Segments*-360) > MidAngle) then
				return i+1
			end
		end
	end
	return -1
end

function draw.PieMenu()
	local x = MidW
	local y = MidH
	for i=0, Segments-1, 1 do
		local Part = {}
		table.insert( Part, { x = x + math.sin(math.rad((i/Segments)*-360))*Scale*RadIn,  y = y + math.cos(math.rad((i/Segments)*-360))*Scale*RadIn, u = 0.5, v = 0.5} )
		for j=0, Resolution, 1 do
			table.insert( Part, { x = x + math.sin(math.rad((i/Segments+1/Segments*j/Resolution )*-360))*Scale, y = y + math.cos(math.rad((i/Segments+1/Segments*j/Resolution)*-360))*Scale, u = 0.5, v = 0.5 } )
		end
		table.insert( Part, { x = x + math.sin(math.rad((i/Segments + 1/Segments)*-360))*Scale*RadIn,  y = y + math.cos(math.rad((i/Segments + 1/Segments)*-360))*Scale*RadIn, u = 0.5, v = 0.5} )
		-- Outline:
		surface.SetDrawColor(0,0,0,255)
		local lastX = Part[#Part].x
		local lastY = Part[#Part].y
		for k, v in pairs(Part) do
			surface.DrawLine(lastX,lastY,v.x,v.y)
			lastX = v.x
			lastY = v.y
		end
		local Sel = InSegment(gui.MousePos())
		if Sel-1 == i then
			surface.SetDrawColor(150,150,150,200)
		else
			surface.SetDrawColor(0,0,0,200)
		end
		surface.DrawPoly(Part)
		local rotation = (i/Segments+1/Segments*1/2)*360+90
		local tx, ty = Part[1].x, Part[1].y
		if (i+1)/Segments <= 0.5 then
			rotation = rotation+180
			tx = tx-math.cos(math.rad(rotation))*select(1, surface.GetTextSize(Acts[i+1].."("..Time[Acts[i+1]].."s)"))+math.sin(math.rad(rotation))*select(2, surface.GetTextSize( Acts[i+1].."("..Time[Acts[i+1]].."s)"))
			ty = ty-math.sin(math.rad(rotation))*select(1, surface.GetTextSize(Acts[i+1].."("..Time[Acts[i+1]].."s)"))-math.cos(math.rad(rotation))*select(2, surface.GetTextSize( Acts[i+1].."("..Time[Acts[i+1]].."s)"))
			tx = tx-math.cos(math.rad(rotation))*space
			ty = ty-math.sin(math.rad(rotation))*space
		else
			tx = tx+math.cos(math.rad(rotation))*space
			ty = ty+math.sin(math.rad(rotation))*space
		end
		
		draw.SpecialText(Acts[i+1].."("..Time[Acts[i+1]].."s)",tx,ty,1,1,rotation)
	end
	
end

local matrix = Matrix();
local matrixAng = Angle(0, 0, 0);
local matrixTrans = Vector(0, 0, 0);
local matrixScale = Vector(0, 0, 0);
function draw.SpecialText(text, posX, posY, scaleX, scaleY, angle)
	matrixAng.y = angle;
	matrix:SetAngles(matrixAng);
	matrixTrans.x = posX;
	matrixTrans.y = posY;
	matrix:SetTranslation(matrixTrans);
	matrixScale.x = scaleX;
	matrixScale.y = scaleY;
	matrix:Scale(matrixScale);
	surface.SetTextPos(0, 0);
	cam.PushModelMatrix(matrix);
	surface.DrawText(text);
	cam.PopModelMatrix();
end

local function HUD(name,xPos,yPos,allignment,ColorA,ColorB,value,maximum)
	if GAMEMODE_NAME != "terrortown" then return end
	if LocalPlayer():Alive() and (GAMEMODE_NAME != "terrortown"  || LocalPlayer():IsTerror() and (not LocalPlayer():IsSpec())) then
		local valueNumber = value
		local number = true
		if maximum == 0 then
			valueNumber = 1
			maximum = 1
			number = false
		end
		xPos = xPos:GetFloat()
		yPos = yPos:GetFloat()
		allignment = allignment:GetFloat()
		local x = 0
		local y = 0
		if allignment == 1 then
			x = xPos
			y = yPos
		elseif allignment == 2 then
			x = ScrW()-xPos
			y = yPos
		elseif allignment == 3 then
			x = ScrW()-xPos
			y = ScrH()-yPos
		else
			x = xPos
			y = ScrH()-yPos
		end
		draw.RoundedBox(8, x-5, y-10, 250, 60, Color(0, 0, 0, 200))
		draw.RoundedBox(8, x+4, y+4, 232, 27, ColorB)
		surface.SetDrawColor(ColorA)

		
		if 230/maximum*valueNumber > 0 then
			surface.DrawRect( x+12, y+5, 230/maximum*valueNumber-14, 25 )
			surface.DrawRect( x+5, y+13, 8, 25-8*2 )
			surface.SetTexture( surface.GetTextureID( "gui/corner8" ) )
			surface.DrawTexturedRectRotated( x+5 + 8/2 , y+5 + 8/2, 8, 8, 0 )
			surface.DrawTexturedRectRotated( x+5 + 8/2 , y+5 + 25 -8/2, 8, 8, 90 )
			
			if 230/maximum*valueNumber > 13 then
				surface.DrawRect( x+5+230/maximum*valueNumber-8, y+13, 8, 25-8*2 )
				surface.DrawTexturedRectRotated( x+5 + 230/maximum*valueNumber - 8/2 , y+5 + 8/2, 8, 8, 270 )
				surface.DrawTexturedRectRotated( x+5 + 230/maximum*valueNumber - 8/2 , y+5 + 25 - 8/2, 8, 8, 180 )
			else
				surface.DrawRect( x+5 + math.max(230/maximum*valueNumber-8, 8), y+5, 8/2, 25 )
			end
		end
		if number then
			if value < 1 then
				value = 0 --prevent -1s
			end
			draw.SimpleText(math.ceil(value).."s", "HUDFont", x+215, y+7, Color(0, 0, 0),TEXT_ALIGN_RIGHT)
			draw.SimpleText(math.ceil(value).."s", "HUDFont", x+213, y+5, Color(255, 255, 255),TEXT_ALIGN_RIGHT)
		else
			draw.SimpleText(value.."s", "HUDFont", x+215, y+7, Color(0, 0, 0),TEXT_ALIGN_RIGHT)
			draw.SimpleText(value.."s", "HUDFont", x+213, y+5, Color(255, 255, 255),TEXT_ALIGN_RIGHT)
		end
		draw.SimpleText(name, "TabLarge", x+194, y-17, Color(255, 255, 255))
	end
end

hook.Add("HUDPaint", "HUDPaint4TTTAct", function()
	if MenuOpen then
		surface.SetDrawColor(0,0,0,200)
		draw.NoTexture()
		draw.Circle( MidW, MidH, 50, 16 )
		draw.SimpleText( "Acts", "Trebuchet24", MidW, MidH, Color( 255, 255, 255, 255 ), 1, 1 )
		draw.NoTexture()
		draw.PieMenu()
	end
	if IsActing then
		if not Timer then
			Timer = CurTime()
		end
		HUD("ACTING",xPos,yPos,allignment,Color(0,255,0,255),Color(0,100,0,255),Time[Act]-(CurTime()-Timer),Time[Act])
	elseif Timer then
		Timer = false
	end
	if PreviewRendering:GetBool() then
		HUD("ACTING",xPos,yPos,allignment,Color(0,255,0,255),Color(0,100,0,255),0,0)
	end
end)

concommand.Add("ttt_act", function(ply)
	if MenuOpen then
		MenuOpen = false
		gui.EnableScreenClicker( false )
		if CrosshairSize == "0" then CrosshairSize = CrosshairDebugSize:GetFloat() end
		RunConsoleCommand( "ttt_crosshair_size", CrosshairSize )
	elseif (not IsActing) and LocalPlayer():Alive() and (GAMEMODE_NAME != "terrortown" || LocalPlayer():IsTerror()) then
		MenuOpen = true
		gui.EnableScreenClicker( true ) 
		CrosshairSize = GetConVarString( "ttt_crosshair_size" )
		RunConsoleCommand( "ttt_crosshair_size", "0" )
	end
end)

local function ThirdPersonView(ply, pos, angles, fov, znear, zfar, drawviewer, ortho)
    if IsActing and ply == LocalPlayer() then
		local view = {}
		local dist = 130
		view.origin = Vector(angles:Forward().x, angles:Forward().y,0)
		if view.origin:IsZero() then
			view.origin = Vector(1,0,0)
		end
		view.origin = pos+view.origin:GetNormalized()*100
		ang = Angle(angles.p*0,angles.y,angles.r)+Angle(0,180,0)
		view.drawviewer = true
		
		local trace = {};
		trace.start = pos;
		trace.endpos = pos - ( ang:Forward() * dist );
		trace.filter = LocalPlayer();
		
		local trace = util.TraceLine( trace );
		if( trace.HitPos:Distance( pos ) < dist - 10 ) then
			dist = trace.HitPos:Distance( pos ) - 10;
		end;
		
		view.origin = pos - ( ang:Forward() * dist );
		view.angles = ang;
		view.fov = fov;

		return view
	end
end
 
hook.Add("CalcView", "CalcView4TTTAct", ThirdPersonView)
 
hook.Add("VGUIMousePressed","VGUIMousePressed4TTTAct",function(pnl,Mouse)
	if MenuOpen then
		local Sel = InSegment(gui.MousePos())
		if not (Sel == -1) then 
		
			LocalPlayer():AnimRestartGesture(GESTURE_SLOT_CUSTOM, Acts_ACT_ENUMS[Sel], true)
			timer.Simple(0.1, function() LocalPlayer().TTTActivity = Acts_ACT_ENUMS[Sel] end)
			
			local soundMode = 0
			local soundPath = "nothing"
			if Sounds[Sel] then
				soundPath = Sounds[Sel][math.random(1, #Sounds[Sel])]
				if Sel > 3 then
					--LocalPlayer():EmitSound(soundPath, 75, 100, 1, CHAN_BODY )
					--Sound = false
					soundMode = 1
				else
					--Sound = CreateSound (LocalPlayer(), soundPath)
					soundMode = 2
					--Sound:Play()
				end
			end
		
		
			net.Start("TTTACT")
			net.WriteEntity(LocalPlayer())
			net.WriteString(Acts_ACT_ENUMS[Sel])
			net.WriteFloat(Time[Acts[Sel]])
			net.WriteString(soundPath)
			net.WriteFloat(soundMode)
			net.SendToServer()
			MenuOpen = false
			gui.EnableScreenClicker( false )
			IsActing = true
			Act = Acts[Sel]
		else
			if CrosshairSize == "0" then CrosshairSize = CrosshairDebugSize:GetFloat() end
			RunConsoleCommand( "ttt_crosshair_size", CrosshairSize )
			RunConsoleCommand( "ttt_act" )
		end
	end
end)

net.Receive("TTTACT", function()
	if CrosshairSize == "0" then CrosshairSize = CrosshairDebugSize:GetFloat() end
	RunConsoleCommand( "ttt_crosshair_size", CrosshairSize )
	IsActing = false
	Timer = false
	LocalPlayer().TTTActivity = nil
end)
local function DefaultI()
	RunConsoleCommand( "ttt_act_hud_allignment", "0")
	RunConsoleCommand( "ttt_act_hud_offset_x", tostring(ScrW()/2-125) )
	RunConsoleCommand( "ttt_act_hud_offset_y", "60" )
	Key_box2:SetValue("Bottom, left")
end
local function DefaultII()
	RunConsoleCommand( "ttt_act_hud_allignment", "0")
	RunConsoleCommand( "ttt_act_hud_offset_x", "15" )
	RunConsoleCommand( "ttt_act_hud_offset_y", "180" )
	Key_box2:SetValue("Bottom, left")
end
local function DefaultIII()
	RunConsoleCommand( "ttt_act_hud_allignment", "3")
	RunConsoleCommand( "ttt_act_hud_offset_x", "255" )
	RunConsoleCommand( "ttt_act_hud_offset_y", "60" )
	Key_box2:SetValue("Bottom, right")
end
local function DefaultIV()
	RunConsoleCommand( "ttt_act_hud_allignment", "0")
	RunConsoleCommand( "ttt_act_hud_offset_x", "265" )
	RunConsoleCommand( "ttt_act_hud_offset_y", "60" )
	Key_box2:SetValue("Bottom, left")
end
local function DefaultV()
	RunConsoleCommand( "ttt_act_hud_allignment", "0")
	RunConsoleCommand( "ttt_act_hud_offset_x", "265" )
	RunConsoleCommand( "ttt_act_hud_offset_y", "120" )
	Key_box2:SetValue("Bottom, left")
end
local function DefaultVI()
	RunConsoleCommand( "ttt_act_hud_allignment", "0")
	RunConsoleCommand( "ttt_act_hud_offset_x", "265" )
	RunConsoleCommand( "ttt_act_hud_offset_y", "180" )
	Key_box2:SetValue("Bottom, left")
end
hook.Add("TTTSettingsTabs", "TTTact4TTTSettingsTabs", function(dtabs)
	local parent = dtabs:GetParent()
	function parent:OnClose()
		RunConsoleCommand("ttt_act_hud_preview", "0")
	end
	local settings_panel = vgui.Create( "DPanelList",dtabs )
	settings_panel:StretchToParent(0,0,dtabs:GetPadding()*2,0)
	settings_panel:EnableVerticalScrollbar(true)
	settings_panel:SetPadding(10)
	settings_panel:SetSpacing(10)
	dtabs:AddSheet( "Act", settings_panel, "icon16/user.png", false, false, "The act settings")
	
	local General_Settings = vgui.Create( "DForm" )
	General_Settings:SetSpacing( 10 )
	General_Settings:SetName( "General settings" )
	General_Settings:SetWide(settings_panel:GetWide()-30)
	settings_panel:AddItem(General_Settings)
	General_Settings:CheckBox("Print chat message at the beginning of the round (TTT FG Addons)","ttt_fgaddons_textmessage")
	
	--HUD Positioning
	
	local settings_act_tab = vgui.Create( "DForm" )
	settings_act_tab:SetSpacing( 10 )
	settings_act_tab:SetName( "HUD Positioning" )
	settings_act_tab:SetWide(settings_panel:GetWide()-30)
	settings_panel:AddItem(settings_act_tab)
	
	settings_act_tab:CheckBox("Show Preview","ttt_act_hud_preview")
	local Settings_text2 = vgui.Create("DLabel", settings_act_tab)
	Settings_text2:SetText("Allignment:")
	Settings_text2:SetColor(Color(0,0,0))
	settings_act_tab:AddItem( Settings_text2 )
	Key_box2 = vgui.Create("DComboBox")
	if allignment == 1 then
		KeySelected2 = "Top, left"
	elseif allignment == 2 then
		KeySelected2 = "Top, right"
	elseif allignment == 3 then
		KeySelected2 = "Bottom, right"
	else
		KeySelected2 = "Bottom, left"
	end
	Key_box2:Clear()
	Key_box2:SetValue(KeySelected2)
	Key_box2:AddChoice("Bottom, left")
	Key_box2:AddChoice("Top, left")
	Key_box2:AddChoice("Top, right")
	Key_box2:AddChoice("Bottom, right")
	settings_act_tab:AddItem( Key_box2 )
	function Key_box2:OnSelect(table_key_box, Ausgewaehlt, data_key_box)
		if Ausgewaehlt == "Bottom, left" then
			RunConsoleCommand( "ttt_act_hud_allignment", "0" )
		elseif Ausgewaehlt == "Top, left" then
			RunConsoleCommand( "ttt_act_hud_allignment", "1" )
		elseif Ausgewaehlt == "Top, right" then
			RunConsoleCommand( "ttt_act_hud_allignment", "2" )
		elseif Ausgewaehlt == "Bottom, right" then
			RunConsoleCommand( "ttt_act_hud_allignment", "3" )
		end 
		KeySelected2 = Ausgewaehlt
	end
	settings_act_tab:NumSlider("X Offset", "ttt_act_hud_offset_x", 0, ScrW(), 0)
	settings_act_tab:NumSlider("Y Offset", "ttt_act_hud_offset_y", 0, ScrH(), 0)

	local Settings_text = vgui.Create("DLabel", General_Settings)
	Settings_text:SetText("Presets:")
	Settings_text:SetColor(Color(0,0,0))
	settings_act_tab:AddItem( Settings_text )
	
	local DefaultI_button = vgui.Create("DButton")
	DefaultI_button:SetText("Lower middle")
	DefaultI_button.DoClick = DefaultI
	settings_act_tab:AddItem( DefaultI_button )
	
	local DefaultII_button = vgui.Create("DButton")
	DefaultII_button:SetText("On top of role")
	DefaultII_button.DoClick = DefaultII
	settings_act_tab:AddItem( DefaultII_button )
	
	local DefaultIII_button = vgui.Create("DButton")
	DefaultIII_button:SetText("Lower right corner")
	DefaultIII_button.DoClick = DefaultIII
	settings_act_tab:AddItem( DefaultIII_button )
	
	local DefaultIV_button = vgui.Create("DButton")
	DefaultIV_button:SetText("Next to role")
	DefaultIV_button.DoClick = DefaultIV
	settings_act_tab:AddItem( DefaultIV_button )
	
	local DefaultV_button = vgui.Create("DButton")
	DefaultV_button:SetText("Next to role 2")
	DefaultV_button.DoClick = DefaultV
	settings_act_tab:AddItem( DefaultV_button )
	
	local DefaultVI_button = vgui.Create("DButton")
	DefaultVI_button:SetText("Next to role 3")
	DefaultVI_button.DoClick = DefaultVI
	settings_act_tab:AddItem( DefaultVI_button )
	
	settings_act_tab:SizeToContents()
	local Version_text = vgui.Create("DLabel", General_Settings)
	Version_text:SetText("Version: "..Version.." by Fresh Garry")
	Version_text:SetColor(Color(100,100,100))
	settings_panel:AddItem( Version_text )
end)


