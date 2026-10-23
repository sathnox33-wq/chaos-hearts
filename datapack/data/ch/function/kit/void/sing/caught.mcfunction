# First catch by this singularity.
scoreboard players operation @s ch.void.sid = #sid ch.tmp
scoreboard players add @e[type=marker,tag=ch.void.scur,limit=1] ch.v3 1
execute if entity @s[type=player] run function ch:api/fx/screen {o:"void",color:"#14002B",in:4,stay:20,out:30}
execute if entity @s[type=player] run title @s subtitle {text:"The void has you",color:"#8A3CFF",italic:true}
