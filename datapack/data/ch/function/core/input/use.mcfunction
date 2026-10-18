# Right-click with a Focus: Ability 1, or Ability 2 while sneaking.
scoreboard players set @s ch.use 0
execute unless items entity @s weapon.* carrot_on_a_stick[custom_data~{ch:{focus:1}}] run return fail
execute if predicate ch:sneaking run return run function ch:core/cast {slot:2}
function ch:core/cast {slot:1}
