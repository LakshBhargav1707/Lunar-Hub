-- [[ LUNAR HUB - PROFESSIONAL UI ]] --

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- 2 Second Delay before appearing
task.wait(2)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LunarHub"
ScreenGui.Parent = (gethui and gethui()) or CoreGui -- Anti-detection support

-- Main UI Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 380)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Sidebar (Left side icons)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 60, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 10)
SideCorner.Parent = Sidebar

local SideLayout = Instance.new("UIListLayout")
SideLayout.Parent = Sidebar
SideLayout.Padding = UDim.new(0, 15)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideLayout.VerticalAlignment = Enum.VerticalAlignment.Center

-- Header (Top Title)
local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1, -70, 0, 40)
Header.Position = UDim2.new(0, 70, 0, 5)
Header.BackgroundTransparency = 1
Header.Text = "LUNAR HUB"
Header.TextColor3 = Color3.fromRGB(200, 200, 200)
Header.TextSize = 18
Header.Font = Enum.Font.GothamBold
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.Parent = MainFrame

-- Container for Content
local ContentHolder = Instance.new("ScrollingFrame")
ContentHolder.Name = "Content"
ContentHolder.Size = UDim2.new(1, -80, 1, -60)
ContentHolder.Position = UDim2.new(0, 70, 0, 50)
ContentHolder.BackgroundTransparency = 1
ContentHolder.ScrollBarThickness = 2
ContentHolder.CanvasSize = UDim2.new(0, 0, 2, 0)
ContentHolder.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Parent = ContentHolder
ContentLayout.Padding = UDim.new(0, 10)

-- Helper Functions (Inputs, Sections, Buttons)

local function CreateSection(title)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -10, 0, 25)
    Label.BackgroundTransparency = 1
    Label.Text = title:upper()
    Label.TextColor3 = Color3.fromRGB(100, 100, 100)
    Label.TextSize = 12
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ContentHolder
end

local function CreateInput(title, defaultText)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -10, 0, 40)
    Container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Container.Parent = ContentHolder
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0.6, 0, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = title:upper()
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 12
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Container

    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(0.3, 0, 0.7, 0)
    Box.Position = UDim2.new(0.65, 0, 0.15, 0)
    Box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Box.Text = defaultText
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.Font = Enum.Font.Gotham
    Box.TextSize = 12
    Box.Parent = Container
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)
end

local function CreateSelection()
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -10, 0, 60)
    Container.BackgroundTransparency = 1
    Container.Parent = ContentHolder

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 20)
    Title.BackgroundTransparency = 1
    Title.Text = "SIDE SELECTION & MODE"
    Title.TextColor3 = Color3.fromRGB(150, 150, 150)
    Title.TextSize = 11
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Container

    local btnFrame = Instance.new("Frame")
    btnFrame.Size = UDim2.new(1, 0, 0, 35)
    btnFrame.Position = UDim2.new(0, 0, 0, 25)
    btnFrame.BackgroundTransparency = 1
    btnFrame.Parent = Container

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.Padding = UDim.new(0, 5)
    layout.Parent = btnFrame

    local function miniBtn(txt)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 80, 1, 0)
        b.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        b.Text = txt
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 11
        b.Parent = btnFrame
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    end
    
    miniBtn("LEFT")
    miniBtn("RIGHT")
    miniBtn("AUTO")
end

-- Adding Content Based on Video
CreateSection("Speed Control")
CreateInput("Speed", "0")
CreateInput("Before Crab", "58")
CreateInput("After Crab", "29")

CreateSection("Mytllock Settings")
CreateInput("Mytllock Speed", "30")

CreateSelection()

CreateSection("Features")
local function CreateToggle(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = "   " .. name:upper()
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = ContentHolder
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
end

CreateToggle("Auto Medusa")
CreateToggle("Flight Mode")
CreateToggle("Infinite Jump")

-- Sidebar Icons (Placeholders)
for i = 1, 4 do
    local icon = Instance.new("Frame")
    icon.Size = UDim2.new(0, 35, 0, 35)
    icon.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    icon.Parent = Sidebar
    Instance.new("UICorner", icon).CornerRadius = UDim.new(1, 0)
end

-- Draggable Script (To move UI)
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

print("Lunar Hub Loaded!")
