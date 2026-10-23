# The charge's guide: faces the path; a burning line telegraphs it for 20 ticks.
tp @s ~ ~ ~ ~ 0
tag @s add ch.tmob
tag @s add ch.noability
tag @s add ch.infernal.tdash
scoreboard players set @s ch.life 34
execute rotated ~ 0 positioned ~ ~0.15 ~ run function ch:api/fx/beam {color:14692378,w:1.8,len:24.0,t:6,life:22}
execute rotated ~ 0 positioned ~ ~0.2 ~ run function ch:api/fx/beam {color:16765503,w:0.4,len:24.0,t:4,life:22}
