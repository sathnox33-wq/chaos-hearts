# Volcanic Leap wind-up.
$execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"crack",color:$(c),s0:0.5,s1:$(dia),t:5,life:14,spin:0,dy:0.0}
$execute rotated 0 0 positioned ~ ~0.08 ~ run function ch:api/fx/sprite {model:"rune",color:$(c2),s0:$(dia),s1:1.0,t:6,life:8,spin:170,dy:0.0}
$particle $(fl) ~ ~0.2 ~ 1 0 1 0.05 30
playsound chaoshearts:infernal_rumble player @a ~ ~ ~ 1.2 1.5
