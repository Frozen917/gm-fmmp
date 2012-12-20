$modelname "mandrac/lgm/gascan.mdl"
$model "studio" "gascan.smd"
$cdmaterials "generators\"
$hboxset "default"
$surfaceprop "metal"
$keyvalues  { prop_data { "base" "Metal.Large"  } } 
$illumposition 0.000 -0.000 0.000
$sequence idle "gascan_idle" fps 1
$sequence on "gascan_full" fps 100.00
$collisionmodel "gascan_phys.smd" 
{
$concave
$maxconvexpieces 20
$mass 70.00
$inertia 1.00
$damping 0.00
$rotdamping 0.00
}
