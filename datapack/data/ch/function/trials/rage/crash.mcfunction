# Gorrath slams into a wall: the arena shakes and he is dazed for 1.5 s, your opening.
scoreboard players set @s ch.v2 4
scoreboard players set @s ch.v3 30
scoreboard players set @s ch.v5 0
kill @e[type=marker,tag=ch.rage.bdir,distance=..40]
function ch:trials/rage/freeze
particle minecraft:explosion ~ ~1.5 ~ 0.6 0.6 0.6 0 4
particle minecraft:block{block_state:"minecraft:polished_blackstone_bricks"} ~ ~1.5 ~ 1 1 1 0.4 60
function ch:api/fx/shake {s:3,t:12,r:30}
playsound minecraft:entity.generic.explode master @a[distance=..90] ~ ~ ~ 1.5 0.6
playsound minecraft:entity.ravager.stunned master @a[distance=..90] ~ ~ ~ 2 0.8
function ch:trials/rage/say {m:"Gorrath crashed into the wall! Strike now!"}
