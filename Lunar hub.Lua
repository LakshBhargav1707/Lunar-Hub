-- LUNAR HUB (Compact Floating Buttons & Fixed Logic)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "LunarHub"
ScreenGui.ResetOnSpawn = false

--------------------------------------------------
-- COMPACT FLOATING BUTTONS (Container for alignment)
--------------------------------------------------
local ButtonContainer = Instance.new("Frame", ScreenGui)
ButtonContainer.Size = UDim2.new(0, 160, 0, 45)
ButtonContainer.Position = UDim2.new(0, 10, 0.5, -22)
ButtonContainer.BackgroundTransparency = 1

local function CreateFloatingBtn(name, xOffset, text)
    local btn = Instance.new("TextButton", ButtonContainer)
    btn.Size = UDim2.new(0, 50, 0, 45)
    btn.Position = UDim2.new(0, xOffset, 0, 0)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.3, 0)
    return btn
end

local MenuBtn = CreateFloatingBtn("Menu", 0, "≡")
local BatBtn = CreateFloatingBtn("Bat", 55, "BAT")
local SideBtn = CreateFloatingBtn("Side", 110, "LEFT")

--------------------------------------------------
-- MAIN PANEL
--------------------------------------------------
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 225, 0, 380)
Main.Position = UDim2.new(0.5, -112, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main)

local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "LUNAR HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Position = UDim2.new(0, 0, 0, 30)
Scroll.Size = UDim2.new(1, 0, 1, -30)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 4
Scroll.CanvasSize = UDim2.new(0, 0, 0, 500)

--------------------------------------------------
-- UI FUNCTIONS (Same Design)
--------------------------------------------------
local function CreateBox(title,y,value)
    local Label = Instance.new("TextLabel", Scroll)
    Label.Position = UDim2.new(0.05,0,0,y); Label.Size = UDim2.new(0.9,0,0,16)
    Label.Text = title; Label.TextColor3 = Color3.new(1,1,1); Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham; Label.TextSize = 11; Label.BackgroundTransparency = 1
    local Box = Instance.new("TextBox", Scroll)
    Box.Position = UDim2.new(0.05,0,0,y+18); Box.Size = UDim2.new(0.9,0,0,28)
    Box.Text = value; Box.BackgroundColor3 = Color3.fromRGB(35,35,50); Instance.new("UICorner", Box)
end

CreateBox("Speed Control", 35, "0")
CreateBox("Before Grab Speed", 95, "38")
CreateBox("After Grab Speed", 155, "38")

-- Mode Buttons
local LeftBtn = Instance.new("TextButton", Scroll)
local RightBtn = Instance.new("TextButton", Scroll)
local AutoGrabBtn = Instance.new("TextButton", Scroll)

local function StyleButton(btn, x, text)
    btn.Size = UDim2.new(0,65,0,28); btn.Position = UDim2.new(x,0,0,240)
    btn.Text = text; btn.BackgroundColor3 = Color3.fromRGB(35,35,50); Instance.new("UICorner", btn)
end

StyleButton(LeftBtn, 0.05, "LEFT")
StyleButton(RightBtn, 0.37, "RIGHT")
StyleButton(AutoGrabBtn, 0.69, "AUTO GRAB")

-- Logic for Left/X toggle
local isLeft = true
LeftBtn.MouseButton1Click:Connect(function()
    isLeft = not isLeft
    SideBtn.Text = isLeft and "LEFT" or "X"
    LeftBtn.Text = isLeft and "LEFT" or "X"
end)

RightBtn.MouseButton1Click:Connect(function() SideBtn.Text = "RIGHT"; isLeft = false; LeftBtn.Text = "LEFT" end)

AutoGrabBtn.MouseButton1Click:Connect(function()
    AutoGrabBtn.Text = (AutoGrabBtn.Text == "AUTO GRAB") and "MANUAL" or "AUTO GRAB"
    AutoGrabBtn.BackgroundColor3 = (AutoGrabBtn.Text == "MANUAL") and Color3.fromRGB(130,70,255) or Color3.fromRGB(35,35,50)
end)

--------------------------------------------------
-- MINIMIZE & DRAGGING (TitleBar Only)
--------------------------------------------------
MenuBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

local dragging, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = Main.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
