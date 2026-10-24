# The admin settings page: the most used ch.cfg values with buttons to change them.
function ch:menu/new {t:"Settings"}
function ch:admin/ui/set_line {k:"#starter",t:"Random heart on first join (1 on, 0 off)"}
function ch:admin/ui/set_line {k:"#unique",t:"One heart of each type on the server"}
function ch:admin/ui/set_line {k:"#combat_log",t:"Logging out in combat drops a heart"}
function ch:admin/ui/set_line {k:"#xp_pct",t:"Mastery XP %"}
function ch:admin/ui/set_line {k:"#dmg_pct",t:"Ability damage %"}
function ch:admin/ui/set_line {k:"#cd_pct",t:"Ability cooldowns %"}
function ch:admin/ui/set_line {k:"#pvp_pct",t:"Ability damage on players %"}
function ch:admin/ui/set_line {k:"#collect_sec",t:"Seconds to collect a dropped heart"}
function ch:menu/text {t:"\\nEvery other setting: /scoreboard players set #<name> ch.cfg <value> (see the README).",c:"dark_gray"}
function ch:admin/ui/btn {l:"Toggle first-join heart",c:50}
function ch:admin/ui/btn {l:"Toggle unique hearts",c:51}
function ch:admin/ui/btn {l:"Toggle combat-log drop",c:52}
function ch:admin/ui/btn {l:"XP −25%",c:53}
function ch:admin/ui/btn {l:"XP +25%",c:54}
function ch:admin/ui/btn {l:"Damage −10%",c:55}
function ch:admin/ui/btn {l:"Damage +10%",c:56}
function ch:admin/ui/btn {l:"Cooldowns −10%",c:57}
function ch:admin/ui/btn {l:"Cooldowns +10%",c:58}
function ch:admin/ui/btn {l:"PvP damage −10%",c:59}
function ch:admin/ui/btn {l:"PvP damage +10%",c:60}
function ch:admin/ui/btn {l:"Collect time −60 s",c:61}
function ch:admin/ui/btn {l:"Collect time +60 s",c:62}
function ch:admin/ui/btn {l:"Reset all to defaults",c:69}
function ch:admin/ui/btn {l:"← Back",c:1}
function ch:menu/show
