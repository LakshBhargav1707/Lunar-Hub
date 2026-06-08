local UIS = game:GetService("UserInputService")

pcall(function()
    game:GetService("CoreGui"):FindFirstChild("LunarHub"):Destroy()
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LunarHub"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- Main Frame
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 280, 0, 400)
Frame.Position = UDim2.new(0.5, -140, 0.5, -200)
Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Frame.BorderSizePixel = 0
Frame.Active = true

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = Frame

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1, -50, 0, 45)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Lunar Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextStrokeTransparency = 0
Title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize Button
local Minimize = Instance.new("TextButton")
Minimize.Parent = Frame
Minimize.Size = UDim2.new(0, 30, 0, 30)
Minimize.Position = UDim2.new(1, -40, 0, 10)
Minimize.BackgroundTransparency = 1
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.TextStrokeTransparency = 0
Minimize.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 28

-- Mini Button
local Mini = Instance.new("TextButton")
Mini.Parent = ScreenGui
Mini.Size = UDim2.new(0, 100, 0, 35)
Mini.Position = UDim2.new(0, 20, 0.5, 0)
Mini.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Mini.BorderSizePixel = 0
Mini.Visible = false
Mini.Text = "Lunar Hub"
Mini.TextColor3 = Color3.fromRGB(255, 255, 255)
Mini.TextStrokeTransparency = 0
Mini.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
Mini.Font = Enum.Font.GothamBold
Mini.TextSize = 16
Mini.Active = true

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 10)
MiniCorner.Parent = Mini

-- Minimize/Open
Minimize.MouseButton1Click:Connect(function()
    Frame.Visible = false
    Mini.Visible = true
end)

Mini.MouseButton1Click:Connect(function()
    Frame.Visible = true
    Mini.Visible = false
end)

-- Drag Main Frame
local dragging = false
local dragInput
local dragStart
local startPos

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart

        Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Drag Mini Button
local miniDragging = false
local miniDragInput
local miniDragStart
local miniStartPos

Mini.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then

        miniDragging = true
        miniDragStart = input.Position
        miniStartPos = Mini.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                miniDragging = false
            end
        end)
    end
end)

Mini.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseMovement then
        miniDragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if miniDragging and input == miniDragInput then
        local delta = input.Position - miniDragStart

        Mini.Position = UDim2.new(
            miniStartPos.X.Scale,
            miniStartPos.X.Offset + delta.X,
            miniStartPos.Y.Scale,
            miniStartPos.Y.Offset + delta.Y
        )
    end
end)

print("Lunar Hub Loaded!")
