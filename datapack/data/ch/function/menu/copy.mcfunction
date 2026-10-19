# Appends the string at storage ch:tmp $(p) to the body in colour $(c).
$data modify storage ch:tmp dl.body append value {text:"",color:"$(c)"}
$data modify storage ch:tmp dl.body[-1].text set string storage ch:tmp $(p)
