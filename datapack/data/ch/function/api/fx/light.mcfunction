# A brief flash of real light at the position (only into air).
execute unless block ~ ~ ~ minecraft:air run return fail
setblock ~ ~ ~ minecraft:light[level=15]
$function ch:api/later {t:$(t),then:"ch:api/fx/light_off"}
