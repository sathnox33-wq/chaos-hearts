# Celestial holder struck something: Starlight builds; with Radiance, undead struck are set alight.
scoreboard players add @s ch.celestial.sl 2
execute if score @s ch.lvl matches 25.. as @e[tag=ch.victim,type=#ch:undead,type=!player,limit=1] at @s run function ch:kit/celestial/passive/sear
