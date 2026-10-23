# Down: Prism Nova. Eight guide lines of light mark the rays for 10 ticks, then they fire, 12 blocks each.
execute positioned ~ ~1 ~ run function ch:kit/celestial/beam/guides
execute positioned ~ ~0.05 ~ rotated 0 0 run function ch:api/fx/sprite {model:"star",color:16765803,s0:0.5,s1:5.0,t:10,life:12,spin:170,dy:0.0}
playsound minecraft:block.beacon.power_select player @a ~ ~ ~ 1.5 1.4
playsound chaoshearts:trial_telegraph player @a ~ ~ ~ 0.8 1.6
effect give @s minecraft:slowness 1 3 true
scoreboard players set #ce_r ch.tmp 0
function ch:kit/celestial/fx/later {t:10,then:"ch:kit/celestial/beam/nova_l"}
return 1
