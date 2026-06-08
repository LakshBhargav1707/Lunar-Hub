-- [[ Lunar Hub | Undetected V1 - Complete Revul Layout Emulation ]] --
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

-- Complete wipeout of old minimal mobile decks
pcall(function()
    if TargetGuiParent:FindFirstChild("LunarHub") then TargetGuiParent:FindFirstChild("LunarHub"):Destroy() end
    if TargetGuiParent:FindFirstChild("LunarMobileUI") then TargetGuiParent:FindFirstChild("LunarMobileUI"):Destroy() end
end)

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

-- [[ REVUL DECK SIDE MINI-BAR TRIGGER ]] --
local MobileGui = Instance.new("ScreenGui")
MobileGui.Name = "LunarMobileUI"
MobileGui.Parent = TargetGuiParent
MobileGui.ResetOnSpawn = false

local MiniLayout = Instance.new("Frame", MobileGui)
MiniLayout.Size = UDim2.new(0, 140, 0, 40)
MiniLayout.Position = UDim2.new(0, 15, 0, 145)
MiniLayout.BackgroundTransparency = 1

local MiniUIList = Instance.new("UIListLayout", MiniLayout)
MiniUIList.FillDirection = Enum.FillDirection.Horizontal
MiniUIList.SortOrder = Enum.SortOrder.LayoutOrder
MiniUIList.Padding = UDim.new(0, 6)

local function createMiniAccessBtn(text, order)
    local btn = Instance.new("TextButton", MiniLayout)
    btn.Size = UDim2.new(0, 42, 0, 28)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    btn.TextColor3 = Color3.fromRGB(240, 240, 250)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextSize = 10
    btn.LayoutOrder = order
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(60, 60, 75)
    return btn
end

local MiniToggle = createMiniAccessBtn("|||", 1)
local MiniBat = createMiniAccessBtn("BAT", 2)
local MiniSide = createMiniAccessBtn("RGT", 3)
MiniSide.BackgroundColor3 = Color3.fromRGB(85, 70, 180)

-- [[ MAIN ADVANCED VERTICAL PANEL FRAME ]] --
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "LunarHub"
MainGui.Parent = TargetGuiParent
MainGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", MainGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 240, 0, 410) -- High structured canvas
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -205)
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 16)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
local FrameBorder = Instance.new("UIStroke", MainFrame)
FrameBorder.Color = Color3.fromRGB(65, 65, 80)
FrameBorder.Transparency = 0.3

-- Top Navigation Header Bar
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 36)
Header.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 8)

local TitleText = Instance.new("TextLabel", Header)
TitleText.Size = UDim2.new(1, 0, 1, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "LUNAR HUB | UNDETECTED V1"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 11

local ContainerScroll = Instance.new("ScrollingFrame", MainFrame)
ContainerScroll.Size = UDim2.new(1, -20, 1, -48)
ContainerScroll.Position = UDim2.new(0, 10, 0, 42)
ContainerScroll.BackgroundTransparency = 1
ContainerScroll.CanvasSize = UDim2.new(0, 0, 0, 520)
ContainerScroll.ScrollBarThickness = 2
ContainerScroll.ScrollBarImageColor3 = Color3.fromRGB(85, 70, 180)

local FlowLayout = Instance.new("UIListLayout", ContainerScroll)
FlowLayout.SortOrder = Enum.SortOrder.LayoutOrder
FlowLayout.Padding = UDim.new(0, 6)

MiniToggle.Activated:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- UI Building Auxiliary Blocks
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
        if key == "AutoBat" then
            MiniBat.BackgroundColor3 = Config.AutoBat and Color3.fromRGB(240, 100, 100) or Color3.fromRGB(20, 20, 25)
        end
    end)
    return actionBtn
end

-- Assemble Parameters exactly matching requested structures
appendNumericalValueInput("Base Default WalkSpeed", "NormalSpeed", 16, 1)
appendNumericalValueInput("Chasing Target Velocity (Before Grab)", "BeforeGrabSpeed", 32, 3)
appendNumericalValueInput("Sweeping Velocity Load (After Grab)", "AfterGrabSpeed", 35, 5)

appendSectionTitle("Side Selection & Modes", 7)
local DirectionSelector = Instance.new("TextButton", ContainerScroll)
DirectionSelector.Size = UDim2.new(1, 0, 0, 28)
DirectionSelector.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
DirectionSelector.Text = "MODE SIDE DIRECTION: RIGHT"
DirectionSelector.TextColor3 = Color3.fromRGB(155, 130, 255)
DirectionSelector.Font = Enum.Font.GothamBold
DirectionSelector.TextSize = 10
DirectionSelector.LayoutOrder = 8
Instance.new("UICorner", DirectionSelector).CornerRadius = UDim.new(0, 5)
local dirStroke = Instance.new("UIStroke", DirectionSelector)
dirStroke.Color = Color3.fromRGB(50, 50, 65)

local function evaluateSideSync()
    if Config.AutoplayActive then
        MiniSide.Text = "STOP"
        MiniSide.BackgroundColor3 = Color3.fromRGB(220, 80, 80)
    else
        MiniSide.Text = (Config.CurrentDirection == "Right") and "RGT" or "LFT"
        MiniSide.BackgroundColor3 = Color3.fromRGB(85, 70, 180)
    end
end

DirectionSelector.Activated:Connect(function()
    if Config.CurrentDirection == "Right" then
        Config.CurrentDirection = "Left"
        DirectionSelector.Text = "MODE SIDE DIRECTION: LEFT"
    else
        Config.CurrentDirection = "Right"
        DirectionSelector.Text = "MODE SIDE DIRECTION: RIGHT"
    end
    evaluateSideSync()
end)

MiniSide.Activated:Connect(function()
    Config.AutoplayActive = not Config.AutoplayActive
    evaluateSideSync()
end)

MiniBat.Activated:Connect(function()
    Config.AutoBat = not Config.AutoBat
    MiniBat.BackgroundColor3 = Config.AutoBat and Color3.fromRGB(240, 100, 100) or Color3.fromRGB(20, 20, 25)
end)

appendSectionTitle("Main Engine Utilities", 9)
local ToggleSteal = appendFunctionalToggle("Auto Loop Steal", "AutoLoopSteal", 10)
local ToggleJump = appendFunctionalToggle("Infinite Player Jump", "InfiniteJump", 11)

-- [[ DYNAMIC ANTI-CHEATING CONTROL SCHEDULER ]] --
RunService.PreRender:Connect(function()
    if Character and Humanoid and RootPart and Humanoid.Health > 0 then
        if Config.AutoLoopSteal then autoGrabLogic() end

        local adaptiveSpeedValue = Config.NormalSpeed
        if Config.AutoLoopSteal or Config.AutoplayActive or Config.AutoBat then
            adaptiveSpeedValue = checkBrainrot() and Config.AfterGrabSpeed or Config.BeforeGrabSpeed
        end

        if Config.AutoplayActive and not Config.AutoBat then
            Humanoid.WalkSpeed = adaptiveSpeedValue
            local movementVector = (Config.CurrentDirection == "Right") and Vector3.new(1, 0, 0) or Vector3.new(-1, 0, 0)
            Humanoid:Move(movementVector, true)
        else
            if not Config.AutoBat then
                Humanoid.WalkSpeed = Config.NormalSpeed
            end
        end
    end
end)

-- [[ COMBAT INTERCEPT ENGINE ]] --
task.spawn(function()
    while true do
        task.wait(0.015)
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
                local trackingAdjustment = Vector3.new(targetEnemy.Position.X, RootPart.Position.Y, targetEnemy.Position.Z)
                RootPart.CFrame = CFrame.lookAt(RootPart.Position, trackingAdjustment)
                
                Humanoid.WalkSpeed = checkBrainrot() and Config.AfterGrabSpeed or Config.BeforeGrabSpeed
                Humanoid:Move((targetEnemy.Position - RootPart.Position).Unit, false)

                local weaponTool = Character:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                if weaponTool then
                    if weaponTool.Parent ~= Character then weaponTool.Parent = Character end
                    pcall(function() weaponTool:Activate() end)
                end
            else
                if not Config.AutoplayActive then Humanoid:Move(Vector3.new(0,0,0), false) end
            end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    RootPart = newChar:WaitForChild("HumanoidRootPart")
end)

UIS.JumpRequest:Connect(function()
    if Config.InfiniteJump and Humanoid and Humanoid.Health > 0 then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

print("Lunar Hub | Undetected V1 Matrix Setup Loaded!")
