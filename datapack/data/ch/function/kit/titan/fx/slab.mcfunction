# Summons the hidden slab of $(b) that rises next tick, with a spray of that block.
$execute summon block_display run function ch:kit/titan/fx/slab_init_$(sz) {b:"$(b)"}
$particle minecraft:block{block_state:"$(b)"} ~ ~0.4 ~ 0.35 0.25 0.35 0.15 14
$particle minecraft:dust_pillar{block_state:"$(b)"} ~ ~0.2 ~ 0.4 0.1 0.4 0.1 6
