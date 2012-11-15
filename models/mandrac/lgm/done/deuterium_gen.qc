$modelname "mandrac/lgm/deuterium_gen.mdl"
$model "studio" "deuterium_gen.smd"
$cdmaterials "generators\"
$texturegroup skinfamilies
{
	{
	 "gen2bl.vmt"
	 "deutlight.vmt"
	}
	{
	 "gen2.vmt"
	 "nolight.vmt"
	}

}
$hboxset "default"
$surfaceprop "metal"
$keyvalues  { prop_data { "base" "Metal.Large"  } } 
$illumposition 0.000 -0.000 0.000
$sequence idle "deuterium_gen_idle" fps 1.00
$collisionmodel "deuterium_gen_phys.smd" 
{
$concave
$maxconvexpieces 70
$mass 350.00
$inertia 1.00
$damping 0.00
$rotdamping 0.00
}
