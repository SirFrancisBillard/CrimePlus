AddCSLuaFile()

ENT.Base = "crimeplus_base"
ENT.Type = "anim"
ENT.PrintName = "Cooking Pot"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = CrimePlus.Models["Cooking pot"]

self.Recipes = {
	["crimeplus_meth"] = {
		time = CrimePlus.Config["Meth cook time"],
		needs = {
			["ephedrine"] = 1,
			["red phosphorus"] = 1,
			["iodine"] = 1,
			["hydrochloric acid"] = 1,
			["ether"] = 1,
			["ammonia"] = 1,
			["sodium hydroxide"] = 1
		}
	},
	["crimeplus_cocaine"] = {
		time = CrimePlus.Config["Cocaine cook time"],
		needs = {
			["coca paste"] = 1,
			["caustic soda"] = 1
		}
	},
	["crimeplus_crack"] = {
		time = CrimePlus.Config["Crack cook time"],
		needs = {
			["cocaine"] = 1,
			["baking soda"] = 1
		}
	},
	["crimeplus_heroin"] = {
		time = CrimePlus.Config["Heroin cook time"],
		needs = {
			["opium"] = 3,
			["water"] = 2,
			["baking soda"] = 1,
			["vinegar"] = 1
		}
	}
}

function ENT:SetupDataTables()
	-- The client needs to know these for the display to function
	self:NetworkVar("Bool", 0, "Cooking")	
end

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self:SetCooking(false)
	self.CookingEndTime = CurTime() + 90
	self.CookingStartTime = CurTime()
	self.WhatIsCooking = "you, stupid"
	self.Ingredients = {}
end

if SERVER then
	function ENT:Touch(ent)
		if IsValid(ent) and ent.IsValidStove and ent:HasFuel() and self.Cooldown <= CurTime() and then
			if self:GetCooking() then
				if self.CookingEndTime <= CurTime() then
					self:SetCooking(false)
					for k, v in pairs(self.Recipes[self.WhatIsCooking][needs]) do
						self.Ingredients[k] = math.max(self.Ingredients[k] - v, 0)
					end
					local product = ents.Create(self.WhatIsCooking)
					product:SetPos(self:GetPos() + Vector(0, 0, 12))
					product:Spawn()
				end
			else
				for k, v in pairs(self.Recipes) do
					local good = true
					for k2, v2 in pairs(v.needs) do
						if self.Ingredients[k2] < v2 then
							good = false
							break
						end
					end
					if good then
						self:SetCooking(true)
						self.WhatIsCooking = k
						self.CookingStartTime = CurTime()
						self.CookingEndTime = CurTime() + v.time
						break
					end
				end
			end
			self.Cooldown = CurTime() + 0.2
		end
	end
	function ENT:StartTouch(ent)
		if IsValid(ent) and ent.CookingPotIngredient then
			if self.Ingredients[ent.CookingPotIngredient] then
				self.Ingredients[ent.CookingPotIngredient] = self.Ingredients[ent.CookingPotIngredient] + 1
			else
				self.Ingredients[ent.CookingPotIngredient] = 1
			end
		end
	end
end
