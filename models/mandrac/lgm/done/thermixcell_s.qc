$modelname "mandrac/lgm/thermixcell_s.mdl"
$model "studio" "thermixcell_s.smd"
$cdmaterials "generators\"
$texturegroup skinfamilies
{
	{
	 "gen2rl.vmt"
	 "heatlight.vmt"
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
$sequence idle "energycell_s_idle" fps 1.00
$collisionmodel "energycell_s_phys.smd" 
{
$concave
$maxconvexpieces 70
$mass 70.00
$inertia 1.00
$damping 0.00
$rotdamping 0.00
}
