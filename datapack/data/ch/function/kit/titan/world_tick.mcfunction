# Titan, every server tick: drives fault lines, slab animations, sliding debris and spinning sigils.
execute if entity @e[type=marker,tag=ch.titan.fault,limit=1] as @e[type=marker,tag=ch.titan.fault] at @s run function ch:kit/titan/slam/step
execute if entity @e[type=block_display,tag=ch.titan.anew,limit=1] as @e[type=block_display,tag=ch.titan.anew] if score @s ch.t < #now ch.g run function ch:kit/titan/fx/rise
execute if entity @e[type=block_display,tag=ch.titan.slab,scores={ch.life=9},limit=1] as @e[type=block_display,tag=ch.titan.slab,scores={ch.life=9}] run function ch:kit/titan/fx/sink
execute if entity @e[tag=ch.titan.slide,limit=1] as @e[tag=ch.titan.slide] if score @s ch.t < #now ch.g run function ch:kit/titan/fx/slide
