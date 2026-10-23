# Hooked: 4 damage, a 3 s bleed, dragged to the caster, slowed.
function ch:api/hit {d:40}
scoreboard players set #bt ch.tmp 60
scoreboard players set #bm ch.tmp 0
function ch:kit/blood/bleed/apply
execute positioned as @a[tag=ch.caster,limit=1] run function ch:api/pull {s:1.4}
function ch:api/cc {effect:"minecraft:slowness",sec:2,amp:1}
scoreboard players set #ln ch.tmp 30
execute positioned ~ ~1 ~ facing entity @a[tag=ch.caster,limit=1] eyes run function ch:kit/blood/fx/line
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 0.3 0.4 0.3 0.3 25
execute if entity @s[type=player] run function ch:api/fx/screen {o:"blood",color:"#9E0B1F",in:0,stay:3,out:10}
