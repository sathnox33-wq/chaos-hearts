# Turns the execution rotation into a vector of length $(s): #vx #vy #vz ch.tmp in thousandths.
$execute in ch:trials positioned 8.0 64.0 8.0 run tp @e[type=marker,tag=ch.vec,limit=1] ^ ^ ^$(s)
execute store result score #vx ch.tmp run data get entity @e[type=marker,tag=ch.vec,limit=1] Pos[0] 1000
execute store result score #vy ch.tmp run data get entity @e[type=marker,tag=ch.vec,limit=1] Pos[1] 1000
execute store result score #vz ch.tmp run data get entity @e[type=marker,tag=ch.vec,limit=1] Pos[2] 1000
scoreboard players remove #vx ch.tmp 8000
scoreboard players remove #vy ch.tmp 64000
scoreboard players remove #vz ch.tmp 8000
execute in ch:trials run tp @e[type=marker,tag=ch.vec,limit=1] 8.0 64.0 8.0
