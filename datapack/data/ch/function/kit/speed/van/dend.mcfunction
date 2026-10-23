# The decoy fades (Mirror Feint detonates it; Decoy Burst slows those around it). Gear is wiped before removal.
function ch:api/tag_owner
particle minecraft:cloud ~ ~1 ~ 0.3 0.6 0.3 0.05 20
execute positioned ~ ~1 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"swirl",color:16113986,s0:1.6,s1:0.1,t:5,life:7,spin:-170,dy:0.0}
playsound minecraft:entity.illusioner.mirror_move player @a ~ ~ ~ 0.8 1.2
execute if score @s ch.v3 matches 1 run function ch:kit/speed/van/feint_boom
execute if score @s ch.v2 matches 1 run function ch:kit/speed/van/dburst
tag @a remove ch.caster
item replace entity @s armor.head with minecraft:air
item replace entity @s armor.chest with minecraft:air
item replace entity @s armor.legs with minecraft:air
item replace entity @s armor.feet with minecraft:air
item replace entity @s weapon.mainhand with minecraft:air
item replace entity @s weapon.offhand with minecraft:air
tp @s ~ -400 ~
kill @s
