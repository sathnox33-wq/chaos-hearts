# The admin panel's first page: every online player (pick one to manage) and the world tools.
function ch:menu/new {t:"Chaos Hearts Admin"}
function ch:menu/text {t:"Pick a player to give or take hearts, set mastery, awaken, heal or reset cooldowns.\\nWorld tools and settings are at the bottom.\\n\\nReopen this any time with ",c:"gray"}
function ch:menu/text {t:"/trigger chadmin",c:"white"}
execute as @a run function ch:admin/ui/player_btn
function ch:admin/ui/btn {l:"⚙ Settings",c:6}
function ch:admin/ui/btn {l:"✦ Place altar here",c:40}
function ch:admin/ui/btn {l:"✖ Remove nearest altar",c:41}
execute unless score @s ch.eye matches 1.. run function ch:admin/ui/btn {l:"◉ Become the Eye",c:42}
execute if score @s ch.eye matches 1.. run function ch:admin/ui/btn {l:"◉ Leave the Eye",c:43}
function ch:admin/ui/btn {l:"☰ Heart registry (chat)",c:44}
function ch:admin/ui/btn {l:"↩ Return all dropped hearts",c:45}
function ch:admin/ui/btn {l:"⌨ Typed commands",c:9}
function ch:admin/ui/btn {l:"? Help",c:8}
function ch:menu/show
