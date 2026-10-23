# The Blood holder killed a player: Blood Price (during the Pact below 4 hearts) and Martyr (resets the Pact).
execute store result score #hp ch.tmp run data get entity @s Health 10
execute if score @s ch.blood.pact matches 1.. if score #hp ch.tmp matches ..79 run function ch:api/feat {h:"blood",n:2}
execute if score @s ch.b3 matches 5.. run function ch:kit/blood/martyr
