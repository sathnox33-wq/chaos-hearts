# Internal: the particle layer for one sprite, sized from its final scale.
scoreboard players add #vb ch.g 1
$function ch:vfx/col {color:$(color)}
$data modify storage ch:vfx cur.sf set value $(s1)
execute store result score #os ch.tmp run data get storage ch:vfx cur.sf 10
$function ch:vfx/up/m_$(model)
