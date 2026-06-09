-- LUNAR HUB - ADVANCED UI FRAMEWORK
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

-- 2 Second Delay Load
task.wait(2)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LunarHub"
ScreenGui.Parent = PlayerGui

-- Main Panel
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 480) -- Matches width from your photo
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Title
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "LUNAR HUB"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.BackgroundTransparency = 1

-- Scrolling Content
local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, -20, 1, -40)
Scroll.Position = UDim2.new(0, 10, 0, 35)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 8)

-- Function to create Input Fields
local function CreateInput(name, default)
    local frame = Instance.new("Frame", Scroll)
    frame.Size = UDim2.new(1, 0, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 5)
    
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.Text = "  " .. name
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    
    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(0.4, 0, 0.6, 0)
    box.Position = UDim2.new(0.55, 0, 0.2, 0)
    box.Text = default
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", box)
end

-- Function to create Mode Selectors (Left/Right/Auto)
local function CreateModeSelector()
    local frame = Instance.new("Frame", Scroll)
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.BackgroundTransparency = 1
    
    local options = {"LEFT", "RIGHT", "AUTO"}
    for i, v in pairs(options) do
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0.3, 0, 1, 0)
        btn.Position = UDim2.new((i-1)*0.33, 0, 0, 0)
        btn.Text = v
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Instance.new("UICorner", btn)
    end
end

-- Function for Toggles (Features)
local function CreateToggle(name)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", btn)
end

-- Initializing UI Elements
CreateInput("SPEED", "0")
CreateInput("BEFORE CRAB", "58")
CreateInput("AFTER CRAB", "29")
CreateInput("LAGGER COUNTER SPEED", "30")
CreateModeSelector()
CreateToggle("AUTO MEDUSA")
CreateToggle("FLIGHT MODE")
CreateToggle("INFINITE JUMP")
CreateToggle("LOW GFX")
CreateToggle("OPTIMIZER")
CreateToggle("ANTI RAGDOLL")
CreateToggle("GALAXY SKY")
CreateToggle("UNWALK")
CreateToggle("NO COLLISION")
CreateToggle("FPS BOOST")
CreateToggle("AUTO BAT")
CreateToggle("LOOP AUTO STEAL")
CreateToggle("PREDICT (BETA)")

-- External Buttons logic (Reference to external GUI)
local ExternalGui = Instance.new("ScreenGui", PlayerGui)
local BatBtn = Instance.new("TextButton", ExternalGui)
BatBtn.Position = UDim2.new(0, 10, 0.5, 0)
BatBtn.Size = UDim2.new(0, 80, 0, 40)
BatBtn.Text = "BAT"

-- Draggable Logic
local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
