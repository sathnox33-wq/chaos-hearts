# Like sprite, with non-uniform start and end scales: a:"[x,y,z]" b:"[x,y,z]".
$data modify storage ch:tmp fxa set value {model:"$(model)",color:$(color),t:$(t),life:$(life),spin:$(spin),dy:0.0,roll:0}
$data modify storage ch:tmp fxa.a set value $(a)
$data modify storage ch:tmp fxa.b set value $(b)
data modify storage ch:tmp fxa.ax set from storage ch:tmp fxa.a[0]
data modify storage ch:tmp fxa.ay set from storage ch:tmp fxa.a[1]
data modify storage ch:tmp fxa.az set from storage ch:tmp fxa.a[2]
data modify storage ch:tmp fxa.bx set from storage ch:tmp fxa.b[0]
data modify storage ch:tmp fxa.by set from storage ch:tmp fxa.b[1]
data modify storage ch:tmp fxa.bz set from storage ch:tmp fxa.b[2]
function ch:api/fx/sprite_go with storage ch:tmp fxa
