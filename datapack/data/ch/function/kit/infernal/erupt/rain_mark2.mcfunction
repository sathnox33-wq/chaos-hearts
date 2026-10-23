# Bomb telegraph: a target rune; the bomb is released 18 ticks later and lands 8 ticks after that.
$execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"hex",color:$(c),s0:0.3,s1:$(dia),t:10,life:28,spin:170,dy:0.0}
$execute rotated 0 0 positioned ~ ~0.08 ~ run function ch:api/fx/sprite {model:"ring_soft",color:$(c2),s0:$(dia),s1:0.6,t:26,life:28,spin:90,dy:0.0}
playsound chaoshearts:trial_telegraph player @a ~ ~ ~ 0.8 1.2
function ch:api/later {t:18,then:"ch:kit/infernal/erupt/rain_drop"}
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
