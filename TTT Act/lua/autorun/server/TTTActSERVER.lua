-- Please ask me if you want to use parts of this code!

util.AddNetworkString( "TTTACT" )
hook.Add("PlayerShouldTaunt", "PlayerShouldTaunt4TTTAct", function() return true end)
net.Receive("TTTACT", function()
	local ply = net.ReadEntity()
	local Act = net.ReadString()
	local Time = net.ReadFloat()
	RunConsoleCommand("act",Act)

	ply:Freeze(true)
	timer.Simple(Time,function() ply:Freeze(false) net.Start("TTTACT") net.Send(ply) end)
end)