local Plugin = {}

Plugin.id = "spaceslower"
Plugin.name = "Space Prop Slower"
Plugin.description = "Slows props and physical entities down while in space to enhance distance perception"

Plugin.DragIntensity = 100 -- From 0.4 to 1 for better results

function Plugin.Run()
	hook.Add("ThinkOnMovingEnts", "PropSlowerHook", Plugin.SlowEntityDown)
end

function Plugin.Stop()
	hook.Remove("ThinkOnMovingEnts", "PropSlowerHook")
end


function Plugin.SlowEntityDown(ent)
	local phys = ent:GetPhysicsObject()
	if phys:IsValid() and ent:GetEnvironment() then
		if not ent:GetEnvironment():IsPlanet() == "space" then	
			local vel = phys:GetVelocity()
			local speed = vel:Length()
			phys:SetVelocity(vel/( 1 + Plugin.DragIntensity/100))
		end
	end
end

Plugins.Register(Plugin)