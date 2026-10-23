# As the caster after a landed Infernal hit: +5 Heat and remember the time (Cremation, Phoenix Ember).
scoreboard players operation @s ch.infernal.lbt = #now ch.g
scoreboard players set #i_hg ch.tmp 5
function ch:kit/infernal/heat
