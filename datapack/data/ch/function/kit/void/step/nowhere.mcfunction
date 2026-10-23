# Nothing to step into: clean up and refund the cast.
kill @e[type=marker,tag=ch.void.origin]
kill @e[type=marker,tag=ch.void.dest]
tag @e[tag=ch.void.path] remove ch.void.path
tag @e[tag=ch.void.sst] remove ch.void.sst
function ch:core/msg/say {m:"Nowhere to step.",c:"gray"}
return fail
