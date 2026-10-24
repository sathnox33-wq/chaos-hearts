# Internal: succeeds when ad.heart is one of the ten heart names.
execute if data storage ch:tmp ad{heart:"none"} run return fail
return run function ch:admin/check_heart2 with storage ch:tmp ad
