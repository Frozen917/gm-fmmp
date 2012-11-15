Core = {}

function Core.UpdateLocalEnvironment()
	if LocalPlayer():IsValid() then
		LocalPlayer().environments = net.ReadTable()
		for i,v in ipairs(LocalPlayer().environments) do
			setmetatable(v, {__index=Environment})
		end
	else
		Core.environments = net.ReadTable()
		for i,v in ipairs(Core.environments) do
			setmetatable(v, {__index=Environment})
		end
	end
end
net.Receive("UpdateLocalEnvironment", Core.UpdateLocalEnvironment)

function Core.CopyStartupDataToLocalPlayer()
	LocalPlayer().environments = Core.environments
end
hook.Add("InitPostEntity", "CopyStartupDataToLocalPlayer", Core.CopyStartupDataToLocalPlayer)

function Core.ReadyToPlay()
	LocalPlayer().readyToPlay = true
	net.Start("ReadyToPlay")
	net.WriteBit(true)
	net.SendToServer()
end
hook.Add("InitPostEntity", "ReadyToPlay", Core.ReadyToPlay)