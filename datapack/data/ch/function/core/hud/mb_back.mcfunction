# Internal: every mastery glyph advances 113 pixels; this steps back so the next layer lands on the same spot.
scoreboard players add #adv ch.tmp 113
scoreboard players set #dx ch.tmp -113
function ch:core/hud/move
