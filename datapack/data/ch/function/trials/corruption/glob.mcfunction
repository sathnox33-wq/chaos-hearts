# One bile glob: a closing ring on the ground and the glob falling onto it 16 ticks later.
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:13161514,s0:5.0,s1:1.0,t:16,life:17,spin:150,dy:0.0}
execute positioned ~ ~14 ~ rotated 0 0 run function ch:api/fx/sprite {model:"orb",color:8114490,s0:1.0,s1:1.3,t:16,life:17,spin:150,dy:-14.0}
function ch:api/later {t:16,then:"ch:trials/corruption/glob_hit"}
