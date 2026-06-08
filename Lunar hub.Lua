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

createUIElementLabel("Features", 238)

local function createMainPanelToggle(name, y, configKey, callbackOn)
    local frameBtn = Instance.new("TextButton", ScrollFrame)
    frameBtn.Size = UDim2.new(0, 215, 0, 30) -- Medium sizing
    frameBtn.Position = UDim2.new(0, 12, 0, y)
    frameBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    frameBtn.Text = "  " .. name .. ": OFF"
    frameBtn.Font = Enum.Font.GothamBold
    frameBtn.TextColor3 = Color3.fromRGB(200, 80, 80)
    frameBtn.TextXAlignment = Enum.TextXAlignment.Left
    frameBtn.TextSize = 11
    Instance.new("UICorner", frameBtn).CornerRadius = UDim.new(0, 6)
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

local toggleSteal = createMainPanelToggle("Auto Loop Steal", 258, "AutoLoopSteal")
local toggleBat = createMainPanelToggle("Auto Bat + AimLock", 294, "AutoBat", function(state)
    if state then
        MiniBat.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    else
        MiniBat.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    end
end)

MiniBat.MouseButton1Click:Connect(function() toggleBat() end)
createMainPanelToggle("Infinite Jump (Safe Mode)", 330, "InfiniteJump")

-- [[ SECURE MOVEMENT & PHYSICS OVERRIDE ]] --

RunService.Heartbeat:Connect(function()
    if Character and Humanoid and RootPart and Humanoid.Health > 0 then
        if Config.AutoLoopSteal then
            autoGrabLogic()
        end

        local targetMaxSpeed = Config.NormalSpeed
        if Config.AutoLoopSteal then
            if checkBrainrot() then
                targetMaxSpeed = Config.AfterGrabSpeed
            else
                targetMaxSpeed = Config.BeforeGrabSpeed
            end
        end

        if Humanoid.MoveDirection.Magnitude > 0 then
            local adjustedDeltaOffset = Humanoid.MoveDirection * (targetMaxSpeed - 16) * 0.0155
            RootPart.CFrame = RootPart.CFrame + adjustedDeltaOffset
        end

        if Config.PlayMode == "Autoplay" then
            local stepVector = Vector3.new(0, 0, 0)
            if Config.SideSelection == "Left" then
                stepVector = RootPart.CFrame.RightVector * -0.28
            elseif Config.SideSelection == "Right" then
                stepVector = RootPart.CFrame.RightVector * 0.28
            end
            RootPart.CFrame = RootPart.CFrame + stepVector
        end
    end
end)

-- Fully Encrypted Local Replication Weapon Controller
task.spawn(function()
    while true do
        if Config.AutoBat and checkBrainrot() and RootPart then
            local targetingCap = nil
            local scanRange = 22

            for _, scanPlayer in pairs(Players:GetPlayers()) do
                if scanPlayer ~= LocalPlayer and scanPlayer.Character and scanPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local playerRoot = scanPlayer.Character.HumanoidRootPart
                    local currentRange = (RootPart.Position - playerRoot.Position).Magnitude
                    
                    if currentRange < scanRange then
                        scanRange = currentRange
                        targetingCap = playerRoot
                    end
                end
            end

            if targetingCap then
                local visualMatrix = Vector3.new(targetingCap.Position.X, RootPart.Position.Y, targetingCap.Position.Z)
                RootPart.CFrame = CFrame.lookAt(RootPart.Position, visualMatrix)
                
                local systemTool = Character:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                if systemTool then
                    if systemTool.Parent ~= Character then systemTool.Parent = Character end
                    pcall(function()
                        systemTool:Activate()
                    end)
                end
            end
        end
        task.wait(0.04)
    end
end)

-- Safe Micro-Interval High Jump
local lastSafeJump = 0
UIS.JumpRequest:Connect(function()
    if Config.InfiniteJump and RootPart and (tick() - lastSafeJump) > 0.15 then
        lastSafeJump = tick()
        RootPart.CFrame = RootPart.CFrame * CFrame.new(0, 4.5, 0)
    end
end)

print("Lunar Hub Duel Script: Compact Version Deployed!")
