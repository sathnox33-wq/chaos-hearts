# Generated: default settings. Change them with /scoreboard players set <name> ch.cfg <value>.
# #starter: 1 gives each new player a random heart, 0 gives nothing
execute unless score #starter ch.cfg = #starter ch.cfg run scoreboard players set #starter ch.cfg 1
# #unique: 1 allows only one heart of each type on the server
execute unless score #unique ch.cfg = #unique ch.cfg run scoreboard players set #unique ch.cfg 0
# #max_hearts: Most hearts one player can own (0 = no limit)
execute unless score #max_hearts ch.cfg = #max_hearts ch.cfg run scoreboard players set #max_hearts ch.cfg 0
# #collect_sec: Seconds a killer has to collect a dropped heart
execute unless score #collect_sec ch.cfg = #collect_sec ch.cfg run scoreboard players set #collect_sec ch.cfg 300
# #combat_sec: Seconds of combat tag after PvP damage
execute unless score #combat_sec ch.cfg = #combat_sec ch.cfg run scoreboard players set #combat_sec ch.cfg 15
# #combat_log: 1 makes logging out in combat drop your latest heart for your opponent
execute unless score #combat_log ch.cfg = #combat_log ch.cfg run scoreboard players set #combat_log ch.cfg 1
# #swap_sec: Cooldown in seconds on shuffling the active heart
execute unless score #swap_sec ch.cfg = #swap_sec ch.cfg run scoreboard players set #swap_sec ch.cfg 2
# #xp_pct: Mastery XP multiplier in percent
execute unless score #xp_pct ch.cfg = #xp_pct ch.cfg run scoreboard players set #xp_pct ch.cfg 100
# #daily_cap: Daily mastery XP before the soft cap applies
execute unless score #daily_cap ch.cfg = #daily_cap ch.cfg run scoreboard players set #daily_cap ch.cfg 2500
# #cap_pct: Percent of XP still earned above the daily cap
execute unless score #cap_pct ch.cfg = #cap_pct ch.cfg run scoreboard players set #cap_pct ch.cfg 25
# #xp_hit_player: XP for an ability hit on a player
execute unless score #xp_hit_player ch.cfg = #xp_hit_player ch.cfg run scoreboard players set #xp_hit_player ch.cfg 15
# #xp_hit_mob: XP for an ability hit on a hostile mob
execute unless score #xp_hit_mob ch.cfg = #xp_hit_mob ch.cfg run scoreboard players set #xp_hit_mob ch.cfg 5
# #xp_kill_mob: XP for an ability kill on a hostile mob
execute unless score #xp_kill_mob ch.cfg = #xp_kill_mob ch.cfg run scoreboard players set #xp_kill_mob ch.cfg 8
# #xp_pvp_kill: XP for a PvP kill with the heart active
execute unless score #xp_pvp_kill ch.cfg = #xp_pvp_kill ch.cfg run scoreboard players set #xp_pvp_kill ch.cfg 150
# #xp_boss: XP for killing a Wither, Warden, Elder Guardian or Ender Dragon
execute unless score #xp_boss ch.cfg = #xp_boss ch.cfg run scoreboard players set #xp_boss ch.cfg 400
# #pvp_pct: Ability damage against players in percent
execute unless score #pvp_pct ch.cfg = #pvp_pct ch.cfg run scoreboard players set #pvp_pct ch.cfg 75
# #cc_pct: Crowd-control duration on players in percent
execute unless score #cc_pct ch.cfg = #cc_pct ch.cfg run scoreboard players set #cc_pct ch.cfg 50
# #dmg_pct: Global ability damage in percent
execute unless score #dmg_pct ch.cfg = #dmg_pct ch.cfg run scoreboard players set #dmg_pct ch.cfg 100
# #cd_pct: Global ability cooldowns in percent
execute unless score #cd_pct ch.cfg = #cd_pct ch.cfg run scoreboard players set #cd_pct ch.cfg 100
# #awaken_pts: Skill points granted on awakening
execute unless score #awaken_pts ch.cfg = #awaken_pts ch.cfg run scoreboard players set #awaken_pts ch.cfg 3
# #asc_per_pt: Ascension XP per extra skill point
execute unless score #asc_per_pt ch.cfg = #asc_per_pt ch.cfg run scoreboard players set #asc_per_pt ch.cfg 1000
# #max_pts: Most skill points per heart
execute unless score #max_pts ch.cfg = #max_pts ch.cfg run scoreboard players set #max_pts ch.cfg 15
# #respec_lvls: XP levels a respec costs after the free one
execute unless score #respec_lvls ch.cfg = #respec_lvls ch.cfg run scoreboard players set #respec_lvls ch.cfg 20
# #trial_retry_min: Minutes to wait after failing a trial
execute unless score #trial_retry_min ch.cfg = #trial_retry_min ch.cfg run scoreboard players set #trial_retry_min ch.cfg 10
# #trial_pct: Trial mob health and damage in percent
execute unless score #trial_pct ch.cfg = #trial_pct ch.cfg run scoreboard players set #trial_pct ch.cfg 100
# #trial_min: Trial time limit in minutes
execute unless score #trial_min ch.cfg = #trial_min ch.cfg run scoreboard players set #trial_min ch.cfg 15
