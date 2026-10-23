# The collapse is telegraphed: shrinking rings and a warning for everyone inside.
$execute positioned ~ ~0.2 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16777215,s0:$(r).0,s1:0.5,t:20,life:21,spin:-170,dy:0.0}
$execute positioned ~ ~1 ~ rotated 0 90 run function ch:api/fx/sprite {model:"ring_soft",color:16113986,s0:$(r).0,s1:0.5,t:20,life:21,spin:0,dy:0.0}
$title @a[distance=..$(r)] subtitle {text:"The fracture is collapsing!",color:"#29D3F2",bold:true}
$title @a[distance=..$(r)] title ""
playsound chaoshearts:trial_telegraph player @a ~ ~ ~ 1.2 1.4
