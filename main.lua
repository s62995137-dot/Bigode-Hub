--[[ 
    BIGODE HUB - MAIN LOADER
    Author: Bigode
    GitHub: https://github.com/s62995137-dot/Bigode-Hub
]]

--// Proteção básica
if not game:IsLoaded() then
    game.Loaded:Wait()
end

--// Serviços
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--// Função de require seguro
local function SafeRequire(moduleScript, name)
    local success, result = pcall(require, moduleScript)
    if not success then
        warn("[Bigode Hub] Erro ao carregar:", name)
        warn(result)
        return nil
    end
    return result
end

--// Referências da estrutura
local Root = script
local ApiFolder = Root:WaitForChild("api")
local UiFolder = Root:WaitForChild("ui")

--// Carregar módulos
local Aimbot = SafeRequire(ApiFolder:WaitForChild("aimbot"), "Aimbot")
local RayfieldUI = SafeRequire(UiFolder:WaitForChild("rayfield"), "Rayfield UI")

if not Aimbot or not RayfieldUI then
    warn("[Bigode Hub] Falha ao iniciar o hub.")
    return
end

--// Inicializar Interface
task.spawn(function()
    RayfieldUI(Aimbot)
end)

--// Log
print("[Bigode Hub] Carregado com sucesso!")
