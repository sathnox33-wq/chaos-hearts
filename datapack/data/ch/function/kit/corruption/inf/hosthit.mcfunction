# As the host at the burst (a self-infested caster is immune).
function ch:kit/corruption/hurt
function ch:kit/corruption/poison {sec:4,amp:1}
tag @s add ch.corruption.bh
execute if entity @s[type=player] unless entity @s[tag=ch.caster] run function ch:api/fx/screen {o:"corruption",color:"#7BD13A",in:0,stay:6,out:16}
