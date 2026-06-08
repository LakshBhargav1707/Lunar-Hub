-- Lunar Hub (GUI Only)
-- This is a UI template. Toggle states and textboxes work in the interface,
-- but no game automation/exploit actions are connected.

local UIS = game:GetService("UserInputService")

pcall(function()
    game:GetService("CoreGui"):FindFirstChild("LunarHub"):Destroy()
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LunarHub"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 280, 0, 500)
Frame.Position = UDim2.new(0.5, -140, 0.5, -250)
Frame.BackgroundColor3 = Color3.fromRGB(18,18,24)
Frame.BorderSizePixel = 0
Frame.Active = true

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,12)

local function createLabel(text, y)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = Frame
    lbl.Position = UDim2.new(0,15,0,y)
    lbl.Size = UDim2.new(0,120,0,30)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 16
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return lbl
end

local function createBox(default, y)
    local box = Instance.new("TextBox")
    box.Parent = Frame
    box.Position = UDim2.new(0,150,0,y)
    box.Size = UDim2.new(0,110,0,30)
    box.BackgroundColor3 = Color3.fromRGB(30,30,40)
    box.TextColor3 = Color3.new(1,1,1)
    box.PlaceholderText = default
    box.Text = default
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)
    return box
end

local Title = createLabel("Lunar Hub", 10)
Title.TextColor3 = Color3.fromRGB(170,85,255)
Title.TextStrokeTransparency = 0
Title.TextStrokeColor3 = Color3.new(0,0,0)
Title.TextSize = 24

local Minimize = Instance.new("TextButton")
Minimize.Parent = Frame
Minimize.Position = UDim2.new(1,-40,0,10)
Minimize.Size = UDim2.new(0,30,0,30)
Minimize.BackgroundTransparency = 1
Minimize.Text = "-"
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 28

local Mini = Instance.new("TextButton")
Mini.Parent = ScreenGui
Mini.Size = UDim2.new(0,100,0,35)
Mini.Position = UDim2.new(0,20,0.5,0)
Mini.Visible = false
Mini.BackgroundColor3 = Color3.fromRGB(18,18,24)
Mini.Text = "Lunar Hub"
Mini.TextColor3 = Color3.new(1,1,1)
Mini.Font = Enum.Font.GothamBold
Mini.TextSize = 16
Instance.new("UICorner", Mini).CornerRadius = UDim.new(0,10)

Minimize.MouseButton1Click:Connect(function()
    Frame.Visible = false
    Mini.Visible = true
end)

Mini.MouseButton1Click:Connect(function()
    Frame.Visible = true
    Mini.Visible = false
end)

createLabel("Speed", 70)
createBox("32", 70)

createLabel("Before Grab", 115)
createBox("30", 115)

createLabel("After Grab", 160)
createBox("30", 160)

createLabel("Side Selection", 210)

local Left = Instance.new("TextButton")
Left.Parent = Frame
Left.Position = UDim2.new(0,15,0,245)
Left.Size = UDim2.new(0,110,0,35)
Left.Text = "Left"

local Right = Left:Clone()
Right.Parent = Frame
Right.Position = UDim2.new(0,150,0,245)
Right.Text = "Right"

createLabel("Mode", 295)

local Mode = Instance.new("TextButton")
Mode.Parent = Frame
Mode.Position = UDim2.new(0,150,0,295)
Mode.Size = UDim2.new(0,110,0,35)
Mode.Text = "AutoPlay"

Mode.MouseButton1Click:Connect(function()
    Mode.Text = Mode.Text == "AutoPlay" and "Manual" or "AutoPlay"
end)

local function createToggle(name, y)
    createLabel(name, y)

    local btn = Instance.new("TextButton")
    btn.Parent = Frame
    btn.Position = UDim2.new(0,150,0,y)
    btn.Size = UDim2.new(0,110,0,35)
    btn.Text = "OFF"

    btn.MouseButton1Click:Connect(function()
        btn.Text = btn.Text == "OFF" and "ON" or "OFF"
    end)
end

createToggle("Auto Loop Steal", 345)
createToggle("Auto Bat", 390)
createToggle("Infinite Jump", 435)

print("Lunar Hub UI Loaded")
