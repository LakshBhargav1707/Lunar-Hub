 -- [[ Lunar Hub | Undetected - V18.0 Tactical X-Ray & Night Vision Patch ]] --
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local TargetGuiParent = nil
pcall(function()
    if CoreGui and type(CoreGui) == "userdata" then TargetGuiParent = CoreGui end
end)
if not TargetGuiParent then TargetGuiParent = LocalPlayer:WaitForChild("PlayerGui") end

-- Clean Up Previous Instances Completely
pcall(function()
    if TargetGuiParent:FindFirstChild("LunarHub") then TargetGuiParent:FindFirstChild("LunarHub"):Destroy() end
    if TargetGuiParent:FindFirstChild("LunarMobileUI") then TargetGuiParent:FindFirstChild("LunarMobileUI"):Destroy() end
end)

-- [[ CONFIGURATION SYSTEM ]] --
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
    BeforeGrabSpeed = 38, 
    AfterGrabSpeed = 40,  
    CurrentDirection = "Right", 
    AutoplayActive = false,
    AutoLoopSteal = false,
    AutoBat = false,
    InfiniteJump = false,
    NightVision = false
}

-- Default Lighting Cache for smooth restoration
local OriginalLightingCache = {
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    ClockTime = Lighting.ClockTime,
    Brightness = Lighting.Brightness,
    Exposure = Lighting.ExposureCompensation
}

-- Brainrot Inventory Scanner
local function checkBrainrot()
    if Character then
        return Character:FindFirstChild("Brainrot") or LocalPlayer.Backpack:FindFirstChild("Brainrot") or 
               Character:FindFirstChild("brainrot") or LocalPlayer.Backpack:FindFirstChild("brainrot")
    end
    return false
end

-- Snatcher Mechanics (Network Injected Handlers)
local function autoGrabLogic()
    if Character and RootPart and not checkBrainrot() then
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Tool") and (obj.Name:lower() == "brainrot" or obj:FindFirstChild("Handle")) then
                local handle = obj:FindFirstChild("Handle") or obj
                if handle:IsA("BasePart") and (RootPart.Position - handle.Position).Magnitude < 55 then
                    pcall(function()
                        firetouchinterest(handle, RootPart, 0)
                        firetouchinterest(handle, RootPart, 1)
                        obj.Parent = Character
                    end)
                    break
                end
            end
        end

        for _, pl in pairs(Players:GetPlayers()) do
            if pl ~= LocalPlayer and pl.Character then
                local enemyTool = pl.Character:FindFirstChild("Brainrot") or pl.Character:FindFirstChild("brainrot")
                if enemyTool and enemyTool:IsA("Tool") then
                    local handle = enemyTool:FindFirstChild("Handle")
                    if handle and handle:IsA("BasePart") and (RootPart.Position - handle.Position).Magnitude < 55 then
                        pcall(function()
                            firetouchinterest(handle, RootPart, 0)
                            firetouchinterest(handle, RootPart, 1)
                            enemyTool.Parent = Character
                        end)
                    end
                end
            end
        end
    end
end

-- [[ OUTSIDE THE PANEL - TINY MOBILE CONTROLS ]] --
local MobileGui = Instance.new("ScreenGui")
MobileGui.Name = "LunarMobileUI"
MobileGui.Parent = TargetGuiParent
MobileGui.ResetOnSpawn = false
MobileGui.DisplayOrder = 99999

local Layout = Instance.new("Frame", MobileGui)
Layout.Size = UDim2.new(0, 180, 0, 40)
Layout.Position = UDim2.new(0, 15, 0, 140)
Layout.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", Layout)
UIList.FillDirection = Enum.FillDirection.Horizontal
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 8)

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

local MiniToggle = createMiniControlBtn("|||", 1)
local MiniBat = createMiniControlBtn("BAT", 2)
local MiniPlay = createMiniControlBtn("RIGHT", 3) 
MiniPlay.BackgroundColor3 = Color3.fromRGB(115, 90, 230)

-- [[ INTERIOR MAIN PANEL ]] --
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "LunarHub"
MainGui.Parent = TargetGuiParent
MainGui.ResetOnSpawn = false
MainGui.DisplayOrder = 99998

local MainFrame = Instance.new("Frame", MainGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 210, 0, 345)
MainFrame.Position = UDim2.new(0.5, -105, 0.5, -172)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Active = true
MainFrame.Draggable = true 
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(55, 45, 90)

local HeaderFrame = Instance.new("Frame", MainFrame)
HeaderFrame.Size = UDim2.new(1, 0, 0, 32)
HeaderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
Instance.new("UICorner", HeaderFrame).CornerRadius = UDim.new(0, 8)

local MainTitle = Instance.new("TextLabel", HeaderFrame)
MainTitle.Size = UDim2.new(1, 0, 1, 0)
MainTitle.BackgroundTransparency = 1
MainTitle.Text = "Lunar Hub | Undetected" 
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

MiniToggle.Activated:Connect(function() 
    MainFrame.Visible = not MainFrame.Visible 
end)

local function createUIElementLabel(text, order)
    local lbl = Instance.new("TextLabel", Container)
    lbl.Size = UDim2.new(1, 0, 0, 14)
    lbl.BackgroundTransparency = 1
    lbl.Text = text:upper()
    lbl.TextColor3 = Color3.fromRGB(130, 130, 140)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 9
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.LayoutOrder = order
    return lbl
end

local function createTextBoxInput(default, configKey, order)
    local box = Instance.new("TextBox", Container)
    box.Size = UDim2.new(1, 0, 0, 24)
    box.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.PlaceholderText = default
    box.Text = default
    box.Font = Enum.Font.GothamSemibold
    box.TextSize = 11
    box.LayoutOrder = order
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
    Instance.new("UIStroke", box).Color = Color3.fromRGB(45, 45, 55)
    
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val then 
            if val > 65 then val = 65 box.Text = "65" end 
            Config[configKey] = val 
        end
    end)
    return box
end

-- RENDER SPEED INPUTS
createUIElementLabel("Speed Control", 1)
createTextBoxInput("16", "NormalSpeed", 2)
createUIElementLabel("Before Grab Speed", 3)
createTextBoxInput("38", "BeforeGrabSpeed", 4)
createUIElementLabel("After Grab Speed", 5)
createTextBoxInput("40", "AfterGrabSpeed", 6)

createUIElementLabel("Set Autoplay Direction", 7)

local InsideSideBtn = Instance.new("TextButton", Container)
InsideSideBtn.Size = UDim2.new(1, 0, 0, 26)
InsideSideBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
InsideSideBtn.Text = "DEFAULT SIDE: RIGHT"
InsideSideBtn.Font = Enum.Font.GothamBold
InsideSideBtn.TextColor3 = Color3.fromRGB(170, 85, 255)
InsideSideBtn.TextSize = 10
InsideSideBtn.LayoutOrder = 8
InsideSideBtn.Active = true
Instance.new("UICorner", InsideSideBtn).CornerRadius = UDim.new(0, 5)
Instance.new("UIStroke", InsideSideBtn).Color = Color3.fromRGB(45, 45, 55)

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
    if Config.AutoBat then
        MiniBat.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    else
        MiniBat.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    end
end)

createUIElementLabel("Features Toggle", 9)

local function createMainPanelToggle(name, configKey, order, callback)
    local frameBtn = Instance.new("TextButton", Container)
    frameBtn.Size = UDim2.new(1, 0, 0, 26)
    frameBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    frameBtn.Text = "  " .. name .. ": OFF"
    frameBtn.Font = Enum.Font.GothamBold
    frameBtn.TextColor3 = Color3.fromRGB(200, 80, 80)
    frameBtn.TextXAlignment = Enum.TextXAlignment.Left
    frameBtn.TextSize = 10
    frameBtn.LayoutOrder = order
    frameBtn.Active = true
    Instance.new("UICorner", frameBtn).CornerRadius = UDim.new(0, 5)
    Instance.new("UIStroke", frameBtn).Color = Color3.fromRGB(45, 45, 55)

    frameBtn.Activated:Connect(function()
        Config[configKey] = not Config[configKey]
        if Config[configKey] then
            frameBtn.Text = "  " .. name .. ": ON"
            frameBtn.TextColor3 = Color3.fromRGB(80, 200, 80)
            if callback then callback(true) end
        else
            frameBtn.Text = "  " .. name .. ": OFF"
            frameBtn.TextColor3 = Color3.fromRGB(200, 80, 80)
            if callback then callback(false) end
        end
    end)
end

createMainPanelToggle("Auto Loop Steal", "AutoLoopSteal", 10)
createMainPanelToggle("Infinite Jump", "InfiniteJump", 11)

-- [[ IMPROVED TACTICAL X-RAY & NIGHTVISION SYSTEM ]] --
createMainPanelToggle("NightVision / X-Ray", "NightVision", 12, function(state)
    if state then
        -- Inject Clear High Exposure Midnight Atmosphere
        Lighting.Ambient = Color3.fromRGB(35, 40, 65)
        Lighting.OutdoorAmbient = Color3.fromRGB(30, 30, 45)
        Lighting.ClockTime = 0 -- Forces Deep Midnight Atmosphere
        Lighting.Brightness = 0 -- Disables harsh sun flares shadowing bases
        Lighting.ExposureCompensation = 3.5 -- Dynamic night vision gamma boost

        task.spawn(function()
            while Config.NightVision do
                for _, part in pairs(Workspace:GetDescendants()) do
                    if part:IsA("BasePart") and not part.Parent:FindFirstChildOfClass("Humanoid") and part.Name ~= "Terrain" then
                        -- IGNORE TREE/LEAF COMPONENTS ENTIRELY FOR ULTRA CLARITY
                        local parentName = part.Parent.Name:lower()
                        local partName = part.Name:lower()
                        
                        if not parentName:find("tree") and not partName:find("leaf") and not partName:find("leaves") and not parentName:find("foliage") and not partName:find("branch") and not parentName:find("bush") then
                            if not part:GetAttribute("OldTrans") then 
                                part:SetAttribute("OldTrans", part.Transparency) 
                            end
                            part.Transparency = 0.70 -- High clarity transparent base walls
                        end
                    end
                end
                task.wait(1.5)
            end
        end)
    else
        -- Clean Restoration to Original Atmosphere Assets
        Lighting.Ambient = OriginalLightingCache.Ambient
        Lighting.OutdoorAmbient = OriginalLightingCache.OutdoorAmbient
        Lighting.ClockTime = OriginalLightingCache.ClockTime
        Lighting.Brightness = OriginalLightingCache.Brightness
        Lighting.ExposureCompensation = OriginalLightingCache.Exposure

        for _, part in pairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and part:GetAttribute("OldTrans") then
                part.Transparency = part:GetAttribute("OldTrans")
                part:SetAttribute("OldTrans", nil)
            end
        end
    end
end)

-- [[ HYBRID ANTI-RESET WALKSPEED CORE ENGINE ]] --
local DynamicVelocityForce = Instance.new("LinearVelocity")
local DirectAttachment = Instance.new("Attachment")

RunService.Heartbeat:Connect(function()
    if Character and Humanoid and RootPart and Humanoid.Health > 0 then
        if Config.AutoLoopSteal then autoGrabLogic() end

        local activeTargetSpeed = Config.NormalSpeed
        if Config.AutoLoopSteal or Config.AutoplayActive or Config.AutoBat then
            if checkBrainrot() then activeTargetSpeed = Config.AfterGrabSpeed else activeTargetSpeed = Config.BeforeGrabSpeed end
        end

        if Config.AutoplayActive and not Config.AutoBat then
            if DirectAttachment.Parent ~= RootPart then DirectAttachment.Parent = RootPart end
            if DynamicVelocityForce.Parent ~= RootPart then
                DynamicVelocityForce.Attachment0 = DirectAttachment
                DynamicVelocityForce.MaxForce = math.huge
                DynamicVelocityForce.Parent = RootPart
            end
            
            local runVector = Vector3.new(0, 0, 0)
            if Config.CurrentDirection == "Left" then
                runVector = RootPart.CFrame.RightVector * -activeTargetSpeed
            elseif Config.CurrentDirection == "Right" then
                runVector = RootPart.CFrame.RightVector * activeTargetSpeed
            end
            
            DynamicVelocityForce.VectorVelocity = Vector3.new(runVector.X, RootPart.Velocity.Y, runVector.Z)
            Humanoid.WalkSpeed = activeTargetSpeed 
        else
            if not Config.AutoBat then
                if DynamicVelocityForce.Parent then DynamicVelocityForce.Parent = nil end
                Humanoid.WalkSpeed = Config.NormalSpeed
            end
        end
    else
        if DynamicVelocityForce.Parent then DynamicVelocityForce.Parent = nil end
    end
end)

-- [[ STABLE SMOOTH BAT TRACKING LOOP ]] --
task.spawn(function()
    while true do
        task.wait(0.01)
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
                
                local safeBatSpeed = Config.BeforeGrabSpeed
                if checkBrainrot() then safeBatSpeed = Config.AfterGrabSpeed end

                if DirectAttachment.Parent ~= RootPart then DirectAttachment.Parent = RootPart end
                if DynamicVelocityForce.Parent ~= RootPart then
                    DynamicVelocityForce.Attachment0 = DirectAttachment
                    DynamicVelocityForce.MaxForce = math.huge
                    DynamicVelocityForce.Parent = RootPart
                end

                local directHeading = (targetEnemy.Position - RootPart.Position).Unit * safeBatSpeed
                DynamicVelocityForce.VectorVelocity = Vector3.new(directHeading.X, RootPart.Velocity.Y, directHeading.Z)
                Humanoid.WalkSpeed = safeBatSpeed

                local weaponTool = Character:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                if weaponTool then
                    if weaponTool.Parent ~= Character then weaponTool.Parent = Character end
                    pcall(function() weaponTool:Activate() end)
                end
            else
                if not Config.AutoplayActive and DynamicVelocityForce.Parent then DynamicVelocityForce.Parent = nil end
            end
        else
            if not Config.AutoplayActive and DynamicVelocityForce.Parent then DynamicVelocityForce.Parent = nil end
        end
    end
end)

-- Infinite Jump Mechanics
local lastJumpAction = 0
UIS.JumpRequest:Connect(function()
    if Config.InfiniteJump and RootPart and (tick() - lastJumpAction) > 0.15 then
        lastJumpAction = tick()
        RootPart.CFrame = RootPart.CFrame * CFrame.new(0, 4.2, 0)
    end
end)

print("Lunar Hub | V18.0 Tactical Atmosphere Active!")
