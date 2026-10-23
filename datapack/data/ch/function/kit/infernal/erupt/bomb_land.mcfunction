# A bomb lands: an eruption 2.4 blocks wide for 7 damage.
tag @a remove ch.caster
function ch:api/tag_owner
function ch:kit/infernal/pal_e
data modify storage ch:tmp ki merge value {r:2.4,dia:4.8,rh:1.1,d:70}
function ch:kit/infernal/erupt/boom with storage ch:tmp ki
tag @a remove ch.caster
kill @s
