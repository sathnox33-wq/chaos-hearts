# Op: /function ch:admin opens the clickable admin panel and makes you a Chaos Hearts admin, so from then on
# /trigger chadmin opens it too (its buttons use that trigger, so they never ask for confirmation).
# To make someone else an admin: /tag <name> add ch.admin (remove the tag to undo).
tag @s add ch.admin
scoreboard players enable @s chadmin
function ch:admin/ui/main
