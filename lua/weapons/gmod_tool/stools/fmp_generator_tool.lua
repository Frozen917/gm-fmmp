TOOL.Mode       = "fmp_generator_tool"
TOOL.Category   = "FMP GameMode"
TOOL.Name       = "Generator Tool"
TOOL.Tab		= "FMP"


TOOL.ClientConVar["ent"] = "sb_wind_gen"
TOOL.ClientConVar["freeze"] = "0"
TOOL.ClientConVar["autohold"] = "0"

local allowedClasses = {}

local function RegisterGenerator(sName, nType, sClass, sModel)
	list.Add("FMPGenerators", {name = sName, genType = nType,ent = sClass, model = sModel })
	table.insert(allowedClasses, sClass)
end
-- CLIENT
if CLIENT then
    language.Add("Tool.fmp_generator_tool.name", "Generator Tool" )
    language.Add("Tool.fmp_generator_tool.desc", "Create a generator!" )
    language.Add("Tool.fmp_generator_tool.0", "Left click to create a generator")
	
	
	
end
local GEN_PRIMARY = 1
local GEN_SECONDARY = 2

RegisterGenerator("Large Deuterium Generator", GEN_SECONDARY, "sb_deuterium_gen", "models/mandrac/lgm/deuterium_gen.mdl")
RegisterGenerator("Small Wind Turbine", GEN_PRIMARY, "sb_wind_gen", "models/mandrac/lgm/wind_turbine.mdl")

function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("Header", { Text = "Generator Tool", Description = "Spawns a generator" })

	local primaryLabel = vgui.Create("DLabel", CPanel)
	primaryLabel:SetText("Primary Generators")
	primaryLabel:SetColor(Color(0,0,0))
	CPanel:AddItem(primaryLabel)
	
	
	local primaryPanel = vgui.Create("DPanel", CPanel)
	primaryPanel:SetSize(CPanel:GetWide() - 20, 15)
	primaryPanel.spawnIconX = 0
	primaryPanel.spawnIconY = 0
	CPanel:AddItem(primaryPanel)
	
	
	
	local secondaryLabel = vgui.Create("DLabel", CPanel)
	secondaryLabel:SetText("Secondary Generators")
	secondaryLabel:SetColor(Color(0,0,0))
	CPanel:AddItem(secondaryLabel)

	local secondaryPanel = vgui.Create("DPanel", CPanel)
	secondaryPanel:SetSize(CPanel:GetWide(), 15)
	secondaryPanel.spawnIconX = 0
	secondaryPanel.spawnIconY = 0
	CPanel:AddItem(secondaryPanel)
	
	local checkbox = vgui.Create("DCheckBoxLabel", CPanel)
		checkbox:SetText("Freeze ?")
		checkbox:SetConVar("fmp_generator_tool_freeze")
		checkbox:SizeToContents()
		CPanel:AddItem(checkbox)
		
	local checkbox2 = vgui.Create("DCheckBoxLabel", CPanel)
		checkbox2:SetText("Autohold ?")
		checkbox2:SetConVar("fmp_generator_tool_autohold")
		checkbox2:SizeToContents()
		CPanel:AddItem(checkbox2)
	
	
	local image1 = vgui.Create("DImage", primaryPanel)
	image1:SetImage("generators/gui/selection")
	image1:SetSize(150, 150)
	image1:SetVisible(false)
	
	local image2 = vgui.Create("DImage", secondaryPanel)
	image2:SetImage("generators/gui/selection")
	image2:SetSize(150, 150)
	image2:SetVisible(false)
	
	for name,v in pairs(list.Get("FMPGenerators")) do
		local parent
		local image, otherimage
		if v.genType == GEN_PRIMARY then
			parent = primaryPanel
			image = image1
			otherimage = image2
		elseif v.genType == GEN_SECONDARY then
			parent = secondaryPanel
			image = image2
			otherimage = image1
		end
		
		parent:SetTall(parent:GetTall() + 150)
		
		local spawnIcon = vgui.Create("DModelPanel", parent)
		spawnIcon:SetPos(parent.spawnIconX, parent.spawnIconY)
		spawnIcon:SetSize(150, 150)
		spawnIcon:SetFOV(80)
		spawnIcon:SetCamPos(Vector(130, 130, 0))
		spawnIcon:SetLookAt(Vector(0, 0, 0))
		spawnIcon:SetToolTip(v.name)
		spawnIcon:SetModel(v.model)
		spawnIcon.DoClick = function(icon)
			image:SetPos(icon:GetPos())
			image:SetVisible(true)
			otherimage:SetVisible(false)
			RunConsoleCommand("fmp_generator_tool_ent", v.ent)
		end
		
		local lbl = vgui.Create("DLabel", parent)
		lbl:SetText(v.name)
		lbl:SetTall(50)
		lbl:SetPos(parent.spawnIconX + 170, parent.spawnIconY + 25)
		lbl:SetWrap(true)
		--lbl:SizeToContents()
		
		parent.spawnIconY = parent.spawnIconY + 160
	end
end
-- SHARED
function TOOL:LeftClick(trace)
	if SERVER then
		local className = self:GetClientInfo("ent")
		if table.HasValue(allowedClasses, className) then
			
				local ent = scripted_ents.GetStored(className).t
				if ent.AdminSpawnable and not ent.Spawnable and not self:GetOwner():IsAdmin() then
					self:GetOwner():PrintMessage(HUD_PRINTTALK, "You are not allowed to do that!")
					return false
				end
				local entity = ent:SpawnFunction(self:GetOwner(), trace, self:GetClientInfo("freeze") == "1")
				if self:GetClientInfo("autohold") == "1" then
					local holder = trace.Entity
					if holder and holder.type == "HOLDER" then
						local found = false
						local distance = -1
						local nearest = nil
						for _,slot in ipairs(holder:GetSlots()) do
							if ( distance == -1 or holder:WorldToLocal(trace.HitPos):Distance(slot:GetPos()) < distance) and slot:GetGenerator() == nil and slot:GetSize() == entity:GetSlotSize() then
								distance = holder:WorldToLocal(trace.HitPos):Distance(slot:GetPos())
								nearest = slot
								found = true
							end
						end
						if nearest then
							nearest:Grab(entity)
						end
					end
				end
			return true
		else
			self:GetOwner():PrintMessage(HUD_PRINTTALK, className.." is not a valid generator!")
			return false
		end
	end
	return true
end
