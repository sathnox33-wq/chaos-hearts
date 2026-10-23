# The beam's layers along the look, $(len) blocks long: a white core, a gold sheath, a soft outer glow.
$function ch:api/fx/beam {color:16777215,w:0.22,len:$(len),t:2,life:9}
$function ch:api/fx/beam {color:16765803,w:0.6,len:$(len),t:3,life:7}
$function ch:api/fx/beam {color:16773808,w:1.2,len:$(len),t:4,life:5}
execute if score #ce_ex ch.tmp matches 1 run function ch:api/fx/sprite {model:"ring",color:16765803,s0:0.5,s1:3.0,t:4,life:8,spin:90,dy:0.0}
