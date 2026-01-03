-- api/aimbot.lua
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Aimbot = {}

local Config = {
    Enabled = false,
    AimPart = "HumanoidRootPart",
    FOV = 200,
    Smoothness = 0.15,
    TeamCheck = true
}

local function GetClosestTarget()
    local closest, shortest = nil, math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(Config.AimPart) then
            if Config.TeamCheck and player.Team == LocalPlayer.Team then continue end
            local pos, onScreen = Camera:WorldToViewportPoint(player.Character[Config.AimPart].Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if dist < shortest and dist <= Config.FOV then
                    shortest = dist
                    closest = player.Character[Config.AimPart]
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if not Config.Enabled then return end
    local target = GetClosestTarget()
    if target then
        Camera.CFrame = Camera.CFrame:Lerp(
            CFrame.new(Camera.CFrame.Position, target.Position),
            Config.Smoothness
        )
    end
end)

function Aimbot:SetEnabled(v) Config.Enabled = v end
function Aimbot:SetAimPart(v) Config.AimPart = v end
function Aimbot:SetFoV(v) Config.FOV = v end
function Aimbot:SetSmoothness(v) Config.Smoothness = v end
function Aimbot:SetTeamCheck(v) Config.TeamCheck = v end

return Aimbot
