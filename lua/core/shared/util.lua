Util = {}

function Util.BezierZ(a, b, c, d)
	return function(t) return a*(1-t)^3 + 3*b*t*(t-1)^2 + 3*c*(t^2)*(1-t) + d*t^3 end
end

function Util.EntityCenter(entity)
	return entity:LocalToWorld(entity:OBBCenter())
end

function Util.FindByModel(sModel) -- ents.FindByModel does not work on client!
	local props = ents.FindByClass("prop_physics")
	for k,v in ipairs(props) do
		if v:GetModel() == sModel then
			return v
		end
	end
	return nil
end


function Util.InheritFrom(baseClass)
	local newClass = {}
	if baseClass then
		setmetatable(newClass, {__index = baseClass})
	end
	return newClass
end

function Util.IsInRange(nMin, nMax, nNum)
	return nMin <= nNum and nNum <= nMax
end

function Util.TableHasSameElements(t1, t2)
	if t1 == nil or t2 == nil or #t1 != #t2 then return false end
	for k,v in pairs(t1) do
		if v != t2[k] then return false end
	end
	return true	
end

function Util.EntityBearing(eEntity, vPosition)
	local vec = eEntity:WorldToLocal(vPosition)
	return -atan2(vec.x, vec.y)*(180/math.pi)
end

function Util.EntityElevation(eEntity, vPosition)
	local vec = eEntity:WorldToLocal(vPosition)
	return asin(vec.z/vec:Length())*(180/math.pi)
end

function Util.AngleBetweenVectors(v1, v2)
	local a = v1:Length()
	local b = v2:Length()
	local c = (v2 - v1):Length()
	return (180/math.pi)*math.acos((c^2 - a^2 - b^2)/(-2*a*b))
end

function Util.StringIsInArray(t1, s1)
	for i,v in ipairs(t1) do
		if v == s1 then return true end
	end
	return false
end

function Util.RandInt(n1, n2)
	return math.floor(math.random()*(n2-n1+0.999)+n1)
end
