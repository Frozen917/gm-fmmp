ENT.initFunctions = {}

function ENT.addInitFunction(func)
	table.insert(ENT.initFunctions, func)
end

function ENT:Initialize()
	for _,func in pairs(self.initFunctions) do
		func(self)
	end
end
