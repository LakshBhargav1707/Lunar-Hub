-- [[ LakshByte Custom Brainrot Steal Hub V13 - Compact Premium UI ]] --
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

-- Old UI Cleanup
pcall(function()
    if CoreGui:FindFirstChild("LunarHub") then CoreGui:FindFirstChild("LunarHub"):Destroy() end
    if CoreGui:FindFirstChild("LunarMobileUI") then CoreGui:FindFirstChild("LunarMobileUI"):Destroy() end
end)

-- [[ CONFIGURATION SYSTEM ]] --
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
    NormalSpeed = 16,
    BeforeGrabSpeed = 50.5,
    AfterGrabSpeed = 58,
    SideSelection = "Left",
    PlayMode = "Manual", 
    AutoLoopSteal = false,
    AutoBat = false,
    InfiniteJump = false
}

-- Brainrot Check Utility
local function checkBrainrot()
    if Character then
        return Character:FindFirstChild("Brainrot") or LocalPlayer.Backpack:FindFirstChild("Brainrot") or 
               Character:FindFirstChild("brainrot") or LocalPlayer.Backpack:FindFirstChild("brainrot")
    end
    return false
end

-- Raycast-Buffered Detection-Safe Auto Grab
local function autoGrabLogic()
    if Character and RootPart and not checkBrainrot() then
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Tool") and (obj.Name:lower() == "brainrot" or obj:FindFirstChild("Handle")) then
                local handle = obj:FindFirstChild("Handle") or obj
                if handle:IsA("BasePart") then
                    local distance = (RootPart.Position - handle.Position).Magnitude
                    if distance < 35 then
                        pcall(function()
                            local touchSignal = firetouchinterest or pairs
                            touchSignal(handle, RootPart, 0)
                            task.wait()
                            touchSignal(handle, RootPart, 1)
                        end)
                        break
                    end
                end
            end
        end
    end
end

-- [[ SCREEN LEFT SIDE MINI MOBILE UI SETUP ]] --
local MobileGui = Instance.new("ScreenGui")
MobileGui.Name = "LunarMobileUI"
MobileGui.Parent = CoreGui
MobileGui.ResetOnSpawn = false

local Layout = Instance.new("Frame")
Layout.Parent = MobileGui
Layout.Size = UDim2.new(0, 190, 0, 45)
Layout.Position = UDim2.new(0, 20, 0, 110)
Layout.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", Layout)
UIList.FillDirection = Enum.FillDirection.Horizontal
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 8)

local function createMiniButton(name, text, order)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = Layout
    btn.Size = UDim2.new(0, 55, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextSize = 13
    btn.LayoutOrder = order
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(50, 50, 60)
    stroke.Thickness = 1
    return btn
end

local MiniToggle = createMiniButton("ToggleBtn", "|||", 1)
local MiniBat = createMiniButton("BatBtn", "BAT", 2)
local MiniSide = createMiniButton("SideBtn", "LEFT", 3)
MiniSide.BackgroundColor3 = Color3.fromRGB(115, 90, 230)

-- [[ COMPACT & SLIM MAIN PANEL ]] --
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "LunarHub"
MainGui.Parent = CoreGui
MainGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = MainGui
MainFrame.Size = UDim2.new(0, 245, 0, 340) -- Slim Width & Optimized Height
MainFrame.Position = UDim2.new(0.5, -122, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local FrameGlow = Instance.new("UIStroke", MainFrame)
FrameGlow.Color = Color3.fromRGB(45, 45, 55)
FrameGlow.Thickness = 1.5

-- Drag Only via Header Title Frame
local HeaderFrame = Instance.new("Frame", MainFrame)
HeaderFrame.Size = UDim2.new(1, 0, 0, 42)
HeaderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
Instance.new("UICorner", HeaderFrame).CornerRadius = UDim.new(0, 10)

MainFrame.Active = true
MainFrame.Draggable = true 

local MainTitle = Instance.new("TextLabel", HeaderFrame)
MainTitle.Size = UDim2.new(1, 0, 1, 0)
MainTitle.BackgroundTransparency = 1
MainTitle.Text = "LUNAR HUB DUEL SCRIPT" -- Name Updated
MainTitle.TextColor3 = Color3.fromRGB(170, 85, 255)
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 13

-- SCROLLING CONTAINER SETUP
local ScrollFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollFrame.Size = UDim2.new(1, 0, 1, -48)
ScrollFrame.Position = UDim2.new(0, 0, 0, 45)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ClipsDescendants = true
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 440)
ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(115, 90, 230)

MiniToggle.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local function createUIElementLabel(text, y)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = ScrollFrame
    lbl.Position = UDim2.new(0, 12, 0, y)
    lbl.Size = UDim2.new(0, 200, 0, 18)
    lbl.BackgroundTransparency = 1
    lbl.Text = text:upper()
    lbl.TextColor3 = Color3.fromRGB(130, 130, 140)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return lbl
end

local function createTextBoxInput(default, y, configKey)
    local box = Instance.new("TextBox")
    box.Parent = ScrollFrame
    box.Position = UDim2.new(0, 12, 0, y)
    box.Size = UDim2.new(0, 215, 0, 28) -- Medium optimized size
    box.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.PlaceholderText = default
    box.Text = default
    box.Font = Enum.Font.GothamSemibold
    box.TextSize = 12
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", box).Color = Color3.fromRGB(45, 45, 55)
    
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val then Config[configKey] = val end
    end)
    return box
end

-- RENDER COMPACT ELEMENTS
createUIElementLabel("Speed Control", 10)
createTextBoxInput("16", 28, "NormalSpeed")

createUIElementLabel("Before Grab Speed", 66)
createTextBoxInput("50.5", 84, "BeforeGrabSpeed")

createUIElementLabel("After Grab Speed", 122)
createTextBoxInput("58", 140, "AfterGrabSpeed")

createUIElementLabel("Side Selection & Mode", 180)

-- Medium Sized Left/Right/Manual Buttons
local BtnLeft = Instance.new("TextButton", ScrollFrame)
BtnLeft.Size = UDim2.new(0, 65, 0, 28) -- Medium sizing
BtnLeft.Position = UDim2.new(0, 12, 0, 198)
BtnLeft.BackgroundColor3 = Color3.fromRGB(115, 90, 230)
BtnLeft.Text = "LEFT"
BtnLeft.Font = Enum.Font.GothamBold
BtnLeft.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnLeft.TextSize = 11
Instance.new("UICorner", BtnLeft).CornerRadius = UDim.new(0, 6)

local BtnRight = BtnLeft:Clone()
BtnRight.Parent = ScrollFrame
BtnRight.Position = UDim2.new(0, 84, 0, 198)
BtnRight.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
BtnRight.Text = "RIGHT"

local BtnManual = BtnLeft:Clone()
BtnManual.Parent = ScrollFrame
BtnManual.Position = UDim2.new(0, 156, 0, 198)
BtnManual.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
BtnManual.Text = "MANUAL"

local function updateSelectionButtons()
    BtnLeft.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    BtnRight.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    BtnManual.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    
    if Config.PlayMode == "Autoplay" then
        BtnManual.Text = "AUTOPLAY"
        if Config.SideSelection == "Left" then
            BtnLeft.BackgroundColor3 = Color3.fromRGB(115, 90,
