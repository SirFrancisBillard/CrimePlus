AddCSLuaFile()

ENT.Base = "crimeplus_base"
ENT.Type = "anim"
ENT.PrintName = "Crime+ Base Market"
ENT.Category = "Crime+ Goods"
ENT.Spawnable = false
ENT.Model = "models/error.mdl"
ENT.MarketData = {Price = 250, Dealer = "crimeplus_dealer_drug", Color = Color(255, 0, 0)}

function ENT:Initialize()
	self.BaseClass.Initialize(self)
end

if SERVER then
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			for k, v in pairs(ents.FindInSphere(self:GetPos(), 128)) do
				if v:GetClass() == self.MarketData.Dealer then
					-- This next line gave me aids
					caller:SendLua("chat.AddText(Color(255, 255, 255), 'You have sold', Color(" .. self.MarketData.Color.r .. ", " .. self.MarketData.Color.g .. ", " .. self.MarketData.Color.b .. "), ' " .. self.PrintName .. " ', Color(255, 255, 255), 'for ', Color(0, 255, 0), '$', string.Comma('" .. self.MarketData.Price .. "'))")
					caller:addMoney(self.MarketData.Price)
					SafeRemoveEntity(self)
					return
				end
			end
		end
	end
end
