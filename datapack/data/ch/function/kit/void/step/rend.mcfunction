# Null Dash: an enemy the fold passed through is torn for 5 damage.
scoreboard players set #vd ch.tmp 50
function ch:kit/void/hurt
playsound minecraft:entity.player.attack.sweep player @a ~ ~ ~ 0.8 0.6
particle minecraft:sweep_attack ~ ~1 ~ 0.2 0.3 0.2 0 2
execute positioned ~ ~1.1 ~ rotated ~ 90 run function ch:api/fx/sprite3 {model:"slash",color:13864191,a:"[0.3,0.3,0.3]",b:"[2.2,2.2,2.2]",t:3,life:7,spin:120}
