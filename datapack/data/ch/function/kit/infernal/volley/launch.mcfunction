# As the caster: fires one projectile of kind #i_kind (0 fireball, 1 meteor, 2 mortar shell, 3 seeker, 4 ember) for #i_dmg; it is tagged ch.infernal.np.
execute if score #i_kind ch.tmp matches 1 run function ch:api/proj {item:"minecraft:magma_block",scale:0.9,speed:4,life:50,hit:"ch:kit/infernal/volley/hit",step:"ch:kit/infernal/volley/step",end:"ch:kit/infernal/volley/end",pierce:0,ignore:"ch.powner"}
execute unless score #i_kind ch.tmp matches 1 run function ch:api/proj {item:"minecraft:fire_charge",scale:0.75,speed:6,life:40,hit:"ch:kit/infernal/volley/hit",step:"ch:kit/infernal/volley/step",end:"ch:kit/infernal/volley/end",pierce:0,ignore:"ch.powner"}
tag @e[type=item_display,tag=ch.lnew,tag=ch.proj,tag=!ch.infernal.p,distance=..4,sort=nearest,limit=1] add ch.infernal.np
tag @e[type=item_display,tag=ch.infernal.np] add ch.infernal.p
scoreboard players operation @e[type=item_display,tag=ch.infernal.np,limit=1] ch.v2 = #i_dmg ch.tmp
scoreboard players operation @e[type=item_display,tag=ch.infernal.np,limit=1] ch.v3 = @s ch.infernal.vid
execute if score #i_kind ch.tmp matches 3..4 run scoreboard players set @e[type=item_display,tag=ch.infernal.np,limit=1] ch.v3 0
scoreboard players operation @e[type=item_display,tag=ch.infernal.np,limit=1] ch.v4 = #i_kind ch.tmp
scoreboard players operation @e[type=item_display,tag=ch.infernal.np,limit=1] ch.v5 = @s ch.infernal.sk
scoreboard players set @e[type=item_display,tag=ch.infernal.np,limit=1] ch.v6 0
execute if score @s ch.awake matches 1 run scoreboard players set @e[type=item_display,tag=ch.infernal.np,limit=1] ch.v6 1
execute if score #i_kind ch.tmp matches 2 run tag @e[type=item_display,tag=ch.infernal.np] add ch.infernal.arc
execute unless score #i_kind ch.tmp matches 1 as @e[type=item_display,tag=ch.infernal.np,limit=1] run function ch:kit/infernal/volley/skin with storage ch:tmp ki
