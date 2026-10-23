# Starlight is full: the next Starfall or Radiant Beam will be Exalted.
scoreboard players set @s ch.celestial.full 1
function ch:core/msg/say {m:"Starlight full: your next Starfall or Radiant Beam is EXALTED",c:"#FFD36B"}
playsound minecraft:block.amethyst_block.resonate player @s ~ ~ ~ 1 1.4
particle minecraft:end_rod ~ ~1.2 ~ 0.4 0.6 0.4 0.05 16
