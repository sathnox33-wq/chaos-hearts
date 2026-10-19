# As the challenger: the heart they fought for is awakened and grants its skill points.
scoreboard players operation #i ch.tmp = #hid ch.tmp
function ch:gen/describe
function ch:trial/awaken2 with storage ch:tmp h
function ch:gen/sync_active
