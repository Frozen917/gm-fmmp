Devices = {}

Devices.Containers = {}
Devices.Generators = {}
Devices.Holders = {}

--[[
	Registers a container.
	Resource table layout:
	{
		resource_name1 = {
			amount_on_spawn = aNumber1, (Default to zero)
			maxamount = aNumber1,
			flow = aNumber1
		},
		resource_name2 = {
			amount_on_spawn = aNumber2,
			maxamount = aNumber2,
			flow = aNumber2
		}
	}

]]
function Devices.RegisterContainer(sName, sModel, aHoldAngle, nSlotSize, nHeightOffset, tResources)
	local index = string.lower(string.gsub(sName, " ", "_"))
	if not Devices.Containers[index] then
		Devices.Containers[index] = {
			name = sName,
			model = sModel,
			holdAngle = aHoldAngle,
			slotSize = nSlotSize,
			heightOffset = nHeightOffset,
			resources = tResources
		}
		return true
	else
		return false
	end
end

function Devices.GetRegisteredContainers()
	return Devices.Containers
end
--[[
	Registers a generator.
	Inputs/Outputs table layout:
	{
		resource_name1 = rate1,
		resource_name2 = rate2
	}
]]
function Devices.RegisterGenerator(sName, sModel, sSound, sAnimationOn, sAnimationIdle, aHoldAngle, nSlotSize, nHeightOffset, tCharacteristics, tInputs, tOutputs)
	local index = string.lower(string.gsub(sName, " ", "_"))
	if not Devices.Generators[index] then
		Devices.Generators[index] = {
			name = sName,
			model = sModel,
			sound = sSound,
			animationOn = sAnimationOn,
			animationIdle = sAnimationIdle,
			holdAngle = aHoldAngle,
			slotSize = nSlotSize,
			heightOffset = nHeightOffset,
			requiredCharacteristics = tCharacteristics,
			inputRates = tInputs,
			outputRates = tOutputs
		}
		return true
	else
		return false
	end
end

function Devices.GetRegisteredGenerators()
	return Devices.Generators
end

--[[
	Registers a holder.
	Slots table layout:
	{
		{	(One subtable per slot)
			nSlotSize,
			vCenterPos,
			vDirection,
			
		}
	}
	
	Plugs table layout:
	{
		{	(One subtable per plug)
			vPosition,
			vDirection,
			aAngle
		
		}
	}
]]
function Devices.RegisterHolder(sName, sModel, tSlots, tPlugs)
	local index = string.lower(string.gsub(sName, " ", "_"))
	if not Devices.Holders[index] then
		Devices.Holders[index] = {
			name = sName,
			model = sModel,
			slots = tSlots,
			plugs = tPlugs
		}
		return true
	else
		return false
	end
end

function Devices.GetRegisteredHolders() 
	return Devices.Holders
end

Devices.RegisterContainer(	"Small Energy Cell", 
							"models/mandrac/lgm/energycell_s.mdl",
							Angle(90, 0, 0),
							1,
							0,
							{
								energy = {
									amount = 0,
									maxamount = 60000,
									flow = 100
								}
							})
							
Devices.RegisterContainer(	"Small Oxygen Tank", 
							"models/mandrac/lgm/gascan.mdl",
							Angle(90, 0, 0),
							1,
							0,
							{
								oxygen = {
									amount = 0,
									maxamount = 60000,
									flow = 2000
								}
							})
						

Devices.RegisterGenerator(	"Small Wind Generator",
							"models/mandrac/lgm/wind_turbine.mdl",
							"ambient/machines/machine3.wav",
							"on", -- Animation when enabled
							"idle",	-- Animation when disabled
							Angle(90, 0, 0),
							1,
							0,
							{ 
								wind = {
									min = 0.1,
									max = 100
								}
							},
							{},
							{
								energy = 100
							})
							
Devices.RegisterGenerator(	"Large Deuterium Generator",
							"models/mandrac/lgm/deuterium_gen.mdl",
							"",
							"",
							"",
							Angle(90, -90, -90),
							3,
							0,
							{},
							{
								energy = 20
							},
							{
								energy = 500
							})
							
							
Devices.RegisterHolder(		"Generic 1x Small Holder",
							"models/mandrac/lgm/genholder_small_single.mdl",
							{
								{
									1,
									Vector(0, 0, 39.76),
									Vector(0, 0, 1),
									15,
									0.4,
									0
								}
							},
							{
								{
									Vector(-24.688917160034,0,7.911262512207),
									Vector(-1,0,0),
									Angle(-180,0,180)
								},
								{
									Vector(24.688917160034,0,7.911262512207),
									Vector(1,0,0),
									Angle(-180,180,180)
								},
								{
									Vector(0,-24.682241439819,7.911262512207),
									Vector(0,-1,0),
									Angle(-180,90,180)
								},
								{
									Vector(0,24.682241439819,7.911262512207),
									Vector(0,1,0),
									Angle(-180,-90,180)
								}
							})
					
Devices.RegisterHolder(		"SmallBridge 2x Large Holder - SW",
							"models/mandrac/lgm/genholder_sw.mdl",
							{
								{
									3,
									Vector(45.2, -56.3, -10.2),
									Vector(0, -1, 0),
									40,
									0.4,
									90
								},
								{
									3,
									Vector(-45.2, -56.3, -10.2),
									Vector(0, -1, 0),
									40,
									0.4,
									90
								}
							},
							{
								{
									Vector(-78.401016235352,-55.906661987305,-48.207065582275),
									Vector(0,-1,0),
									Angle(0,-90,0)
								},
								{
									Vector(76.658271789551,-55.906215667725,-48.028030395508),
									Vector(0,-1,0),
									Angle(0,-90,0)
								}
							})

Devices.RegisterHolder(		"SmallBridge 8x Small Holder - SW",
							"models/mandrac/lgm/genholder_small_sw.mdl",
							{
								{
									1,
									Vector(-53.572681427002,84.017471313477,-8.349513053894),
									Vector(0.34175047278404,0,0.93979072570801),
									15,
									0.4,
									90
								},
								{
									1,
									Vector(-53.58349609375,28.173332214355,-8.3456010818481),
									Vector(0.34174245595932,0,0.9397936463356),
									15,
									0.4,
									90
								},
								{
									1,
									Vector(-53.4814453125,-27.600107192993,-8.3826904296875),
									Vector(0.34174245595932,0,0.9397936463356),
									15,
									0.4,
									90
								},
								{
									1,
									Vector(-53.43408203125,-83.405281066895,-8.3999395370483),
									Vector(0.34174245595932,0,0.9397936463356),
									15,
									0.4,
									90
								},
								{
									1,
									Vector(53.39990234375,84.172355651855,-8.2872142791748),
									Vector(-0.34174197912216,0,0.93979382514954),
									15,
									0.4,
									90
								},
								{
									1,
									Vector(53.618789672852,28.331449508667,-8.207615852356),
									Vector(-0.34174236655235,0,0.9397936463356),
									15,
									0.4,
									90
								},
								{
									1,
									Vector(53.688945770264,-27.442905426025,-8.1821985244751),
									Vector(-0.34174197912216,0,0.93979382514954),
									15,
									0.4,
									90
								},
								{
									1,
									Vector(53.83154296875,-83.233894348145,-8.1303071975708),
									Vector(-0.34174197912216,0,0.93979382514954),
									15,
									0.4,
									90
								}
							},
							{
								{
									Vector(-60.783207, -111.510254, -25.141457),
									Vector(0,-1,0),
									Angle(0,-90,180)
								},
								{
									Vector(60.783207, -111.510254, -25.141457),
									Vector(0,-1,0),
									Angle(0,-90,180)
								},
								{
									Vector(-60.783207, 111.510254, -25.141457),
									Vector(0,1,0),
									Angle(0,90,180)
								},
								{
									Vector(60.783207, 111.510254, -25.141457),
									Vector(0,1,0),
									Angle(0,90,180)
								}
							})