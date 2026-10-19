# Right-clicking the altar: shows the active heart's trial status and the button to begin.
advancement revoke @s only ch:event/altar
execute if score @s ch.active matches 0 run return run function ch:core/msg/say {m:"You hold no Chaos Heart. Win one in PvP.",c:"gray"}
playsound chaoshearts:ui_open player @s ~ ~ ~ 0.6 1
scoreboard players operation #i ch.tmp = @s ch.active
function ch:gen/describe
execute store result storage ch:tmp h.lvl int 1 run scoreboard players get @s ch.lvl
data modify storage ch:tmp h.state set value "Reach mastery 100 to face its trial."
execute if score @s ch.lvl matches 100.. run data modify storage ch:tmp h.state set value "The heart is ready. Begin when you are."
execute if score @s ch.awake matches 1 run data modify storage ch:tmp h.state set value "This heart is already awakened."
function ch:altar/dialog with storage ch:tmp h
