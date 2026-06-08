-- [[ Lunar Hub | Undetected V1 — Full Functional Minimize/Maximize Edition ]] --
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

local TargetGuiParent = nil
pcall(function()
    if CoreGui and type(CoreGui) == "userdata" then TargetGuiParent = CoreGui end
end)
if not TargetGuiParent then TargetGuiParent = LocalPlayer:WaitForChild("PlayerGui") end

-- Purge any old versions to prevent memory overlap
pcall(function()
    if TargetGuiParent:FindFirstChild("LunarHub_V1") then TargetGuiParent:FindFirstChild("LunarHub_V1"):Destroy() end
end)

-- [[ GLOBAL ENGINE CONFIG ]] --
local Config = {
    NormalSpeed = 16,
    BeforeGrabSpeed = 32, 
    AfterGrabSpeed = 35,  
    CurrentDirection = "Right", 
    AutoplayActive = false,
    AutoLoopSteal = false,
    AutoBat = false,
    InfiniteJump = false
}

local function checkBrainrot()
    if Character then
        return Character:FindFirstChild("Brainrot") or LocalPlayer.Backpack:FindFirstChild("Brainrot") or 
               Character:FindFirstChild("brainrot") or LocalPlayer.Backpack:FindFirstChild("brainrot")
    end
    return false
end

-- Server-Side Hitbox Steal Trigger
local function autoGrabLogic()
    if Character and RootPart and not checkBrainrot() then
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Tool") and (obj.Name:lower() == "brainrot" or obj:FindFirstChild("Handle")) then
                local handle = obj:FindFirstChild("Handle") or obj
                if handle:IsA("BasePart") and (RootPart.Position - handle.Position).Magnitude < 35 then
                    pcall(function()
                        firetouchinterest(handle, RootPart, 0)
                        firetouchinterest(handle, RootPart, 1)
                        obj.Parent = Character
                    end)
                    break
                end
            end
        end
    end
end

-- [[ MAIN SCREEN GUI CANVAS ]] --
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "LunarHub_V1"
MainGui.Parent = TargetGuiParent
MainGui.ResetOnSpawn = false
MainGui.DisplayOrder = 99999

-- [[ FLOATING MINIMIZED ICON BUTTON ]] --
local MinimizedIcon = Instance.new("TextButton", MainGui)
MinimizedIcon.Name = "MinimizedIcon"
MinimizedIcon.Size = UDim2.new(0, 45, 0, 45)
MinimizedIcon.Position = UDim2.new(0, 15, 0, 140) -- Perfect screen position
MinimizedIcon.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
MinimizedIcon.Text = "🌙"
MinimizedIcon.TextSize = 18
MinimizedIcon.Font = Enum.Font.GothamBold
MinimizedIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizedIcon.Visible = false -- Off initially since main frame is open
MinimizedIcon.Active = true
MinimizedIcon.Draggable = true
Instance.new("UICorner", MinimizedIcon).CornerRadius = UDim.new(0, 12)
local IconStroke = Instance.new("UIStroke", MinimizedIcon)
IconStroke.Color = Color3.fromRGB(115, 90, 230)
IconStroke.Width = 1.5

-- [[ MAIN STRUCTURED VERTICAL PANEL FRAME ]] --
local MainFrame = Instance.new("Frame", MainGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 240, 0, 410)
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -205)
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 16)
MainFrame.Active = true
MainFrame.Draggable = true 
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
local FrameBorder = Instance.new("UIStroke", MainFrame)
FrameBorder.Color = Color3.fromRGB(115, 90, 230)
FrameBorder.Transparency = 0.2

-- Header Navigation Bar
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 34)
Header.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 8)

local TitleText = Instance.new("TextLabel", Header)
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Lunar Hub | Undetected V1"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 11
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- SMART MINIMIZE BUTTON (-)
local MinimizeBtn = Instance.new("TextButton", Header)
MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
MinimizeBtn.Position = UDim2.new(1, -30, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 10
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 6)

-- Toggle Windows System Callbacks
MinimizeBtn.Activated:Connect(function()
    MainFrame.Visible = false
    MinimizedIcon.Visible = true
end)

MinimizedIcon.Activated:Connect(function()
    MinimizedIcon.Visible = false
    MainFrame.Visible = true
    MainFrame.Position = UDim2.new(0.5, -120, 0.5, -205) -- Reset center layout cleanly
end)

-- Scroll Deck Container
local ContainerScroll = Instance.new("ScrollingFrame", MainFrame)
ContainerScroll.Size = UDim2.new(1, -16, 1, -44)
ContainerScroll.Position = UDim2.new(0, 8, 0, 38)
ContainerScroll.BackgroundTransparency = 1
ContainerScroll.CanvasSize = UDim2.new(0, 0, 0, 480)
ContainerScroll.ScrollBarThickness = 2
ContainerScroll.ScrollBarImageColor3 = Color3.fromRGB(115, 90, 230)

local FlowLayout = Instance.new("UIListLayout", ContainerScroll)
FlowLayout.SortOrder = Enum.SortOrder.LayoutOrder
FlowLayout.Padding = UDim.new(0, 6)

local function appendSectionTitle(text, order)
    local block = Instance.new("TextLabel", ContainerScroll)
    block.Size = UDim2.new(1, 0, 0, 16)
    block.BackgroundTransparency = 1
    block.Text = text:upper()
    block.TextColor3 = Color3.fromRGB(140, 140, 155)
    block.Font = Enum.Font.GothamBold
    block.TextSize = 9
    block.TextXAlignment = Enum.TextXAlignment.Left
    block.LayoutOrder = order
    return block
end

local function appendNumericalValueInput(label, key, defaultVal, order)
    appendSectionTitle(label, order)
    
    local entryBox = Instance.new("TextBox", ContainerScroll)
    entryBox.Size = UDim2.new(1, 0, 0, 26)
    entryBox.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    entryBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    entryBox.Text = tostring(defaultVal)
    entryBox.Font = Enum.Font.GothamSemibold
    entryBox.TextSize = 11
    entryBox.LayoutOrder = order + 1
    Instance.new("UICorner", entryBox).CornerRadius = UDim.new(0, 5)
    local stroke = Instance.new("UIStroke", entryBox)
    stroke.Color = Color3.fromRGB(50, 50, 65)

    entryBox.FocusLost:Connect(function()
        local convertedNum = tonumber(entryBox.Text)
        if convertedNum then
            if convertedNum > 50 then convertedNum = 50 entryBox.Text = "50" end
            Config[key] = convertedNum
        end
    end)
end

local function appendFunctionalToggle(name, key, order)
    local actionBtn = Instance.new("TextButton", ContainerScroll)
    actionBtn.Size = UDim2.new(1, 0, 0, 28)
    actionBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    actionBtn.Text = "   " .. name .. ": OFF"
    actionBtn.TextColor3 = Color3.fromRGB(240, 100, 100)
    actionBtn.Font = Enum.Font.GothamBold
    actionBtn.TextXAlignment = Enum.TextXAlignment.Left
    actionBtn.TextSize = 10
    actionBtn.LayoutOrder = order
    Instance.new("UICorner", actionBtn).CornerRadius = UDim.new(0, 5)
    local stroke = Instance.new("UIStroke", actionBtn)
    stroke.Color = Color3.fromRGB(50, 50, 65)

    actionBtn.Activated:Connect(function()
        Config[key] = not Config[key]
        if Config[key] then
            actionBtn.Text = "   " .. name .. ": ON"
            actionBtn.TextColor3 = Color3.fromRGB(100, 240, 140)
            actionBtn.BackgroundColor3 = Color3.fromRGB(22, 35, 26)
        else
            actionBtn.Text = "   " .. name .. ": OFF"
            actionBtn.TextColor3 = Color3.fromRGB(240, 100, 100)
            actionBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
        end
    end)
    return actionBtn
end

-- Assemble Options Setup (Revul Clone Layout)
appendNumericalValueInput("Base Default WalkSpeed", "NormalSpeed", 16, 1)
appendNumericalValueInput("Chasing Target Velocity (Before Grab)", "BeforeGrabSpeed", 32, 3)
appendNumericalValueInput("Sweeping Velocity Load (After Grab)", "AfterGrabSpeed", 35, 5)

appendSectionTitle("Autoplay Side Configuration", 7)
local DirectionSelector = Instance.new("TextButton", ContainerScroll)
DirectionSelector.Size = UDim2.new(1, 0, 0, 28)
DirectionSelector.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
DirectionSelector.Text = "DEFAULT SIDE: RIGHT"
DirectionSelector.TextColor3 = Color3.fromRGB(155, 130, 255)
DirectionSelector.Font = Enum.Font.GothamBold
DirectionSelector.TextSize = 10
DirectionSelector.LayoutOrder = 8
Instance.new("UICorner", DirectionSelector).CornerRadius = UDim.new(0, 5)
local dirStroke = Instance.new("UIStroke", DirectionSelector)
dirStroke.Color = Color3.fromRGB(50, 50, 65)

DirectionSelector.Activated:Connect(function()
    if Config.CurrentDirection == "Right" then
        Config.CurrentDirection = "Left"
        DirectionSelector.Text = "DEFAULT SIDE: LEFT"
    else
        Config.CurrentDirection = "Right"
        DirectionSelector.Text = "DEFAULT SIDE: RIGHT"
    end
end)

appendSectionTitle("Features Toggle Panel", 9)
appendFunctionalToggle("Autoplay State Engine", "AutoplayActive", 10)
appendFunctionalToggle("Auto Loop Steal", "AutoLoopSteal", 11)
appendFunctionalToggle("Auto Engage Bat", "AutoBat", 12)
appendFunctionalToggle("Infinite Jump", "InfiniteJump", 13)

-- [[ DYNAMIC POSITION TRANSLATION LOOP ]] --
RunService.Heartbeat:Connect(function(deltaTime)
    if Character and Humanoid and RootPart and Humanoid.Health > 0 then
        if Config.AutoLoopSteal then autoGrabLogic() end

        local targetWalkSpeed = Config.NormalSpeed
        if Config.AutoLoopSteal or Config.AutoplayActive or Config.AutoBat then
            targetWalkSpeed = checkBrainrot() and Config.AfterGrabSpeed or Config.BeforeGrabSpeed
        end

        if Config.AutoplayActive and not Config.AutoBat then
            local velocityTranslation = Vector3.new(0, 0, 0)
            if Config.CurrentDirection == "Left" then
                velocityTranslation = RootPart.CFrame.RightVector * -targetWalkSpeed
            elseif Config.CurrentDirection == "Right" then
                velocityTranslation = RootPart.CFrame.RightVector * targetWalkSpeed
            end
            RootPart.CFrame = RootPart.CFrame + Vector3.new(velocityTranslation.X * deltaTime, 0, velocityTranslation.Z * deltaTime)
        end
    end
end)

-- [[ COMBAT CHASE SUBSYSTEM ]] --
task.spawn(function()
    while true do
        local deltaTime = task.wait(0.015)
        if Config.AutoBat and RootPart and Character and Humanoid.Health > 0 then
            local targetEnemy = nil
            local shortestDistance = math.huge

            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    local dist = (RootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if dist < shortestDistance then
                        shortestDistance = dist
                        targetEnemy = player.Character.HumanoidRootPart
                    end
                end
            end

            if targetEnemy then
                RootPart.CFrame = CFrame.lookAt(RootPart.Position, Vector3.new(targetEnemy.Position.X, RootPart.Position.Y, targetEnemy.Position.Z))
                
                local activeSpeed = checkBrainrot() and Config.AfterGrabSpeed or Config.BeforeGrabSpeed
                local moveDir = (targetEnemy.Position - RootPart.Position).Unit
                RootPart.CFrame = RootPart.CFrame + Vector3.new(moveDir.X * activeSpeed * deltaTime, 0, moveDir.Z * activeSpeed * deltaTime)

                local weaponTool = Character:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                if weaponTool then
                    if weaponTool.Parent ~= Character then weaponTool.Parent = Character end
                    pcall(function() weaponTool:Activate() end)
                end
            end
        end
    end
end)

-- Infinite Jump Hook
UIS.JumpRequest:Connect(function()
    if Config.InfiniteJump and Humanoid and Humanoid.Health > 0 then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    RootPart = newChar:WaitForChild("HumanoidRootPart")
end)

print("Lunar Hub | Undetected V1 Matrix Setup Loaded!")
