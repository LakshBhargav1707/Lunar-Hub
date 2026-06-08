-- [[ Lunar Hub | Undetected - V16.5 Safe Anti-Kick Override ]] --
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

-- Clean Up Old Interface
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
    BeforeGrabSpeed = 34, -- Safe calibrated speed to stop anti-cheat kicks
    AfterGrabSpeed = 35,  -- Safe sweet spot for auto-play sweeps
    CurrentDirection = "Right", 
    AutoplayActive = false,
    AutoLoopSteal = false,
    AutoBat = false,
    InfiniteJump = false,
    NightVision = false
}

-- Brainrot Inventory Scanner
local function checkBrainrot()
    if Character then
        return Character:FindFirstChild("Brainrot") or LocalPlayer.Backpack:FindFirstChild("Brainrot") or 
               Character:FindFirstChild("brainrot") or LocalPlayer.Backpack:FindFirstChild("brainrot")
    end
    return false
end

-- Forced Snatcher (Micro-Touch Network Injection)
local function autoGrabLogic()
    if Character and RootPart and not checkBrainrot() then
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Tool") and (obj.Name:lower() == "brainrot" or obj:FindFirstChild("Handle")) then
                local handle = obj:FindFirstChild("Handle") or obj
                if handle:IsA("BasePart") and (RootPart.Position - handle.Position).Magnitude < 50 then
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
                    if handle and handle:IsA("BasePart") and (RootPart.Position - handle.Position).Magnitude < 50 then
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

local Layout = Instance.new("Frame", MobileGui)
Layout.Size = UDim2.new(0, 160, 0, 35)
Layout.Position = UDim2.new(0, 15, 0, 120)
Layout.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", Layout)
UIList.FillDirection = Enum.FillDirection.Horizontal
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 6)

local function createMiniControlBtn(text, order)
    local btn = Instance.new("TextButton", Layout)
    btn.Size = UDim2.new(0, 48, 0, 28)
    btn.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextSize = 11
    btn.LayoutOrder = order
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", btn).Color = Color3.fromRGB(50, 50, 60)
    return btn
end

local MiniToggle = createMiniControlBtn("|||", 1)
local MiniBat = createMiniControlBtn("BAT", 2)
local MiniPlay = createMiniControlBtn("RIGHT", 3) 
MiniPlay.BackgroundColor3 = Color3.fromRGB(115, 90, 230)

-- [[ INTERIOR CONFIGURATION PANEL ]] --
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "LunarHub"
MainGui.Parent = TargetGuiParent
MainGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", MainGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 200, 0, 310)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(55, 45, 90)

local HeaderFrame = Instance.new("Frame", MainFrame)
HeaderFrame.Size = UDim2.new(1, 0, 0, 32)
HeaderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
Instance.new("UICorner", HeaderFrame).CornerRadius = UDim.new(0, 8)

MainFrame.Active = true
MainFrame.Draggable = true 

local MainTitle = Instance.new("TextLabel", HeaderFrame)
MainTitle.Size = UDim2.new(1, 0, 1, 0)
MainTitle.BackgroundTransparency = 1
MainTitle.Text = "Lunar Hub | Undetected" 
MainTitle.TextColor3 = Color3.fromRGB(170, 85, 255)
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 11

local ScrollFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollFrame.Size = UDim2.new(1, 0, 1, -36)
ScrollFrame.Position = UDim2.new(0, 0, 0, 34)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ClipsDescendants = true
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 420)
ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(115, 90, 230)

local UIListLayout = Instance.new("UIListLayout", ScrollFrame)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

local UIPadding = Instance.new("UIPadding", ScrollFrame)
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.PaddingTop = UDim.new(0, 8)

MiniToggle.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local function createUIElementLabel(text, order)
    local lbl = Instance.new("TextLabel", ScrollFrame)
    lbl.Size = UDim2.new(0, 175, 0, 14)
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
    local box = Instance.new("TextBox", ScrollFrame)
    box.Size = UDim2.new(0, 175, 0, 24)
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
            if val > 55 then val = 55 box.Text = "55" end -- Safety cap limit to prevent severe anti-cheat tracking
            Config[configKey] = val 
        end
    end)
    return box
end

-- RENDER ALL INPUT FIELDS SEAMLESSLY
createUIElementLabel("Speed Control", 1)
createTextBoxInput("16", "NormalSpeed", 2)

createUIElementLabel("Before Grab Speed", 3)
createTextBoxInput("34", "BeforeGrabSpeed", 4)

createUIElementLabel("After Grab Speed", 5)
createTextBoxInput("35", "AfterGrabSpeed", 6)

createUIElementLabel("Set Autoplay Direction", 7)

local InsideSideBtn = Instance.new("TextButton", ScrollFrame)
InsideSideBtn.Size = UDim2.new(0, 175, 0, 26)
InsideSideBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
InsideSideBtn.Text = "DEFAULT SIDE: RIGHT"
InsideSideBtn.Font = Enum.Font.GothamBold
InsideSideBtn.TextColor3 = Color3.fromRGB(170, 85, 255)
InsideSideBtn.TextSize = 10
InsideSideBtn.LayoutOrder = 8
Instance.new("UICorner", InsideSideBtn).CornerRadius = UDim.new(0, 5)
InsideSideBtn.UIStroke = Instance.new("UIStroke", InsideSideBtn)
InsideSideBtn.UIStroke.Color = Color3.fromRGB(45, 45, 55)

local function refreshOutsideAutoplayVisuals()
    if Config.AutoplayActive then
        MiniPlay.Text = "X (STOP)"
        MiniPlay.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    else
        MiniPlay.Text = Config.CurrentDirection:upper()
        MiniPlay.BackgroundColor3 = Color3.fromRGB(115, 90, 230)
    end
end

InsideSideBtn.MouseButton1Click:Connect(function()
    if Config.CurrentDirection == "Right" then
        Config.CurrentDirection = "Left"
        InsideSideBtn.Text = "DEFAULT SIDE: LEFT"
    else
        Config.CurrentDirection = "Right"
        InsideSideBtn.Text = "DEFAULT SIDE: RIGHT"
    end
    refreshOutsideAutoplayVisuals()
end)

MiniPlay.MouseButton1Click:Connect(function()
    Config.AutoplayActive = not Config.AutoplayActive
    refreshOutsideAutoplayVisuals()
end)

MiniBat.MouseButton1Click:Connect(function()
    Config.AutoBat = not Config.AutoBat
    if Config.AutoBat then
        MiniBat.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    else
        MiniBat.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    end
end)

createUIElementLabel("Features Toggle", 9)

local function createMainPanelToggle(name, configKey, order, callback)
    local frameBtn = Instance.new("TextButton", ScrollFrame)
    frameBtn.Size = UDim2.new(0, 175, 0, 26)
    frameBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    frameBtn.Text = " " .. name .. ": OFF"
    frameBtn.Font = Enum.Font.GothamBold
    frameBtn.TextColor3 = Color3.fromRGB(200, 80, 80)
    frameBtn.TextXAlignment = Enum.TextXAlignment.Left
    frameBtn.TextSize = 10
    frameBtn.LayoutOrder = order
    Instance.new("UICorner", frameBtn).CornerRadius = UDim.new(0, 5)
    Instance.new("UIStroke", frameBtn).Color = Color3.fromRGB(45, 45, 55)

    frameBtn.MouseButton1Click:Connect(function()
        Config[configKey] = not Config[configKey]
        if Config[configKey] then
            frameBtn.Text = " " .. name .. ": ON"
            frameBtn.TextColor3 = Color3.fromRGB(80, 200, 80)
            if callback then callback(true) end
        else
            frameBtn.Text = " " .. name .. ": OFF"
            frameBtn.TextColor3 = Color3.fromRGB(200, 80, 80)
            if callback then callback(false) end
        end
    end)
end

createMainPanelToggle("Auto Loop Steal", "AutoLoopSteal", 10)
createMainPanelToggle("Infinite Jump", "InfiniteJump", 11)

createMainPanelToggle("NightVision / X-Ray", "NightVision", 12, function(state)
    if state then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        task.spawn(function()
            while Config.NightVision do
                for _, part in pairs(Workspace:GetDescendants()) do
                    if part:IsA("BasePart") and not part.Parent:FindFirstChildOfClass("Humanoid") and part.Name ~= "Terrain" then
                        if not part:GetAttribute("OldTrans") then part:SetAttribute("OldTrans", part.Transparency) end
                        part.Transparency = 0.55
                    end
                end
                task.wait(2)
            end
        end)
    else
        Lighting.Ambient = Color3.fromRGB(130, 130, 130)
        Lighting.OutdoorAmbient = Color3.fromRGB(130, 130, 130)
        for _, part in pairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and part:GetAttribute("OldTrans") then
                part.Transparency = part:GetAttribute("OldTrans")
                part:SetAttribute("OldTrans", nil)
            end
        end
    end
end)

-- [[ BYPASS FRAMERATE MOVEMENT ENGINE (NO BODYVELOCITY KICK) ]] --
RunService.Heartbeat:Connect(function(deltaTime)
    if Character and Humanoid and RootPart and Humanoid.Health > 0 then
        if Config.AutoLoopSteal then autoGrabLogic() end

        -- Fetch precise user speeds from configs
        local currentMovingSpeed = Config.NormalSpeed
        if Config.AutoLoopSteal or Config.AutoplayActive or Config.AutoBat then
            if checkBrainrot() then currentMovingSpeed = Config.AfterGrabSpeed else currentMovingSpeed = Config.BeforeGrabSpeed end
        end

        -- Direct CFrame Frame-Translation for Autoplay (Completely Uncatchable)
        if Config.AutoplayActive and not Config.AutoBat then
            local translationVector = Vector3.new(0, 0, 0)
            if Config.CurrentDirection == "Left" then
                translationVector = RootPart.CFrame.RightVector * -currentMovingSpeed
            elseif Config.CurrentDirection == "Right" then
                translationVector = RootPart.CFrame.RightVector * currentMovingSpeed
            end
            
            -- Increment position directly using delta timing sequence safely
            RootPart.CFrame = RootPart.CFrame + Vector3.new(translationVector.X * deltaTime, 0, translationVector.Z * deltaTime)
        end
    end
end)

-- [[ SAFE LERP CHASE ENGINE ]] --
task.spawn(function()
    while true do
        local deltaTime = task.wait(0.015) -- Controlled tracking update intervals
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
                -- Face enemy perfectly
                RootPart.CFrame = CFrame.lookAt(RootPart.Position, Vector3.new(targetEnemy.Position.X, RootPart.Position.Y, targetEnemy.Position.Z))
                
                local activeSpeed = Config.BeforeGrabSpeed
                if checkBrainrot() then activeSpeed = Config.AfterGrabSpeed end

                -- Advanced CFrame Step Slide Translation (No engine force flags sent to server)
                local moveDir = (targetEnemy.Position - RootPart.Position).Unit
                RootPart.CFrame = RootPart.CFrame + Vector3.new(moveDir.X * activeSpeed * deltaTime, 0, moveDir.Z * activeSpeed * deltaTime)

                -- Automatically activate combat bat swing mechanics
                local weaponTool = Character:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                if weaponTool then
                    if weaponTool.Parent ~= Character then weaponTool.Parent = Character end
                    pcall(function() weaponTool:Activate() end)
                end
            end
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

print("Lunar Hub | V16.5 Safe Patch Deployed!")
