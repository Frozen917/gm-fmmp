$modelname "mandrac/lgm/tictac.mdl"
$model "studio" "tictac.smd"
$cdmaterials "generators\"
$hboxset "default"
$surfaceprop "metal"
$keyvalues  { prop_data { "base" "Metal.Large"  } } 
$illumposition 0.000 -0.000 0.000
$sequence idle "tictac_idle" fps 1.00
$collisionmodel "tictac.smd" 
{
$mass 5.00
$inertia 1.00
$damping 0.00
$rotdamping 0.00
}
