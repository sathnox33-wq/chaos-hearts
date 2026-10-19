# Advancement reward: this player hurt something. Finds what was just hit, tags PvP combat and runs the heart's on_attack.
advancement revoke @s only ch:event/attack
tag @s add ch.self
tag @e[distance=..8,type=!#ch:ignore,tag=!ch.self,nbt={HurtTime:10s},sort=nearest,limit=1] add ch.victim
tag @s remove ch.self
tag @a[tag=ch.victim] add ch.pairv
execute if entity @a[tag=ch.pairv,limit=1] run function ch:combat/pair
tag @a remove ch.pairv
tag @s add ch.caster
execute if entity @e[tag=ch.victim,limit=1] run function ch:gen/on_attack
tag @s remove ch.caster
tag @e[tag=ch.victim] remove ch.victim
