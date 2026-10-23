# A target pierced by a Blood Spike or Lance (#sd damage).
scoreboard players operation #sd2 ch.tmp = #sd ch.tmp
execute if score @a[tag=ch.caster,limit=1] ch.b2 matches 3.. if score @s ch.blood.bleed matches 1.. run function ch:kit/blood/spike/veins
execute store result storage ch:tmp blood.d int 1 run scoreboard players get #sd2 ch.tmp
function ch:kit/blood/spike/dmg with storage ch:tmp blood
function ch:kit/blood/bleed/apply
scoreboard players set #ln ch.tmp 14
execute positioned ~ ~1 ~ facing entity @a[tag=ch.caster,limit=1] eyes run function ch:kit/blood/fx/line
execute as @a[tag=ch.caster,limit=1] run function ch:kit/blood/spike/feed
execute if entity @s[type=player] run function ch:api/fx/screen {o:"blood",color:"#9E0B1F",in:0,stay:2,out:8}
