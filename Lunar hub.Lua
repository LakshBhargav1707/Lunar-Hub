-- SHINARA HUB (Red & Black Theme)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "ShinaraHub"

--------------------------------------------------
-- BAHAR WALE BUTTONS (Red Text & Dark Theme)
--------------------------------------------------
local ButtonContainer = Instance.new("Frame", ScreenGui)
ButtonContainer.Size = UDim2.new(0, 160, 0, 45)
ButtonContainer.Position = UDim2.new(0, 10, 0.4, 0)
ButtonContainer.BackgroundTransparency = 1

local function CreateFloatingBtn(text, xOffset)
    local btn = Instance.new("TextButton", ButtonContainer)
    btn.Size = UDim2.new(0, 50, 0, 45)
    btn.Position = UDim2.new(0, xOffset, 0, 0)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Dark Background
    btn.TextColor3 = Color3.fromRGB(255, 50, 50) -- Red Text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.3, 0)
    return btn
end

local MenuBtn = CreateFloatingBtn("≡", 0)
local BatBtn = CreateFloatingBtn("BAT", 55)
local LeftBtn = CreateFloatingBtn("LEFT", 110)

local isLeft = true
LeftBtn.MouseButton1Click:Connect(function()
    isLeft = not isLeft
    LeftBtn.Text = isLeft and "LEFT" or "X"
end)

--------------------------------------------------
-- MAIN PANEL
--------------------------------------------------
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 225, 0, 350)
Main.Position = UDim2.new(0.5, -112, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", Main)

local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "SHINARA HUB"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Position = UDim2.new(0, 0, 0, 30)
Scroll.Size = UDim2.new(1, 0, 1, -30)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 4
Scroll.CanvasSize = UDim2.new(0, 0, 0, 400)

--------------------------------------------------
-- PANEL CONTENTS (RED TEXT)
--------------------------------------------------
local function CreateBox(title,y,value)
    local Label = Instance.new("TextLabel", Scroll)
    Label.Position = UDim2.new(0.05,0,0,y); Label.Size = UDim2.new(0.9,0,0,16)
    Label.Text = title; Label.TextColor3 = Color3.fromRGB(255, 50, 50); Label.Font = Enum.Font.Gotham; Label.TextSize = 11; Label.BackgroundTransparency = 1
    local Box = Instance.new("TextBox", Scroll)
    Box.Position = UDim2.new(0.05,0,0,y+18); Box.Size = UDim2.new(0.9,0,0,28)
    Box.Text = value; Box.BackgroundColor3 = Color3.fromRGB(35, 35, 35); Box.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", Box)
end

CreateBox("Speed Control", 10, "0")
CreateBox("Before Grab Speed", 70, "38")
CreateBox("After Grab Speed", 130, "38")

-- Auto/Manual Button
local ModeBtn = Instance.new("TextButton", Scroll)
ModeBtn.Size = UDim2.new(0, 200, 0, 28); ModeBtn.Position = UDim2.new(0.05, 0, 0, 200)
ModeBtn.Text = "AUTO GRAB"; ModeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); ModeBtn.TextColor3 = Color3.fromRGB(255, 50, 50); ModeBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", ModeBtn)

ModeBtn.MouseButton1Click:Connect(function()
    ModeBtn.Text = (ModeBtn.Text == "AUTO GRAB") and "MANUAL" or "AUTO GRAB"
end)

--------------------------------------------------
-- DRAG LOGIC
--------------------------------------------------
MenuBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
local dragging, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; dragStart = input.Position; startPos = Main.Position end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
