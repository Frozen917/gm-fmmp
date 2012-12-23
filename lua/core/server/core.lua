Core = {}
Core.entities = {}
Core.blacklist = {
	"keyframe_rope",
	"crossbow_bolt",
	"env_spritetrail",
	"soundent",
	"player_manager",
	"ai_network",
	"predicted_viewmodel",
	"scene_manager",
	"sb_small_holder",
	"logic_collision_pair",
	"gmod_gamerules",
	"env_laserdot",
	"rpg_missile",
	"env_rockettrail",
	"gmod_wire_hologram",
	"npc_grenade_frag",
	"entityflame"
}

util.AddNetworkString("ReadyToPlay")

function Core.MainEntsLoop()
	for i,v in ipairs (Core.entities) do
		local entity = v
		if entity:IsValid() and entity:GetPhysicsObject():IsValid() then
			hook.Call("ThinkOnEveryEnts_HP", nil, entity)
			if not entity:IsPlayer() then
				local physobj = entity:GetPhysicsObject()
				if physobj:IsValid() then
					if not physobj:IsMoveable() then
						hook.Call("ThinkOnFrozenEnts", nil, entity)
					end
					if physobj:IsAsleep() then
						hook.Call("ThinkOnSleepingEnts", nil, entity)
					end
					if physobj:IsMoveable() and not physobj:IsAsleep() then
						hook.Call("ThinkOnMovingEnts", nil, entity)
					end
				end
			elseif entity:IsPlayer() then
				hook.Call("ThinkOnPlayers", nil, entity)
			end
			hook.Call("ThinkOnEveryEnts", nil, entity)
		else
			table.remove(Core.entities, i)
		end
	end
end
hook.Add("Think", "EntsMainLoop", Core.MainEntsLoop)

function Core.SpawnEntity(entity)
	if not entity:IsWeapon() and not Util.StringIsInArray(Core.blacklist, entity:GetClass()) and string.find(entity:GetClass(), "constraint") == nil then
		table.insert(Core.entities, entity)
	end
end

function Core.RemoveEntity(entity)
	for i=1,#Core.entities do
		if Core.entities[i] == entity then
			table.remove(Core.entities, i)
		end
	end
end

function Core.RegisterEntities()
	hook.Add("OnEntityCreated", "AddEntityToCore", Core.SpawnEntity)
	hook.Add("EntityRemoved", "RemoveEntityFromCore", Core.RemoveEntity)
end
hook.Add("InitPostEntity", "RegisterEntitiesAfterLoading", Core.RegisterEntities)

function Core.EntEnteringEnvironment(entity)
	local environments = Universe.GetEntityEnvironments(entity)
	if not Util.TableHasSameElements(entity.environments, environments) then
		entity.environments = environments
		if entity:IsPlayer() then
			Core.UpdateLocalEnvironmentForPlayer(entity)
			hook.Call("PlayerEnteredNewEnvironment", nil, entity)
		end
		hook.Call("EntityEnteredNewEnvironment", nil, entity)
	end
end
hook.Add("ThinkOnEveryEnts_HP", "DetectingPlayerEnteringEnvironment", Core.EntEnteringEnvironment)
--hook.Add("ThinkOnPlayers_HP", "DetectingPlayerEnteringEnvironment", Core.EntEnteringEnvironment)
--hook.Add("ThinkOnMovingEnts_HP", "DetectingPropsEnteringEnvironment", Core.EntEnteringEnvironment)

function Core.UpdateLocalEnvironmentForPlayer(player)
	net.Start("UpdateLocalEnvironment")
	net.WriteTable(player:GetEnvironments())
	net.Send(player)
end

function Core.PlayerReadyToPlay(length, ply)
	if net.ReadBit() == 1 then
		hook.Call("PlayerReadyToPlay", nil, ply)
	end
end
net.Receive("ReadyToPlay", Core.PlayerReadyToPlay)

FindMetaTable("Entity").IsGod = function(self) return self.isgod or false end
