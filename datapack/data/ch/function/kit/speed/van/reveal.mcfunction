# You reappear: visibility and armour come back.
scoreboard players set @s ch.speed.van 0
effect clear @s minecraft:invisibility
function ch:kit/speed/van/unvault
particle minecraft:dust{color:[0.96,0.88,0.26],scale:1.2} ~ ~1 ~ 0.3 0.6 0.3 0 18
execute positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"ring_soft",color:16113986,s0:0.2,s1:2.2,t:4,life:6,spin:0,dy:0.0}
playsound minecraft:entity.illusioner.mirror_move player @a ~ ~ ~ 0.6 1.6
