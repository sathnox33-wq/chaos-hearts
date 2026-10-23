# Up: Meteor Lob. The boulder goes straight up; a spot near the closest enemy is marked and it crashes down there.
data modify storage ch:tmp trk.y set value 0
data modify storage ch:tmp trk.p set value -90
function ch:api/proj {item:"minecraft:cobblestone",scale:1.3,speed:8,life:7,hit:"ch:api/noop",step:"ch:kit/titan/rock/up_step",end:"ch:api/noop",pierce:1,ignore:"ch.powner"}
execute as @e[type=item_display,tag=ch.lnew,tag=!ch.titan.rk,distance=..4,limit=1] at @s run function ch:kit/titan/rock/style with storage ch:tmp trk
scoreboard players set #ti_found ch.tmp 0
execute as @e[type=player,tag=!ch.caster,gamemode=!spectator,gamemode=!creative,distance=..22,sort=nearest,limit=1] at @s run function ch:kit/titan/rock/lob_at
execute if score #ti_found ch.tmp matches 0 as @e[type=!#ch:ignore,type=!player,tag=!ch.noability,distance=..22,sort=nearest,limit=1] at @s run function ch:kit/titan/rock/lob_at
execute if score #ti_found ch.tmp matches 0 rotated ~ 0 positioned ^ ^ ^10 run function ch:kit/titan/rock/lob_ground
