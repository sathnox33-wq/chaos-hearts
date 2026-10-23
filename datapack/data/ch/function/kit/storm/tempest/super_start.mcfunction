# Supercell: you are rooted while the sky winds up for 30 ticks. Everyone sees it coming.
effect give @s minecraft:slowness 2 6 true
effect give @s minecraft:resistance 2 1 true
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:5220607,s0:1.0,s1:18.0,t:30,life:31,spin:170,dy:0.0}
execute positioned ~ ~0.12 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:15267583,s0:18.0,s1:2.0,t:30,life:31,spin:-170,dy:0.0}
execute positioned ~ ~9 ~ rotated 0 0 run function ch:api/fx/sprite {model:"cloud",color:7241632,s0:2.0,s1:20.0,t:30,life:34,spin:170,dy:0.0}
execute positioned ~ ~0.2 ~ rotated 0 0 run function ch:api/fx/sprite {model:"dome",color:2842040,s0:1.0,s1:18.0,t:30,life:31,spin:90,dy:0.0}
particle minecraft:electric_spark ~ ~4 ~ 4 4 4 0.2 80
playsound chaoshearts:trial_telegraph player @a ~ ~ ~ 1.5 0.8
playsound minecraft:block.respawn_anchor.charge player @a ~ ~ ~ 1.5 0.6
playsound minecraft:entity.lightning_bolt.thunder player @a ~ ~ ~ 1 0.5
title @a[distance=..20] subtitle {text:"⛈ A supercell is forming...",color:"#4FA8FF",bold:true}
title @a[distance=..20] title ""
function ch:api/later {t:10,then:"ch:kit/storm/tempest/super_rumble"}
function ch:api/later {t:20,then:"ch:kit/storm/tempest/super_rumble"}
function ch:api/later {t:30,then:"ch:kit/storm/tempest/super"}
return 1
