# Generated: blood signature VFX by slot (#sig_s ch.tmp).
function ch:vfx/col {color:10357535}
execute if score #sig_s ch.tmp matches 1 run return run function ch:gen/sig/blood_a1
execute if score #sig_s ch.tmp matches 2 run return run function ch:gen/sig/blood_a2
execute if score #sig_s ch.tmp matches 3 run return run function ch:gen/sig/blood_a3
execute if score #sig_s ch.tmp matches 4 run return run function ch:gen/sig/blood_a4
