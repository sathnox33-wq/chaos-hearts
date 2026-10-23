# As a vanilla projectile in the wall.
execute on origin if entity @s[tag=ch.caster] run return 0
function ch:kit/infernal/wall/burnfx
kill @s
