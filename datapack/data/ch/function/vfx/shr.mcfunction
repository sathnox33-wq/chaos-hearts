# Draws a dynamic ring (gen/vfx/mring<n>) of radius $(r) with particle cur.$(k) from storage ch:vfx cur.
$data modify storage ch:vfx cur.p set from storage ch:vfx cur.$(k)
$data modify storage ch:vfx cur.r set value $(r)
$function ch:gen/vfx/mring$(n) with storage ch:vfx cur
