# Celestial, every server tick: falling stars, sanctuaries, sigils growing in and spinning.
execute if entity @e[type=item_display,tag=ch.celestial.star,limit=1] as @e[type=item_display,tag=ch.celestial.star] at @s run function ch:kit/celestial/star/fall
execute if entity @e[type=marker,tag=ch.celestial.sanc,limit=1] as @e[type=marker,tag=ch.celestial.sanc] at @s run function ch:kit/celestial/sanc/tick
execute if entity @e[type=item_display,tag=ch.celestial.gnew,limit=1] as @e[type=item_display,tag=ch.celestial.gnew] if score @s ch.t < #now ch.g run function ch:kit/celestial/fx/grow
scoreboard players operation #ce_w ch.tmp = #now ch.g
scoreboard players operation #ce_w ch.tmp %= #10 ch.g
execute if score #ce_w ch.tmp matches 0 if entity @e[type=item_display,tag=ch.celestial.spin,limit=1] run function ch:kit/celestial/fx/spin_all
