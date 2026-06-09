-- SHINARA HUB (Original UI Design - Red/Black Theme)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShinaraHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

--------------------------------------------------
-- FLOATING BUTTONS (Red/Black Theme)
--------------------------------------------------
local function StyleRedBtn(btn)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.TextColor3 = Color3.fromRGB(255, 50, 50)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn)
end

local MenuBtn = Instance.new("TextButton", ScreenGui)
MenuBtn.Size = UDim2.new(0,45,0,45); MenuBtn.Position = UDim2.new(0,10,0.5,-54); MenuBtn.Text = "≡"
StyleRedBtn(MenuBtn)

local BatBtn = Instance.new("TextButton", ScreenGui)
BatBtn.Size = UDim2.new(0,38,0,32); BatBtn.Position = UDim2.new(0,55,0.5,-54); BatBtn.Text = "BAT"
StyleRedBtn(BatBtn)

local LeftBtn = Instance.new("TextButton", ScreenGui)
LeftBtn.Size = UDim2.new(0,45,0,32); LeftBtn.Position = UDim2.new(0,98,0.5,-54); LeftBtn.Text = "LEFT"
StyleRedBtn(LeftBtn)

-- Left button logic (X change)
local isLeft = true
LeftBtn.MouseButton1Click:Connect(function()
    isLeft = not isLeft
    LeftBtn.Text = isLeft and "LEFT" or "X"
end)

--------------------------------------------------
-- MAIN PANEL (Red/Black Theme)
--------------------------------------------------
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,225,0,380); Main.Position = UDim2.new(0.5,-112,0.5,-190)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Main.BorderSizePixel = 0
Instance.new("UICorner", Main)

local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1,0,0,30); TitleBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1,0,1,0); Title.Text = "SHINARA HUB"; Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.Font = Enum.Font.GothamBold; Title.TextSize = 16; Title.BackgroundTransparency = 1

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Position = UDim2.new(0,0,0,30); Scroll.Size = UDim2.new(1,0,1,-30); Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 4; Scroll.CanvasSize = UDim2.new(0,0,0,500)

--------------------------------------------------
-- CONTENT
--------------------------------------------------
local function CreateBox(title,y,value)
    local Label = Instance.new("TextLabel", Scroll)
    Label.Position = UDim2.new(0.05,0,0,y); Label.Size = UDim2.new(0.9,0,0,16)
    Label.Text = title; Label.TextColor3 = Color3.fromRGB(255, 50, 50); Label.Font = Enum.Font.Gotham; Label.TextSize = 11; Label.BackgroundTransparency = 1
    local Box = Instance.new("TextBox", Scroll)
    Box.Position = UDim2.new(0.05,0,0,y+18); Box.Size = UDim2.new(0.9,0,0,28)
    Box.Text = value; Box.BackgroundColor3 = Color3.fromRGB(35, 35, 35); Box.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", Box)
end

CreateBox("Speed Control", 35, "0")
CreateBox("Before Grab Speed", 95, "38")
CreateBox("After Grab Speed", 155, "38")

-- Auto Grab Button
local AutoGrabBtn = Instance.new("TextButton", Scroll)
AutoGrabBtn.Size = UDim2.new(0, 200, 0, 28); AutoGrabBtn.Position = UDim2.new(0.05, 0, 0, 240)
AutoGrabBtn.Text = "AUTO GRAB"; AutoGrabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); AutoGrabBtn.TextColor3 = Color3.fromRGB(255, 50, 50); AutoGrabBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", AutoGrabBtn)

AutoGrabBtn.MouseButton1Click:Connect(function()
    AutoGrabBtn.Text = (AutoGrabBtn.Text == "AUTO GRAB") and "MANUAL" or "AUTO GRAB"
end)

-- Toggles
local function CreateToggle(name, y)
    local state = false
    local Btn = Instance.new("TextButton", Scroll)
    Btn.Position = UDim2.new(0.05, 0, 0, y); Btn.Size = UDim2.new(0.9, 0, 0, 28)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); Btn.Text = name.." : OFF"; Btn.TextColor3 = Color3.fromRGB(255, 50, 50)
    Btn.Font = Enum.Font.GothamBold; Instance.new("UICorner", Btn)
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.Text = name..(state and " : ON" or " : OFF")
    end)
end

CreateToggle("INFINITE JUMP", 305)
CreateToggle("AUTO GRAB", 340)

--------------------------------------------------
-- DRAG & MINIMIZE
--------------------------------------------------
MenuBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

local dragging, dragStart, startPos
TitleBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; dragStart = i.Position; startPos = Main.Position end end)
UIS.InputChanged:Connect(function(i) if dragging then local d = i.Position - dragStart; Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
