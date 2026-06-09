-- SHINARA HUB: PERFORMANCE OPTIMIZED (CACHED VERSION)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

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

local function InitializeScript()
    Cleanup()
    local MyLoopId = CurrentLoopId
    
    -- Caching Character and Humanoid
    local cachedChar, cachedHum = nil, nil
    local function UpdateCache()
        cachedChar = Player.Character
        cachedHum = cachedChar and cachedChar:FindFirstChild("Humanoid")
    end
    
    UpdateCache()
    Player.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid")
        UpdateCache()
    end)

    -- 1. Speed Mechanism (Direct Cache use)
    local hb = RunService.Heartbeat:Connect(function()
        if cachedHum and cachedHum.WalkSpeed ~= UIState.Speed then
            cachedHum.WalkSpeed = math.clamp(UIState.Speed, 0, 100)
        end
    end)
    table.insert(connections, hb)

    -- 2. Inf Jump Mechanism
    local jr = UIS.JumpRequest:Connect(function()
        if cachedHum and UIState.InfJumpActive then 
            cachedHum:ChangeState(Enum.HumanoidStateType.Jumping) 
        end
    end)
    table.insert(connections, jr)

    -- 3. Auto Grab Mechanism (Cached check)
    task.spawn(function()
        while MyLoopId == CurrentLoopId do
            if UIState.AutoGrabActive and cachedChar and cachedHum and cachedHum.Health > 0 then
                local tool = cachedChar:FindFirstChild("Bat")
                if tool and tool:IsA("Tool") then 
                    tool:Activate() 
                end
            end
            task.wait(0.1)
        end
    end)

    return {
        SetSpeed = function(v) UIState.Speed = math.clamp(tonumber(v) or 38, 0, 100) end,
        SetInfJump = function(s) UIState.InfJumpActive = s end,
        SetAutoGrab = function(s) UIState.AutoGrabActive = s end,
        EquipBat = function()
            local tool = Player.Backpack:FindFirstChild("Bat") or (cachedChar and cachedChar:FindFirstChild("Bat"))
            if tool and cachedHum then cachedHum:EquipTool(tool) end
        end
    }
end

-- Initialize
local Controls = InitializeScript()
Player.CharacterAdded:Connect(function() 
    task.wait(0.5)
    Controls = InitializeScript() 
end)
