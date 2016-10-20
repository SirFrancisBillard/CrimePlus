AddCSLuaFile()

ENT.Base = "crimeplus_base"
ENT.Type = "anim"
ENT.PrintName = "Jar"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = CrimePlus.Models["Jar"]

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Cocaine")
	self:NetworkVar("Int", 1, "Bleach")
	self:NetworkVar("Int", 2, "Water")
end

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self:SetCocaine(0)
	self:SetBleach(0)
	self:SetWater(0)
end

if SERVER then
	function ENT:StartTouch(ent)
		if IsValid(ent) then
			if ent:GetClass() == "crimeplus_cocaine" and self:GetCocaine() < 4 then
				SafeRemoveEntity(ent)
				self:SetCocaine(math.Clamp(self:GetCocaine() + 1, 0, 3))
			end
			if ent:GetClass() == "crimeplus_bleach" and self:GetBleach() < 4 then
				SafeRemoveEntity(ent)
				self:SetBleach(math.Clamp(self:GetBleach() + 1, 0, 3))
			end
			if ent:GetClass() == "crimeplus_water" and self:GetWater() < 4 then
				SafeRemoveEntity(ent)
				self:SetWater(math.Clamp(self:GetWater() + 1, 0, 3))
			end
			if ent:GetClass() == "crimeplus_cooking_pot" and self:GetCocaine() > 0 and self:GetBleach() > 0 and self:GetWater() > 0 then
				self:SetCocaine(math.Clamp(self:GetCocaine() - 1, 0, 3))
				self:SetBleach(math.Clamp(self:GetBleach() - 1, 0, 3))
				self:SetWater(math.Clamp(self:GetWater() - 1, 0, 3))
				if ent.Ingredients["cocaine"] then
					ent.Ingredients["cocaine"] = ent.Ingredients["cocaine"] + 1
				else
					ent.Ingredients["cocaine"] = 1
				end
			end
		end
	end
end
