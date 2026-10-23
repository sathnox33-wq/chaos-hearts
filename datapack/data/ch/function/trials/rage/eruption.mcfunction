# Phase 3, Crimson Eruption: five rings of the floor are marked around Gorrath, then burst outward one after another.
function ch:trials/rage/say {m:"The ground splits around Gorrath! Find the gaps between the rings!"}
playsound minecraft:entity.warden.emerge master @a[distance=..90] ~ ~ ~ 2 0.6
playsound chaoshearts:trial_telegraph master @a[distance=..90] ~ ~ ~ 1.4 0.6
function ch:trials/rage/eruption_mark
