$modelname "mandrac/lgm/wind_turbine.mdl"
$model "studio" "wind_turbine.smd"
$cdmaterials "generators\"
$hboxset "default"
$surfaceprop "metal"
$keyvalues  { prop_data { "base" "Metal.Large"  } } 
$illumposition 0.000 -0.000 0.000
$sequence idle "wind_turbine_idle" fps 30
$sequence on "wind_turbine_on" fps 30.00
$collisionmodel "wind_turbine_phys.smd" 
{
$concave
$maxconvexpieces 20
$mass 150.00
$inertia 1.00
$damping 0.00
$rotdamping 0.00
}
