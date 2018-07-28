-- Please ask me if you want to use parts of this code!
hook.Add("PlayerButtonDown", "TTTAct_Cancel", function(ply, key)
	if(ply.TTTActivity != nil) then
		timer.Remove("TTTAct_TimesUp" .. ply:Nick())
		ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, ACT_IDLE, true)
		ply.TTTActivity = nil
		net.Start("TTTACT") 
		net.Send(ply) 
	end
end)

hook.Add("StartCommand", "TTTAct_MovementCancel", function(ply, ucmd)
	if(ply.TTTActivity != nil) then
		ucmd:ClearMovement()
	end
end)



util.AddNetworkString( "TTTACT" )
net.Receive("TTTACT", function()
	local ply = net.ReadEntity()
	local Act = net.ReadString()
	local Time = net.ReadFloat()
	
	ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, Act, true)
	timer.Simple(0.1, function() ply.TTTActivity = Act end)
	
	timer.Create("TTTAct_TimesUp" .. ply:Nick(), Time, 1, function() 
		ply.TTTActivity = nil
		net.Start("TTTACT") 
		net.Send(ply) 
	end)
end)