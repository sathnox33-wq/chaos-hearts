# Generated: signature VFX of frozen ability 2; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:10217471}
execute rotated 0 0 positioned ~ ~0.05 ~ run function ch:vfx/sh {s:"flake4",k:"d",v:0}
function ch:vfx/sh {s:"streak16",k:"a",v:0.35}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/frozen_a2_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/frozen_a2_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/frozen_a2_v2
