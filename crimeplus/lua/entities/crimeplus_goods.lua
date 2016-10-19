AddCSLuaFile()

local weed = {}
local cocaine = {}
local meth = {}
local heroin = {}
local crack = {}
local weps = {}

weed.name = "Cannabis"
weed.id = "weed"
weed.price = CrimePlus.Config["Weed sell price"]
weed.model = CrimePlus.Models["Weed bag"]
weed.dealer = "crimeplus_dealer_drug"
weed.color = Color(50, 160, 20)

cocaine.name = "Cocaine"
cocaine.id = "coke"
cocaine.price = CrimePlus.Config["Cocaine sell price"]
cocaine.model = CrimePlus.Models["Cocaine brick"]
cocaine.dealer = "crimeplus_dealer_drug"
cocaine.color = Color(255, 230, 255)

meth.name = "Methamphetamine"
meth.id = "meth"
meth.price = CrimePlus.Config["Meth sell price"]
meth.model = CrimePlus.Models["Meth bag"]
meth.dealer = "crimeplus_dealer_drug"
meth.color = Color(60, 240, 245)

heroin.name = "Heroin"
heroin.id = "heroin"
heroin.price = CrimePlus.Config["Heroin sell price"]
heroin.model = CrimePlus.Models["Heroin needle"]
heroin.dealer = "crimeplus_dealer_drug"
heroin.color = Color(60, 240, 245)

heroin.name = "Crack Cocaine"
heroin.id = "crack"
heroin.price = CrimePlus.Config["Crack sell price"]
heroin.model = CrimePlus.Models["Cocaine bag"]
heroin.dealer = "crimeplus_dealer_drug"
heroin.color = Color(60, 240, 245)

heroin.name = "Illegal Weapons"
heroin.id = "weapons"
heroin.price = CrimePlus.Config["Weapons sell price"]
heroin.model = CrimePlus.Models["Weapons"]
heroin.dealer = "crimeplus_dealer_arms"
heroin.color = Color(142, 68, 25)
