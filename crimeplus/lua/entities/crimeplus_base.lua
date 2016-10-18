AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Crime+ Base Entity"
ENT.Category = "Crime+ Generic"
ENT.Spawnable = false
ENT.Model = "models/error.mdl"

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self:SetModel(self.Model)
end
