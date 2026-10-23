# As an enemy struck by the chain: marked as part of this chain so it is not struck twice.
scoreboard players operation @s ch.storm.cid = #cc ch.storm.g
function ch:kit/storm/fn/zap
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"bolt",color:15267583,s0:0.3,s1:1.6,t:2,life:5,spin:170,dy:0.0}
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:3}
playsound minecraft:entity.lightning_bolt.impact player @a ~ ~ ~ 0.7 1.3
