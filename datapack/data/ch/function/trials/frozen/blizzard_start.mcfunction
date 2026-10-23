# A six-second blizzard: the challenger freezes if they stand still.
function ch:trials/frozen/callout {t:"BLIZZARD: keep moving or freeze!"}
scoreboard players set @s ch.frozen.zero 120
playsound chaoshearts:frozen_blizzard master @a[distance=..90] ~ ~ ~ 2 0.8
playsound minecraft:block.powder_snow.step master @a[distance=..90] ~ ~ ~ 3 0.4
