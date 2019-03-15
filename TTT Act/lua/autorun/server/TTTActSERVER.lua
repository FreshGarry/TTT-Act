-- Please ask me if you want to use parts of this code!
hook.Add("PlayerButtonDown", "TTTAct_Cancel", function(ply, key)
	if(ply.TTTActivity != nil) then
		timer.Remove("TTTAct_TimesUp" .. ply:Nick())
		ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, ACT_IDLE, true)
		ply.TTTActivity = nil
		
		ply:SetNWInt("TTTActivity", ACT_IDLE)
		if ply.TTTActSound then
			ply.TTTActSound:FadeOut(1)
		end
		
		net.Start("TTTACT") 
		net.Send(ply) 
	end
end)

hook.Add("StartCommand", "TTTAct_MovementCancel", function(ply, ucmd)
	if(ply.TTTActivity != nil) then
		ucmd:ClearMovement()
	end
end)

hook.Add("TTTPrepareRound", "TTTAct_TTTPrepareRound", function() -- Cancel when round ends
	for k, ply in pairs(player:GetAll()) do
		if(ply.TTTActivity != nil) then
			timer.Remove("TTTAct_TimesUp" .. ply:Nick())
			ply.TTTActivity = nil
			net.Start("TTTACT") 
			net.Send(ply)
		end
	end
end)


util.AddNetworkString( "TTTACT" )
net.Receive("TTTACT", function()
	local ply = net.ReadEntity()
	local Act = net.ReadString()
	local Time = net.ReadFloat()
	local soundPath = net.ReadString()
	local mode = net.ReadFloat()
	
	ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, Act, true)
	timer.Simple(0.1, function() ply.TTTActivity = Act end)
	
	ply:SetNWInt("TTTActivity", Act)
	ply:SetNWString("TTTActivitySoundPath", soundPath)
	ply:SetNWFloat("TTTActivitySoundMode", mode)
	
	timer.Create("TTTAct_TimesUp" .. ply:Nick(), Time, 1, function() 
		ply.TTTActivity = nil
		net.Start("TTTACT") 
		net.Send(ply) 
		
		ply:SetNWInt("TTTActivity", ACT_IDLE)
		if ply.TTTActSound then
			ply.TTTActSound:FadeOut(1)
		end
	end)
end)