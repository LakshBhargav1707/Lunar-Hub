-- SHINARA HUB (Full Functional Version)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "ShinaraHub"
ScreenGui.ResetOnSpawn = false

--------------------------------------------------
-- FUNCTIONAL VARIABLES
--------------------------------------------------
local SpeedVal = 38
local AutoGrab = false
local InfJump = false

--------------------------------------------------
-- FLOATING BUTTONS
--------------------------------------------------
local ButtonContainer = Instance.new("Frame", ScreenGui)
ButtonContainer.Size = UDim2.new(0, 130, 0, 45)
ButtonContainer.Position = UDim2.new(0.02, 0, 0.12, 0)
ButtonContainer.BackgroundTransparency = 1

local function CreateFloatingBtn(text, xOffset)
    local btn = Instance.new("TextButton", ButtonContainer)
    btn.Size = UDim2.new(0, 40, 0, 40)
    btn.Position = UDim2.new(0, xOffset, 0, 0)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.TextColor3 = Color3.fromRGB(255, 50, 50)
    btn.Font = Enum.Font.GothamBold; btn.TextSize = 12
    Instance.new("UICorner", btn)
    return btn
end

local MenuBtn = CreateFloatingBtn("≡", 0)
local BatBtn = CreateFloatingBtn("BAT", 45)
local LeftBtn = CreateFloatingBtn("LEFT", 90)

--------------------------------------------------
-- MAIN PANEL
--------------------------------------------------
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 225, 0, 480); Main.Position = UDim2.new(0.5, -112, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Instance.new("UICorner", Main)

local TitleBar = Instance.new("Frame", Main); TitleBar.Size = UDim2.new(1, 0, 0, 30); TitleBar.BackgroundTransparency = 1
local Title = Instance.new("TextLabel", TitleBar); Title.Size = UDim2.new(1, 0, 1, 0); Title.Text = "SHINARA HUB"
Title.TextColor3 = Color3.fromRGB(255, 50, 50); Title.Font = Enum.Font.GothamBold; Title.TextSize = 16; Title.BackgroundTransparency = 1

local Scroll = Instance.new("ScrollingFrame", Main); Scroll.Position = UDim2.new(0, 0, 0, 30); Scroll.Size = UDim2.new(1, 0, 1, -30)
Scroll.BackgroundTransparency = 1; Scroll.ScrollBarThickness = 4; Scroll.CanvasSize = UDim2.new(0, 0, 0, 600)

--------------------------------------------------
-- CONTENT & MECHANISMS
--------------------------------------------------
local function CreateBox(title, y, default)
    local Label = Instance.new("TextLabel", Scroll); Label.Position = UDim2.new(0.05, 0, 0, y); Label.Size = UDim2.new(0.9, 0, 0, 16)
    Label.Text = title; Label.TextColor3 = Color3.fromRGB(255, 50, 50); Label.Font = Enum.Font.Gotham; Label.TextSize = 11; Label.BackgroundTransparency = 1
    local Box = Instance.new("TextBox", Scroll); Box.Position = UDim2.new(0.05, 0, 0, y+18); Box.Size = UDim2.new(0.9, 0, 0, 28)
    Box.Text = default; Box.BackgroundColor3 = Color3.fromRGB(35, 35, 35); Box.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", Box)
    Box.FocusLost:Connect(function() SpeedVal = tonumber(Box.Text) or SpeedVal end)
end

CreateBox("Speed Control", 10, "38")
CreateBox("Before Grab Speed", 70, "38")
CreateBox("After Grab Speed", 130, "38")

-- Side Configuration
local function CreateCategory(text, y)
    local Label = Instance.new("TextLabel", Scroll); Label.Size = UDim2.new(0.9, 0, 0, 20); Label.Position = UDim2.new(0.05, 0, 0, y)
    Label.Text = text; Label.TextColor3 = Color3.fromRGB(255, 50, 50); Label.Font = Enum.Font.GothamBold; Label.TextSize = 12; Label.BackgroundTransparency = 1; Label.TextXAlignment = Enum.TextXAlignment.Center
end

CreateCategory("Side Configuration", 185)
local LeftPBtn = Instance.new("TextButton", Scroll); LeftPBtn.Size = UDim2.new(0, 95, 0, 28); LeftPBtn.Position = UDim2.new(0.05, 0, 0, 210)
LeftPBtn.Text = "LEFT"; LeftPBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); LeftPBtn.TextColor3 = Color3.fromRGB(255, 50, 50); Instance.new("UICorner", LeftPBtn)
local RightPBtn = Instance.new("TextButton", Scroll); RightPBtn.Size = UDim2.new(0, 95, 0, 28); RightPBtn.Position = UDim2.new(0.52, 0, 0, 210)
RightPBtn.Text = "RIGHT"; RightPBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); RightPBtn.TextColor3 = Color3.fromRGB(255, 50, 50); Instance.new("UICorner", RightPBtn)

LeftPBtn.MouseButton1Click:Connect(function() LeftBtn.Text = "LEFT" end)
RightPBtn.MouseButton1Click:Connect(function() LeftBtn.Text = "RIGHT" end)

-- Bat Button Logic
BatBtn.MouseButton1Click:Connect(function()
    local char = Player.Character
    local tool = Player.Backpack:FindFirstChildOfClass("Tool") or char:FindFirstChildOfClass("Tool")
    if tool then char.Humanoid:EquipTool(tool) end
end)

-- Auto Grab & Auto Play
local AutoPlayBtn = Instance.new("TextButton", Scroll); AutoPlayBtn.Size = UDim2.new(0.9, 0, 0, 28); AutoPlayBtn.Position = UDim2.new(0.05, 0, 0, 245)
AutoPlayBtn.Text = "AUTO PLAY"; AutoPlayBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); AutoPlayBtn.TextColor3 = Color3.fromRGB(255, 50, 50); Instance.new("UICorner", AutoPlayBtn)

AutoPlayBtn.MouseButton1Click:Connect(function() AutoPlayBtn.Text = (AutoPlayBtn.Text == "AUTO PLAY") and "MANUAL" or "AUTO PLAY" end)

-- Toggle Panel
CreateCategory("Toggle Panel", 290)
local function CreateToggle(text, y, callback)
    local state = false; local Btn = Instance.new("TextButton", Scroll); Btn.Position = UDim2.new(0.05, 0, 0, y); Btn.Size = UDim2.new(0.9, 0, 0, 28)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); Btn.Text = text.." : OFF"; Btn.TextColor3 = Color3.fromRGB(255, 50, 50); Instance.new("UICorner", Btn)
    Btn.MouseButton1Click:Connect(function() state = not state; Btn.Text = text..(state and " : ON" or " : OFF"); callback(state) end)
end

CreateToggle("INFINITE JUMP", 315, function(s) InfJump = s end)
CreateToggle("AUTO GRAB", 350, function(s) AutoGrab = s end)

--------------------------------------------------
-- MAIN LOOPS (MECHANISMS)
--------------------------------------------------
RunService.Heartbeat:Connect(function()
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = SpeedVal
    end
end)

UIS.JumpRequest:Connect(function()
    if InfJump then Player.Character.Humanoid:ChangeState("Jumping") end
end)

RunService.RenderStepped:Connect(function()
    if AutoGrab then
        local tool = Player.Character and Player.Character:FindFirstChildOfClass("Tool")
        if tool then tool:Activate() end
    end
end)

MenuBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
