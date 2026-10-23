# Leaves a rumble marker carrying ki in its data; it rumbles $(n) times $(t) ticks apart, then erupts.
$function ch:api/later {t:$(t),then:"ch:kit/infernal/erupt/rumble"}
data modify entity @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] data.e set from storage ch:tmp ki
$scoreboard players set @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v1 $(n)
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
