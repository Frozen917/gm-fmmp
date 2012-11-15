FindMetaTable("Entity").GetEnvironments = function(self) return self.environments end
FindMetaTable("Entity").GetEnvironment = function(self) return self:GetEnvironments()[1] end
FindMetaTable("Entity").GetEnvCharacteristic = function(self, type)
	local environments = self:GetEnvironments()
	local characteristic = -1
	local indent = 1
	while characteristic < 0 and indent <= #environments do
		characteristic = environments[indent]:GetCharacteristic(type)
		indent = indent + 1
	end
	return characteristic or 0
end
