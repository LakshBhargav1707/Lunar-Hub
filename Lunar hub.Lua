local UIS = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Close = Instance.new("TextButton")
local Plus = Instance.new("TextButton")
local Minus = Instance.new("TextButton")

ScreenGui.Name = "LunarHub"
ScreenGui.Parent = game:GetService("CoreGui")

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 300, 0, 180)
Frame.Position = UDim2.new(0.5, -150, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Frame.BorderSizePixel = 0
Frame.Active = true

Title.Parent = Frame
Title.Size = UDim2.new(1, -100, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "👾 Lunar Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true

Close.Parent = Frame
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -35, 0, 5)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
Close.TextColor3 = Color3.new(1, 1, 1)

Plus.Parent = Frame
Plus.Size = UDim2.new(0, 30, 0, 30)
Plus.Position = UDim2.new(1, -70, 0, 5)
Plus.Text = "+"
Plus.BackgroundColor3 = Color3.fromRGB(70, 255, 70)

Minus.Parent = Frame
Minus.Size = UDim2.new(0, 30, 0, 30)
Minus.Position = UDim2.new(1, -105, 0, 5)
Minus.Text = "-"
Minus.BackgroundColor3 = Color3.fromRGB(255, 200, 70)

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

Plus.MouseButton1Click:Connect(function()
    Frame.Size = Frame.Size + UDim2.new(0, 20, 0, 20)
end)

Minus.MouseButton1Click:Connect(function()
    Frame.Size = Frame.Size - UDim2.new(0, 20, 0, 20)
end)

-- Draggable GUI
local dragging = false
local dragInput, dragStart, startPos

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
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

print("Lunar Hub Loaded!")
