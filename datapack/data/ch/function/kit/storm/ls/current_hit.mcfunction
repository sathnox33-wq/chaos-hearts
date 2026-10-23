# As an enemy the Ground Current reached: zapped and rooted.
scoreboard players operation @s ch.storm.hitc = #cc ch.storm.g
function ch:kit/storm/fn/zap
function ch:api/stun {t:16}
execute positioned ~ ~ ~ run function ch:api/fx/pillar {model:"beam",color:15267583,w:0.25,h:3.0,t:1,life:5}
playsound minecraft:entity.lightning_bolt.impact player @a ~ ~ ~ 0.8 1.4
function ch:api/fx/shake {s:2,t:5,r:1}
