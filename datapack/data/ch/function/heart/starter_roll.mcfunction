scoreboard players add #tries ch.tmp 1
execute if score #tries ch.tmp matches 30.. run return run tellraw @s {text:"Every Chaos Heart already has an owner. Win one in PvP.",color:"gray"}
execute store result score #i ch.tmp run random value 1..10
function ch:gen/describe
data modify storage ch:tmp args set value {h:"",i:0,force:0}
data modify storage ch:tmp args.h set from storage ch:tmp h.name
data modify storage ch:tmp args.i set from storage ch:tmp h.i
execute store result score #ok ch.tmp run function ch:heart/create with storage ch:tmp args
execute if score #ok ch.tmp matches 0 run function ch:heart/starter_roll
