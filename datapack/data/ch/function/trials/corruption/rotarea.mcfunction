# The infestation disc: particles every 6 ticks, damage and poison every 10 ticks to a challenger inside it.
scoreboard players operation #cb ch.tmp = #now ch.g
scoreboard players operation #cb ch.tmp %= #10 ch.g
$execute if score #cb ch.tmp matches 0 positioned ~ ~1.1 ~ run particle minecraft:dust_color_transition{from_color:[0.239,0.102,0.322],to_color:[0.482,0.82,0.227],scale:1.5} ~ ~ ~ $(h) 0.05 $(h) 0 60 force
$execute if score #cb ch.tmp matches 5 positioned ~ ~1.1 ~ run particle minecraft:sculk_charge_pop ~ ~ ~ $(h) 0.05 $(h) 0 20 force
$execute if score #cb ch.tmp matches 0 positioned ~ ~1.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:8114490,s0:$(d),s1:$(d),t:10,life:11,spin:30,dy:0.0}
$execute if score #cb ch.tmp matches 0 positioned ~ ~1 ~ as @a[tag=ch.challenger,distance=..$(r)] run function ch:trials/corruption/rotburn
