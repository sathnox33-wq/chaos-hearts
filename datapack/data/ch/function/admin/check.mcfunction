# Checks storage ch:tmp ad {player, heart} before an admin command runs, and says what is wrong instead of failing
# silently: an empty name, a player who is not online, or a heart name that does not exist.
execute if data storage ch:tmp ad{player:""} run return run function ch:admin/bad {m:"Type a player name, or @s for yourself."}
execute unless function ch:admin/check_heart run return run function ch:admin/bad {m:"Unknown heart. Use rage, speed, infernal, void, frozen, storm, blood, titan, celestial or corruption."}
execute unless function ch:admin/check_player run return run function ch:admin/bad {m:"No online player matches that name."}
return 1
