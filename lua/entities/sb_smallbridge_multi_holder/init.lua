AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


local angleTolerance = 30

function ENT:SpawnFunction(spawner, trace)
	local entity = ents.Create("sb_smallbridge_multi_holder")
	entity:SetPos(trace.HitPos + trace.HitNormal*56) 
    entity:Spawn()
    entity:Activate()
	undo.Create("SmallBridge_Holder")
		undo.AddEntity(entity)
		undo.SetPlayer(spawner)
		undo.SetCustomUndoText("Undone SmallBridge Holder")
	undo.Finish()
	self.type = "CONTAINER"
end

function ENT:ServerSideInit()
	self:SetModel("models/mandrac/lgm/genholder_small_sw.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	-- RIGHT
	table.insert(self.slots, Slot.New(
		self,
		1,
		Vector(-53.572681427002,84.017471313477,-8.349513053894),
		Vector(0.34175047278404,0,0.93979072570801),
		15,
		0.4
	))
	table.insert(self.slots, Slot.New(
		self,
		1,
		Vector(-53.58349609375,28.173332214355,-8.3456010818481),
		Vector(0.34174245595932,0,0.9397936463356),
		15,
		0.4
	))
	table.insert(self.slots, Slot.New(
		self,
		1,
		Vector(-53.4814453125,-27.600107192993,-8.3826904296875),
		Vector(0.34174245595932,0,0.9397936463356),
		15,
		0.4
	))
	table.insert(self.slots, Slot.New(
		self,
		1,
		Vector(-53.43408203125,-83.405281066895,-8.3999395370483),
		Vector(0.34174245595932,0,0.9397936463356),
		15,
		0.4
	))	
	
	-- LEFT
	table.insert(self.slots, Slot.New(
		self,
		1,
		Vector(53.39990234375,84.172355651855,-8.2872142791748),
		Vector(-0.34174197912216,0,0.93979382514954),
		15,
		0.4
	))
	table.insert(self.slots, Slot.New(
		self,
		1,
		Vector(53.618789672852,28.331449508667,-8.207615852356),
		Vector(-0.34174236655235,0,0.9397936463356),
		15,
		0.4
	))
	table.insert(self.slots, Slot.New(
		self,
		1,
		Vector(53.688945770264,-27.442905426025,-8.1821985244751),
		Vector(-0.34174197912216,0,0.93979382514954),
		15,
		0.4
	))
	table.insert(self.slots, Slot.New(
		self,
		1,
		Vector(53.83154296875,-83.233894348145,-8.1303071975708),
		Vector(-0.34174197912216,0,0.93979382514954),
		15,
		0.4
	))
end