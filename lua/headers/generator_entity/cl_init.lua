function ENT:Draw()
	self:DrawModel()
	local trace = LocalPlayer():GetEyeTrace()
	if trace.Entity == self and trace.Fraction * 16384 < 256 then
		local txt = string.format("%s\n\nOutputs\n", self.DeviceName)
		for k,res in pairs(self.outputRates) do
			local resname = string.upper(string.sub(k,0,1)) .. string.sub(k, 2)
			txt = txt .. string.format("%s: %d/%d\n", resname, self:GetNetworkedInt(k), res)
		end
		
		AddWorldTip(nil,txt,nil,self:GetPos(),nil)
	end
end
