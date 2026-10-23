# The second, wider shockwave of a Colossus rising.
function ch:api/fx/wave {color:3880238,r:12,t:12}
scoreboard players set #ti_big ch.tmp 1
function ch:kit/titan/fx/ring16
playsound minecraft:block.deepslate.break player @a ~ ~ ~ 1.5 0.4
