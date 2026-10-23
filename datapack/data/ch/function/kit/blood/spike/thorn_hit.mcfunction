# Skewered by a blood thorn.
scoreboard players operation @s ch.blood.hit = #fe ch.tmp
function ch:api/hit {d:45}
function ch:kit/blood/bleed/apply
function ch:api/stun {t:12}
function ch:api/push {s:0.05,y:0.45}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"blood",color:"#9E0B1F",in:0,stay:3,out:10}
execute as @a[tag=ch.caster,limit=1] run function ch:kit/blood/spike/feed
