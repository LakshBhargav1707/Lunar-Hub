-- SHINARA HUB (Final Version with Left/Right Buttons)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "ShinaraHub"

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

local isLeft = true
LeftBtn.MouseButton1Click:Connect(function()
    isLeft = not isLeft
    LeftBtn.Text = isLeft and "LEFT" or "X"
end)

--------------------------------------------------
-- MAIN PANEL
--------------------------------------------------
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 225, 0, 380); Main.Position = UDim2.new(0.5, -112, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Instance.new("UICorner", Main)

local TitleBar = Instance.new("Frame", Main); TitleBar.Size = UDim2.new(1, 0, 0, 30); TitleBar.BackgroundTransparency = 1
local Title = Instance.new("TextLabel", TitleBar); Title.Size = UDim2.new(1, 0, 1, 0); Title.Text = "SHINARA HUB"
Title.TextColor3 = Color3.fromRGB(255, 50, 50); Title.Font = Enum.Font.GothamBold; Title.TextSize = 16; Title.BackgroundTransparency = 1

local Scroll = Instance.new("ScrollingFrame", Main); Scroll.Position = UDim2.new(0, 0, 0, 30); Scroll.Size = UDim2.new(1, 0, 1, -30)
Scroll.BackgroundTransparency = 1; Scroll.ScrollBarThickness = 4; Scroll.CanvasSize = UDim2.new(0, 0, 0, 500)

--------------------------------------------------
-- CONTENT
--------------------------------------------------
local function CreateBox(title, y, value)
    local Label = Instance.new("TextLabel", Scroll); Label.Position = UDim2.new(0.05, 0, 0, y); Label.Size = UDim2.new(0.9, 0, 0, 16)
    Label.Text = title; Label.TextColor3 = Color3.fromRGB(255, 50, 50); Label.Font = Enum.Font.Gotham; Label.TextSize = 11; Label.BackgroundTransparency = 1
    local Box = Instance.new("TextBox", Scroll); Box.Position = UDim2.new(0.05, 0, 0, y+18); Box.Size = UDim2.new(0.9, 0, 0, 28)
    Box.Text = value; Box.BackgroundColor3 = Color3.fromRGB(35, 35, 35); Box.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", Box)
end

CreateBox("Speed Control", 10, "0")
CreateBox("Before Grab Speed", 70, "38")
CreateBox("After Grab Speed", 130, "38")

local function CreateCategory(text, y)
    local Label = Instance.new("TextLabel", Scroll); Label.Size = UDim2.new(0.9, 0, 0, 20); Label.Position = UDim2.new(0.05, 0, 0, y)
    Label.Text = text; Label.TextColor3 = Color3.fromRGB(255, 50, 50); Label.Font = Enum.Font.GothamBold; Label.TextSize = 12; Label.BackgroundTransparency = 1; Label.TextXAlignment = Enum.TextXAlignment.Center
end

-- Side Configuration (Left/Right Buttons)
CreateCategory("Side Configuration", 185)
local LeftPBtn = Instance.new("TextButton", Scroll); LeftPBtn.Size = UDim2.new(0, 95, 0, 28); LeftPBtn.Position = UDim2.new(0.05, 0, 0, 210)
LeftPBtn.Text = "LEFT"; LeftPBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); LeftPBtn.TextColor3 = Color3.fromRGB(255, 50, 50); LeftPBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", LeftPBtn)
local RightPBtn = Instance.new("TextButton", Scroll); RightPBtn.Size = UDim2.new(0, 95, 0, 28); RightPBtn.Position = UDim2.new(0.52, 0, 0, 210)
RightPBtn.Text = "RIGHT"; RightPBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); RightPBtn.TextColor3 = Color3.fromRGB(255, 50, 50); RightPBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", RightPBtn)

-- Auto Play Button
local AutoPlayBtn = Instance.new("TextButton", Scroll); AutoPlayBtn.Size = UDim2.new(0.9, 0, 0, 28); AutoPlayBtn.Position = UDim2.new(0.05, 0, 0, 245)
AutoPlayBtn.Text = "AUTO PLAY"; AutoPlayBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); AutoPlayBtn.TextColor3 = Color3.fromRGB(255, 50, 50); AutoPlayBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", AutoPlayBtn)
AutoPlayBtn.MouseButton1Click:Connect(function() AutoPlayBtn.Text = (AutoPlayBtn.Text == "AUTO PLAY") and "MANUAL" or "AUTO PLAY" end)

CreateCategory("Toggle Panel", 290)
local function CreateToggle(name, y)
    local state = false; local Btn = Instance.new("TextButton", Scroll); Btn.Position = UDim2.new(0.05, 0, 0, y); Btn.Size = UDim2.new(0.9, 0, 0, 28)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); Btn.Text = name.." : OFF"; Btn.TextColor3 = Color3.fromRGB(255, 50, 50); Btn.Font = Enum.Font.GothamBold; Instance.new("UICorner", Btn)
    Btn.MouseButton1Click:Connect(function() state = not state; Btn.Text = name..(state and " : ON" or " : OFF") end)
end
CreateToggle("B", 315); CreateToggle("A", 350)

--------------------------------------------------
-- DRAG LOGIC
--------------------------------------------------
MenuBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
local drag, dStart, sPos
TitleBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true; dStart = i.Position; sPos = Main.Position end end)
UIS.InputChanged:Connect(function(i) if drag then local d = i.Position - dStart; Main.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)
