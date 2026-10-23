# A delayed star (as its later marker, owner tagged ch.caster).
execute unless entity @a[tag=ch.caster,scores={ch.active=9},limit=1] run return 0
function ch:kit/celestial/fx/lget
function ch:kit/celestial/star/drop
