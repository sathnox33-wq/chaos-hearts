# Each bleeding victim takes 1 + its remaining bleed seconds x 1.5 as damage at once; the caster drinks half.
scoreboard players operation #me ch.tmp = @s ch.pid
scoreboard players set #dsum ch.tmp 0
execute as @e[type=!#ch:ignore,tag=!ch.caster,distance=..14,scores={ch.blood.bleed=1..}] if score @s ch.blood.bo = #me ch.tmp at @s run function ch:kit/blood/siphon/burst_one
scoreboard players operation #dk ch.tmp = #dsum ch.tmp
scoreboard players operation #dk ch.tmp /= #2 ch.g
scoreboard players set #bk ch.tmp 0
execute if score @s ch.b1 matches 4.. run scoreboard players set #bk ch.tmp 1
function ch:kit/blood/drink
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:16723263,s:2.5,t:3,life:6}
function ch:api/fx/screen {o:"blood",color:"#FF2D3F",in:0,stay:4,out:12}
playsound chaoshearts:blood_drink player @a ~ ~ ~ 1.2 0.8
