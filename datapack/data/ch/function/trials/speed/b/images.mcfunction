# Afterimages: Vael streaks between three points (the last one where you are heading); each streak detonates later.
execute if score @s ch.v2 matches 1 run tellraw @a[tag=ch.challenger] {text:"Vael leaves afterimages... stay off the lines!",color:"#F5E142",italic:true}
execute if score @s ch.v2 matches 6 run function ch:trials/speed/b/seg_rand
execute if score @s ch.v2 matches 12 run function ch:trials/speed/b/seg_rand
execute if score @s ch.v2 matches 18 run function ch:trials/speed/b/seg_player
execute if score @s ch.v2 matches 50.. run function ch:trials/speed/b/end
