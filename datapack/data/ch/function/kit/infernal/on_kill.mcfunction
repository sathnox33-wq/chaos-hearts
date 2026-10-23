# Kill bookkeeping: Cremation and Phoenix Ember for burning kills, Living Inferno and Endless Pyre during the Avatar.
scoreboard players operation #i_dt ch.tmp = #now ch.g
scoreboard players operation #i_dt ch.tmp -= @s ch.infernal.lbt
execute if score #i_dt ch.tmp matches 0..40 run function ch:kit/infernal/burn_kill
execute if score @s ch.infernal.av matches 1.. run function ch:kit/infernal/avatar/kill
