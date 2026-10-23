# Void, every tick for the holder: timers, Phase (projectiles pass through you), the aura.
execute if score @s ch.void.st matches 1.. run scoreboard players remove @s ch.void.st 1
execute if score @s ch.void.swt matches 1.. run function ch:kit/void/disp/timer
scoreboard players operation #vme ch.tmp = @s ch.pid
execute if entity @e[type=#minecraft:arrows,distance=..6,tag=!ch.void.rolled,limit=1] run function ch:kit/void/phase/scan
execute if entity @e[type=trident,distance=..6,tag=!ch.void.rolled,limit=1] run function ch:kit/void/phase/scan
execute if entity @e[type=item_display,tag=ch.proj,distance=..4,tag=!ch.void.rolled,limit=1] run function ch:kit/void/phase/scan
execute if entity @e[type=small_fireball,distance=..4,tag=!ch.void.rolled,limit=1] run function ch:kit/void/phase/scan
execute if entity @e[type=shulker_bullet,distance=..3,tag=!ch.void.rolled,limit=1] run function ch:kit/void/phase/scan
execute if score @s ch.lvl matches 90.. run function ch:kit/void/aura
