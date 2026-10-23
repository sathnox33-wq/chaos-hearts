# The target already carries an infection.
tag @e[tag=ch.target] remove ch.target
function ch:core/msg/say {m:"That host is already infested.",c:"gray"}
return fail
