# The sanctuary opens: a beam from the sky, sigils that grow and turn, pillars of light at its edge (radius $(r)).
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:1.6,h:24.0,t:4,life:12}
$function ch:kit/celestial/fx/sigil {model:"hex",color:16765803,s:$(d),life:$(l),tag:"ch.celestial.cw"}
$execute positioned ~ ~0.03 ~ run function ch:kit/celestial/fx/sigil {model:"rune",color:16773808,s:$(r),life:$(l),tag:"ch.celestial.rev"}
$function ch:api/fx/wave {color:16773808,r:$(r),t:8}
$execute rotated 0 0 positioned ^ ^ ^$(r) run function ch:api/fx/pillar {model:"beam",color:16765803,w:0.35,h:4.0,t:8,life:$(l)}
$execute rotated 60 0 positioned ^ ^ ^$(r) run function ch:api/fx/pillar {model:"beam",color:16765803,w:0.35,h:4.0,t:8,life:$(l)}
$execute rotated 120 0 positioned ^ ^ ^$(r) run function ch:api/fx/pillar {model:"beam",color:16765803,w:0.35,h:4.0,t:8,life:$(l)}
$execute rotated 180 0 positioned ^ ^ ^$(r) run function ch:api/fx/pillar {model:"beam",color:16765803,w:0.35,h:4.0,t:8,life:$(l)}
$execute rotated 240 0 positioned ^ ^ ^$(r) run function ch:api/fx/pillar {model:"beam",color:16765803,w:0.35,h:4.0,t:8,life:$(l)}
$execute rotated 300 0 positioned ^ ^ ^$(r) run function ch:api/fx/pillar {model:"beam",color:16765803,w:0.35,h:4.0,t:8,life:$(l)}
$execute if score #ce_v ch.tmp matches 1 positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"dome",color:12576511,s0:0.5,s1:$(d),t:8,life:$(l),spin:40,dy:0.0}
$execute if score #ce_v ch.tmp matches 2 positioned ~ ~0.05 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:16763210,s0:0.5,s1:$(d),t:10,life:$(l),spin:0,dy:0.0}
particle minecraft:end_rod ~ ~1 ~ 1 1.5 1 0.05 60
particle minecraft:totem_of_undying ~ ~1 ~ 1 0.5 1 0.2 30
playsound chaoshearts:celestial_sanctuary player @a ~ ~ ~ 1.4 1
playsound minecraft:block.beacon.activate player @a ~ ~ ~ 1.4 1.2
playsound minecraft:block.amethyst_block.resonate player @a ~ ~ ~ 1.2 1.5
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:12}
function ch:api/fx/shake {s:1,t:4,r:6}
function ch:api/fx/screen {o:"celestial",color:"#FFF2B0",in:2,stay:4,out:14}
