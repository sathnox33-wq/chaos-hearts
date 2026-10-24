# Internal: is $(heart) in the list of heart names?
$execute if data storage ch:const {names:["$(heart)"]} run return 1
return fail
