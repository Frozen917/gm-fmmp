$modelname "mandrac/lgm/genholder_small_single.mdl"
$model "studio" "genholder_small_single.smd"
$cdmaterials "generators\"
$hboxset "default"
$surfaceprop "metal"
$keyvalues  { prop_data { "base" "Metal.Large"  } } 
$illumposition 0.000 -0.000 0.000
$sequence idle "genholder_small_single_idle" fps 1.00
$collisionmodel "genholder_small_single_phys.smd" 
{
$concave
$maxconvexpieces 54
$mass 250.00
$inertia 1.00
$damping 0.00
$rotdamping 0.00
}
