# Appends a player's score $(o) as text in colour $(c).
$execute store result storage ch:tmp sc int 1 run scoreboard players get @s $(o)
data modify storage ch:tmp dl.body append value {text:""}
$data modify storage ch:tmp dl.body[-1].color set value "$(c)"
data modify storage ch:tmp dl.body[-1].text set string storage ch:tmp sc
