ResourceDistribution = {}

ResourceDistribution.Devices = {}
ResourceDistribution.lastProcessing = math.floor(CurTime())
ResourceDistribution.floor = math.floor	-- Optimization

function ResourceDistribution.Think()
	local second = ResourceDistribution.floor(CurTime())
	if second > ResourceDistribution.lastProcessing then	-- Do it every second
		ResourceDistribution.lastProcessing = second
		for i,v in ipairs(ResourceDistribution.Devices) do
			v:ProcessResources()
		end
	end
end
hook.Add("Think", "GMFMMResourceDistribution", ResourceDistribution.Think)

function ResourceDistribution.AddDevice(device)
	if not ResourceDistribution.FindDeviceIndex(device) then
		table.insert(ResourceDistribution.Devices, device)
	end
end

function ResourceDistribution.RemoveDevice(device)
	local index = ResourceDistribution.FindDeviceIndex(device)
	if index then
		table.remove(ResourceDistribution.Devices, index)
	end
end

function ResourceDistribution.FindDeviceIndex(device)
	for i,v in ipairs(ResourceDistribution.Devices) do
		if v == device then
			return i
		end
	end
end
