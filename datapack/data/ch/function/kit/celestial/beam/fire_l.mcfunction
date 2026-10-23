# The gathered lance fires (as its marker, the Celestial tagged ch.caster) along their current aim.
execute unless entity @a[tag=ch.caster,scores={ch.active=9},limit=1] run return 0
function ch:kit/celestial/fx/lget
scoreboard players operation #ce_ex ch.tmp = #ce_r ch.tmp
execute as @a[tag=ch.caster,limit=1] at @s run function ch:kit/celestial/beam/fire
