$modelname "mandrac/lgm/compressor.mdl"
$model "studio" "compressor.smd"
$cdmaterials "generators\"
$hboxset "default"
$surfaceprop "metal"
$keyvalues  { prop_data { "base" "Metal.Large"  } } 
$illumposition 0.000 -0.000 0.000
$sequence idle "compressor_idle" fps 1.00
$collisionmodel "compressor_phys.smd" 
{
$concave
$maxconvexpieces 54
$mass 300.00
$inertia 1.00
$damping 0.00
$rotdamping 0.00
}
