# The tether drinks: 2.5 damage (3.5 in phase 3) to the challenger, and Vesperine heals.
tag @s add ch.caster
execute if score @s ch.v6 matches ..2 as @a[tag=ch.challenger,distance=..15] run function ch:api/hit {d:25}
execute if score @s ch.v6 matches 3 as @a[tag=ch.challenger,distance=..15] run function ch:api/hit {d:35}
tag @s remove ch.caster
function ch:api/heal {n:10}
execute at @a[tag=ch.challenger,distance=..15,limit=1] run particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 0.3 0.4 0.3 0.2 12
execute as @a[tag=ch.challenger,distance=..15] run function ch:api/fx/screen {o:"blood",color:"#5A0010",in:0,stay:3,out:8}
playsound minecraft:item.honey_bottle.drink master @a[distance=..90] ~ ~ ~ 1.4 0.6
