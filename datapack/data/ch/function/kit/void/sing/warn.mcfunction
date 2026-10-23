# One second left: the hole shrieks, everything shakes - get out.
playsound chaoshearts:void_singularity player @a ~ ~ ~ 2 1.6
playsound minecraft:entity.warden.sonic_charge player @a ~ ~ ~ 2 0.8
execute rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:15259903,s0:0.5,s1:12.0,t:20,life:21,spin:170,dy:0.0}
function ch:api/fx/shake {s:1,t:20,r:16}
execute as @a[distance=..14] run title @s subtitle {text:"It collapses!",color:"#D38CFF",bold:true}
