-- [[ LakshByte Custom Brainrot Steal Hub V8 Undetected Wrapper ]] --
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

-- Invisible Physics Body for Undetected Speed Bypass
local SpeedForce = Instance.new("BodyVelocity")
SpeedForce.MaxForce = Vector3.new(100000, 0, 100000) -- Only horizontal force, no vertical to prevent anti-cheat triggers
SpeedForce.Velocity = Vector3.new(0, 0, 0)

local function updateSpeedForce(targetSpeed)
    if RootPart and Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
        if SpeedForce.Parent ~= RootPart then
            SpeedForce.Parent = RootPart
        end
        -- Calculate clean horizontal velocity based on input direction
        SpeedForce.Velocity = Humanoid.MoveDirection * targetSpeed
    else
        SpeedForce.Velocity = Vector3.new(0, 0, 0)
    end
end

-- Brainrot Check Utility
local function checkBrainrot()
    if Character then
        return Character:FindFirstChild("Brainrot") or LocalPlayer.Backpack:FindFirstChild("Brainrot") or 
               Character:FindFirstChild("brainrot") or LocalPlayer.Backpack:FindFirstChild("brainrot")
    end
    return false
end

-- Anti-Cheat Safe Auto Grab
local function autoGrabLogic()
    if Character and RootPart and not checkBrainrot() then
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Tool") and (obj.Name:lower() == "brainrot" or obj:FindFirstChild("Handle")) then
                local handle = obj:FindFirstChild("Handle") or obj
                if handle:IsA("BasePart") then
                    local distance = (RootPart.Position - handle.Position).Magnitude
                    if distance < 30 then
                        -- Smooth lerp sequence instead of direct CFrame overwrite to stay undetected
                        local targetPos = handle.CFrame
                        RootPart.CFrame = RootPart.CFrame:Lerp(targetPos, 0.5)
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

-- [[ MAIN ADVANCED PANEL DESIGN ]] --
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "LunarHub"
MainGui.Parent = CoreGui
MainGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Parent = MainGui
MainFrame.Size = UDim2.new(0, 290, 0, 510)
MainFrame.Position = UDim2.new(0.5, -145, 0.5, -255)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local FrameGlow = Instance.new("UIStroke", MainFrame)
FrameGlow.Color = Color3.fromRGB(40, 40, 50)
FrameGlow.Thickness = 1.5

MiniToggle.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local function createUIElementLabel(text, y)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = MainFrame
    lbl.Position = UDim2.new(0, 20, 0, y)
    lbl.Size = UDim2.new(0, 200, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text = text:upper()
    lbl.TextColor3 = Color3.fromRGB(140, 140, 150)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return lbl
end

local function createTextBoxInput(default, y, configKey)
    local box = Instance.new("TextBox")
    box.Parent = MainFrame
    box.Position = UDim2.new(0, 20, 0, y)
    box.Size = UDim2.new(0, 250, 0, 36)
    box.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.PlaceholderText = default
    box.Text = default
    box.Font = Enum.Font.GothamSemibold
    box.TextSize = 14
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", box).Color = Color3.fromRGB(45, 45, 55)
    
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val then Config[configKey] = val end
    end)
    return box
end

-- Header Title FIXED to Lunar Hub
local MainTitle = Instance.new("TextLabel", MainFrame)
MainTitle.Size = UDim2.new(1, 0, 0, 45)
MainTitle.Text = "LUNAR HUB"
MainTitle.TextColor3 = Color3.fromRGB(170, 85, 255)
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 18
MainTitle.BackgroundColor3 = Color3.fromRGB(20, 20, 26)

-- PANEL INPUTS
createUIElementLabel("Speed Control", 60)
createTextBoxInput("16", 80, "NormalSpeed")

createUIElementLabel("Before Grab", 130)
createTextBoxInput("50.5", 150, "BeforeGrabSpeed")

createUIElementLabel("After Grab", 200)
createTextBoxInput("58", 220, "AfterGrabSpeed")

createUIElementLabel("Side Selection & Mode", 275)

local BtnLeft = Instance.new("TextButton", MainFrame)
BtnLeft.Size = UDim2.new(0, 75, 0, 36)
BtnLeft.Position = UDim2.new(0, 20, 0, 295)
BtnLeft.BackgroundColor3 = Color3.fromRGB(115, 90, 230)
BtnLeft.Text = "LEFT"
BtnLeft.Font = Enum.Font.GothamBold
BtnLeft.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnLeft.TextSize = 12
Instance.new("UICorner", BtnLeft).CornerRadius = UDim.new(0, 8)

local BtnRight = BtnLeft:Clone()
BtnRight.Parent = MainFrame
BtnRight.Position = UDim2.new(0, 105, 0, 295)
BtnRight.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
BtnRight.Text = "RIGHT"

local BtnManual = BtnLeft:Clone()
BtnManual.Parent = MainFrame
BtnManual.Position = UDim2.new(0, 190, 0, 295)
BtnManual.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
BtnManual.Text = "MANUAL"

local function updateSelectionButtons()
    BtnLeft.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    BtnRight.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    BtnManual.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    
    if Config.PlayMode == "Autoplay" then
        BtnManual.Text = "AUTOPLAY"
        if Config.SideSelection == "Left" then
            BtnLeft.BackgroundColor3 = Color3.fromRGB(115, 90, 230)
            MiniSide.Text = "LEFT"
            MiniSide.BackgroundColor3 = Color3.fromRGB(115, 90, 230)
        else
            BtnRight.BackgroundColor3 = Color3.fromRGB(115, 90, 230)
            MiniSide.Text = "RIGHT"
            MiniSide.BackgroundColor3 = Color3.fromRGB(115, 90, 230)
        end
    else
        BtnManual.Text = "MANUAL"
        BtnManual.BackgroundColor3 = Color3.fromRGB(115, 90, 230)
        MiniSide.Text = "MANUAL"
        MiniSide.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    end
end

BtnLeft.MouseButton1Click:Connect(function()
    Config.SideSelection = "Left"
    Config.PlayMode = "Autoplay"
    updateSelectionButtons()
end)

BtnRight.MouseButton1Click:Connect(function()
    Config.SideSelection = "Right"
    Config.PlayMode = "Autoplay"
    updateSelectionButtons()
end)

BtnManual.MouseButton1Click:Connect(function()
    if Config.PlayMode == "Manual" then
        Config.PlayMode = "Autoplay"
    else
        Config.PlayMode = "Manual"
    end
    updateSelectionButtons()
end)

MiniSide.MouseButton1Click:Connect(function()
    if Config.PlayMode == "Manual" then
        Config.PlayMode = "Autoplay"
        Config.SideSelection = "Left"
    elseif Config.PlayMode == "Autoplay" and Config.SideSelection == "Left" then
        Config.SideSelection = "Right"
    else
        Config.PlayMode = "Manual"
    end
    updateSelectionButtons()
end)

-- Features Toggles Block
createUIElementLabel("Features", 350)

local function createMainPanelToggle(name, y, configKey, callbackOn)
    local frameBtn = Instance.new("TextButton", MainFrame)
    frameBtn.Size = UDim2.new(0, 250, 0, 38)
    frameBtn.Position = UDim2.new(0, 20, 0, y)
    frameBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    frameBtn.Text = "  " .. name .. ": OFF"
    frameBtn.Font = Enum.Font.GothamBold
    frameBtn.TextColor3 = Color3.fromRGB(200, 80, 80)
    frameBtn.TextXAlignment = Enum.TextXAlignment.Left
    frameBtn.TextSize = 13
    Instance.new("UICorner", frameBtn).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", frameBtn).Color = Color3.fromRGB(45, 45, 55)

    local function toggleState()
        Config[configKey] = not Config[configKey]
        if Config[configKey] then
            frameBtn.Text = "  " .. name .. ": ON"
            frameBtn.TextColor3 = Color3.fromRGB(80, 200, 80)
            if callbackOn then callbackOn(true) end
        else
            frameBtn.Text = "  " .. name .. ": OFF"
            frameBtn.TextColor3 = Color3.fromRGB(200, 80, 80)
            if callbackOn then callbackOn(false) end
        end
    end
    frameBtn.MouseButton1Click:Connect(toggleState)
    return toggleState
end

local toggleSteal = createMainPanelToggle("Auto Loop Steal", 375, "AutoLoopSteal")

local toggleBat = createMainPanelToggle("Auto Bat (Kill Players)", 420, "AutoBat", function(state)
    if state then
        MiniBat.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    else
        MiniBat.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    end
end)

MiniBat.MouseButton1Click:Connect(function()
    toggleBat()
end)

createMainPanelToggle("Infinite Jump (No Fall Limit)", 465, "InfiniteJump")

-- [[ CORE ENGINE RUNNING TRACKS ]] --

-- Undetected Heartbeat Loop
RunService.Heartbeat:Connect(function()
    if Character and Humanoid and RootPart and Humanoid.Health > 0 then
        if Config.AutoLoopSteal then
            autoGrabLogic()
        end

        -- Calculate Target Velocity Speed
        local targetVelocitySpeed = Config.NormalSpeed
        if Config.AutoLoopSteal then
            if checkBrainrot() then
                targetVelocitySpeed = Config.AfterGrabSpeed
            else
                targetVelocitySpeed = Config.BeforeGrabSpeed
            end
        end

        -- Bypassed Speed Application via BodyVelocity
        updateSpeedForce(targetVelocitySpeed)

        -- Autoplay Smooth Micro-Drift (No direct CFrame spikes to avoid reset)
        if Config.PlayMode == "Autoplay" then
            if Config.SideSelection == "Left" then
                RootPart.CFrame = RootPart.CFrame * CFrame.new(-0.35, 0, 0)
            elseif Config.SideSelection == "Right" then
                RootPart.CFrame = RootPart.CFrame * CFrame.new(0.35, 0, 0)
            end
        end
    else
        -- Clean up physics force on death
        SpeedForce.Velocity = Vector3.new(0, 0, 0)
    end
end)

-- Auto Bat Target Tracking Engine
task.spawn(function()
    while true do
        if Config.AutoBat and checkBrainrot() and RootPart then
            for _, targetPlayer in pairs(Players:GetPlayers()) do
                if targetPlayer ~= LocalPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local targetRoot = targetPlayer.Character.HumanoidRootPart
                    local targetDistance = (RootPart.Position - targetRoot.Position).Magnitude
                    
                    if targetDistance <= 18 then 
                        local activeTool = Character:FindFirstChildOfClass("Tool")
                        if activeTool then 
                            activeTool:Activate() 
                        end
                    end
                end
            end
        end
        task.wait(0.08)
    end
end)

-- Completely Undetected Infinite Jump System (Altered JumpState Loop)
UIS.JumpRequest:Connect(function()
    if Config.InfiniteJump and Humanoid then
        -- Anti-cheat reset workaround: Change the internal humanoid state instead of adding rapid CFrame force
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

print("Lunar Hub Undetected Bypass V8 Loaded!")
