# Frost Armor: melee attackers are slowed. Chilled Blood: wounds from slowed enemies partly close.
execute if score @s ch.b3 matches 1.. on attacker if entity @s[distance=..5] run function ch:kit/frozen/armor
execute if score @s ch.b3 matches 2.. run function ch:kit/frozen/chilled
