# A bleeding enemy died to the Blood holder (tagged ch.caster).
scoreboard players set @s ch.blood.bleed 0
execute as @a[tag=ch.caster,limit=1] run scoreboard players add @s ch.blood.kills 1
execute as @a[tag=ch.caster,limit=1] if score @s ch.blood.kills matches 10.. run function ch:api/feat {h:"blood",n:1}
execute if score @a[tag=ch.caster,limit=1] ch.b2 matches 5.. run function ch:kit/blood/bleed/burst
