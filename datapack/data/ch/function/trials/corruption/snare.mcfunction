# Snare: webs gather beneath the challenger (25 ticks); if still caught, they are bound and Nyxara pounces.
execute as @a[tag=ch.challenger,limit=1] run function ch:core/msg/say {m:"Webs gather beneath you!",c:"#E0E0E0"}
playsound chaoshearts:trial_telegraph hostile @a ~ ~ ~ 1 1.2
execute at @a[tag=ch.challenger,limit=1] positioned ~ ~0.1 ~ run function ch:trials/corruption/snare_mark
