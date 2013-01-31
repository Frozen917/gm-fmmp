$modelname "mandrac/lgm/waterpump.mdl"
$model "studio" "waterpump.smd"
$cdmaterials "generators\"
$hboxset "default"
$surfaceprop "metal"
$keyvalues  { prop_data { "base" "Metal.Large"  } } 
$illumposition 0.000 -0.000 0.000
$sequence idle "waterpump_idle" fps 1.00
$collisionmodel "waterpump_phys.smd" 
{
$concave
$maxconvexpieces 1000
$mass 500.00
$inertia 1.00
$damping 0.00
$rotdamping 0.00
}
