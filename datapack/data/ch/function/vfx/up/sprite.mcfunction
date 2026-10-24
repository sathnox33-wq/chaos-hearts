# Extra layers for fx/sprite by model: rune and crack decals get matching particle geometry, stars, skulls, hexes
# and swirls get their shape in particles too.
execute if score #vb ch.g matches 12.. run return 0
$data modify storage ch:vfx tmp.m set value "$(model)"
$execute if data storage ch:vfx tmp{m:"rune"} run return run function ch:vfx/up/sprite_go {model:"rune",color:$(color),s1:$(s1)}
$execute if data storage ch:vfx tmp{m:"crack"} run return run function ch:vfx/up/sprite_go {model:"crack",color:$(color),s1:$(s1)}
$execute if data storage ch:vfx tmp{m:"star"} run return run function ch:vfx/up/sprite_go {model:"star",color:$(color),s1:$(s1)}
$execute if data storage ch:vfx tmp{m:"skull"} run return run function ch:vfx/up/sprite_go {model:"skull",color:$(color),s1:$(s1)}
$execute if data storage ch:vfx tmp{m:"hex"} run return run function ch:vfx/up/sprite_go {model:"hex",color:$(color),s1:$(s1)}
$execute if data storage ch:vfx tmp{m:"swirl"} run return run function ch:vfx/up/sprite_go {model:"swirl",color:$(color),s1:$(s1)}
