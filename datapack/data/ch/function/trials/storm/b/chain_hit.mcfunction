# As the challenger struck by the Chain bolt.
function ch:trials/storm/b/hit {d:80}
function ch:api/cc {effect:"minecraft:slowness",sec:2,amp:2}
playsound minecraft:entity.lightning_bolt.impact master @a[distance=..40] ~ ~ ~ 2 1.3
function ch:api/fx/shake {s:3,t:8,r:2}
