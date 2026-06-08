-- [[ Lunar Hub Duel Script V15.2 - Forced Auto Steal Snatcher ]] --
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

-- Cleanup Previous UI
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
    BeforeGrabSpeed = 50.5,
    AfterGrabSpeed = 58,
    SideSelection = "None",
    AutoLoopSteal = false,
    AutoBat = false,
    InfiniteJump = false,
    NightVision = false
}

-- Brainrot Check Utility
local function checkBrainrot()
    if Character then
        return Character:FindFirstChild("Brainrot") or LocalPlayer.Backpack:FindFirstChild("Brainrot") or 
               Character:FindFirstChild("brainrot") or LocalPlayer.Backpack:FindFirstChild("brainrot")
    end
    return false
end

-- 🔥 ULTRA AGGRESSIVE OPPONENT HAND SNATCHER (Forced Auto Steal)
local function autoGrabLogic()
    if Character and RootPart and not checkBrainrot() then
        -- 1. Check inside Workspace (Grounded items)
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Tool") and (obj.Name:lower() == "brainrot" or obj:FindFirstChild("Handle")) then
                local handle = obj:FindFirstChild("Handle") or obj
                if handle:IsA("BasePart") then
                    local distance = (RootPart.Position - handle.Position).Magnitude
                    if distance < 55 then
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

        -- 2. Check inside Other Players (Opponent Hand Snatch)
        for _, pl in pairs(Players:GetPlayers()) do
            if pl ~= LocalPlayer and pl.Character then
                local enemyTool = pl.Character:FindFirstChild("Brainrot") or pl.Character:FindFirstChild("brainrot")
                if enemyTool and enemyTool:IsA("Tool") then
                    local handle = enemyTool:FindFirstChild("Handle")
                    if handle and handle:IsA("BasePart") then
                        local distance = (RootPart.Position - handle.Position).Magnitude
                        if distance < 55 then -- Snatches from opponent hand instantly when near
                            pcall(function()
                                firetouchinterest(handle, RootPart, 0)
                                firetouchinterest(handle, RootPart, 1)
                                enemyTool.Parent = Character -- Forces tool into your hand
                            end)
                        end
                    end
                end
            end
        end
    end
end

-- [[ SCREEN LEFT SIDE - TINY MOBILE TOGGLE ]] --
local MobileGui = Instance.new("ScreenGui")
MobileGui.Name = "LunarMobileUI"
MobileGui.Parent = TargetGuiParent
MobileGui.ResetOnSpawn = false

local MiniToggle = Instance.new("TextButton", MobileGui)
MiniToggle.Size = UDim2.new(0, 35, 0, 26)
MiniToggle.Position = UDim2.new(0, 15, 0, 120)
MiniToggle.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MiniToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniToggle.Font = Enum.Font.GothamBold
MiniToggle.Text = "|||"
MiniToggle.TextSize = 11
Instance.new("UICorner", MiniToggle).CornerRadius = UDim.new(0, 5)
Instance.new("UIStroke", MiniToggle).Color = Color3.fromRGB(50, 50, 60)

-- [[ ULTRA SLIM & MICRO MAIN PANEL ]] --
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "LunarHub"
MainGui.Parent = TargetGuiParent
MainGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = MainGui
MainFrame.Size = UDim2.new(0, 195, 0, 310)
MainFrame.Position = UDim2.new(0.5, -97, 0.5, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local FrameGlow = Instance.new("UIStroke", MainFrame)
FrameGlow.Color = Color3.fromRGB(55, 45, 90)
FrameGlow.Thickness = 1.2

local HeaderFrame = Instance.new("Frame", MainFrame)
HeaderFrame.Size = UDim2.new(1, 0, 0, 32)
HeaderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
Instance.new("UICorner", HeaderFrame).CornerRadius = UDim.new(0, 8)

MainFrame.Active = true
MainFrame.Draggable = true 

local MainTitle = Instance.new("TextLabel", HeaderFrame)
MainTitle.Size = UDim2.new(1, 0, 1, 0)
MainTitle.BackgroundTransparency = 1
MainTitle.Text = "LUNAR HUB DUEL V15.2"
MainTitle.TextColor3 = Color3.fromRGB(170, 85, 255)
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 11

local ScrollFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollFrame.Size = UDim2.new(1, 0, 1, -36)
ScrollFrame.Position = UDim2.new(0, 0, 0, 34)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ClipsDescendants = true
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 420)
ScrollFrame.ScrollBarThickness = 2
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(115, 90, 230)

MiniToggle.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local function createUIElementLabel(text, y)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = ScrollFrame
    lbl.Position = UDim2.new(0, 10, 0, y)
    lbl.Size = UDim2.new(0, 175, 0, 14)
    lbl.BackgroundTransparency = 1
    lbl.Text = text:upper()
    lbl.TextColor3 = Color3.fromRGB(130, 130, 140)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 9
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return lbl
end

local function createTextBoxInput(default, y, configKey)
    local box = Instance.new("TextBox")
    box.Parent = ScrollFrame
    box.Position = UDim2.new(0, 10, 0, y)
    box.Size = UDim2.new(0, 175, 0, 24)
    box.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.PlaceholderText = default
    box.Text = default
    box.Font = Enum.Font.GothamSemibold
    box.TextSize = 11
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
    Instance.new("UIStroke", box).Color = Color3.fromRGB(45, 45, 55)
    
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val then 
            if val > 60 then val = 60 box.Text = "60" end
            Config[configKey] = val 
        end
    end)
    return box
end

-- RENDERING MICRO ELEMENTS
createUIElementLabel("Speed Control", 8)
createTextBoxInput("16", 24, "NormalSpeed")

createUIElementLabel("Before Grab Speed (Max 60)", 54)
createTextBoxInput("50.5", 70, "BeforeGrabSpeed")

createUIElementLabel("After Grab Speed (Max 60)", 100)
createTextBoxInput("58", 116, "AfterGrabSpeed")

createUIElementLabel("Autoplay Side Select", 146)

local BtnLeft = Instance.new("TextButton", ScrollFrame)
BtnLeft.Size = UDim2.new(0, 82, 0, 24)
BtnLeft.Position = UDim2.new(0, 10, 0, 162)
BtnLeft.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
BtnLeft.Text = "LEFT"
BtnLeft.Font = Enum.Font.GothamBold
BtnLeft.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnLeft.TextSize = 11
Instance.new("UICorner", BtnLeft).CornerRadius = UDim.new(0, 5)

local BtnRight = BtnLeft:Clone()
BtnRight.Parent = ScrollFrame
BtnRight.Position = UDim2.new(0, 103, 0, 162)
BtnRight.Text = "RIGHT"

local function resetAutoplayButtons()
    BtnLeft.Text = "LEFT"
    BtnLeft.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    BtnRight.Text = "RIGHT"
    BtnRight.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
end

BtnLeft.MouseButton1Click:Connect(function()
    if Config.SideSelection == "Left" then
        Config.SideSelection = "None"
        resetAutoplayButtons()
    else
        Config.SideSelection = "Left"
        resetAutoplayButtons()
        BtnLeft.Text = "X (STOP)"
        BtnLeft.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    end
end)

BtnRight.MouseButton1Click:Connect(function()
    if Config.SideSelection == "Right" then
        Config.SideSelection = "None"
        resetAutoplayButtons()
    else
        Config.SideSelection = "Right"
        resetAutoplayButtons()
        BtnRight.Text = "X (STOP)"
        BtnRight.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    end
end)

createUIElementLabel("Features Toggle", 194)

local function createMainPanelToggle(name, y, configKey, callback)
    local frameBtn = Instance.new("TextButton", ScrollFrame)
    frameBtn.Size = UDim2.new(0, 175, 0, 26)
    frameBtn.Position = UDim2.new(0, 10, 0, y)
    frameBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    frameBtn.Text = " " .. name .. ": OFF"
    frameBtn.Font = Enum.Font.GothamBold
    frameBtn.TextColor3 = Color3.fromRGB(200, 80, 80)
    frameBtn.TextXAlignment = Enum.TextXAlignment.Left
    frameBtn.TextSize = 10
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

createMainPanelToggle("Auto Loop Steal", 212, "AutoLoopSteal")
createMainPanelToggle("Auto Bat + AimLock", 242, "AutoBat")
createMainPanelToggle("Infinite Jump", 272, "InfiniteJump")

-- NIGHT VISION / X-RAY BASE
createMainPanelToggle("NightVision / X-Ray", 302, "NightVision", function(state)
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

-- [[ MOVEMENT & PHYSICAL ENGINE ]] --
local NetworkMoveVelocity = Instance.new("BodyVelocity")
NetworkMoveVelocity.MaxForce = Vector3.new(250000, 0, 250000)
NetworkMoveVelocity.Velocity = Vector3.new(0, 0, 0)

RunService.Heartbeat:Connect(function()
    if Character and Humanoid and RootPart and Humanoid.Health > 0 then
        if Config.AutoLoopSteal then
            autoGrabLogic()
        end

        local selectedRawVelocity = Config.NormalSpeed
        if Config.AutoLoopSteal then
            if checkBrainrot() then selectedRawVelocity = Config.AfterGrabSpeed else selectedRawVelocity = Config.BeforeGrabSpeed end
        end
        if selectedRawVelocity > 60 then selectedRawVelocity = 60 end

        if Humanoid.MoveDirection.Magnitude > 0 and Config.SideSelection == "None" then
            if NetworkMoveVelocity.Parent then NetworkMoveVelocity.Parent = nil end
            local microStepOffset = Humanoid.MoveDirection * (selectedRawVelocity - 16) * 0.0142
            RootPart.CFrame = RootPart.CFrame + microStepOffset
        end

        if Config.SideSelection ~= "None" then
            if NetworkMoveVelocity.Parent ~= RootPart then NetworkMoveVelocity.Parent = RootPart end
            Humanoid.PlatformStand = false
            local vectorPushDirection = Vector3.new(0,0,0)
            if Config.SideSelection == "Left" then
                vectorPushDirection = RootPart.CFrame.RightVector * -selectedRawVelocity
            elseif Config.SideSelection == "Right" then
                vectorPushDirection = RootPart.CFrame.RightVector * selectedRawVelocity
            end
            NetworkMoveVelocity.Velocity = Vector3.new(vectorPushDirection.X, RootPart.Velocity.Y, vectorPushDirection.Z)
        else
            if NetworkMoveVelocity.Parent then NetworkMoveVelocity.Parent = nil end
        end
    else
        if NetworkMoveVelocity.Parent then NetworkMoveVelocity.Parent = nil end
    end
end)

-- Auto Weapon Weapon Loop
task.spawn(function()
    while true do
        if Config.AutoBat and checkBrainrot() and RootPart then
            local trackingCap = nil
            local rangeDist = 24
            for _, pl in pairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                    local targetRoot = pl.Character.HumanoidRootPart
                    local currentRange = (RootPart.Position - targetRoot.Position).Magnitude
                    if currentRange < rangeDist then rangeDist = currentRange trackingCap = targetRoot end
                end
            end
            if trackingCap then
                RootPart.CFrame = CFrame.lookAt(RootPart.Position, Vector3.new(trackingCap.Position.X, RootPart.Position.Y, trackingCap.Position.Z))
                local weaponTool = Character:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                if weaponTool then
                    if weaponTool.Parent ~= Character then weaponTool.Parent = Character end
                    pcall(function() weaponTool:Activate() end)
                end
            end
        end
        task.wait(0.03)
    end
end)

local lastJumpAction = 0
UIS.JumpRequest:Connect(function()
    if Config.InfiniteJump and RootPart and (tick() - lastJumpAction) > 0.15 then
        lastJumpAction = tick()
        RootPart.CFrame = RootPart.CFrame * CFrame.new(0, 4.2, 0)
    end
end)

print("Lunar Hub Duel Script V15.2 Deployed!")
