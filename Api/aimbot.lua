--[[⊹˚₊‧───────────────‧₊˚⊹·͙⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧͙⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧͙⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧͙⊹˚₊‧───────────────‧₊˚⊹

  ______                                   ______  __              __                  __     
 /      \                                 /      \|  \            |  \                |  \    
|  ▓▓▓▓▓▓\ ______   ______  _______      |  ▓▓▓▓▓▓\\▓▓______ ____ | ▓▓____   ______  _| ▓▓_   
| ▓▓  | ▓▓/      \ /      \|       \     | ▓▓__| ▓▓  \      \    \| ▓▓    \ /      \|   ▓▓ \  
| ▓▓  | ▓▓  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\    | ▓▓    ▓▓ ▓▓ ▓▓▓▓▓▓\▓▓▓▓\ ▓▓▓▓▓▓▓\  ▓▓▓▓▓▓\\▓▓▓▓▓▓  
| ▓▓  | ▓▓ ▓▓  | ▓▓ ▓▓    ▓▓ ▓▓  | ▓▓    | ▓▓▓▓▓▓▓▓ ▓▓ ▓▓ | ▓▓ | ▓▓ ▓▓  | ▓▓ ▓▓  | ▓▓ | ▓▓ __ 
| ▓▓__/ ▓▓ ▓▓__/ ▓▓ ▓▓▓▓▓▓▓▓ ▓▓  | ▓▓    | ▓▓  | ▓▓ ▓▓ ▓▓ | ▓▓ | ▓▓ ▓▓__/ ▓▓ ▓▓__/ ▓▓ | ▓▓|  \
 \▓▓    ▓▓ ▓▓    ▓▓\▓▓     \ ▓▓  | ▓▓    | ▓▓  | ▓▓ ▓▓ ▓▓ | ▓▓ | ▓▓ ▓▓    ▓▓\▓▓    ▓▓  \▓▓  ▓▓
  \▓▓▓▓▓▓| ▓▓▓▓▓▓▓  \▓▓▓▓▓▓▓\▓▓   \▓▓     \▓▓   \▓▓\▓▓\▓▓  \▓▓  \▓▓\▓▓▓▓▓▓▓  \▓▓▓▓▓▓    \▓▓▓▓ 
         | ▓▓                                                                                 
         | ▓▓                                                                                 
          \▓▓                                                                                 

༺☆༻____________☾✧ ✩ ✧☽____________༺☆༻༺☆༻____________☾✧ ✩ ✧☽____________༺☆༻

    ✨Universal Aim Assist Framework✨
    Release 1.9.5

    twix.cyou/pix
    twix.cyou/OpenAimbotV3rm

    Author: ttwiz_z (ttwizz) <i@twix.cyou>
    License: MIT
    GitHub: https://github.com/ttwizz/Open-Aimbot

    Issues: https://github.com/ttwizz/Open-Aimbot/issues
    Pull requests: https://github.com/ttwizz/Open-Aimbot/pulls
    Discussions: https://github.com/ttwizz/Open-Aimbot/discussions

    Wiki: https://moderka.org/Open-Aimbot

    Trustpilot: https://www.trustpilot.com/review/moderka.org

•───────•°•❀•°•───────•୧‿̩͙ ˖︵ꕀ ⠀𓏶 ̣̣̥⠀ ꕀ︵˖ ̩͙‿୨•───────•°•❀•°•───────•]]


--! Debugger

local DEBUG = false

if DEBUG then
    getfenv().getfenv = function()
        return setmetatable({}, {
            __index = function()
                return function()
                    return true
                end
            end
        })
    end
end


--! Services

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")


--! Interface Manager

local UISettings = {
    TabWidth = 160,
    Size = { 580, 460 },
    Theme = "VSC Dark High Contrast",
    Acrylic = false,
    Transparency = true,
    MinimizeKey = "RightShift",
    ShowNotifications = true,
    ShowWarnings = true,
    RenderingMode = "RenderStepped",
    AutoImport = true
}

local InterfaceManager = {}

function InterfaceManager:ImportSettings()
    pcall(function()
        if not DEBUG and getfenv().isfile and getfenv().readfile and getfenv().isfile("UISettings.ttwizz") and getfenv().readfile("UISettings.ttwizz") then
            for Key, Value in next, HttpService:JSONDecode(getfenv().readfile("UISettings.ttwizz")) do
                UISettings[Key] = Value
            end
        end
    end)
end

function InterfaceManager:ExportSettings()
    pcall(function()
        if not DEBUG and getfenv().isfile and getfenv().readfile and getfenv().writefile then
            getfenv().writefile("UISettings.ttwizz", HttpService:JSONEncode(UISettings))
        end
    end)
end

InterfaceManager:ImportSettings()

UISettings.__LAST_RUN__ = os.date()
InterfaceManager:ExportSettings()


--! Colors Handler

local ColorsHandler = {}

function ColorsHandler:PackColour(Colour)
    return typeof(Colour) == "Color3" and { R = Colour.R * 255, G = Colour.G * 255, B = Colour.B * 255 } or typeof(Colour) == "table" and Colour or { R = 255, G = 255, B = 255 }
end

function ColorsHandler:UnpackColour(Colour)
    return typeof(Colour) == "table" and Color3.fromRGB(Colour.R, Colour.G, Colour.B) or typeof(Colour) == "Color3" and Colour or Color3.fromRGB(255, 255, 255)
end


--! Configuration Importer

local ImportedConfiguration = {}

pcall(function()
    if not DEBUG and getfenv().isfile and getfenv().readfile and getfenv().isfile(string.format("%s.ttwizz", game.GameId)) and getfenv().readfile(string.format("%s.ttwizz", game.GameId)) and UISettings.AutoImport then
        ImportedConfiguration = HttpService:JSONDecode(getfenv().readfile(string.format("%s.ttwizz", game.GameId)))
        for Key, Value in next, ImportedConfiguration do
            if Key == "FoVColour" or Key == "NameESPOutlineColour" or Key == "ESPColour" then
                ImportedConfiguration[Key] = ColorsHandler:UnpackColour(Value)
            end
        end
    end
end)


--! Configuration Initializer

local Configuration = {}

--? Aimbot

Configuration.Aimbot = ImportedConfiguration["Aimbot"] or false
Configuration.OnePressAimingMode = ImportedConfiguration["OnePressAimingMode"] or false
Configuration.AimKey = ImportedConfiguration["AimKey"] or "RMB"
Configuration.AimMode = ImportedConfiguration["AimMode"] or "Camera"
Configuration.SilentAimMethods = ImportedConfiguration["SilentAimMethods"] or { "Mouse.Hit / Mouse.Target", "GetMouseLocation" }
Configuration.SilentAimChance = ImportedConfiguration["SilentAimChance"] or 100
Configuration.OffAimbotAfterKill = ImportedConfiguration["OffAimbotAfterKill"] or false
Configuration.AimPartDropdownValues = ImportedConfiguration["AimPartDropdownValues"] or { "Head", "HumanoidRootPart" }
Configuration.AimPart = ImportedConfiguration["AimPart"] or "HumanoidRootPart"
Configuration.RandomAimPart = ImportedConfiguration["RandomAimPart"] or false

Configuration.UseOffset = ImportedConfiguration["UseOffset"] or false
Configuration.OffsetType = ImportedConfiguration["OffsetType"] or "Static"
Configuration.StaticOffsetIncrement = ImportedConfiguration["StaticOffsetIncrement"] or 10
Configuration.DynamicOffsetIncrement = ImportedConfiguration["DynamicOffsetIncrement"] or 10
Configuration.AutoOffset = ImportedConfiguration["AutoOffset"] or false
Configuration.MaxAutoOffset = ImportedConfiguration["MaxAutoOffset"] or 50

Configuration.UseSensitivity = ImportedConfiguration["UseSensitivity"] or false
Configuration.Sensitivity = ImportedConfiguration["Sensitivity"] or 50
Configuration.UseNoise = ImportedConfiguration["UseNoise"] or false
Configuration.NoiseFrequency = ImportedConfiguration["NoiseFrequency"] or 50

--? Bots

Configuration.SpinBot = ImportedConfiguration["SpinBot"] or false
Configuration.OnePressSpinningMode = ImportedConfiguration["OnePressSpinningMode"] or false
Configuration.SpinKey = ImportedConfiguration["SpinKey"] or "Q"
Configuration.SpinBotVelocity = ImportedConfiguration["SpinBotVelocity"] or 50
Configuration.SpinPartDropdownValues = ImportedConfiguration["SpinPartDropdownValues"] or { "Head", "HumanoidRootPart" }
Configuration.SpinPart = ImportedConfiguration["SpinPart"] or "HumanoidRootPart"
Configuration.RandomSpinPart = ImportedConfiguration["RandomSpinPart"] or false

Configuration.TriggerBot = ImportedConfiguration["TriggerBot"] or false
Configuration.OnePressTriggeringMode = ImportedConfiguration["OnePressTriggeringMode"] or false
Configuration.SmartTriggerBot = ImportedConfiguration["SmartTriggerBot"] or false
Configuration.TriggerKey = ImportedConfiguration["TriggerKey"] or "E"
Configuration.TriggerBotChance = ImportedConfiguration["TriggerBotChance"] or 100

--? Checks

Configuration.AliveCheck = ImportedConfiguration["AliveCheck"] or false
Configuration.GodCheck = ImportedConfiguration["GodCheck"] or false
Configuration.TeamCheck = ImportedConfiguration["TeamCheck"] or false
Configuration.FriendCheck = ImportedConfiguration["FriendCheck"] or false
Configuration.FollowCheck = ImportedConfiguration["FollowCheck"] or false
Configuration.VerifiedBadgeCheck = ImportedConfiguration["VerifiedBadgeCheck"] or false
Configuration.WallCheck = ImportedConfiguration["WallCheck"] or false
Configuration.WaterCheck = ImportedConfiguration["WaterCheck"] or false

Configuration.FoVCheck = ImportedConfiguration["FoVCheck"] or false
Configuration.FoVRadius = ImportedConfiguration["FoVRadius"] or 100
Configuration.MagnitudeCheck = ImportedConfiguration["MagnitudeCheck"] or false
Configuration.TriggerMagnitude = ImportedConfiguration["TriggerMagnitude"] or 500
Configuration.TransparencyCheck = ImportedConfiguration["TransparencyCheck"] or false
Configuration.IgnoredTransparency = ImportedConfiguration["IgnoredTransparency"] or 0.5
Configuration.WhitelistedGroupCheck = ImportedConfiguration["WhitelistedGroupCheck"] or false
Configuration.WhitelistedGroup = ImportedConfiguration["WhitelistedGroup"] or 0
Configuration.BlacklistedGroupCheck = ImportedConfiguration["BlacklistedGroupCheck"] or false
Configuration.BlacklistedGroup = ImportedConfiguration["BlacklistedGroup"] or 0

Configuration.IgnoredPlayersCheck = ImportedConfiguration["IgnoredPlayersCheck"] or false
Configuration.IgnoredPlayersDropdownValues = ImportedConfiguration["IgnoredPlayersDropdownValues"] or {}
Configuration.IgnoredPlayers = ImportedConfiguration["IgnoredPlayers"] or {}
Configuration.TargetPlayersCheck = ImportedConfiguration["TargetPlayersCheck"] or false
Configuration.TargetPlayersDropdownValues = ImportedConfiguration["TargetPlayersDropdownValues"] or {}
Configuration.TargetPlayers = ImportedConfiguration["TargetPlayers"] or {}

Configuration.PremiumCheck = ImportedConfiguration["PremiumCheck"] or false

--? Visuals

Configuration.FoV = ImportedConfiguration["FoV"] or false
Configuration.FoVKey = ImportedConfiguration["FoVKey"] or "R"
Configuration.FoVThickness = ImportedConfiguration["FoVThickness"] or 2
Configuration.FoVOpacity = ImportedConfiguration["FoVOpacity"] or 0.8
Configuration.FoVFilled = ImportedConfiguration["FoVFilled"] or false
Configuration.FoVColour = ImportedConfiguration["FoVColour"] or Color3.fromRGB(255, 255, 255)

Configuration.SmartESP = ImportedConfiguration["SmartESP"] or false
Configuration.ESPKey = ImportedConfiguration["ESPKey"] or "T"
Configuration.ESPBox = ImportedConfiguration["ESPBox"] or false
Configuration.ESPBoxFilled = ImportedConfiguration["ESPBoxFilled"] or false
Configuration.NameESP = ImportedConfiguration["NameESP"] or false
Configuration.NameESPFont = ImportedConfiguration["NameESPFont"] or "Monospace"
Configuration.NameESPSize = ImportedConfiguration["NameESPSize"] or 16
Configuration.NameESPOutlineColour = ImportedConfiguration["NameESPOutlineColour"] or Color3.fromRGB(0, 0, 0)
Configuration.HealthESP = ImportedConfiguration["HealthESP"] or false
Configuration.MagnitudeESP = ImportedConfiguration["MagnitudeESP"] or false
Configuration.TracerESP = ImportedConfiguration["TracerESP"] or false
Configuration.ESPThickness = ImportedConfiguration["ESPThickness"] or 2
Configuration.ESPOpacity = ImportedConfiguration["ESPOpacity"] or 0.8
Configuration.ESPColour = ImportedConfiguration["ESPColour"] or Color3.fromRGB(255, 255, 255)
Configuration.ESPUseTeamColour = ImportedConfiguration["ESPUseTeamColour"] or false

Configuration.RainbowVisuals = ImportedConfiguration["RainbowVisuals"] or false
Configuration.RainbowDelay = ImportedConfiguration["RainbowDelay"] or 5


--! Constants

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local IsComputer = UserInputService.KeyboardEnabled and UserInputService.MouseEnabled

local MonthlyLabels = { "🎅%s❄️", "☃️%s🏂", "🌷%s☘️", "🌺%s🎀", "🐝%s🌼", "🌈%s😎", "🌞%s🏖️", "☀️%s💐", "🌦%s🍁", "🎃%s💀", "🍂%s☕", "🎄%s🎁" }
local PremiumLabels = { "💫PREMIUM💫", "✨PREMIUM✨", "🌟PREMIUM🌟", "⭐PREMIUM⭐", "🤩PREMIUM🤩" }


--! Names Handler

local function GetPlayerName(String)
    if typeof(String) == "string" and #String > 0 then
        for _, _Player in next, Players:GetPlayers() do
            if string.sub(string.lower(_Player.Name), 1, #string.lower(String)) == string.lower(String) then
                return _Player.Name
            end
        end
    end
    return ""
end


--! Fields

local Status = ""

local Fluent = nil
local ShowWarning = false

local RobloxActive = true
local Clock = os.clock()

local Aiming = false
local Target = nil
local Tween = nil
local MouseSensitivity = UserInputService.MouseDeltaSensitivity

local Spinning = false
local Triggering = false
local ShowingFoV = false
local ShowingESP = false

do
    if typeof(script) == "Instance" and script:FindFirstChild("Fluent") and script:FindFirstChild("Fluent"):IsA("ModuleScript") then
        Fluent = require(script:FindFirstChild("Fluent"))
    else
        local Success, Result = pcall(function()
            return game:HttpGet("https://twix.cyou/Fluent.txt", true)
        end)
        if Success and typeof(Result) == "string" and string.find(Result, "dawid") then
            Fluent = getfenv().loadstring(Result)()
            if Fluent.Premium then
                return getfenv().loadstring(game:HttpGet("https://twix.cyou/Aimbot.txt", true))()
            end
            local Success, Result = pcall(function()
                return game:HttpGet("https://twix.cyou/AimbotStatus.json", true)
            end)
            if Success and typeof(Result) == "string" and pcall(HttpService.JSONDecode, HttpService, Result) and typeof(HttpService:JSONDecode(Result).message) == "string" then
                Status = HttpService:JSONDecode(Result).message
            end
        else
            return
        end
    end
end

local SensitivityChanged; SensitivityChanged = UserInputService:GetPropertyChangedSignal("MouseDeltaSensitivity"):Connect(function()
    if not Fluent then
        SensitivityChanged:Disconnect()
    elseif not Aiming or not DEBUG and (getfenv().mousemoverel and IsComputer and Configuration.AimMode == "Mouse" or getfenv().hookmetamethod and getfenv().newcclosure and getfenv().checkcaller and getfenv().getnamecallmethod and Configuration.AimMode == "Silent") then
        MouseSensitivity = UserInputService.MouseDeltaSensitivity
    end
end)


--! UI Initializer

do
    local Window = Fluent:CreateWindow({
        Title = string.format("%s <b><i>%s</i></b>", string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot"), #Status > 0 and Status or "🔥FREE🔥"),
        SubTitle = "By @ttwiz_z",
        TabWidth = UISettings.TabWidth,
        Size = UDim2.fromOffset(table.unpack(UISettings.Size)),
        Theme = UISettings.Theme,
        Acrylic = UISettings.Acrylic,
        MinimizeKey = UISettings.MinimizeKey
    })

    local Tabs = { Aimbot = Window:AddTab({ Title = "Aimbot", Icon = "crosshair" }) }

    Window:SelectTab(1)

    Tabs.Aimbot:AddParagraph({
        Title = string.format("%s 🔥FREE🔥", string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot")),
        Content = "✨Universal Aim Assist Framework✨\nhttps://github.com/ttwizz/Open-Aimbot"
    })

    local AimbotSection = Tabs.Aimbot:AddSection("Aimbot")

    local AimbotToggle = AimbotSection:AddToggle("Aimbot", { Title = "Aimbot", Description = "Toggles the Aimbot", Default = Configuration.Aimbot })
    AimbotToggle:OnChanged(function(Value)
        Configuration.Aimbot = Value
        if not IsComputer then
            Aiming = Value
        end
    end)

    if IsComputer then
        local OnePressAimingModeToggle = AimbotSection:AddToggle("OnePressAimingMode", { Title = "One-Press Mode", Description = "Uses the One-Press Mode instead of the Holding Mode", Default = Configuration.OnePressAimingMode })
        OnePressAimingModeToggle:OnChanged(function(Value)
            Configuration.OnePressAimingMode = Value
        end)

        local AimKeybind = AimbotSection:AddKeybind("AimKey", {
            Title = "Aim Key",
            Description = "Changes the Aim Key",
            Default = Configuration.AimKey,
            ChangedCallback = function(Value)
                Configuration.AimKey = Value
            end
        })
        Configuration.AimKey = AimKeybind.Value ~= "RMB" and Enum.KeyCode[AimKeybind.Value] or Enum.UserInputType.MouseButton2
    end

    local AimModeDropdown = AimbotSection:AddDropdown("AimMode", {
        Title = "Aim Mode",
        Description = "Changes the Aim Mode",
        Values = { "Camera" },
        Default = Configuration.AimMode,
        Callback = function(Value)
            Configuration.AimMode = Value
        end
    })
    if getfenv().mousemoverel and IsComputer then
        table.insert(AimModeDropdown.Values, "Mouse")
        AimModeDropdown:BuildDropdownList()
    else
        ShowWarning = true
    end
    if getfenv().hookmetamethod and getfenv().newcclosure and getfenv().checkcaller and getfenv().getnamecallmethod then
        table.insert(AimModeDropdown.Values, "Silent")
        AimModeDropdown:BuildDropdownList()

        local SilentAimMethodsDropdown = AimbotSection:AddDropdown("SilentAimMethods", {
            Title = "Silent Aim Methods",
            Description = "Sets the Silent Aim Methods",
            Values = { "Mouse.Hit / Mouse.Target", "GetMouseLocation", "Raycast", "FindPartOnRay", "FindPartOnRayWithIgnoreList", "FindPartOnRayWithWhitelist" },
            Multi = true,
            Default = Configuration.SilentAimMethods
        })
        SilentAimMethodsDropdown:OnChanged(function(Value)
            Configuration.SilentAimMethods = {}
            for Key, _ in next, Value do
                if typeof(Key) == "string" then
                    table.insert(Configuration.SilentAimMethods, Key)
                end
            end
        end)

        AimbotSection:AddSlider("SilentAimChance", {
            Title = "Silent Aim Chance",
            Description = "Changes the Hit Chance for Silent Aim",
            Default = Configuration.SilentAimChance,
            Min = 1,
            Max = 100,
            Rounding = 1,
            Callback = function(Value)
                Configuration.SilentAimChance = Value
            end
        })
    else
        ShowWarning = true
    end

    local OffAimbotAfterKillToggle = AimbotSection:AddToggle("OffAimbotAfterKill", { Title = "Off After Kill", Description = "Disables the Aiming Mode after killing a Target", Default = Configuration.OffAimbotAfterKill })
    OffAimbotAfterKillToggle:OnChanged(function(Value)
        Configuration.OffAimbotAfterKill = Value
    end)

    local AimPartDropdown = AimbotSection:AddDropdown("AimPart", {
        Title = "Aim Part",
        Description = "Changes the Aim Part",
        Values = Configuration.AimPartDropdownValues,
        Default = Configuration.AimPart,
        Callback = function(Value)
            Configuration.AimPart = Value
        end
    })

    local RandomAimPartToggle = AimbotSection:AddToggle("RandomAimPart", { Title = "Random Aim Part", Description = "Selects every second a Random Aim Part from Dropdown", Default = Configuration.RandomAimPart })
    RandomAimPartToggle:OnChanged(function(Value)
        Configuration.RandomAimPart = Value
    end)

    AimbotSection:AddInput("AddAimPart", {
        Title = "Add Aim Part",
        Description = "After typing, press Enter",
        Finished = true,
        Placeholder = "Part Name",
        Callback = function(Value)
            if #Value > 0 and not table.find(Configuration.AimPartDropdownValues, Value) then
                table.insert(Configuration.AimPartDropdownValues, Value)
                AimPartDropdown:SetValue(Value)
            end
        end
    })

    AimbotSection:AddInput("RemoveAimPart", {
        Title = "Remove Aim Part",
        Description = "After typing, press Enter",
        Finished = true,
        Placeholder = "Part Name",
        Callback = function(Value)
            if #Value > 0 and table.find(Configuration.AimPartDropdownValues, Value) then
                if Configuration.AimPart == Value then
                    AimPartDropdown:SetValue(nil)
                end
                table.remove(Configuration.AimPartDropdownValues, table.find(Configuration.AimPartDropdownValues, Value))
                AimPartDro
