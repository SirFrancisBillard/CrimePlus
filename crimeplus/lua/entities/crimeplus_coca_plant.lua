AddCSLuaFile()

ENT.Base = "crimeplus_base"
ENT.Type = "anim"
ENT.PrintName = "Coca plant"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = CrimePlus.Models["Coca plant"]

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self:SetStage(0)
	self:SetWater(false)
	self:SetGrowing(false)
end

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Stage")
	self:NetworkVar("Bool", 0, "Water")
	self:NetworkVar("Bool", 1, "Growing")
end

if SERVER then
	function ENT:StartTouch(ent)
		if ent:GetClass() == "crimeplus_ingredient_water" and not self:GetWater() and self:GetSoil() then
			SafeRemoveEntity(ent)
			self:SetWater(true)
		end
	end
	function ENT:Think()
		self:SetBodygroup(1, self:GetStage())
		self:NextThink(CurTime() + 0.1)
		return true
	end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() and self:GetStage() > 0 then
			self:SetStage(math.Clamp(self:GetStage() - 1, 0, 2))
			local leaves = ents.Create("crimeplus_coca_leaves")
			leaves:SetPos(self:GetPos() + Vector(0, 0, 16))
			leaves:Spawn()
		end
	end
end
