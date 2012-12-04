Pipe = {}
Pipe.__index = Pipe
Pipe.FANCY = 1
Pipe.FAST = 2
Pipe.NONE = 3
Pipe.RenderType = Pipe.FANCY

Pipe.ModelCount = 15

function Pipe.New(nPipeID, pPlug1, pPlug2)
	local pipe = {}
	setmetatable(pipe, Pipe)
	pipe.id = nPipeID
	pipe.enteringPlug = pPlug1
	pipe.exitingPlug = pPlug2
	pPlug1:PlugTo(pPlug2, pipe)
	pPlug2:PlugTo(pPlug1, pipe)
	return pipe
end

function Pipe:GetID()
	return self.id
end

function Pipe:GetEntryPlug()
	return self.enteringPlug
end

function Pipe:GetExitPlug()
	return self.exitingPlug
end

function Pipe:Delete()
	self.enteringPlug:PlugTo(nil)
	self.exitingPlug:PlugTo(nil)
    sound.Play("/npc/dog/dog_pneumatic" .. math.floor(math.random()*1.99) .. ".wav", self.enteringPlug:GetEntity():LocalToWorld(self.enteringPlug:GetPos()))
    sound.Play("/npc/dog/dog_pneumatic" .. math.floor(math.random()*1.99) .. ".wav", self.exitingPlug:GetEntity():LocalToWorld(self.exitingPlug:GetPos()))
end

function Pipe:GetLength()
    return (self.enteringPlug:GetEntity():LocalToWorld(self.enteringPlug:GetPos()) - self.exitingPlug:GetEntity():LocalToWorld(self.exitingPlug:GetPos())):Length()
end


if CLIENT then
	local cyl = ClientsideModel("models/XQM/cylinderx1.mdl")
	local plug = ClientsideModel("models/props_lab/tpplug.mdl")
	local beammat = Material("cable/cable")
	
	function Pipe:Draw()
		local modelCount = self.ModelCount
		local mat = Matrix()
		local oldDist = 12.499979972839
		local firstPlug = self:GetEntryPlug()
		local secondPlug = self:GetExitPlug()
		local firstEntity = firstPlug:GetEntity()
		local secondEntity = secondPlug:GetEntity()
		local entryPlugPosition = firstEntity:LocalToWorld(firstPlug:GetPos())
		local entryNormal = firstEntity:LocalToWorld(firstPlug:GetPos()+firstPlug:GetNormal()) - entryPlugPosition
		local exitPlugPosition = secondEntity:LocalToWorld(secondPlug:GetPos())
		local exitNormal = secondEntity:LocalToWorld(secondPlug:GetPos()+secondPlug:GetNormal()) - exitPlugPosition
		
		if Pipe.RenderType == Pipe.FANCY then
			
			if firstEntity:IsValid() and secondEntity:IsValid() then
				
				local bfunc = Util.BezierZ( entryPlugPosition+entryNormal*10,
											entryPlugPosition+entryNormal*50,
											exitPlugPosition+exitNormal*50,
											exitPlugPosition+exitNormal*10)
				cam.Start3D(LocalPlayer():EyePos(), EyeAngles())
					mat:Scale(Vector(1,0.3,0.3))
					cyl:EnableMatrix("RenderMultiply", mat)
					cyl:SetMaterial("phoenix_storms/metalset_1-2")
					plug:SetRenderAngles(firstEntity:LocalToWorldAngles(firstPlug:GetAngles()))
					plug:SetRenderOrigin(entryPlugPosition)
					plug:SetupBones()
					plug:DrawModel()
					plug:SetRenderAngles(secondEntity:LocalToWorldAngles(secondPlug:GetAngles()))
					plug:SetRenderOrigin(exitPlugPosition)
					plug:SetupBones()
					plug:DrawModel()
					for j=1,modelCount do
						local vDist = (bfunc((1/modelCount)*j) - bfunc((1/modelCount)*(j-1)))
						local nDist = vDist:Length()*1.15
						mat:Scale(Vector(nDist/oldDist,1,1))
						cyl:EnableMatrix("RenderMultiply", mat)
						cyl:SetRenderAngles(vDist:Angle())
						cyl:SetRenderOrigin(bfunc((1/modelCount)*(j-1))+vDist/2)
						cyl:SetupBones()
						cyl:DrawModel()
						oldDist = nDist
					end
				cam.End3D()
			end
		elseif Pipe.RenderType == Pipe.FAST then
			cam.Start3D(LocalPlayer():EyePos(), EyeAngles())
				plug:SetRenderAngles(firstEntity:LocalToWorldAngles(firstPlug:GetAngles()))
				plug:SetRenderOrigin(entryPlugPosition)
				plug:SetupBones()
				plug:DrawModel()
				plug:SetRenderAngles(secondEntity:LocalToWorldAngles(secondPlug:GetAngles()))
				plug:SetRenderOrigin(exitPlugPosition)
				plug:SetupBones()
				plug:DrawModel()
				render.SetMaterial(beammat)
				render.DrawBeam(firstEntity:LocalToWorld(firstPlug:GetPos() + firstPlug:GetNormal()*(oldDist - 0.1)), secondEntity:LocalToWorld(secondPlug:GetPos() + secondPlug:GetNormal()*(oldDist-0.1)), 3, 1, 1, Color(255,255,255,255))
			cam.End3D()
		end
    end
	CreateClientConVar("gm_fmmp_pipe_modelcount", "15", true)
	cvars.AddChangeCallback("gm_fmmp_pipe_modelcount", function( convar_name, oldValue, newValue )
		if tonumber(newValue) > 0 then
			Pipe.ModelCount = tonumber(newValue)
		end
	end)
	CreateClientConVar("gm_fmmp_pipe_rendertype", "fancy", true)
	cvars.AddChangeCallback("gm_fmmp_pipe_rendertype", function( convar_name, oldValue, newValue )
		if newValue == "fancy" then
			Pipe.RenderType = Pipe.FANCY
		elseif newValue == "fast" then 
			Pipe.RenderType = Pipe.FAST
		elseif newValue == "none" then
			Pipe.RenderType = Pipe.NONE
		end
	end)
end