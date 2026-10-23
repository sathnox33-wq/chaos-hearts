# Phoenix (capstone): dropping to 2 hearts or less makes you explode in flame and rise with 6 hearts, once every 3 minutes.
execute unless score @s ch.b3 matches 5.. run return 0
execute store result score #i_hp ch.tmp run data get entity @s Health 10
execute unless score #i_hp ch.tmp matches 1..40 run return 0
execute if score @s ch.infernal.phx > #now ch.g run return 0
function ch:kit/infernal/phoenix
