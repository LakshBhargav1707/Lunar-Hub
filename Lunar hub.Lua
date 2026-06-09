local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LunarHub"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- 2 Second Delay before panel appears
task.wait(2)

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 250, 0, 350)
frame.Position = UDim2.new(0.5, -125, 0.5, -175)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.1 -- Slight transparency for professional look
frame.Parent = ScreenGui

-- Rounded corners for the main panel
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Layout and Padding for organized buttons
local uiLayout = Instance.new("UIListLayout")
uiLayout.Padding = UDim.new(0, 8)
uiLayout.Parent = frame

local uiPadding = Instance.new("UIPadding")
uiPadding.PaddingTop = UDim.new(0, 10)
uiPadding.PaddingLeft = UDim.new(0, 10)
uiPadding.PaddingRight = UDim.new(0, 10)
uiPadding.Parent = frame

-- Professional Button Creator
local function createButton(textName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Text = textName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 16
    btn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    -- Hover effect for professionalism
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)
end

-- Adding features
createButton("Auto Medusa")
createButton("Flight Mode")
createButton("Infinite Jump")
createButton("FPS Boost")
createButton("Auto Bat")
