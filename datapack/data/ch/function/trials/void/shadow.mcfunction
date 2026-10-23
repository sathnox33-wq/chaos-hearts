# Shadow Step: the Sovereign dissolves; 8 ticks later it steps out of the challenger's shadow.
particle minecraft:reverse_portal ~ ~2 ~ 0.5 1.5 0.5 0.3 60
particle minecraft:squid_ink ~ ~2 ~ 0.5 1.2 0.5 0.05 30
playsound minecraft:entity.enderman.teleport hostile @a ~ ~ ~ 1.5 0.5
effect give @s minecraft:invisibility 1 0 true
function ch:api/later {t:8,then:"ch:trials/void/shadow2"}
