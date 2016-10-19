AddCSLuaFile()

CrimePlus = {Config = {}}

CRIMEPLUS_LOADING = true

include("crimeplus_config.lua")
include("crimeplus_enums.lua")
include("crimeplus_meta.lua")

CRIMEPLUS_LOADING = false

CrimePlus.Models = {
	-- Generic models
	["Stove"] = "models/props_c17/furnitureStove001a.mdl",
	["Cooking pot"] = "models/props_c17/metalPot001a.mdl",
	["Propane tank"] = "models/props_junk/propane_tank001a.mdl",
	["Gas can"] = "models/props_junk/metalgascan.mdl",
	["Fertilizer"] = "models/props_junk/plasticbucket001a.mdl",
	["Drying rack"] = "models/props_wasteland/kitchen_shelf001a.mdl",
	["Grinder"] = "models/props_junk/MetalBucket02a.mdl",

	-- Weed models
	["Weed seed"] = "models/nater/weedplant_pot.mdl",
	["Weed pot"] = "models/nater/weedplant_pot.mdl",
	["Weed pot soil"] = "models/nater/weedplant_pot_dirt.mdl",
	["Weed pot planted"] = "models/nater/weedplant_pot_planted.mdl",
	["Weed stage 1"] = "models/nater/weedplant_pot_growing1.mdl",
	["Weed stage 2"] = "models/nater/weedplant_pot_growing2.mdl",
	["Weed stage 3"] = "models/nater/weedplant_pot_growing3.mdl",
	["Weed stage 4"] = "models/nater/weedplant_pot_growing4.mdl",
	["Weed stage 5"] = "models/nater/weedplant_pot_growing5.mdl",
	["Weed stage 6"] = "models/nater/weedplant_pot_growing6.mdl",
	["Weed stage 7"] = "models/nater/weedplant_pot_growing7.mdl",
	["Weed bag"] = "models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl",

	-- Cocaine models
	["Coca plant"] = "models/srcocainelab/cocaplant.mdl",
	["Cocaine brick"] = "models/srcocainelab/cocainebrick.mdl",
	["Cocaine bag"] = "models/srcocainelab/ziplockedcocaine.mdl",

	-- Meth models
	["Ephedrine"] = "models/meth_mod/ephedrine/ephedrine.mdl",
	["Red phosphorus"] = "models/meth_mod/matchbox/matchbox.mdl",
	["Iodine"] = "models/meth_mod/iodine/iodine.mdl",
	["Hydrochloric acid"] = "models/meth_mod/hydrochloric_acid/hydrochloric_acid.mdl",
	["Ether"] = "models/meth_mod/ether/ether.mdl",
	["Ammonia"] = "models/meth_mod/anhydrousammonia/anhydrousammonia.mdl",
	["Sodium hydroxide"] = "models/meth_mod/sodiumhydroxide/sodiumhydroxide.mdl",
	["Meth bag"] = "models/katharsmodels/contraband/metasync/blue_sky.mdl",
}

CrimePlus.PlayerVars = {}

function CrimePlus.AddIngredient(tab)
	local ing = {}
	ing.name = tab.name or "Unknown"
	ing.id = string.lower(tab.id) or string.lower(ing.name) or "unknown"
	ing.class = tab.class or "crimeplus_ingredient_" .. ing.id
	ing.price = tab.price or "nope"
	ing.model = tab.model or "models/error.mdl"
	ing.max = tab.max or 2
	ing.cmd = tab.cmd or "buy" .. ing.id
	ing.category = tab.category or "Other"
	DEFINE_BASECLASS("crimeplus_base")
	local sent = {
		Base = "crimeplus_base",
		Type = "anim",
		PrintName = ing.name,
		Category = "Crime+ Ingredients",
		Spawnable = true,
		Model = ing.model
	}
	scripted_ents.Register(sent, ing.class)
	if ing.price ~= "nope" and type(DarkRP.createEntity) == "function" then
		DarkRP.createEntity(ing.name, {
			ent = ing.class,
			model = ing.model,
			price = ing.price,
			max = ing.max,
			category = ing.category,
			cmd = ing.cmd
		})
	end
end

function CrimePlus.AddDealer(tab)
	local dealer = {}
	dealer.name = tab.name or "Unknown"
	dealer.id = string.lower(tab.id) or string.lower(dealer.name) or "unknown"
	dealer.class = tab.class or "crimeplus_dealer_" .. dealer.id
	dealer.model = tab.model or "models/error.mdl"
	dealer.anim = tab.anim or "idleall01"
	DEFINE_BASECLASS("crimeplus_base_dealer")
	local sent = {
		Base = "crimeplus_base_dealer",
		Type = "anim",
		PrintName = dealer.name,
		Category = "Crime+ Dealers",
		Spawnable = true,
		Model = dealer.model,
		DealerData = {Anim = dealer.anim}
	}
	scripted_ents.Register(sent, dealer.class)
end

function CrimePlus.AddMarketItem(tab)
	local item = {}
	item.name = tab.name or "Unknown"
	item.id = string.lower(tab.id) or string.lower(item.name) or "unknown"
	item.class = tab.class or "crimeplus_item_" .. item.id
	item.price = tab.price or "nope"
	item.model = tab.model or "models/error.mdl"
	item.dealer = tab.dealer or "crimeplus_dealer_drug"
	item.color = tab.color or Color(255, 0, 0)
	DEFINE_BASECLASS("crimeplus_base_market")
	local sent = {
		Base = "crimeplus_base_market",
		Type = "anim",
		PrintName = item.name,
		Category = "Crime+ Goods",
		Spawnable = true,
		Model = item.model,
		MarketData = {Price = item.price, Dealer = item.dealer, Color = item.color}
	}
	scripted_ents.Register(sent, item.class)
end

function CrimePlus.SetGrowthModel(ent, plant, stage)
	if not IsValid(ent) then return end
	if plant == CRIMEPLUS_PLANT_WEED then
		return ent:SetModel("models/error.mdl")
	elseif plant == CRIMEPLUS_PLANT_COCA then
		return ent:SetBodygroup(1, math.Clamp(stage - 1, 0, 2))
	end
	-- Nothing for opium yet
end

function CrimePlus.HandlePlayerSpawn(ply)
	-- Do Stuff
end

hook.Add("PlayerSpawn", "CrimePlus_PlayerSpawn", CrimePlus.HandlePlayerSpawn)
