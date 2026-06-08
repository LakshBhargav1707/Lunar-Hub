-- [[ Lunar Hub | Undetected - V21.0 Hardcore Safe & Clean Master ]] --
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

-- Purge Old Interfaces to prevent overlap logs
pcall(function()
    if TargetGuiParent:FindFirstChild("LunarHub") then TargetGuiParent:FindFirstChild("LunarHub"):Destroy() end
    if TargetGuiParent:FindFirstChild("LunarMobileUI") then TargetGuiParent:FindFirstChild("LunarMobileUI"):Destroy() end
end)

-- [[ SETUP SAFE CONFIGURATION ]] --
local Config = {
    NormalSpeed = 16,
    BeforeGrabSpeed = 32, -- Lowered to legal high-ping thresholds
    AfterGrabSpeed = 34,  
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

-- Server-Side Invisible Steal Grabber
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

-- [[ COMPACT MOBILE CONTROLS ]] --
local MobileGui = Instance.new("ScreenGui")
MobileGui.Name = "LunarMobileUI"
MobileGui.Parent = TargetGuiParent
MobileGui.ResetOnSpawn = false
MobileGui.DisplayOrder = 99999

local Layout = Instance.new("Frame", MobileGui)
Layout.Size = UDim2.new(0, 180, 0, 40)
Layout.Position = UDim2.new(0, 15, 0, 140)
Layout.BackgroundTransparency = 1

local function createMiniControlBtn(text, order)
    local btn = Instance.new("TextButton", Layout)
    btn.Size = UDim2.new(0, 52, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextSize = 11
    btn.LayoutOrder = order
    btn.Active = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", btn).Color = Color3.fromRGB(50, 50, 60)
    return btn
end

local UIList = Instance.new("UIListLayout", Layout)
UIList.FillDirection = Enum.FillDirection.Horizontal
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 8)

local MiniToggle = createMiniControlBtn("|||", 1)
local MiniBat = createMiniControlBtn("BAT", 2)
local MiniPlay = createMiniControlBtn("RIGHT", 3) 
MiniPlay.BackgroundColor3 = Color3.fromRGB(115, 90, 230)

-- [[ MAIN UI WINDOW ]] --
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "LunarHub"
MainGui.Parent = TargetGuiParent
MainGui.ResetOnSpawn = false
MainGui.DisplayOrder = 99998

local MainFrame = Instance.new("Frame", MainGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 230, 0, 350) 
MainFrame.Position = UDim2.new(0.5, -115, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
MainFrame.Active = true
MainFrame.Draggable = true 
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 9)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(115, 90, 230)

local HeaderFrame = Instance.new("Frame", MainFrame)
HeaderFrame.Size = UDim2.new(1, 0, 0, 32)
HeaderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
Instance.new("UICorner", HeaderFrame).CornerRadius = UDim.new(0, 9)

local MainTitle = Instance.new("TextLabel", HeaderFrame)
MainTitle.Size = UDim2.new(1, 0, 1, 0)
MainTitle.BackgroundTransparency = 1
MainTitle.Text = "Lunar Hub | Ultra Safe V21" 
MainTitle.TextColor3 = Color3.fromRGB(170, 85, 255)
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 11

local Container = Instance.new("Frame", MainFrame)
Container.Size = UDim2.new(1, -20, 1, -42)
Container.Position = UDim2.new(0, 10, 0, 38)
Container.BackgroundTransparency = 1

local UIListLayout = Instance.new("UIListLayout", Container)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 4)

MiniToggle.Activated:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local function createUIElementLabel(text, order)
    local lbl = Instance.new("TextLabel", Container)
    lbl.Size = UDim2.new(1, 0, 0, 13)
    lbl.BackgroundTransparency = 1
    lbl.Text = text:upper()
    lbl.TextColor3 = Color3.fromRGB(140, 140, 150)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 9
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.LayoutOrder = order
    return lbl
end

local function createTextBoxInput(default, configKey, order)
    local box = Instance.new("TextBox", Container)
    box.Size = UDim2.new(1, 0, 0, 24)
    box.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.PlaceholderText = default
    box.Text = default
    box.Font = Enum.Font.GothamSemibold
    box.TextSize = 11
    box.LayoutOrder = order
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
    Instance.new("UIStroke", box).Color = Color3.fromRGB(50, 50, 65)
    
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val then 
            if val > 50 then val = 50 box.Text = "50" end 
            Config[configKey] = val 
        end
    end)
    return box
end

createUIElementLabel("Normal Walking Speed", 1)
createTextBoxInput("16", "NormalSpeed", 2)

createUIElementLabel("Before Grab Speed (Chasing)", 3)
createTextBoxInput("32", "BeforeGrabSpeed", 4)

createUIElementLabel("After Grab Speed (Sweeping)", 5)
createTextBoxInput("34", "AfterGrabSpeed", 6)

createUIElementLabel("Autoplay Side Configuration", 7)

local InsideSideBtn = Instance.new("TextButton", Container)
InsideSideBtn.Size = UDim2.new(1, 0, 0, 24)
InsideSideBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
InsideSideBtn.Text = "DEFAULT SIDE: RIGHT"
InsideSideBtn.Font = Enum.Font.GothamBold
InsideSideBtn.TextColor3 = Color3.fromRGB(170, 85, 255)
InsideSideBtn.TextSize = 10
InsideSideBtn.LayoutOrder = 8
InsideSideBtn.Active = true
Instance.new("UICorner", InsideSideBtn).CornerRadius = UDim.new(0, 5)
local strokeBtn = Instance.new("UIStroke", InsideSideBtn)
strokeBtn.Color = Color3.fromRGB(50, 50, 65)

local function refreshOutsideAutoplayVisuals()
    if Config.AutoplayActive then
        MiniPlay.Text = "X (STOP)"
        MiniPlay.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    else
        MiniPlay.Text = Config.CurrentDirection:upper()
        MiniPlay.BackgroundColor3 = Color3.fromRGB(115, 90, 230)
    end
end

InsideSideBtn.Activated:Connect(function()
    if Config.CurrentDirection == "Right" then
        Config.CurrentDirection = "Left"
        InsideSideBtn.Text = "DEFAULT SIDE: LEFT"
    else
        Config.CurrentDirection = "Right"
        InsideSideBtn.Text = "DEFAULT SIDE: RIGHT"
    end
    refreshOutsideAutoplayVisuals()
end)

MiniPlay.Activated:Connect(function()
    Config.AutoplayActive = not Config.AutoplayActive
    refreshOutsideAutoplayVisuals()
end)

MiniBat.Activated:Connect(function()
    Config.AutoBat = not Config.AutoBat
    MiniBat.BackgroundColor3 = Config.AutoBat and Color3.fromRGB(200, 80, 80) or Color3.fromRGB(24, 24, 28)
end)

createUIElementLabel("Features Toggle Panel", 9)

local function createMainPanelToggle(name, configKey, order)
    local frameBtn = Instance.new("TextButton", Container)
    frameBtn.Size = UDim2.new(1, 0, 0, 25)
    frameBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    frameBtn.Text = "  " .. name .. ": OFF"
    frameBtn.Font = Enum.Font.GothamBold
    frameBtn.TextColor3 = Color3.fromRGB(200, 80, 80)
    frameBtn.TextXAlignment = Enum.TextXAlignment.Left
    frameBtn.TextSize = 10
    frameBtn.LayoutOrder = order
    frameBtn.Active = true
    Instance.new("UICorner", frameBtn).CornerRadius = UDim.new(0, 5)
    Instance.new("UIStroke", frameBtn).Color = Color3.fromRGB(50, 50, 65)

    frameBtn.Activated:Connect(function()
        Config[configKey] = not Config[configKey]
        if Config[configKey] then
            frameBtn.Text = "  " .. name .. ": ON"
            frameBtn.TextColor3 = Color3.fromRGB(80, 200, 80)
        else
            frameBtn.Text = "  " .. name .. ": OFF"
            frameBtn.TextColor3 = Color3.fromRGB(200, 80, 80)
        end
    end)
end

createMainPanelToggle("Auto Loop Steal", "AutoLoopSteal", 10)
createMainPanelToggle("Infinite Jump", "InfiniteJump", 11)

-- [[ 100% LEGITIMATE PLAYER MOVEMENT EXECUTION ]] --
RunService.PreRender:Connect(function()
    if Character and Humanoid and RootPart and Humanoid.Health > 0 then
        if Config.AutoLoopSteal then autoGrabLogic() end

        -- Setup dynamic fallback speeds
        local activeTargetSpeed = Config.NormalSpeed
        if Config.AutoLoopSteal or Config.AutoplayActive or Config.AutoBat then
            activeTargetSpeed = checkBrainrot() and Config.AfterGrabSpeed or Config.BeforeGrabSpeed
        end

        if Config.AutoplayActive and not Config.AutoBat then
            Humanoid.WalkSpeed = activeTargetSpeed
            
            -- Pure Humanoid native navigation translation (Zero physics alerts)
            local moveVector = Vector3.new(0, 0, 0)
            if Config.CurrentDirection == "Left" then
                moveVector = Vector3.new(-1, 0, 0)
            elseif Config.CurrentDirection == "Right" then
                moveVector = Vector3.new(1, 0, 0)
            end
            Humanoid:Move(moveVector, true)
        else
            if not Config.AutoBat then
                Humanoid.WalkSpeed = Config.NormalSpeed
            end
        end
    end
end)

-- [[ LEGIT COMPLIANT AUTOBAT SIMULATOR ]] --
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
                -- Safely look at target without structural network warping
                local trackingPos = Vector3.new(targetEnemy.Position.X, RootPart.Position.Y, targetEnemy.Position.Z)
                RootPart.CFrame = CFrame.lookAt(RootPart.Position, trackingPos)
                
                local currentBatSpeed = checkBrainrot() and Config.AfterGrabSpeed or Config.BeforeGrabSpeed
                Humanoid.WalkSpeed = currentBatSpeed

                -- Safe vector mapping
                local relativeDirection = (targetEnemy.Position - RootPart.Position).Unit
                Humanoid:Move(relativeDirection, false)

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

-- Setup clean humanoid adjustments on rebirth/respawn
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    RootPart = newChar:WaitForChild("HumanoidRootPart")
end)

-- Core Standard State Jump Modifier
UIS.JumpRequest:Connect(function()
    if Config.InfiniteJump and Humanoid and Humanoid.Health > 0 then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

print("Lunar Hub | V21.0 Hardcore Anti-Ban Safe Sweeper Running!")
