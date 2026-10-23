# ch:api/later, then copies the #ti_ values and the current rotation onto the new marker.
$function ch:api/later {t:$(t),then:"$(then)"}
$execute as @e[type=marker,tag=ch.lnew,tag=!ch.titan.lset,distance=..0.01,nbt={data:{then:"$(then)"}},limit=1] run function ch:kit/titan/fx/lset
