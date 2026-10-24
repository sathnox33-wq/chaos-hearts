# A crescent slash in front of the eyes following the look, rolled `roll` degrees, sweeping as it grows.
$data modify storage ch:tmp fxa set value {model:"slash",color:$(color),s0:0.6,s1:$(s),t:$(t),spin:100,dy:0.0,roll:$(roll)}
execute store result score #l ch.tmp run data get storage ch:tmp fxa.t
scoreboard players add #l ch.tmp 4
execute store result storage ch:tmp fxa.life int 1 run scoreboard players get #l ch.tmp
execute anchored eyes positioned ^ ^-0.2 ^1.2 run function ch:api/fx/sprite_go with storage ch:tmp fxa
particle minecraft:sweep_attack ^ ^1.2 ^1.5 0.3 0.1 0.3 0 3
$function ch:vfx/up/slash {color:$(color),s:$(s)}
