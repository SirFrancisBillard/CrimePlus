AddCSLuaFile()

ENT.Base = "crimeplus_base"
ENT.Type = "anim"
ENT.PrintName = "Raw Weed"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = CrimePlus.Models["Weed raw"]

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self:SetProgress(0)
	self:SetDry(false)
	self:SetMaterial(Material("models/antlion/antlion_innards"))
	self:SetColor(Color(0, 58, 12))
end

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Cooldown")
	self:NetworkVar("Int", 1, "Progress")
	self:NetworkVar("Bool", 0, "Dry")
end

if SERVER then
	function ENT:Touch(ent)
		if IsValid(ent) and ent:GetClass() == "crimeplus_drying_rack" and self:GetCooldown() <= CurTime() and not self:GetDry() then
			self:SetProgress(self:GetProgress() + 1)
			if self:GetProgress() >= CrimePlus.Config["Weed dry time"] then
				self:SetDry(true)
			end
			self:SetCooldown(CurTime() + 1)
		end
	end
	function ENT:StartTouch(ent)
		if IsValid(ent) and ent:GetClass() == "crimeplus_grinder" and self:GetDry() and ent:GetWeed() < 4 then
			ent:SetWeed(ent:GetWeed() + 1)
			SafeRemoveEntity(self)
		end
	end
	function ENT:Think()
		self:SetMaterial(Material("models/antlion/antlion_innards"))
		if self:GetDry() then
			self:SetColor(Color(0, 240, 50))
		else
			self:SetColor(Color(0, 58, 12))
		end
		self:NextThink(CurTime() + 0.1)
		return true
	end
end
