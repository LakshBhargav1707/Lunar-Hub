-- [[ Lunar Hub | Undetected — Performance Optimized Edition ]] --
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local TargetGuiParent = CoreGui -- Direct Injection

-- Clean Up
pcall(function() if TargetGuiParent:FindFirstChild("LunarHub") then TargetGuiParent:FindFirstChild("LunarHub"):Destroy() end end)

local Config = {
    NormalSpeed = 16,
    BeforeGrabSpeed = 50, -- Increased default
    AfterGrabSpeed = 60,  -- Increased default
    CurrentDirection = "Right", 
    AutoplayActive = false,
    AutoLoopSteal = false,
    AutoBat = false,
    InfiniteJump = false,
    NightVision = false
}

-- [[ UI ENGINE ]] --
local MainGui = Instance.new("ScreenGui", TargetGuiParent)
MainGui.Name = "LunarHub"
local MainFrame = Instance.new("Frame", MainGui)
MainFrame.Size = UDim2.new(0, 210, 0, 345)
MainFrame.Position = UDim2.new(0.5, -105, 0.5, -172)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, 0, 1, 0)
Container.BackgroundTransparency = 1
Instance.new("UIListLayout", Container).Padding = UDim.new(0, 5)

-- Removed Input Limits
local function createInput(default, key)
    local box = Instance.new("TextBox", Container)
    box.Size = UDim2.new(0.9, 0, 0, 30)
    box.Text = tostring(default)
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    box.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", box)
    box.FocusLost:Connect(function() Config[key] = tonumber(box.Text) or 50 end)
end

createInput(50, "BeforeGrabSpeed")
createInput(60, "AfterGrabSpeed")

-- [[ PHYSICS CORE (NO-RESET ENGINE) ]] --
local BodyVelocity = Instance.new("BodyVelocity")
BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * 1e6 -- High force but stable

RunService.Heartbeat:Connect(function()
    local Character = LocalPlayer.Character
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        local RootPart = Character.HumanoidRootPart
        
        if Config.AutoplayActive or Config.AutoBat then
            BodyVelocity.Parent = RootPart
            local speed = (Character:FindFirstChild("Brainrot") or LocalPlayer.Backpack:FindFirstChild("Brainrot")) and Config.AfterGrabSpeed or Config.BeforeGrabSpeed
            BodyVelocity.Velocity = (Config.CurrentDirection == "Right" and RootPart.CFrame.RightVector or -RootPart.CFrame.RightVector) * speed
        else
            BodyVelocity.Parent = nil
        end
    end
end)

print("Lunar Hub | Undetected Loaded - Physics Limits Removed")
