-- Lunar Hub (Steal A Brainrot Duel Edition - No Speed Limits V6)
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("LunarHub") then
        game:GetService("CoreGui"):FindFirstChild("LunarHub"):Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LunarHub"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 280, 0, 500)
Frame.Position = UDim2.new(0.5, -140, 0.5, -250)
Frame.BackgroundColor3 = Color3.fromRGB(18,18,24)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,12)

-- [[ CONFIGURATION VALUES ]] --
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    RootPart = newChar:WaitForChild("HumanoidRootPart")
end)

local Config = {
    Speed = 32,
    BeforeGrab = 45, -- No limits
    AfterGrab = 35,  -- No limits
    Side = "Left",
    Mode = "AutoPlay",
    AutoLoopSteal = false,
    AutoBat = false,
    InfiniteJump = false
}

-- Check if holding Brainrot
local function checkBrainrot()
    if Character then
        return Character:FindFirstChild("Brainrot") or LocalPlayer.Backpack:FindFirstChild("Brainrot") or 
               Character:FindFirstChild("brainrot") or LocalPlayer.Backpack:FindFirstChild("brainrot")
    end
    return false
end

-- [[ AUTO GRAB LOGIC ]] --
local function autoGrabBrainrots()
    if Character and RootPart and not checkBrainrot() then
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Tool") and (obj.Name:lower() == "brainrot" or obj:FindFirstChild("Handle")) then
                local handle = obj:FindFirstChild("Handle") or obj
                if handle:IsA("BasePart") then
                    local distance = (RootPart.Position - handle.Position).Magnitude
                    if distance < 25 then
                        local savedCFrame = RootPart.CFrame
                        RootPart.CFrame = handle.CFrame
                        task.wait(0.05)
                        RootPart.CFrame = savedCFrame
                        break
                    end
                end
            end
        end
    end
end

local function createLabel(text, y)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = Frame
    lbl.Position = UDim2.new(0,15,0,y)
    lbl.Size = UDim2.new(0,120,0,30)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 16
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return lbl
end

local function createBox(default, y, configKey)
    local box = Instance.new("TextBox")
    box.Parent = Frame
    box.Position = UDim2.new(0,150,0,y)
    box.Size = UDim2.new(0,110,0,30)
    box.BackgroundColor3 = Color3.fromRGB(30,30,40)
    box.TextColor3 = Color3.new(1,1,1)
    box.PlaceholderText = default
    box.Text = default
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)
    
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val then
            Config[configKey] = val
        end
    end)
    return box
end

local Title = createLabel("Lunar Hub", 10)
Title.TextColor3 = Color3.fromRGB(170,85,255)
