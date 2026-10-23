# As a rift orb every tick: move by variant, drag, sting and draw; ends when its life runs out.
scoreboard players add @s ch.t 1
scoreboard players remove @s ch.life 1
execute if score @s ch.t matches 1 unless score @s ch.v1 matches 2 run data merge entity @s {start_interpolation:0,interpolation_duration:6,transformation:{scale:[0.9f,0.9f,0.9f]}}
execute if score @s ch.t matches 1 if score @s ch.v1 matches 2 run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{scale:[0.35f,0.35f,0.35f]}}
tag @a remove ch.caster
function ch:api/tag_owner
tag @s add ch.void.cur
scoreboard players operation #oid ch.tmp = @s ch.eid
scoreboard players operation #vt ch.tmp = @s ch.t
scoreboard players operation #vt ch.tmp %= #10 ch.g
scoreboard players operation #ver ch.tmp = @s ch.v6
execute store result storage ch:void v.s double 0.001 run scoreboard players get @s ch.v2
execute if score @s ch.v1 matches 0 run function ch:kit/void/orb/t_drift
execute if score @s ch.v1 matches 1 run function ch:kit/void/orb/t_lift
execute if score @s ch.v1 matches 2 run function ch:kit/void/orb/t_mine
execute if score @s ch.v1 matches 3 run function ch:kit/void/orb/t_trip
execute if score @s ch.life matches ..0 at @s run function ch:kit/void/orb/end
tag @s remove ch.void.cur
tag @a remove ch.caster
