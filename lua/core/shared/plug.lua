Plug = {}
Plug.__index = Plug

function Plug.New(eParent, nID, vPos, vNorm, aAng)
	local plug = {}
	setmetatable(plug, Plug)
	plug.entity = eParent
	plug.id = nID
	plug.position = vPos
	plug.normal = vNorm
	plug.angles = aAng
	plug.plugged = nil
	plug.pipe = nil
	return plug
end

function Plug:IsPlugged()
	return self.plugged != nil
end

function Plug:GetOtherPlug()
	if self:IsPlugged() then
		return self.plugged
	end
end

function Plug:PlugTo(pPlug, pPipe)
	if pPlug != nil then
		self.pipe = pPipe
		self.plugged = pPlug
	else
		self.pipe = nil
		self.plugged = nil
	end
end

function Plug:GetPipe()
	return self.pipe
end

function Plug:GetEntity()
	return self.entity
end

function Plug:GetID()
	return self.id
end

function Plug:GetPos()
	return self.position
end

function Plug:GetNormal()
	return self.normal
end

function Plug:GetAngles()
	return self.angles
end

function Plug:FetchInputResourceAmount(sResource)
	if self:GetOtherPlug() != nil then
		return self:GetOtherPlug():FetchOutputResourceAmount(sResource)
	else return 0 end
end

function Plug:FetchOutputResourceAmount(sResource)
	return self:GetEntity():FetchOutputResourceAmount(sResource)
end

