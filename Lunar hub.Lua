-- LUNAR HUB - EXACT LAYOUT REPLICA
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

task.wait(2) -- 2 second delay as requested

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "LunarHub"

-- Main Panel (Static/Non-moveable)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 360, 0, 520) -- Width adjusted to match photo
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 6)

-- Title
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "REVUL HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

-- Scrolling Content
local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, -10, 1, -50)
Scroll.Position = UDim2.new(0, 5, 0, 45)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 10)

-- Category/Section Header
local function CreateCategory(text)
    local label = Instance.new("TextLabel", Scroll)
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(150, 150, 150)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
end

-- Input/Button Creation
local function CreateField(name)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
end

-- Layout based on your Screenshots
CreateField("SPEED: 0")
CreateCategory("SPEED CONTROL")
CreateField("58")
CreateField("29")

CreateCategory("BAT/LOCK SPEED")
CreateField("30")

CreateCategory("SIDE SELECTION & MODE")
local ModeFrame = Instance.new("Frame", Scroll)
ModeFrame.Size = UDim2.new(1, 0, 0, 40)
ModeFrame.BackgroundTransparency = 1
for _, v in pairs({"LEFT", "RIGHT", "AUTO"}) do
    local b = Instance.new("TextButton", ModeFrame)
    b.Size = UDim2.new(0.32, 0, 1, 0)
    b.Position = UDim2.new((table.find({"LEFT", "RIGHT", "AUTO"}, v)-1)*0.33, 0, 0, 0)
    b.Text = v
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", b)
end

CreateCategory("FEATURES")
CreateField("AUTO MEDUSA")
CreateField("FLIGHT MODE")
CreateField("INFINITE JUMP")
CreateField("LOW GFX")
CreateField("OPTIMIZER")
CreateField("ANTI RAGDOLL")
CreateField("GALAXY SKY")
CreateField("UNWALK")
CreateField("NO COLLISION")
CreateField("FPS BOOST")
CreateField("AUTO BAT")
CreateField("LOOP AUTO STEAL")
CreateField("PREDICT (BETA)")

CreateCategory("BUTTON VISIBILITY")
CreateField("SHOW LOCK MEDUSA")
CreateField("SHOW JUKE")
CreateField("SHOW TP DOWN")
CreateField("SHOW DESYNC")
CreateField("SHOW AUTO TP")
CreateField("SHOW TP UP")
CreateField("SHOW SPEED BYPASS")
CreateField("SHOW LAGGER COUNTER")

CreateCategory("STEAL SETTINGS")
CreateField("STEAL RADIUS (56-90)")
CreateField("56")
CreateField("FLIGHT HEIGHT")
CreateField("6")

CreateCategory("UI SETTINGS")
CreateField("Unlock Buttons")
CreateField("100")
CreateCategory("SPEED CUSTOMIZER")
CreateField("Enable Custom Speed")
CreateField("40")
