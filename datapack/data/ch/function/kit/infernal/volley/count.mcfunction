# Triple Threat: three fireballs of one volley on one target.
execute unless score @s ch.infernal.vid = #i_vid ch.tmp run scoreboard players set @s ch.infernal.vh 0
scoreboard players operation @s ch.infernal.vid = #i_vid ch.tmp
scoreboard players add @s ch.infernal.vh 1
execute if score @s ch.infernal.vh matches 3.. as @a[tag=ch.caster,limit=1] run function ch:api/feat {h:"infernal",n:1}
