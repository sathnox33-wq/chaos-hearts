# The challenger bleeds from Vesperine's spikes: 1 damage a second, and she heals.
scoreboard players remove @s ch.blood.tbl 1
execute if score #r2 ch.tmp matches 0 run particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~1.2 ~ 0.25 0.3 0.25 0 1
scoreboard players operation #m ch.tmp = @s ch.blood.tbl
scoreboard players operation #m ch.tmp %= #20 ch.g
execute unless score #m ch.tmp matches 0 run return 0
tag @e[type=evoker,tag=ch.blood.boss,distance=..80,limit=1] add ch.caster
function ch:api/hit {d:10}
tag @e[tag=ch.caster] remove ch.caster
execute as @e[type=evoker,tag=ch.blood.boss,distance=..80,limit=1] run function ch:api/heal {n:2}
