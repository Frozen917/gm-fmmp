$modelname "mandrac/lgm/deuterium_extractor.mdl"
$model "studio" "deuterium_extractor.smd"
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
$sequence idle "deuterium_extractor_idle" fps 1.00
$collisionmodel "deuterium_extractor_phys" 
{
$concave
$maxconvexpieces 70
$mass 500.00
$inertia 1.00
$damping 0.00
$rotdamping 0.00
}
