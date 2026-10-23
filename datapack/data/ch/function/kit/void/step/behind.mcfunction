# As the shadow-step target: the caster lands behind it (in front if its back is to a wall).
execute rotated ~ 0 positioned ^ ^ ^-1.8 if block ~ ~ ~ #ch:passable if block ~ ~1 ~ #ch:passable run return run summon marker ~ ~ ~ {Tags:["ch.void.dest","ch.noability"]}
execute rotated ~90 0 positioned ^ ^ ^-1.6 if block ~ ~ ~ #ch:passable if block ~ ~1 ~ #ch:passable run return run summon marker ~ ~ ~ {Tags:["ch.void.dest","ch.noability"]}
execute rotated ~ 0 positioned ^ ^ ^1.8 if block ~ ~ ~ #ch:passable if block ~ ~1 ~ #ch:passable run return run summon marker ~ ~ ~ {Tags:["ch.void.dest","ch.noability"]}
summon marker ~ ~ ~ {Tags:["ch.void.dest","ch.noability"]}
