# Telegraph at the ground: a burning rune and the danger circle, then four rumbles and the eruption.
$execute rotated 0 0 positioned ~ ~0.05 ~ run function ch:api/fx/sprite {model:"rune",color:$(c2),s0:0.3,s1:$(dia),t:8,life:26,spin:170,dy:0.0}
$execute rotated 0 0 positioned ~ ~0.08 ~ run function ch:api/fx/sprite {model:"ring_soft",color:$(c),s0:$(dia),s1:$(dia),t:20,life:24,spin:90,dy:0.0}
$execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"crack",color:$(c),s0:0.5,s1:$(dia),t:20,life:34,spin:0,dy:0.0}
playsound chaoshearts:infernal_rumble player @a ~ ~ ~ 1.4 1
playsound minecraft:block.lava.ambient block @a ~ ~ ~ 1.4 0.6
function ch:kit/infernal/erupt/chain {t:4,n:4}
