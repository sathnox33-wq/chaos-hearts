# Caught in the Sanguine Nova.
scoreboard players operation #sd2 ch.tmp = #sd ch.tmp
execute if score @a[tag=ch.caster,limit=1] ch.b2 matches 3.. if score @s ch.blood.bleed matches 1.. run function ch:kit/blood/spike/veins
execute store result storage ch:tmp blood.d int 1 run scoreboard players get #sd2 ch.tmp
function ch:kit/blood/spike/dmg with storage ch:tmp blood
function ch:kit/blood/bleed/apply
function ch:api/push {s:0.7,y:0.4}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"blood",color:"#9E0B1F",in:0,stay:3,out:10}
