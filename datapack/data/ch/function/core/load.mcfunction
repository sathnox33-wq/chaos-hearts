# Sets up scoreboards, storage and helper entities. Safe to run again on /reload.
function ch:gen/objectives
function ch:gen/config_defaults
function ch:gen/constants
function ch:gen/menu_data
scoreboard players set #unlock1 ch.g 0
scoreboard players set #unlock2 ch.g 10
scoreboard players set #unlock3 ch.g 40
scoreboard players set #unlock4 ch.g 75
execute unless data storage ch:reg hearts run data modify storage ch:reg hearts set value []
execute unless data storage ch:data pending run data modify storage ch:data pending set value []
execute unless data storage ch:data names run data modify storage ch:data names set value []
execute unless data storage ch:data returns run data modify storage ch:data returns set value []
execute unless data storage ch:data pvp run data modify storage ch:data pvp set value []
team add ch.trial
team modify ch.trial friendlyFire false
team modify ch.trial seeFriendlyInvisibles false
function ch:trial/load
function ch:gen/kit_load
execute in ch:trials run forceload add 0 0
schedule function ch:core/helpers 5t replace
scoreboard players set #loaded ch.g 1
