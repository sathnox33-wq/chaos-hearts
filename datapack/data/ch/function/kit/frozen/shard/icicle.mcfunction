# One falling icicle (a spike flipped point-down that drops 8 blocks).
data modify storage ch:tmp fxa set value {model:"spike",color:10217471,ax:0.45,ay:1.6,az:0.45,bx:0.45,by:1.6,bz:0.45,t:6,life:12,spin:0,dy:-8.0,roll:180}
function ch:api/fx/sprite_go with storage ch:tmp fxa
particle minecraft:snowflake ~ ~ ~ 0.1 0.2 0.1 0.01 3
