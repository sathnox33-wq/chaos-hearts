# Down: Epicenter. The ground ripples out from you in three rings, each a little later and weaker than the last.
function ch:kit/titan/slam/origin_fx
scoreboard players set #ti_x ch.tmp 1
function ch:kit/titan/slam/ring
scoreboard players set #ti_x ch.tmp 2
function ch:kit/titan/fx/later {t:4,then:"ch:kit/titan/slam/ring_l"}
scoreboard players set #ti_x ch.tmp 3
function ch:kit/titan/fx/later {t:8,then:"ch:kit/titan/slam/ring_l"}
return 1
