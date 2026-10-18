$data remove storage ch:data names[{pid:$(pid)}]
$data modify storage ch:data names append value {pid:$(pid),name:"$(name)"}
