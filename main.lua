-- main.lua
local Aimbot = require(script.api.aimbot)

-- Rayfield
local Rayfield = loadstring(game:HttpGet(
  "https://raw.githubusercontent.com/shlexware/Rayfield/main/source"
))()

local Window = Rayfield:CreateWindow({
	Name = "Bigode Aimbot",
	LoadingTitle = "Bigode Aimbot",
	LoadingSubtitle = "Framework",
	KeySystem = false
})

local AimbotTab = Window:CreateTab("Aimbot", 4483362458)

AimbotTab:CreateToggle({
	Name = "Aimbot",
	CurrentValue = false,
	Callback = function(v)
		Aimbot:SetEnabled(v)
	end
})

AimbotTab:CreateDropdown({
	Name = "Aim Part",
	Options = {"Head","HumanoidRootPart"},
	CurrentOption = "HumanoidRootPart",
	Callback = function(v)
		Aimbot:SetAimPart(v)
	end
})

AimbotTab:CreateSlider({
	Name = "FoV",
	Range = {50, 400},
	Increment = 5,
	CurrentValue = 150,
	Callback = function(v)
		Aimbot:SetFoV(v)
	end
})

AimbotTab:CreateSlider({
	Name = "Smoothness",
	Range = {0.05, 0.5},
	Increment = 0.01,
	CurrentValue = 0.15,
	Callback = function(v)
		Aimbot:SetSmoothness(v)
	end
})
