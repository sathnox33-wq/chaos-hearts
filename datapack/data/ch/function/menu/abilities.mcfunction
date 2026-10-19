execute unless function ch:menu/load run return run function ch:menu/main
function ch:menu/new {t:"Abilities"}
function ch:menu/ab_line {n:0,key:"Sneak + Jump"}
function ch:menu/ab_line {n:1,key:"Sneak + Sprint"}
function ch:menu/ab_line {n:2,key:"Sneak + Left twice"}
function ch:menu/ab_line {n:3,key:"Sneak + Right twice"}
function ch:menu/text {t:"Passive: ",c:"gray"}
function ch:menu/copy {p:"m.p1",c:"white"}
function ch:menu/text {t:"\\n",c:"gray"}
function ch:menu/copy {p:"m.p1d",c:"gray"}
function ch:menu/text {t:"\\n\\nPassive (mastery 25): ",c:"gray"}
function ch:menu/copy {p:"m.p2",c:"white"}
function ch:menu/text {t:"\\n",c:"gray"}
function ch:menu/copy {p:"m.p2d",c:"gray"}
function ch:menu/text {t:"\\n\\nAwakened: ",c:"gold"}
function ch:menu/copy {p:"m.aw",c:"white"}
function ch:menu/text {t:"\\n",c:"gray"}
function ch:menu/copy {p:"m.awd",c:"gray"}
function ch:menu/text {t:"\\n\\nMastery 60 hones every ability (15% shorter cooldowns, 10% more damage). Mastery 90 shows the heart's aura.",c:"dark_gray"}
function ch:menu/button {l:"Back",c:0}
function ch:menu/button {l:"Skill tree",c:30}
function ch:menu/show
