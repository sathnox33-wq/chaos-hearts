# As an Avatar player, every tick: body of fire, burning aura every 0.5 s, seeking fireballs, buffs.
tag @a remove ch.caster
tag @s add ch.caster
function ch:kit/infernal/pal
scoreboard players remove @s ch.infernal.av 1
execute if score @s ch.infernal.av matches ..0 run return run function ch:kit/infernal/avatar/end with storage ch:tmp ki
function ch:kit/infernal/avatar/tick_fx with storage ch:tmp ki
scoreboard players operation #i_p ch.tmp = @s ch.infernal.av
scoreboard players operation #i_p ch.tmp %= #10 ch.g
execute if score #i_p ch.tmp matches 0 run function ch:kit/infernal/avatar/aura with storage ch:tmp ki
execute if score #i_p ch.tmp matches 5 run effect give @s minecraft:speed 2 0 true
execute if score #i_p ch.tmp matches 5 run effect give @s minecraft:fire_resistance 15 0 true
scoreboard players operation #i_p ch.tmp = @s ch.infernal.av
scoreboard players operation #i_p ch.tmp %= #20 ch.g
execute if score @s ch.infernal.avm matches 0 if score #i_p ch.tmp matches 0 run function ch:kit/infernal/avatar/seeker
execute if score @s ch.infernal.avm matches 1 if score #i_p ch.tmp matches 0 run function ch:kit/infernal/avatar/seeker
execute if score @s ch.infernal.avm matches 1 if score #i_p ch.tmp matches 10 run function ch:kit/infernal/avatar/seeker
tag @s remove ch.caster
