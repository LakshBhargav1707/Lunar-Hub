--[[
    SHINARA HUB - OFFICIAL SOURCE CODE
    Version: 1.0.0
    Description: Optimized & Respawn-Safe Script
--]]

-- Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Global States
local UIState = { Speed = 38, AutoGrabActive = false, InfJumpActive = false }
local connections = {}
local CurrentLoopId = 0

-- UI Initialization
local function CreateUI()
    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "ShinaraHub"
    ScreenGui.ResetOnSpawn = false

    local Main = Instance.new("Frame", ScreenGui)
    Main.Name = "MainPanel"
    Main.Size = UDim2.new(0, 225, 0, 480)
    Main.Position = UDim2.new(0.5, -112, 0.5, -240)
    Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Main.Visible = true
    Instance.new("UICorner", Main)
    
    return Main
end

local MainPanel = CreateUI()

-- Logic Cleanup
local function Cleanup()
    CurrentLoopId = CurrentLoopId + 1
    for _, conn in pairs(connections) do
        if conn and typeof(conn.Disconnect) == "function" then conn:Disconnect() end
    end
    connections = {}
end

-- Core Engine
local function InitializeScript()
    Cleanup()
    local MyLoopId = CurrentLoopId
    
    local cachedChar, cachedHum = nil, nil
    local function UpdateCache()
        cachedChar = Player.Character
        cachedHum = cachedChar and cachedChar:FindFirstChild("Humanoid")
    end
    
    UpdateCache()
    Player.CharacterAdded:Connect(UpdateCache)

    -- Speed Control
    local hb = RunService.Heartbeat:Connect(function()
        if cachedHum and cachedHum.WalkSpeed ~= UIState.Speed then
            cachedHum.WalkSpeed = math.clamp(UIState.Speed, 0, 100)
        end
    end)
    table.insert(connections, hb)

    -- Infinite Jump
    local jr = UIS.JumpRequest:Connect(function()
        if cachedHum and UIState.InfJumpActive then 
            cachedHum:ChangeState(Enum.HumanoidStateType.Jumping) 
        end
    end)
    table.insert(connections, jr)

    -- Auto Grab Logic
    task.spawn(function()
        while MyLoopId == CurrentLoopId do
            if UIState.AutoGrabActive and cachedChar and cachedHum and cachedHum.Health > 0 then
                local tool = cachedChar:FindFirstChild("Bat")
                if tool and tool:IsA("Tool") then tool:Activate() end
            end
            task.wait(0.1)
        end
    end)
end

-- Start
InitializeScript()
Player.CharacterAdded:Connect(function() 
    task.wait(1) 
    InitializeScript() 
end)

print("Shinara Hub initialized successfully.")
