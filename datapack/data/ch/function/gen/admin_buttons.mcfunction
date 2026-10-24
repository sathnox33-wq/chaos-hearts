# Generated: give / take / make-active buttons on the admin player page.
function ch:admin/ui/btn {l:"+ Give Rage",c:2001}
function ch:admin/ui/btn {l:"+ Give Speed",c:2002}
function ch:admin/ui/btn {l:"+ Give Infernal",c:2003}
function ch:admin/ui/btn {l:"+ Give Void",c:2004}
function ch:admin/ui/btn {l:"+ Give Frozen",c:2005}
function ch:admin/ui/btn {l:"+ Give Storm",c:2006}
function ch:admin/ui/btn {l:"+ Give Blood",c:2007}
function ch:admin/ui/btn {l:"+ Give Titan",c:2008}
function ch:admin/ui/btn {l:"+ Give Celestial",c:2009}
function ch:admin/ui/btn {l:"+ Give Corruption",c:2010}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.rage matches 1.. run function ch:admin/ui/btn {l:"− Take Rage",c:2101}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.speed matches 1.. run function ch:admin/ui/btn {l:"− Take Speed",c:2102}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.infernal matches 1.. run function ch:admin/ui/btn {l:"− Take Infernal",c:2103}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.void matches 1.. run function ch:admin/ui/btn {l:"− Take Void",c:2104}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.frozen matches 1.. run function ch:admin/ui/btn {l:"− Take Frozen",c:2105}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.storm matches 1.. run function ch:admin/ui/btn {l:"− Take Storm",c:2106}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.blood matches 1.. run function ch:admin/ui/btn {l:"− Take Blood",c:2107}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.titan matches 1.. run function ch:admin/ui/btn {l:"− Take Titan",c:2108}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.celestial matches 1.. run function ch:admin/ui/btn {l:"− Take Celestial",c:2109}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.corruption matches 1.. run function ch:admin/ui/btn {l:"− Take Corruption",c:2110}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.rage matches 1.. unless score @a[tag=ch.adtgt,limit=1] ch.active matches 1 run function ch:admin/ui/btn {l:"◆ Make Rage active",c:2201}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.speed matches 1.. unless score @a[tag=ch.adtgt,limit=1] ch.active matches 2 run function ch:admin/ui/btn {l:"◆ Make Speed active",c:2202}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.infernal matches 1.. unless score @a[tag=ch.adtgt,limit=1] ch.active matches 3 run function ch:admin/ui/btn {l:"◆ Make Infernal active",c:2203}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.void matches 1.. unless score @a[tag=ch.adtgt,limit=1] ch.active matches 4 run function ch:admin/ui/btn {l:"◆ Make Void active",c:2204}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.frozen matches 1.. unless score @a[tag=ch.adtgt,limit=1] ch.active matches 5 run function ch:admin/ui/btn {l:"◆ Make Frozen active",c:2205}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.storm matches 1.. unless score @a[tag=ch.adtgt,limit=1] ch.active matches 6 run function ch:admin/ui/btn {l:"◆ Make Storm active",c:2206}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.blood matches 1.. unless score @a[tag=ch.adtgt,limit=1] ch.active matches 7 run function ch:admin/ui/btn {l:"◆ Make Blood active",c:2207}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.titan matches 1.. unless score @a[tag=ch.adtgt,limit=1] ch.active matches 8 run function ch:admin/ui/btn {l:"◆ Make Titan active",c:2208}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.celestial matches 1.. unless score @a[tag=ch.adtgt,limit=1] ch.active matches 9 run function ch:admin/ui/btn {l:"◆ Make Celestial active",c:2209}
execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.corruption matches 1.. unless score @a[tag=ch.adtgt,limit=1] ch.active matches 10 run function ch:admin/ui/btn {l:"◆ Make Corruption active",c:2210}
