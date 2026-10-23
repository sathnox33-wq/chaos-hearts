# As the player: rebirth. Heals now; the blast follows a tick later (as a later marker, so the caster tags stay clean).
scoreboard players operation @s ch.infernal.phx = #now ch.g
scoreboard players add @s ch.infernal.phx 3600
effect give @s minecraft:instant_health 1 1 true
effect give @s minecraft:regeneration 5 1 true
effect give @s minecraft:resistance 3 1 true
effect give @s minecraft:fire_resistance 30 0 true
title @s times 0 30 15
title @s subtitle {text:"✦ PHOENIX ✦",color:"#FFD23F",bold:true}
function ch:api/fx/screen {o:"awaken",color:"#FFD23F",in:0,stay:8,out:20}
function ch:api/later {t:1,then:"ch:kit/infernal/phoenix_boom"}
