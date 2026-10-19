# One tinted, emissive model at the current position and rotation. Scales s0 -> s1 over t ticks while spinning `spin`
# degrees around its own Y (after rolling `roll` degrees around Z) and rising dy blocks, then shrinks away at the end
# of its life. Callers usually use the wrappers (wave, slash, pillar, beam, orb).
$data modify storage ch:tmp fxa set value {model:"$(model)",color:$(color),s0:$(s0),s1:$(s1),t:$(t),life:$(life),spin:$(spin),dy:$(dy),roll:0}
function ch:api/fx/sprite_go with storage ch:tmp fxa
