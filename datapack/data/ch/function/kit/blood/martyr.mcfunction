# Martyr (Berserker capstone): Crimson Pact is ready again.
scoreboard players set @s ch.cd2 0
function ch:api/fx/text {text:"MARTYR",color:"#FF2D3F"}
playsound minecraft:block.amethyst_block.chime player @s ~ ~ ~ 1 0.6
playsound minecraft:entity.warden.heartbeat player @s ~ ~ ~ 1 1.6
