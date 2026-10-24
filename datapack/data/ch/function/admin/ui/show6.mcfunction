# Shows storage ch:tmp dl as a dialog with six narrow buttons per row.
data modify storage ch:tmp dl.actions[].width set value 64
function ch:admin/ui/show6b with storage ch:tmp dl
