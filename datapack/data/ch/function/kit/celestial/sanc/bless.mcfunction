# Every 10 ticks: allies are healed (Resistance with Blessed Ground, cleansed with Divine Intervention); enemies weakened, undead burn.
$function ch:kit/celestial/sanc/sides {r:$(r)}
execute if score @s ch.v2 matches ..1 as @a[tag=ch.celestial.al] run function ch:kit/celestial/sanc/ally
execute as @e[tag=ch.celestial.en] run function ch:kit/celestial/sanc/enemy
$execute as @a[tag=ch.caster,distance=..$(r)] run function ch:kit/celestial/sanc/haven
tag @a remove ch.celestial.al
tag @e[tag=ch.celestial.en] remove ch.celestial.en
