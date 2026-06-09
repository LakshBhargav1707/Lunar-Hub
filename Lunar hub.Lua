-- SHINARA HUB: PANEL FIX & FINAL INTEGRATED VERSION

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- 1. Panel ko force-load karne ka method
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShinaraHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

--------------------------------------------------
-- UI COMPONENTS (Visible = true default)
--------------------------------------------------
local Main = Instance.new("Frame", ScreenGui)
Main.Name = "MainPanel"
Main.Size = UDim2.new(0, 225, 0, 480)
Main.Position = UDim2.new(0.5, -112, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Visible = true -- Yahan se fix kiya
Instance.new("UICorner", Main)

-- Baki UI components wahi purane hain, bas TitleBar aur Scroll ko Main ke andar define rakhein.

--------------------------------------------------
-- LOGIC INTEGRATION (Stable Version)
--------------------------------------------------
local UIState = { Speed = 38, AutoGrabActive = false, InfJumpActive = false }
local connections = {}
local CurrentLoopId = 0

local function Cleanup()
    CurrentLoopId = CurrentLoopId + 1
    for _, conn in pairs(connections) do
        if conn and typeof(conn.Disconnect) == "function" then conn:Disconnect() end
    end
    connections = {}
end

local function InitializeLogic()
    Cleanup()
    local MyLoopId = CurrentLoopId
    
    local cachedChar, cachedHum = nil, nil
    local function UpdateCache()
        cachedChar = Player.Character
        cachedHum = cachedChar and cachedChar:FindFirstChild("Humanoid")
    end
    
    UpdateCache()
    Player.CharacterAdded:Connect(UpdateCache)

    -- Speed, Jump, AutoGrab logic yahan waisi hi rahegi...
    -- [Purani functional logic yahan insert karein]
end

-- Execution
pcall(function()
    InitializeLogic()
    Player.CharacterAdded:Connect(function() 
        task.wait(1) 
        InitializeLogic() 
    end)
end)
