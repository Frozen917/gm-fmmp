ResourceDistribution = {}

ResourceDistribution.Devices = {}
ResourceDistribution.lastProcessing = math.floor(CurTime())
ResourceDistribution.floor = math.floor	-- Optimization

function ResourceDistribution.Think()
	local second = ResourceDistribution.floor(CurTime())
	if second > ResourceDistribution.lastProcessing then	-- Do it every second
		for i,v in ipairs(ResourceDistribution.Devices) do
			v:ProcessResources()
		end
	end
end
hook.Add("Think", "GMFMMResourceDistribution", ResourceDistribution.Think)

function ResourceDistribution.AddDevice(eDevice)
	table.insert(ResourceDistribution.Devices, eDevice)
end

function ResourceDistribution.RemoveDevice(eDevice)
	for i,v in ipairs(ResourceDistribution.Devices) do
		if v == eDevice then
			table.remove(ResourceDistribution.Devices, i)
		end
	end
end
