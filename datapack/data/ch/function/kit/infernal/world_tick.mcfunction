# Infernal world tick: Flame Wall segments, Avatar followers, falling magma bombs and Hellfire burns.
execute if entity @e[type=marker,tag=ch.infernal.post,limit=1] as @e[type=marker,tag=ch.infernal.post] at @s run function ch:kit/infernal/wall/post
execute if entity @e[type=item_display,tag=ch.infernal.fol,limit=1] as @e[type=item_display,tag=ch.infernal.fol] run function ch:kit/infernal/avatar/follow
execute if entity @e[type=block_display,tag=ch.infernal.bomb,limit=1] as @e[type=block_display,tag=ch.infernal.bomb] at @s run function ch:kit/infernal/erupt/bomb
execute if score #t20 ch.g matches 10 if entity @e[tag=ch.infernal.lit,limit=1] as @e[tag=ch.infernal.lit] at @s run function ch:kit/infernal/lit_tick
