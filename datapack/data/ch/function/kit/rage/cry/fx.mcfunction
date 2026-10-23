# War Cry VFX: shockwave, an exploding throat of light, sonic rings flying out of the mouth, layered aftershocks.
$function ch:api/fx/wave {color:14689835,r:$(r),t:8}
execute positioned ~ ~1.3 ~ run function ch:api/fx/orb {color:16738847,s:3.0,t:3,life:6}
execute anchored eyes positioned ^ ^ ^1.2 rotated ~ 90 run function ch:api/fx/sprite {model:"ring",color:14689835,s0:0.5,s1:3.0,t:6,life:9,spin:0,dy:4.0}
execute anchored eyes positioned ^ ^ ^1.6 rotated ~ 90 run function ch:api/fx/sprite {model:"ring_soft",color:16738847,s0:0.3,s1:5.0,t:8,life:11,spin:0,dy:7.0}
execute anchored eyes positioned ^ ^ ^2 run particle minecraft:sonic_boom ~ ~ ~ 0 0 0 0 1
execute anchored eyes positioned ^ ^ ^4 run particle minecraft:sonic_boom ~ ~ ~ 0 0 0 0 1
particle minecraft:dust{color:[0.88,0.15,0.17],scale:2.0} ~ ~1 ~ 2.5 0.4 2.5 0 50
function ch:api/fx/shake {s:2,t:8,r:12}
function ch:api/fx/screen {o:"rage",color:"#E0262B",in:0,stay:3,out:10}
playsound chaoshearts:rage_warcry player @a ~ ~ ~ 1.6 1
playsound minecraft:entity.ravager.roar player @a ~ ~ ~ 1.2 0.8
playsound minecraft:entity.goat.screaming.ram_impact player @a ~ ~ ~ 0.8 0.5
function ch:api/later {t:2,then:"ch:kit/rage/cry/fx2"}
function ch:api/later {t:5,then:"ch:kit/rage/cry/fx3"}
