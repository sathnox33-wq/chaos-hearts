$tellraw @s [{text:"💔 You lost the ",color:"red"},{text:"$(title) Heart",color:"$(color)",bold:true},{text:". $(cname) can claim it where you fell. Your mastery stays with you.",color:"gray"}]
$execute as @a if score @s ch.pid matches $(col) run function ch:heart/drop_notify_killer
