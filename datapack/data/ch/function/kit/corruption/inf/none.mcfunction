# No host in sight.
tag @e[tag=ch.target] remove ch.target
function ch:core/msg/say {m:"No host in sight.",c:"gray"}
return fail
