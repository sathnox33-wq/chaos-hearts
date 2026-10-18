# Advancement reward: this player killed another player. The victim's death handler reads #killer.
advancement revoke @s only ch:event/kill_player
scoreboard players operation #killer ch.g = @s ch.pid
scoreboard players operation #killer_t ch.g = #now ch.g
