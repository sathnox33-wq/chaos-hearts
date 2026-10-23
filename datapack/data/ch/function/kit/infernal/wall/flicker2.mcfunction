# Two layered flame sprites: an outer tongue and a hot core.
$function ch:api/fx/sprite3 {model:"flame",color:$(c),a:"[0.9,0.6,0.9]",b:"[1.25,3.3,1.25]",t:3,life:7,spin:40}
$execute rotated ~45 0 run function ch:api/fx/sprite3 {model:"flame",color:$(c3),a:"[0.4,0.4,0.4]",b:"[0.6,2.1,0.6]",t:3,life:6,spin:-60}
