# Op: builds an Awakening Altar where you stand. It is made of barrier blocks, so survival players cannot break it,
# explosions and pistons cannot move it, and its look comes from display entities.
execute if entity @e[type=marker,tag=ch.altar,distance=..12,limit=1] run return run tellraw @s {text:"There is already an altar here.",color:"red"}
execute align xyz run function ch:gen/altar_build
playsound chaoshearts:altar_activate master @a ~ ~ ~ 1.5 1
tellraw @s [{text:"✦ Awakening Altar placed. ",color:"light_purple"},{text:"Remove it with /function ch:admin/altar/remove while standing on it.",color:"gray"}]
