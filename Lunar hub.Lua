-- [[ Lunar Hub | Undetected V18.0 Cleaned ]] --
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local TargetGuiParent = CoreGui

-- Clean Up
pcall(function()
    if TargetGuiParent:FindFirstChild("LunarHub") then TargetGuiParent:FindFirstChild("LunarHub"):Destroy() end
    if TargetGuiParent:FindFirstChild("LunarMobileUI") then TargetGuiParent:FindFirstChild("LunarMobileUI"):Destroy() end
end)

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    RootPart = newChar:WaitForChild("HumanoidRootPart")
end)

local Config = {
    BeforeGrabSpeed = 38, 
    AfterGrabSpeed = 40,  
    CurrentDirection = "Right", 
    AutoplayActive = false,
    AutoLoopSteal = false,
    AutoBat = false,
    InfiniteJump = false
}

-- [[ UI SYSTEM ]] --
local MainGui = Instance.new("ScreenGui", TargetGuiParent)
MainGui.Name = "LunarHub"
local MainFrame = Instance.new("Frame", MainGui)
MainFrame.Size = UDim2.new(0, 210, 0, 250)
MainFrame.Position = UDim2.new(0.5, -105, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Active = true
MainFrame.Draggable = true 
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(55, 45, 90)

local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, -20, 1, -20)
Container.Position = UDim2.new(0, 10, 0, 10)
Container.BackgroundTransparency = 1
Instance.new("UIListLayout", Container).Padding = UDim.new(0, 5)

local function createInput(text, key)
    Instance.new("TextLabel", Container).Text = text:upper()
    local box = Instance.new("TextBox", Container)
    box.Size = UDim2.new(1, 0, 0, 30)
    box.Text = tostring(Config[key])
    box.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    box.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", box)
    box.FocusLost:Connect(function() Config[key] = tonumber(box.Text) or 40 end)
end

createInput("Before Grab Speed", "BeforeGrabSpeed")
createInput("After Grab Speed", "AfterGrabSpeed")

-- [[ PHYSICS CORE (STABLE) ]] --
local VelocityPart = Instance.new("LinearVelocity")
local Attachment = Instance.new("Attachment")

RunService.Heartbeat:Connect(function()
    if Character and RootPart and Humanoid.Health > 0 then
        if Config.AutoplayActive or Config.AutoBat then
            Attachment.Parent = RootPart
            VelocityPart.Attachment0 = Attachment
            VelocityPart.MaxForce = Vector3.new(1,1,1) * 1e6
            VelocityPart.Parent = RootPart
            
            local speed = (Character:FindFirstChild("Brainrot") or LocalPlayer.Backpack:FindFirstChild("Brainrot")) and Config.AfterGrabSpeed or Config.BeforeGrabSpeed
            local direction = (Config.CurrentDirection == "Right" and RootPart.CFrame.RightVector or -RootPart.CFrame.RightVector)
            VelocityPart.VectorVelocity = direction * speed
        else
            VelocityPart.Parent = nil
        end
    end
end)

-- [[ BAT TRACKER ]] --
task.spawn(function()
    while true do
        task.wait(0.01)
        if Config.AutoBat and RootPart and Humanoid.Health > 0 then
            local target = nil
            local dist = math.huge
            for _, pl in pairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                    local d = (RootPart.Position - pl.Character.HumanoidRootPart.Position).Magnitude
                    if d < dist then dist = d target = pl.Character.HumanoidRootPart end
                end
            end
            if target then
                RootPart.CFrame = CFrame.lookAt(RootPart.Position, target.Position)
                local tool = Character:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                if tool then tool.Parent = Character pcall(function() tool:Activate() end) end
            end
        end
    end
end)

print("Lunar Hub | Cleaned & Fixed!")
