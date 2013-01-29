FMMP_Containers = {
	small_energy_cell = {
		name = "Small Energy Cell",
		model = "models/mandrac/lgm/energycell_s.mdl",
		holdAngle = Angle(90, 0, 0),
		slotSize = 1,
		self.heightOffset = 0,
		resources = {
			energy = {
				amount = 0,
				maxamount = 60000,
				flow = 100
			}
		}
	},
	small_oxygen_tank = {
		name = "Small Oxygen Tank",
		model = "models/mandrac/lgm/gascan.mdl",
		holdAngle = Angle(90, 0, 0),
		slotSize = 1,
		self.heightOffset = 0,
		resources = {
			oxygen = {
				amount = 0,
				maxamount = 60000,
				flow = 2000
			}
		}
	}
}

FMMP_Generators = {
	small_wind_generator = {
		name = "Small Wind Generator",
		model = "models/mandrac/lgm/wind_turbine.mdl",
		sound = "ambient/machines/machine3.wav",
		holdAngle = Angle(90, 0, 0),
		slotSize = 1,
		self.heightOffset = 0,
		inputeRates = {},
		outputRates = {
			energy = 100
		}
	},
	large_deuterium_generator = {
		name = "Large Deuterium Generator",
		model = "models/mandrac/lgm/deuterium_gen.mdl",
		sound = "",
		holdAngle = Angle(90, -90, -90),
		slotSize = 3,
		self.heightOffset = 0,
		inputeRates = {
			energy = 20
		},
		outputRates = {
			energy = 500
		}
	}
}

FMMP_Holders = {
	small_holder = {
		name = "Generic 1x Small Holder",
		model = "models/mandrac/lgm/genholder_small_single.mdl",
		slots = {
			1 = {
				1,
				Vector(0, 0, 39.76),
				Vector(0, 0, 1),
				15,
				0.4,
				0
			}
		},
		plugs = {
			1 = {
				Vector(-24.688917160034,0,7.911262512207),
				Vector(-1,0,0),
				Angle(-180,0,180)
			},
			2 = {
				Vector(24.688917160034,0,7.911262512207),
				Vector(1,0,0),
				Angle(-180,180,180)
			},
			3 = {
				Vector(0,-24.682241439819,7.911262512207),
				Vector(0,-1,0),
				Angle(-180,90,180)
			},
			4 = {
				Vector(0,24.682241439819,7.911262512207),
				Vector(0,1,0),
				Angle(-180,-90,180)
			}
		}
	},
	smallbridge_holder = {
		name = "SmallBridge 2x Large Holder - SW",
		model = "models/mandrac/lgm/genholder_sw.mdl",
		slots = {
			1 = {
				3,
				Vector(45.2, -56.3, -10.2),
				Vector(0, -1, 0),
				40,
				0.4,
				90
			},
			2 = {
				3,
				Vector(-45.2, -56.3, -10.2),
				Vector(0, -1, 0),
				40,
				0.4,
				90
			}
		},
		plugs = {
			1 = {
				Vector(-78.401016235352,-55.906661987305,-48.207065582275),
				Vector(0,-1,0),
				Angle(0,-90,0)
			},
			2 = {
				Vector(76.658271789551,-55.906215667725,-48.028030395508),
				Vector(0,-1,0),
				Angle(0,-90,0)
			}
		}
	},
	smallbridge_multi_holder = {
		name = "SmallBridge 8x Small Holder - SW",
		model = "models/mandrac/lgm/genholder_small_sw.mdl",
		slots = {
			1 = {
				1,
				Vector(-53.572681427002,84.017471313477,-8.349513053894),
				Vector(0.34175047278404,0,0.93979072570801),
				15,
				0.4,
				90
			},
			2 = {
				1,
				Vector(-53.58349609375,28.173332214355,-8.3456010818481),
				Vector(0.34174245595932,0,0.9397936463356),
				15,
				0.4,
				90
			},
			3 = {
				1,
				Vector(-53.4814453125,-27.600107192993,-8.3826904296875),
				Vector(0.34174245595932,0,0.9397936463356),
				15,
				0.4,
				90
			},
			4 = {
				1,
				Vector(-53.43408203125,-83.405281066895,-8.3999395370483),
				Vector(0.34174245595932,0,0.9397936463356),
				15,
				0.4,
				90
			},
			5 = {
				1,
				Vector(53.39990234375,84.172355651855,-8.2872142791748),
				Vector(-0.34174197912216,0,0.93979382514954),
				15,
				0.4,
				90
			},
			6 = {
				1,
				Vector(53.618789672852,28.331449508667,-8.207615852356),
				Vector(-0.34174236655235,0,0.9397936463356),
				15,
				0.4,
				90
			},
			7 = {
				1,
				Vector(53.688945770264,-27.442905426025,-8.1821985244751),
				Vector(-0.34174197912216,0,0.93979382514954),
				15,
				0.4,
				90
			},
			8 = {
				1,
				Vector(53.83154296875,-83.233894348145,-8.1303071975708),
				Vector(-0.34174197912216,0,0.93979382514954),
				15,
				0.4,
				90
			}
		},
		plugs = {
			1 = {
				Vector(-60.783207, -111.510254, -25.141457),
				Vector(0,-1,0),
				Angle(0,-90,180)
			},
			2 = {
				Vector(60.783207, -111.510254, -25.141457),
				Vector(0,-1,0),
				Angle(0,-90,180)
			},
			3 = {
				Vector(-60.783207, 111.510254, -25.141457),
				Vector(0,1,0),
				Angle(0,90,180)
			},
			4 = {
				Vector(60.783207, 111.510254, -25.141457),
				Vector(0,1,0),
				Angle(0,90,180)
			}
		}
	}
}