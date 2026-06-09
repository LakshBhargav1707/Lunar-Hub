-- LUNAR HUB (Optimized & Fixed Logic)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LunarHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Floating Buttons
local MenuBtn = Instance.new("TextButton", ScreenGui)
MenuBtn.Size = UDim2.new(0,40,0,40); MenuBtn.Position = UDim2.new(0,10,0.5,-50)
MenuBtn.Text = "≡"; MenuBtn.BackgroundColor3 = Color3.fromRGB(130,70,255); MenuBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner",MenuBtn)

local SideBtn = Instance.new("TextButton", ScreenGui)
SideBtn.Size = UDim2.new(0,40,0,30); SideBtn.Position = UDim2.new(0,55,0.5,-45)
SideBtn.Text = "LEFT"; SideBtn.BackgroundColor3 = Color3.fromRGB(35,35,50); SideBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner",SideBtn)

-- Main Panel
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,200,0,320)
Main.Position = UDim2.new(0.5,-100,0.5,-160)
Main.BackgroundColor3 = Color3.fromRGB(20,20,30); Main.BorderSizePixel = 0; Instance.new("UICorner",Main)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Position = UDim2.new(0,0,0,30); Scroll.Size = UDim2.new(1,0,1,-30)
Scroll.BackgroundTransparency = 1; Scroll.ScrollBarThickness = 2; Scroll.CanvasSize = UDim2.new(0,0,0,400)

local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1,0,0,30); TitleBar.BackgroundTransparency = 1

local function CreateBox(title,y,value)
    local Label = Instance.new("TextLabel", Scroll)
    Label.Position = UDim2.new(0.05,0,0,y); Label.Size = UDim2.new(0.9,0,0,15); Label.BackgroundTransparency = 1
    Label.Text = title; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.Gotham; Label.TextSize = 10
    local Box = Instance.new("TextBox", Scroll)
    Box.Position = UDim2.new(0.05,0,0,y+15); Box.Size = UDim2.new(0.9,0,0,25); Box.Text = value
    Box.BackgroundColor3 = Color3.fromRGB(35,35,50); Box.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner",Box)
end

CreateBox("Speed", 5, "0")
CreateBox("Grab Speed", 50, "38")

-- Mode Buttons
local LeftBtn = Instance.new("TextButton", Scroll)
local RightBtn = Instance.new("TextButton", Scroll)
local ModeBtn = Instance.new("TextButton", Scroll)

local function StyleBtn(btn, x, text)
    btn.Size = UDim2.new(0,55,0,25); btn.Position = UDim2.new(x,0,0,100)
    btn.Text = text; btn.BackgroundColor3 = Color3.fromRGB(35,35,50); btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold; btn.TextSize = 10; Instance.new("UICorner", btn)
end

StyleBtn(LeftBtn, 0.05, "LEFT")
StyleBtn(RightBtn, 0.37, "RIGHT")
StyleBtn(ModeBtn, 0.69, "AUTO PLAY")

local isAuto = false
LeftBtn.MouseButton1Click:Connect(function() SideBtn.Text = "LEFT" end)
RightBtn.MouseButton1Click:Connect(function() SideBtn.Text = "RIGHT" end)

ModeBtn.MouseButton1Click:Connect(function()
    isAuto = not isAuto
    ModeBtn.Text = isAuto and "MANUAL" or "AUTO PLAY"
    ModeBtn.BackgroundColor3 = isAuto and Color3.fromRGB(255,70,70) or Color3.fromRGB(35,35,50)
end)

-- Toggles
local function CreateToggle(name, y)
    local state = false
    local Btn = Instance.new("TextButton", Scroll)
    Btn.Position = UDim2.new(0.05,0,0,y); Btn.Size = UDim2.new(0.9,0,0,25)
    Btn.Text = name.." : OFF"; Btn.BackgroundColor3 = Color3.fromRGB(35,35,50); Instance.new("UICorner", Btn)
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.Text = name..(state and " : ON" or " : OFF")
        Btn.BackgroundColor3 = state and Color3.fromRGB(130,70,255) or Color3.fromRGB(35,35,50)
    end)
end

CreateToggle("INFINITE JUMP", 140)
CreateToggle("AUTO GRAB", 175)

-- Draggable
MenuBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
local drag, startPos, dragStart
TitleBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true; dragStart = i.Position; startPos = Main.Position end end)
UIS.InputChanged:Connect(function(i) if drag then Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + (i.Position.X - dragStart.X), startPos.Y.Scale, startPos.Y.Offset + (i.Position.Y - dragStart.Y)) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)
