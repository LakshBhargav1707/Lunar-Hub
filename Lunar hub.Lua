local UIS = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Close = Instance.new("TextButton")

ScreenGui.Name = "LunarHub"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 280, 0, 400)
Frame.Position = UDim2.new(0.5, -140, 0.5, -200)
Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Selectable = true

Title.Parent = Frame
Title.Size = UDim2.new(1, -50, 0, 50)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Lunar Hub"
Title.TextColor3 = Color3.fromRGB(170, 85, 255) -- Purple
Title.TextStrokeTransparency = 0
Title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) -- Black Stroke
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 10

Close.Parent = Frame
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -35, 0, 10)
Close.BackgroundTransparency = 1
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextStrokeTransparency = 0
Close.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
Close.Font = Enum.Font.GothamBold
Close.TextScaled = true
Close.ZIndex = 10

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Drag anywhere on the panel
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
