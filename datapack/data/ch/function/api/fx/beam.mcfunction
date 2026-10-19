# A beam w wide and len long along the look direction.
$data modify storage ch:tmp fxa set value {model:"beam",color:$(color),t:$(t),life:$(life),spin:0,dy:0.0,roll:0,ax:$(w),ay:0.1,az:$(w),bx:$(w),by:$(len),bz:$(w)}
function ch:api/fx/beam_go with storage ch:tmp fxa
