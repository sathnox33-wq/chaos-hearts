# Each blood pool boils in turn during the intro.
execute positioned ~10 ~ ~4 run function ch:api/later {t:10,then:"ch:trials/blood/intro_pool"}
execute positioned ~1 ~ ~11 run function ch:api/later {t:20,then:"ch:trials/blood/intro_pool"}
execute positioned ~-9 ~ ~7 run function ch:api/later {t:30,then:"ch:trials/blood/intro_pool"}
execute positioned ~-10 ~ ~-4 run function ch:api/later {t:40,then:"ch:trials/blood/intro_pool"}
execute positioned ~-1 ~ ~-11 run function ch:api/later {t:50,then:"ch:trials/blood/intro_pool"}
execute positioned ~9 ~ ~-7 run function ch:api/later {t:60,then:"ch:trials/blood/intro_pool"}
