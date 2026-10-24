# Like vfx/go, but the timeline rides on its owner's feet.
$function ch:vfx/play {f:"$(f)",n:$(n),spin:$(spin),dy:0,fw:0}
function ch:vfx/keep_cur
tag @e[type=marker,tag=ch.vnew,limit=1] add ch.vfol
