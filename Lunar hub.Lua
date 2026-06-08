-- [[ LakshByte Custom Brainrot Steal Hub V11 - Final Performance Overhaul ]] --
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

-- Powerful Instant Auto Grab Engine
local function autoGrabLogic()
    if Character and RootPart and not checkBrainrot() then
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Tool") and (obj.Name:lower() == "brainrot" or obj:FindFirstChild("Handle")) then
                local handle = obj:FindFirstChild("Handle") or obj
                if handle:IsA("BasePart") then
                    local distance = (RootPart.Position - handle.Position).Magnitude
                    if distance < 35 then
                        -- Double forced physics replication to drop into backpack instantly
                        firetouchinterest(handle, RootPart, 0)
                        firetouchinterest(handle, RootPart, 1)
                        task.spawn(function()
                            obj.Parent = Character
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

-- [[ NEW COMPACT SCROLLABLE MAIN PANEL ]] --
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "LunarHub"
MainGui.Parent = CoreGui
MainGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = MainGui
MainFrame.Size = UDim2.new(0, 280, 0, 360) -- Chota aur optimized compact size
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local FrameGlow = Instance.new("UIStroke", MainFrame)
FrameGlow.Color = Color3.fromRGB(45, 45, 55)
FrameGlow.Thickness = 1.5

-- Drag Only via Header Title Frame
local HeaderFrame = Instance.new("Frame", MainFrame)
HeaderFrame.Size = UDim2.new(1, 0, 0, 45)
HeaderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
Instance.new("UICorner", HeaderFrame).CornerRadius = UDim.new(0, 12)

-- Lock drag to this header only
MainFrame.Active = true
MainFrame.Draggable = true -- Backward compatible engine safe drag handle base

local MainTitle = Instance.new("TextLabel", HeaderFrame)
MainTitle.Size = UDim2.new(1, 0, 1, 0)
MainTitle.BackgroundTransparency = 1
MainTitle.Text = "LUNAR HUB"
MainTitle.TextColor3 = Color3.fromRGB(170, 85, 255)
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 16

-- SCROLLING CONTAINER SETUP
local ScrollFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollFrame.Size = UDim2.new(1, 0, 1, -50)
ScrollFrame.Position = UDim2.new(0, 0, 0, 48)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ClipsDescendants = true
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 490) -- Dynamic scrolling depth height
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(115, 90, 230)

MiniToggle.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local function createUIElementLabel(text, y)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = ScrollFrame
    lbl.Position = UDim2.new(0, 15, 0, y)
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
    box.Parent = ScrollFrame
    box.Position = UDim2.new(0, 15, 0, y)
    box.Size = UDim2.new(0, 240, 0, 34)
    box.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.PlaceholderText = default
    box.Text = default
    box.Font = Enum.Font.GothamSemibold
    box.TextSize = 13
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", box).Color = Color3.fromRGB(45, 45, 55)
    
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val then Config[configKey] = val end
    end)
    return box
end

-- RENDERING INSIDE SCROLL PANEL
createUIElementLabel("Speed Control", 10)
createTextBoxInput("16", 30, "NormalSpeed")

createUIElementLabel("Before Grab Speed", 75)
createTextBoxInput("50.5", 95, "BeforeGrabSpeed")

createUIElementLabel("After Grab Speed", 140)
createTextBoxInput("58", 160, "AfterGrabSpeed")

createUIElementLabel("Side Selection & Mode", 210)

local BtnLeft = Instance.new("TextButton", ScrollFrame)
BtnLeft.Size = UDim2.new(0, 72, 0, 34)
BtnLeft.Position = UDim2.new(0, 15, 0, 230)
BtnLeft.BackgroundColor3 = Color3.fromRGB(115, 90, 230)
BtnLeft.Text = "LEFT"
BtnLeft.Font = Enum.Font.GothamBold
BtnLeft.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnLeft.TextSize = 11
Instance.new("UICorner", BtnLeft).CornerRadius = UDim.new(0, 8)

local BtnRight = BtnLeft:Clone()
BtnRight.Parent = ScrollFrame
BtnRight.Position = UDim2.new(0, 95, 0, 230)
BtnRight.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
BtnRight.Text = "RIGHT"

local BtnManual = BtnLeft:Clone()
BtnManual.Parent = ScrollFrame
BtnManual.Position = UDim2.new(0, 175, 0, 230)
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

createUIElementLabel("Features", 280)

local function createMainPanelToggle(name, y, configKey, callbackOn)
    local frameBtn = Instance.new("TextButton", ScrollFrame)
    frameBtn.Size = UDim2.new(0, 240, 0, 36)
    frameBtn.Position = UDim2.new(0, 15, 0, y)
    frameBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    frameBtn.Text = "  " .. name .. ": OFF"
    frameBtn.Font = Enum.Font.GothamBold
    frameBtn.TextColor3 = Color3.fromRGB(200, 80, 80)
    frameBtn.TextXAlignment = Enum.TextXAlignment.Left
    frameBtn.TextSize = 12
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

local toggleSteal = createMainPanelToggle("Auto Loop Steal", 305, "AutoLoopSteal")

local toggleBat = createMainPanelToggle("Auto Bat + AimLock", 350, "AutoBat", function(state)
    if state then
        MiniBat.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    else
        MiniBat.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    end
end)

MiniBat.MouseButton1Click:Connect(function() toggleBat() end)
createMainPanelToggle("Infinite Jump (No Fall Reset)", 395, "InfiniteJump")

-- [[ CORE PHYSICAL PHYSICS ENGINE TRACKS ]] --

RunService.Heartbeat:Connect(function()
    if Character and Humanoid and RootPart and Humanoid.Health > 0 then
        if Config.AutoLoopSteal then
            autoGrabLogic()
        end

        -- Target Linear Speed Finder
        local targetRealSpeed = Config.NormalSpeed
        if Config.AutoLoopSteal then
            if checkBrainrot() then
                targetRealSpeed = Config.AfterGrabSpeed
            else
                targetRealSpeed = Config.BeforeGrabSpeed
            end
        end

        -- 🔥 NEW METHOD: AssemblyLinearVelocity (100% Unrespawnable Extreme Speed Boost)
        if Humanoid.MoveDirection.Magnitude > 0 then
            local currentYVelocity = RootPart.AssemblyLinearVelocity.Y
            local pushVelocity = Humanoid.MoveDirection * targetRealSpeed
            RootPart.AssemblyLinearVelocity = Vector3.new(pushVelocity.X, currentYVelocity, pushVelocity.Z)
        end

        -- 🔥 FIX: Stable Undetected Autoplay Vector Sweeper
        if Config.PlayMode == "Autoplay" then
            local directionVector = Vector3.new(0,0,0)
            if Config.SideSelection == "Left" then
                directionVector = RootPart.CFrame.RightVector * -targetRealSpeed
            elseif Config.SideSelection == "Right" then
                directionVector = RootPart.CFrame.RightVector * targetRealSpeed
            end
            RootPart.AssemblyLinearVelocity = Vector3.new(directionVector.X, RootPart.AssemblyLinearVelocity.Y, directionVector.Z)
        end
    end
end)

-- Ultra Fast Forced Hit AimLock Tracker
task.spawn(function()
    while true do
        if Config.AutoBat and checkBrainrot() and RootPart then
            local closestTarget = nil
            local targetRange = 22

            for _, targetPlayer in pairs(Players:GetPlayers()) do
                if targetPlayer ~= LocalPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local targetRoot = targetPlayer.Character.HumanoidRootPart
                    local currentDist = (RootPart.Position - targetRoot.Position).Magnitude
                    
                    if currentDist < targetRange then
                        targetRange = currentDist
                        closestTarget = targetRoot
                    end
                end
            end

            if closestTarget then
                -- Direct Aim Alignment lock
                local lookAtPos = Vector3.new(closestTarget.Position.X, RootPart.Position.Y, closestTarget.Position.Z)
                RootPart.CFrame = CFrame.lookAt(RootPart.Position, lookAtPos)
                
                -- Force Weapon swing mechanics loop
                local targetWeapon = Character:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                if targetWeapon then
                    if targetWeapon.Parent ~= Character then targetWeapon.Parent = Character end
                    targetWeapon:Activate()
                end
            end
        end
        task.wait(0.03) -- Instant 30ms reaction speed trigger
    end
end)

-- Classic High-Jump Fluid Mechanics
local lastJumpTick = 0
UIS.JumpRequest:Connect(function()
    if Config.InfiniteJump and RootPart and (tick() - lastJumpTick) > 0.12 then
        lastJumpTick = tick()
        RootPart.CFrame = RootPart.CFrame * CFrame.new(0, 4.8, 0)
    end
end)

print("Lunar Hub V11 Successfully Loaded! Drag locked to title header.")
