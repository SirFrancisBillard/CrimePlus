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
CrimePlus.AddMarketItem(weed)

cocaine.name = "Cocaine"
cocaine.id = "coke"
cocaine.price = CrimePlus.Config["Cocaine sell price"]
cocaine.model = CrimePlus.Models["Cocaine brick"]
cocaine.dealer = "crimeplus_dealer_drug"
cocaine.color = Color(255, 230, 255)
CrimePlus.AddMarketItem(cocaine)

meth.name = "Methamphetamine"
meth.id = "meth"
meth.price = CrimePlus.Config["Meth sell price"]
meth.model = CrimePlus.Models["Meth bag"]
meth.dealer = "crimeplus_dealer_drug"
meth.color = Color(60, 240, 245)
CrimePlus.AddMarketItem(meth)

heroin.name = "Heroin"
heroin.id = "heroin"
heroin.price = CrimePlus.Config["Heroin sell price"]
heroin.model = CrimePlus.Models["Heroin needle"]
heroin.dealer = "crimeplus_dealer_drug"
heroin.color = Color(60, 240, 245)
CrimePlus.AddMarketItem(heroin)

crack.name = "Crack Cocaine"
crack.id = "crack"
crack.price = CrimePlus.Config["Crack sell price"]
crack.model = CrimePlus.Models["Cocaine bag"]
crack.dealer = "crimeplus_dealer_drug"
crack.color = Color(60, 240, 245)
CrimePlus.AddMarketItem(crack)

weps.name = "Illegal Weapons"
weps.id = "weapons"
weps.price = CrimePlus.Config["Weapons sell price"]
weps.model = CrimePlus.Models["Weapons"]
weps.dealer = "crimeplus_dealer_arms"
weps.color = Color(142, 68, 25)
CrimePlus.AddMarketItem(weps)
