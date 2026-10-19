# Op: removes one heart of type $(heart) from $(player). Their mastery stays.
$execute as $(player) at @s run function ch:heart/destroy {h:"$(heart)"}
$tellraw @s [{text:"Took a $(heart) heart from ",color:"gray"},{selector:"$(player)",color:"white"}]
