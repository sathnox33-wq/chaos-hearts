# Down: Nova Star. A star crashes onto your own position: you are untouched, enemies within 3.5 are blasted away
# and you gain a shield of light.
scoreboard players set #ce_r ch.tmp 35
scoreboard players set #ce_nv ch.tmp 1
scoreboard players set #ce_co ch.tmp 0
scoreboard players operation #ce_d ch.tmp *= #4 ch.g
scoreboard players operation #ce_d ch.tmp /= #5 ch.celestial.k
function ch:kit/celestial/star/call
effect give @s minecraft:absorption 8 0 true
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"dome",color:16773808,s0:0.5,s1:2.4,t:6,life:14,spin:90,dy:0.0}
return 1
