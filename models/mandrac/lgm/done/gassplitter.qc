$modelname "mandrac/lgm/gassplitter.mdl"
$model "studio" "gassplitter.smd"
$cdmaterials "generators\"
$hboxset "default"
$surfaceprop "metal"
$keyvalues  { prop_data { "base" "Metal.Large"  } } 
$illumposition 0.000 -0.000 0.000
$sequence idle "gassplitter_idle" fps 1
$collisionmodel "energycell_s_phys.smd" 
{
$concave
$maxconvexpieces 20
$mass 70.00
$inertia 1.00
$damping 0.00
$rotdamping 0.00
}
