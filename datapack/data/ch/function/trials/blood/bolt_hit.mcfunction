# Struck by a blood bolt.
function ch:api/hit {d:70}
scoreboard players set @s ch.blood.tbl 80
function ch:api/fx/screen {o:"shatter",color:"#9E0B1F",in:0,stay:3,out:10}
function ch:api/fx/shake {s:2,t:6,r:3}
