# As the challenger: the trial is lost. They go home and the heart needs time before another attempt.
$function ch:core/msg/say {m:"$(why)",c:"red"}
function ch:api/fx/screen {o:"shatter",color:"#FFFFFF",in:1,stay:20,out:20}
playsound chaoshearts:trial_fail master @s ~ ~ ~ 1 1
scoreboard players operation #i ch.tmp = #hid ch.tmp
function ch:gen/describe
function ch:trial/fail2 with storage ch:tmp h
function ch:trial/return
$function ch:trial/cleanup {s:$(s)}
