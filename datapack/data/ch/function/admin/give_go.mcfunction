# Internal (after admin/check): creates a new heart of type $(heart) for $(player) (ignores the unique and max-hearts limits).
$execute store result storage ch:tmp ad.i int 1 run function ch:gen/index/$(heart)
$data modify storage ch:tmp ad.h set value "$(heart)"
data modify storage ch:tmp ad.force set value 1
$execute as $(player) at @s run function ch:heart/create with storage ch:tmp ad
$tellraw @s [{text:"Gave a $(heart) heart to ",color:"gray"},{selector:"$(player)",color:"white"}]
