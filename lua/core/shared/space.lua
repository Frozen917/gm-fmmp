local speedDivider = 1.025

local function isInSpace(player)
	return player:GetEnvironment():GetName() == "space"
end

local function playerCantMoveInSpace(player, movedata)
	if isInSpace(player) then
		movedata:SetVelocity(movedata:GetVelocity()/speedDivider)
		if movedata:GetVelocity():Length() < 50 then
			movedata:SetMaxSpeed(0)
		end
	end
end

function disableNoClipWhenEnteringSpace(player)
	if isInSpace(player) or player:GetEnvCharacteristic("noclip") == 0 then -- -5K
		player:SetMoveType(MOVETYPE_WALK)
	end
end

hook.Add("PlayerNoClip", "DisableNoClipInSpace", function(player) return player:GetEnvCharacteristic("noclip") > 0 end)
hook.Add("Move", "PlayerCantMoveInSpace", playerCantMoveInSpace)
hook.Add("PlayerEnteredNewEnvironment", "DisableNoClipInSpaceWhenEnteringSpace", disableNoClipWhenEnteringSpace)


local playerToDamage = 1	-- Next player to take damage, don't modify
local damagePerTick = 20
local tickPerSecond = 3


local function damagePlayerInSpace(player)
	if not player:GetEnvironment():IsViable() and not player:IsGod() and player:Alive() then
		if player:Health() <= damagePerTick then
			player:Kill()
		else
			player:SetHealth(player:Health()-damagePerTick)
		end
	end
end

local function damagePlayerInSpaceLoop()
	if GetConVar("sbox_godmode"):GetBool() then return end
	local playersCount = #player.GetAll()
	if playersCount > 0 then
		playerToDamage = (playerToDamage)%(playersCount)+1
		damagePlayerInSpace(player.GetAll()[playerToDamage])
	end
end

local function adjustPlayerSpaceDamageLoop()
	local playersCount = #player.GetAll()
	if playersCount == 1 then
		timer.Create("PlayerInSpaceDamage", 1/tickPerSecond, 0, damagePlayerInSpaceLoop)
	elseif playersCount > 1 then
		timer.Adjust("PlayerInSpaceDamage", 1/(tickPerSecond*playersCount), 0, damagePlayerInSpaceLoop)
	else
		timer.Stop("PlayerInSpaceDamage")
	end
end

hook.Add("PlayerInitialSpawn", "AdjustPlayerSpaceDamageLoop", adjustPlayerSpaceDamageLoop)
hook.Add("PlayerDisconnected", "AdjustPlayerSpaceDamageLoop", adjustPlayerSpaceDamageLoop)