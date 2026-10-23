# Volcanic Leap: the eruption, and a burst under the caster's feet that throws them high.
execute as @a[tag=ch.caster,distance=..3,limit=1] at @s run summon minecraft:wind_charge ~ ~0.2 ~ {Motion:[0.0,-3.0,0.0]}
function ch:kit/infernal/erupt/boom with entity @s data.e
