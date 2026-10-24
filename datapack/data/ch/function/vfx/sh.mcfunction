# Draws shape $(s) (a function in gen/vfx) with particle cur.$(k) from storage ch:vfx cur, at speed $(v).
$data modify storage ch:vfx cur.p set from storage ch:vfx cur.$(k)
$data modify storage ch:vfx cur.v set value $(v)
$function ch:gen/vfx/$(s) with storage ch:vfx cur
