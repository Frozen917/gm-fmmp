TOOL.Mode       = "fmp_container_tool"
TOOL.Category   = "FMP GameMode"
TOOL.Name       = "Container Tool"
TOOL.Tab 		= "FMP"


TOOL.ClientConVar["ent"] = "sb_small_energycell"



local allowedClasses = {}

local function RegisterContainer(sName, sClass, sModel)
	list.Add("FMPContainers", {name = sName, ent = sClass, model = sModel })
	table.insert(allowedClasses, sClass)
end
-- CLIENT
if CLIENT then
    language.Add("Tool.fmp_container_tool.name", "Container Tool" )
    language.Add("Tool.fmp_container_tool.desc", "Create a container!" )
    language.Add("Tool.fmp_container_tool.0", "Left click to create a container")
	
	
	
end

RegisterContainer("Small Energy Cell", "sb_small_energycell", "models/mandrac/lgm/energycell_s.mdl")



if CLIENT then
	local function paintOutlined(object)
		local x,y = object:GetPos()
		draw.RoundedBox(2, x, y, object:GetWide(), object:GetTall(), Color(25, 25, 25))
		local bgcolor
		if object.GetBackgroundColor then
			bgcolor = object:GetBackgroundColor()
		else
			bgcolor = Color(255, 255, 255)
		end
		draw.RoundedBox(2, x + 2, y + 2, object:GetWide() - 4, object:GetTall() - 4, bgcolor)
		object:originalPaint()
	end


	
	
	function TOOL.BuildCPanel(CPanel)
		CPanel:AddControl("Header", { Text = "Container Tool", Description = "Spawns a container" })
		local panel = vgui.Create("DPanel", CPanel)
		panel:SetSize(CPanel:GetWide() - 20, 30)
		CPanel:AddItem(panel)
		
		local image = vgui.Create("DImage", panel)
		image:SetImage("generators/gui/selection")
		image:SetSize(150, 150)
		image:SetVisible(false)
		
		local x, y = 0, 0
		for _,v in ipairs(list.Get("FMPContainers")) do
			panel:SetTall(panel:GetTall() + 150)
			local spawnIcon = vgui.Create("DModelPanel", panel)
			spawnIcon:SetPos(x, y)
			spawnIcon:SetSize(150, 150)
			spawnIcon:SetCamPos(Vector(170, 170, 0))
			spawnIcon:SetFOV(80)
			spawnIcon:SetLookAt(Vector(0, 0, 0))
			spawnIcon:SetToolTip(v.name)
			spawnIcon:SetModel(v.model)
			spawnIcon.DoClick = function(icon)
				image:SetPos(icon:GetPos())
				image:SetVisible(true)
				RunConsoleCommand("fmp_container_tool_ent", v.ent)
			end
			
			local lbl = vgui.Create("DLabel", panel)
			lbl:SetText(v.name)
			lbl:SetTall(50)
			lbl:SetPos(x + 170, y + 25)
			lbl:SetWrap(true)
			
			y = y + 155
		end
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
				ent:SpawnFunction(self:GetOwner(), trace)
			return true
		else
			self:GetOwner():PrintMessage(HUD_PRINTTALK, className.." is not a valid container!")
			return false
		end
	end
	return true
end
