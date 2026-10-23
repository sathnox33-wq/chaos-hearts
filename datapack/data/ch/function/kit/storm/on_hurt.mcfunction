# Storm holder was hurt: Stormborn shrugs off lightning; Static Field shocks whoever struck during Tempest.
execute if entity @e[type=lightning_bolt,distance=..8,limit=1] run function ch:kit/storm/p/grounded
execute if score @s ch.storm.temp matches 1.. if score @s ch.b3 matches 3.. run function ch:kit/storm/p/field
