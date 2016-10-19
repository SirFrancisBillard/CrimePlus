AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Crime+ Base Entity"
ENT.Category = "Crime+ Generic"
ENT.Spawnable = false
ENT.Model = "models/error.mdl"

self.ChildEnts = {}

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self:SetModel(self.Model)
end

if CLIENT then
	function ENT:Initialize()
		self.m_tblEnts = {}
		if not self.ChildEnts then return end
		for k, v in pairs(self.ChildEnts) do
			local ent = ClientsideModel(v.mdl, RENDERGROUP_BOTH)
			ent:SetPos(self:LocalToWorld(v.pos))
			ent:SetAngles(self:LocalToWorldAngles(v.ang))
			ent:SetParent(self)
			self.m_tblEnts[ent] = k
		end
	end

	function ENT:OnRemove()
		for k, v in pairs(self.m_tblEnts) do
			k:Remove()
		end
	end

	function ENT:Draw()
		self:DrawModel()
		if not self.ChildEnts then return end
		for k, v in pairs(self.m_tblEnts) do
			if IsValid(k) and IsValid(k:GetParent()) then break end
			if not IsValid(k) then continue end

			k:SetPos(self:LocalToWorld(childEnts[v].pos))
			k:SetAngles(self:LocalToWorldAngles(childEnts[v].ang))
			k:SetParent(self)
		end
	end
end
