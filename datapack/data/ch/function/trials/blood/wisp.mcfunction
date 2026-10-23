# A vex she summons is claimed by the trial as a Blood Wisp.
tag @s add ch.tmob
data merge entity @s {CustomName:{text:"Blood Wisp",color:"#FF2D3F"},life_ticks:400}
function ch:api/trial/adopt
