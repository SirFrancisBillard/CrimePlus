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

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.Cooking = false
	self.Ingredients = {}
end

if SERVER then
	function ENT:Touch(ent)
		if IsValid(ent) and ent.IsValidStove and ent:HasFuel() and self.Cooldown <= CurTime() then
			if not self.Cooking then
				for k, v in pairs(self.Recipes) do
					local good = true
					for k2, v2 in pairs(v.needs) do
						if self.Ingredients[k2] < v2 then
							good = false
						end
					end
					if good then
						self.Cooking = true
						self.WhatIsCooking = k
						timer.Simple(v.time, function()
							if not IsValid(self) then return end
							for k2, v2 in pairs(v.needs) do
								self.Ingredients[k2] = self.Ingredients[k2] - v2
							end
							local product = ents.Create(k)
							product:SetPos(self:GetPos() + Vector(0, 0, 12))
							product:Spawn()
						end)
					end
				end
			end
			self.Cooldown = CurTime() + 1
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
