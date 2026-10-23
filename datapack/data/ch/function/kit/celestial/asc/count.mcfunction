# As the Celestial: an Ascension strike landed (Heaven's Wrath at 10).
scoreboard players add @s ch.celestial.sh 1
execute if score @s ch.celestial.sh matches 10.. run function ch:api/feat {h:"celestial",n:3}
