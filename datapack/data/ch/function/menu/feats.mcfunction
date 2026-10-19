execute unless function ch:menu/load run return run function ch:menu/main
function ch:menu/new {t:"Feats"}
function ch:menu/text {t:"Feats are one-time challenges that reward skill with a burst of mastery.\\n\\n",c:"gray"}
function ch:menu/feat_line {n:0,bit:1}
function ch:menu/feat_line {n:1,bit:2}
function ch:menu/feat_line {n:2,bit:4}
function ch:menu/feat_line {n:3,bit:8}
function ch:menu/button {l:"Back",c:0}
function ch:menu/show
