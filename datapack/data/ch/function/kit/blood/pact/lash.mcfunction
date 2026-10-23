# Lashed by the Blood Ward.
function ch:api/hit {d:15}
function ch:kit/blood/bleed/apply
scoreboard players set #ln ch.tmp 12
execute positioned ~ ~1 ~ facing entity @a[tag=ch.caster,limit=1] eyes run function ch:kit/blood/fx/line
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 0.3 0.4 0.3 0.2 16
playsound minecraft:block.honey_block.break player @a ~ ~ ~ 1 0.6
