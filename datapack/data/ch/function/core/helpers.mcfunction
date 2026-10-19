# Keeps the hidden helper entities alive in the always-loaded chunk of the trials dimension.
execute in ch:trials run setblock 0 63 0 minecraft:barrier
execute in ch:trials positioned 0.5 64 0.5 unless entity @e[type=item_display,tag=ch.helper,distance=..3] run summon item_display 0.5 64 0.5 {Tags:["ch.helper","ch.noability"],view_range:0f}
execute in ch:trials positioned 0.5 64 0.5 unless entity @e[type=marker,tag=ch.vec,distance=..3] run summon marker 0.5 64 0.5 {Tags:["ch.vec"]}
execute in ch:trials positioned 0.5 64 0.5 unless entity @e[type=item_display,tag=ch.helper,distance=..3] run schedule function ch:core/helpers 20t replace
