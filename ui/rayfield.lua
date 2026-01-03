-- ui/rayfield.lua
return function(Aimbot)
    local Rayfield = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/shlexware/Rayfield/main/source"
    ))()

    local Window = Rayfield:CreateWindow({
        Name = "Bigode Hub",
        KeySystem = false
    })

    local Tab = Window:CreateTab("Aimbot", 4483362458)

    Tab:CreateToggle({
        Name = "Ativar Aimbot",
        CurrentValue = false,
        Callback = function(v)
            Aimbot:SetEnabled(v)
        end
    })

    Tab:CreateDropdown({
        Name = "Aim Part",
        Options = {"Head","HumanoidRootPart"},
        CurrentOption = "HumanoidRootPart",
        Callback = function(v)
            Aimbot:SetAimPart(v)
        end
    })

    Tab:CreateSlider({
        Name = "FOV",
        Range = {50,500},
        Increment = 10,
        CurrentValue = 200,
        Callback = function(v)
            Aimbot:SetFoV(v)
        end
    })

    Tab:CreateSlider({
        Name = "Smooth",
        Range = {0.05,1},
        Increment = 0.05,
        CurrentValue = 0.15,
        Callback = function(v)
            Aimbot:SetSmoothness(v)
        end
    })
end
