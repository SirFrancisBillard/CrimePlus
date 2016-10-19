AddCSLuaFile()

ENT.Base = "crimeplus_base"
ENT.Type = "anim"
ENT.PrintName = "Drying Rack"
ENT.Category = "Crime+"
ENT.Spawnable = false
ENT.Model = CrimePlus.Models["Drying rack"]

function ENT:Initialize()
	self.BaseClass.Initialize(self)
end

if SERVER then
	
end
