# As a target: plague - Poison for the living, Wither for the undead (poison cannot touch them).
$execute if entity @s[type=#ch:undead] run return run function ch:kit/corruption/afflict {e:"wither",sec:$(sec),amp:$(amp)}
$function ch:kit/corruption/afflict {e:"poison",sec:$(sec),amp:$(amp)}
