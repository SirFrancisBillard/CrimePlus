AddCSLuaFile()

ENT.Base = "crimeplus_base"
ENT.Type = "anim"
ENT.PrintName = "Trimmer"
ENT.Category = "Crime+"
ENT.Spawnable = false
ENT.Model = CrimePlus.Models["Trimmer"]

self.ChildEnts = {
	{
		ang	= Angle(-0.011, -2.769, -0.005),
		mdl	= "models/props_c17/grinderclamp01a.mdl",
		pos	= Vector(-0.063179, -24.012234, 11.650133),
	},
}

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Weed")
	self:NetworkVar("Int", 1, "Coca")
	self:NetworkVar("Bool", 1, "Trimming")
end

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self:SetWeed(0)
	self:SetCoca(0)
	self:SetTrimming(false)
end

if SERVER then
	function ENT:Think()
		if not self:GetTrimming() then
			if self:GetCoca() > 0 then
				self:SetCoca(math.max(self:GetCoca() - 1, 0))
				timer.Simple(CrimePlus.Config["Cocaine trim time"], function()
					if not IsValid(self) then return end
					local coke = ents.Create("crimeplus_coca_paste")
					coke:SetPos(self:GetPos() + Vector(0, 0, 8))
					coke:Spawn()
				end)
			elseif self:GetWeed() > 0 then
				self:SetWeed(math.max(self:GetWeed() - 1, 0))
				timer.Simple(CrimePlus.Config["Weed trim time"], function()
					if not IsValid(self) then return end
					for i = 1, CrimePlus.Config["Weed bags given"] do
						timer.Simple(i / 5, function()
							local weed = ents.Create("crimeplus_cannabis")
							weed:SetPos(self:GetPos() + Vector(0, 0, 8))
							weed:Spawn()
						end)
					end
				end)
			end
		end
		self:NextThink(CurTime() + 1)
		return true
	end
end
