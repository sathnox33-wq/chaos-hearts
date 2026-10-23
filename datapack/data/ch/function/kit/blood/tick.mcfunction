# Blood, every tick for its holders: lifesteal, Pain Tolerance, Pact, Siphon, Blood Moon, Vitae and the aura.
scoreboard players operation #r2 ch.tmp = #now ch.g
scoreboard players operation #r2 ch.tmp %= #2 ch.g
scoreboard players operation #r4 ch.tmp = #now ch.g
scoreboard players operation #r4 ch.tmp %= #4 ch.g
scoreboard players operation #me ch.tmp = @s ch.pid
execute if score @s ch.blood.dealt matches 1.. run function ch:kit/blood/steal
execute if score #t20 ch.g matches 0 run function ch:kit/blood/second
execute if score @s ch.blood.pact matches 1.. run function ch:kit/blood/pact/tick
execute if score @s ch.blood.sip matches 1.. run function ch:kit/blood/siphon/tick
execute if score @s ch.blood.moon matches 1.. run function ch:kit/blood/moon/tick
execute if score @s ch.lvl matches 90.. if score #r4 ch.tmp matches 0 run function ch:kit/blood/aura
