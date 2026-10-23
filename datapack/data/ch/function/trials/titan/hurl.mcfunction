# Boulder Hurl: Golgoth tears a boulder from the floor and holds it high, then hurls it at where you stand.
scoreboard players set @s ch.v2 170
scoreboard players set @s ch.v6 22
data merge entity @s {NoAI:1b}
function ch:trials/titan/callout {m:"Golgoth tears up a boulder! Keep moving."}
execute positioned ~ ~6.5 ~ summon block_display run data merge entity @s {Tags:["ch.tmob","ch.noability","ch.titan.brock"],block_state:{Name:"minecraft:cobblestone"},teleport_duration:2,transformation:{left_rotation:[0.2f,0.3f,0.1f,0.93f],right_rotation:[0f,0f,0f,1f],translation:[-1.2f,-1.2f,-1.2f],scale:[2.4f,2.4f,2.4f]}}
particle minecraft:block{block_state:"minecraft:cobblestone"} ~ ~1 ~ 1.5 0.5 1.5 0.2 60
playsound minecraft:block.stone.break master @a ~ ~ ~ 2 0.5
playsound chaoshearts:titan_boulder master @a ~ ~ ~ 1 0.6
function ch:api/later {t:20,then:"ch:trials/titan/hurl_throw"}
