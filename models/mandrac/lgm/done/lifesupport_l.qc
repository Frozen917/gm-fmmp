$modelname "mandrac/lgm/lifesupport_l.mdl"
$model "studio" "lifesupport_l.smd"
$cdmaterials "generators\"
$hboxset "default"
$surfaceprop "metal"
$keyvalues  { prop_data { "base" "Metal.Large"  } } 
$illumposition 0.000 -0.000 0.000
$sequence idle "lifesupport_l_idle" fps 30
$sequence on "lifesupport_l_on" fps 30.00
$collisionmodel "lifesupport_l_phys.smd" 
{
$concave
$maxconvexpieces 200
$mass 400.00
$inertia 1.00
$damping 0.00
$rotdamping 0.00
}
