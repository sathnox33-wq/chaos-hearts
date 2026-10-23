# Avalanche (Butcher capstone): after a slam, Rage Leap is free again for 3 seconds.
scoreboard players set @s ch.rage.avu 1
scoreboard players set @s ch.rage.ava 60
scoreboard players operation @s ch.rage.avcd = @s ch.cd1
scoreboard players set @s ch.cd1 0
playsound minecraft:block.amethyst_block.chime player @s ~ ~ ~ 1 0.6
function ch:api/fx/text {text:"AVALANCHE",color:"#FF6A1F"}
