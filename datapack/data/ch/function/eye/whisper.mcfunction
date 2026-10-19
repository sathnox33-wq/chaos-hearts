# The Eye whispers to one player only.
$tellraw $(player) [{text:"◉ ",color:"dark_purple"},{text:"The Eye whispers",color:"dark_purple",italic:true},{text:": ",color:"dark_gray"},{text:"$(msg)",color:"gray",italic:true}]
$execute as $(player) at @s run playsound chaoshearts:eye_whisper master @s ~ ~ ~ 1 1
$execute as $(player) run function ch:api/fx/screen {o:"eye",color:"#FFFFFF",in:5,stay:20,out:25}
$tellraw @s [{text:"You whispered to ",color:"dark_gray"},{selector:"$(player)",color:"gray"}]
