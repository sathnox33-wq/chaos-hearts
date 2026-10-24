# Like vfx/gof, but the timeline also turns to face the way its owner faces (for wings and the like).
$function ch:vfx/play {f:"$(f)",n:$(n),spin:0,dy:0,fw:0}
function ch:vfx/keep_cur
tag @e[type=marker,tag=ch.vnew,limit=1] add ch.vfol
tag @e[type=marker,tag=ch.vnew,limit=1] add ch.vfrot
