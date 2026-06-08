-- Lunar Hub (Steal A Brainrot Duel Edition - Fixed V5)
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("LunarHub") then
        game:GetService("CoreGui"):FindFirstChild("LunarHub"):Destroy()
    end
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
Frame.Draggable = true

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,12)

-- [[ CONFIGURATION VALUES ]] --
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
    Speed = 32,
    BeforeGrab = 45,
    AfterGrab = 35,
    Side = "Left",
    Mode = "AutoPlay",
    AutoLoopSteal = false,
    AutoBat = false,
    InfiniteJump = false
}

-- Check if holding Brainrot
local function checkBrainrot()
    if Character then
        return Character:FindFirstChild("Brainrot") or LocalPlayer.Backpack:FindFirstChild("Brainrot") or 
               Character:FindFirstChild("brainrot") or LocalPlayer.Backpack:FindFirstChild("brainrot")
    end
    return false
end

-- [[ AUTO GRAB LOGIC ]] --
local function autoGrabBrainrots()
    if Character and RootPart and not checkBrainrot() then
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Tool") and (obj.Name:lower() == "brainrot" or obj:FindFirstChild("Handle")) then
                local handle = obj:FindFirstChild("Handle") or obj
                if handle:IsA("BasePart") then
                    local distance = (RootPart.Position - handle.Position).Magnitude
                    if distance < 25 then
                        local savedCFrame = RootPart.CFrame
                        RootPart.CFrame = handle.CFrame
                        task.wait(0.05)
                        RootPart.CFrame = savedCFrame
                        break
                    end
                end
            end
        end
    end
end

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

local function createBox(default, y, configKey)
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
    
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val then
            Config[configKey] = val
        end
    end)
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

-- Inputs
createLabel("Speed", 70)
createBox("32", 70, "Speed")

createLabel("Before Grab", 115)
createBox("45", 115, "BeforeGrab")

createLabel("After Grab", 160)
createBox("35", 160, "AfterGrab")

createLabel("Side Selection", 210)

local Left = Instance.new("TextButton")
Left.Parent = Frame
Left.Position = UDim2.new(0,15,0,245)
Left.Size = UDim2.new(0,110,0,35)
Left.BackgroundColor3 = Color3.fromRGB(170,85,255)
Left.TextColor3 = Color3.new(1,1,1)
Left.Font = Enum.Font.GothamBold
Left.Text = "Left"
Instance.new("UICorner", Left).CornerRadius = UDim.new(0,8)

local Right = Left:Clone()
Right.Parent = Frame
Right.Position = UDim2.new(0,150,0,245)
Right.BackgroundColor3 = Color3.fromRGB(30,30,40)
Right.Text = "Right"

Left.MouseButton1Click:Connect(function()
    Config.Side = "Left"
    Left.BackgroundColor3 = Color3.fromRGB(170,85,255)
    Right.BackgroundColor3 = Color3.fromRGB(30,30,40)
end)

Right.MouseButton1Click:Connect(function()
    Config.Side = "Right"
    Right.BackgroundColor3 = Color3.fromRGB(170,85,255)
    Left.BackgroundColor3 = Color3.fromRGB(30,30,40)
end)

createLabel("Mode", 295)

local Mode = Instance.new("TextButton")
Mode.Parent = Frame
Mode.Position = UDim2.new(0,150,0,295)
Mode.Size = UDim2.new(0,110,0,35)
Mode.BackgroundColor3 = Color3.fromRGB(30,30,40)
Mode.TextColor3 = Color3.new(1,1,1)
Mode.Font = Enum.Font.GothamBold
Mode.Text = "AutoPlay"
Instance.new("UICorner", Mode).CornerRadius = UDim.new(0,8)

Mode.MouseButton1Click:Connect(function()
    if Config.Mode == "AutoPlay" then
        Config.Mode = "Manual"
        Mode.Text = "Manual"
    else
        Config.Mode = "AutoPlay"
        Mode.Text = "AutoPlay"
    end
end)

local function createToggle(name, y, configKey)
    createLabel(name, y)

    local btn = Instance.new("TextButton")
    btn.Parent = Frame
    btn.Position = UDim2.new(0,150,0,y)
    btn.Size = UDim2.new(0,110,0,35)
    btn.BackgroundColor3 = Color3.fromRGB(200,50,50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.Text = "OFF"
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

    btn.MouseButton1Click:Connect(function()
        if btn.Text == "OFF" then
            btn.Text = "ON"
            btn.BackgroundColor3 = Color3.fromRGB(50,200,50)
            Config[configKey] = true
        else
            btn.Text = "OFF"
            btn.BackgroundColor3 = Color3.fromRGB(200,50,50)
            Config[configKey] = false
        end
    end)
end

createToggle("Auto Loop Steal", 345, "AutoLoopSteal")
createToggle("Auto Bat", 390, "AutoBat")
createToggle("Infinite Jump", 435, "InfiniteJump")

-- [[ ADVANCED BYPASS & AUTOMATION ]] --
RunService.Heartbeat:Connect(function()
    if Character and Humanoid and RootPart and Humanoid.Health > 0 then
        if Config.AutoLoopSteal then
            autoGrabBrainrots()
        end

        local currentTargetSpeed = Config.Speed
        if Config.AutoLoopSteal then
            if checkBrainrot() then
                currentTargetSpeed = Config.AfterGrab
            else
                currentTargetSpeed = Config.BeforeGrab
            end
        end

        if Humanoid.MoveDirection.Magnitude > 0 then
            local speedMultiplier = (currentTargetSpeed / 16) - 1
            if speedMultiplier > 0 then
                RootPart.CFrame = RootPart.CFrame + (Humanoid.MoveDirection * (speedMultiplier * 0.14))
            end
        end

        if Config.AutoLoopSteal and Config.Mode == "AutoPlay" then
            if Config.Side == "Left" then
                RootPart.CFrame = RootPart.CFrame * CFrame.new(-0.5, 0, 0)
            elseif Config.Side == "Right" then
                RootPart.CFrame = RootPart.CFrame * CFrame.new(0.5, 0, 0)
            end
        end
    end
end)

task.spawn(function()
    while true do
        if Config.AutoBat and checkBrainrot() and RootPart then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local targetRoot = p.Character.HumanoidRootPart
                    local distance = (RootPart.Position - targetRoot.Position).Magnitude
                    
                    if distance < 16 then
                        local Tool = Character:FindFirstChildOfClass("Tool")
                        if Tool then 
                            Tool:Activate() 
                        end
                    end
                end
            end
        end
        task.wait(0.1)
    end
end)

local lastJump = 0
UIS.JumpRequest:Connect(function()
    if Config.InfiniteJump and RootPart and (tick() - lastJump) > 0.08 then
        lastJump = tick()
        RootPart.CFrame = RootPart.CFrame * CFrame.new(0, 5, 0)
    end
end)

print("Lunar Hub Fixed V5 Loaded!")
