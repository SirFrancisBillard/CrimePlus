AddCSLuaFile()

ENT.Base = "crimeplus_base"
ENT.Type = "anim"
ENT.PrintName = "Weed Pot"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = CrimePlus.Models["Weed pot"]

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self:SetStage(0)
end

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Stage")
	self:NetworkVar("Bool", 0, "Fertilizer")
	self:NetworkVar("Bool", 1, "Soil")
	self:NetworkVar("Bool", 2, "Water")
	self:NetworkVar("Bool", 3, "Seed")
	self:NetworkVar("Bool", 4, "Growing")
end

if SERVER then
	function ENT:Touch(ent)
		if ent:GetClass() == "crimeplus_ingredient_soil" and not self:GetSoil() then
			SafeRemoveEntity(ent)
			self:SetSoil(true)
		end
		if ent:GetClass() == "crimeplus_ingredient_fertilizer" and self:CanFertilize() and not self:GetFertilizer() and self:GetSoil() then
			SafeRemoveEntity(ent)
			self:SetFertilizer(true)
		end
		if ent:GetClass() == "crimeplus_ingredient_water" and not self:GetWater() and self:GetSoil() then
			SafeRemoveEntity(ent)
			self:SetWater(true)
		end
		if ent:GetClass() == "crimeplus_ingredient_weedseed" and not self:GetSeed() and self:GetSoil() then
			SafeRemoveEntity(ent)
			self:SetSeed(true)
		end
	end
	function ENT:Think()
		if self:GetSoil() and self:GetSeed() and self:GetWater() then
			self.GrowTime = CrimePlus.Config["Weed grow time"]
			if self:GetFertilizer() then
				self.GrowTime = CrimePlus.Config["Weed grow time with fertilizer"]
			end
			self.Interval = math.floor(self.GrowTime / 7)
			for i = 1, 7, self.Interval do
				timer.Simple(self.Interval * i, function()
					if not IsValid(self) then return end
					self:SetStage(math.Clamp(self:GetStage() + 1, 1, 7))
				end)
			end
		end
		if self:GetStage() < 1 then
			if self:GetSoil() and not self:GetSeed() then
				self:SetModel(CrimePlus.Models["Weed pot soil"])
			elseif self:GetSoil() and self:GetSeed() then
				self:SetModel(CrimePlus.Models["Weed pot planted"])
			elseif not self:GetSoil() then
				self:SetModel(CrimePlus.Models["Weed pot"])
			end
		else
			self:SetModel(CrimePlus.Models["Weed stage " .. self:GetStage()])
		end
		self:NextThink(CurTime() + 0.1)
		return true
	end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() and self:GetStage() == 7 then
			self:SetStage(1)
			local weed = ents.Create("crimeplus_weed")
			weed:SetPos(self:GetPos() + Vector(0, 0, 16))
			weed:Spawn()
		end
	end
end
