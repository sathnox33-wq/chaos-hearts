# The mastery dock, right of the hotbar at the height of the XP bar: the heart's gem in a socket ringed by this
# level's progress, MASTERY and the level in big digits, a bar to 100 with lit milestone pips and a light sliding
# along it, a thin bar for the XP inside the level, and the next unlock. At 100 it tracks Ascension instead.
# It glows while XP comes in and flashes on a level up. Every layer is a full-size glyph drawn at one pen spot.
function ch:gen/mb_xp
scoreboard players operation #ml ch.tmp = @s ch.lvl
# level-up flash and XP glow (not when the active heart just changed)
execute unless score @s ch.mba = @s ch.active run scoreboard players operation @s ch.mbl = #ml ch.tmp
execute unless score @s ch.mba = @s ch.active run scoreboard players operation @s ch.mbx = #mx ch.tmp
execute unless score @s ch.mba = @s ch.active run scoreboard players set @s ch.mbg 0
scoreboard players operation @s ch.mba = @s ch.active
scoreboard players operation #mt ch.tmp = #mx ch.tmp
scoreboard players operation #mt ch.tmp += #ma ch.tmp
execute if score #mt ch.tmp > @s ch.mbx run scoreboard players set @s ch.mbg 6
scoreboard players operation @s ch.mbx = #mt ch.tmp
execute if score #ml ch.tmp > @s ch.mbl run scoreboard players set @s ch.mbf 6
scoreboard players operation @s ch.mbl = #ml ch.tmp
# progress inside the level (#pn of #pd)
scoreboard players operation #need ch.tmp = #ml ch.tmp
function ch:mastery/total
scoreboard players operation #pn ch.tmp = #mx ch.tmp
scoreboard players operation #pn ch.tmp -= #need ch.tmp
scoreboard players operation #pd ch.tmp = #ml ch.tmp
scoreboard players operation #pd ch.tmp *= #4 ch.g
scoreboard players add #pd ch.tmp 40
scoreboard players set #lb ch.tmp 0
execute if score #ml ch.tmp matches 10.. run scoreboard players set #lb ch.tmp 1
execute if score #ml ch.tmp matches 25.. run scoreboard players set #lb ch.tmp 2
execute if score #ml ch.tmp matches 40.. run scoreboard players set #lb ch.tmp 3
execute if score #ml ch.tmp matches 60.. run scoreboard players set #lb ch.tmp 4
execute if score #ml ch.tmp matches 75.. run scoreboard players set #lb ch.tmp 5
execute if score #ml ch.tmp matches 90.. run scoreboard players set #lb ch.tmp 6
scoreboard players operation #pips ch.tmp = #lb ch.tmp
execute if score #ml ch.tmp matches 100.. run function ch:core/hud/mastery_max
execute if score #pn ch.tmp matches ..-1 run scoreboard players set #pn ch.tmp 0
execute if score #pd ch.tmp matches ..0 run scoreboard players set #pd ch.tmp 1
execute if score #pn ch.tmp > #pd ch.tmp run scoreboard players operation #pn ch.tmp = #pd ch.tmp
scoreboard players operation #ring ch.tmp = #pn ch.tmp
scoreboard players set #k ch.tmp 24
scoreboard players operation #ring ch.tmp *= #k ch.tmp
scoreboard players operation #ring ch.tmp /= #pd ch.tmp
scoreboard players operation #sub ch.tmp = #pn ch.tmp
scoreboard players set #k ch.tmp 39
scoreboard players operation #sub ch.tmp *= #k ch.tmp
scoreboard players operation #sub ch.tmp /= #pd ch.tmp
scoreboard players operation #fill ch.tmp = #ml ch.tmp
execute if score #fill ch.tmp matches 101.. run scoreboard players set #fill ch.tmp 100
scoreboard players set #k ch.tmp 78
scoreboard players operation #fill ch.tmp *= #k ch.tmp
scoreboard players operation #fill ch.tmp /= #100 ch.g
# draw
function ch:core/hud/goto {x:97}
data modify storage ch:tmp n.col set from storage ch:tmp h.color
function ch:core/hud/mb_one {k:"frame",col:"#FFFFFF"}
function ch:core/hud/mb_onec {k:"trim"}
scoreboard players operation #c ch.tmp = @s ch.active
scoreboard players remove #c ch.tmp 1
function ch:core/hud/mb_at {k:"gem",col:"#FFFFFF"}
execute if score @s ch.awake matches 1 run function ch:core/hud/mb_one {k:"crown",col:"#FFFFFF"}
scoreboard players operation #c ch.tmp = #ring ch.tmp
function ch:core/hud/mb_atc {k:"ring"}
scoreboard players operation #c ch.tmp = #fill ch.tmp
function ch:core/hud/mb_atc {k:"bar"}
# the sliding light: 12 spots, one per refresh, then a pause; only over the filled part
scoreboard players operation #c ch.tmp = #now ch.g
scoreboard players operation #c ch.tmp /= #5 ch.g
scoreboard players set #k ch.tmp 18
scoreboard players operation #c ch.tmp %= #k ch.tmp
scoreboard players operation #sx ch.tmp = #c ch.tmp
scoreboard players set #k ch.tmp 13
scoreboard players operation #sx ch.tmp *= #k ch.tmp
scoreboard players operation #sx ch.tmp /= #2 ch.g
scoreboard players add #sx ch.tmp 6
execute if score #c ch.tmp matches ..11 if score #sx ch.tmp <= #fill ch.tmp run function ch:core/hud/mb_at {k:"shine",col:"#FFFFFF"}
execute if score @s ch.mbg matches 1.. run function ch:core/hud/mb_onec {k:"glow"}
scoreboard players operation #c ch.tmp = #sub ch.tmp
function ch:core/hud/mb_at {k:"sub",col:"#FFF2D0"}
scoreboard players operation #c ch.tmp = #pips ch.tmp
function ch:core/hud/mb_at {k:"pips",col:"#FFD866"}
function ch:core/hud/mastery_digits
scoreboard players operation #c ch.tmp = #lb ch.tmp
function ch:core/hud/mb_at {k:"label",col:"#FFFFFF"}
scoreboard players operation #c ch.tmp = @s ch.mbf
scoreboard players operation #c ch.tmp %= #2 ch.g
execute if score @s ch.mbf matches 1.. if score #c ch.tmp matches 0 run function ch:core/hud/mb_onec {k:"flash"}
execute if score @s ch.mbg matches 1.. run scoreboard players remove @s ch.mbg 1
execute if score @s ch.mbf matches 1.. run scoreboard players remove @s ch.mbf 1
