# Every half second: a star (or, with Judgment, a pillar of light) strikes a random enemy within 18 blocks.
function ch:kit/celestial/asc/setstar
tag @s add ch.caster
execute if score @s ch.b3 matches 5.. as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,type=!#ch:ignore,distance=..18,sort=random,limit=1] at @s run return run function ch:kit/celestial/asc/judgment
execute as @e[type=player,tag=!ch.caster,gamemode=!spectator,gamemode=!creative,distance=..18,sort=random,limit=1] at @s as @a[tag=ch.caster,limit=1] run return run function ch:kit/celestial/star/drop
execute as @e[type=!#ch:ignore,type=!player,tag=!ch.noability,distance=..18,sort=random,limit=1] at @s as @a[tag=ch.caster,limit=1] run function ch:kit/celestial/star/drop
tag @s remove ch.caster
