# The moon opens one enemy's veins.
function ch:kit/blood/bleed/apply
execute if entity @s[type=player] run playsound minecraft:entity.warden.heartbeat player @s ~ ~ ~ 0.8 1.2
