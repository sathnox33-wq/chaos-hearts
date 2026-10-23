# Aftershock: the same fault erupts again a second later for half damage.
scoreboard players operation #ti_x ch.tmp = #ti_len ch.tmp
function ch:kit/titan/fx/later {t:20,then:"ch:kit/titan/slam/after"}
