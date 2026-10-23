# Telegraph a crack zone (25 ticks), then it opens for 5 seconds.
execute rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:9059583,s0:1.0,s1:6.0,t:25,life:27,spin:0,dy:0.0}
playsound minecraft:block.glass.break hostile @a ~ ~ ~ 1 0.5
function ch:api/later {t:25,then:"ch:trials/void/crack_open"}
