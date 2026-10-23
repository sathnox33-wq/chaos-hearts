# The tether: a thread reaches for the challenger for 15 ticks, then drinks for 3 s. Break line of sight or get 15 away.
scoreboard players set @s ch.v3 75
function ch:trials/blood/say {m:"Vesperine reaches for your blood! Break line of sight!"}
playsound minecraft:entity.evoker.cast_spell master @a[distance=..90] ~ ~ ~ 2 0.6
playsound chaoshearts:blood_siphon master @a[distance=..90] ~ ~ ~ 1.5 0.7
execute positioned ~ ~2.5 ~ run function ch:api/fx/orb {color:16723263,s:1.6,t:5,life:15}
