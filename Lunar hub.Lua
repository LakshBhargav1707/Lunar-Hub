-- [[ Lunar Hub | V22.0 Hyper-Response Mobile Native Edition ]] --
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

-- Hard Reset: Sab kuch pehle clear karo taaki lag ya hang na ho
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
    AutoBat = false
}

local function checkBrainrot()
    if Character then
        return Character:FindFirstChild("Brainrot") or LocalPlayer.Backpack:FindFirstChild("Brainrot") or 
               Character:FindFirstChild("brainrot") or LocalPlayer.Backpack:FindFirstChild("brainrot")
    end
    return false
end

-- Native Interaction Module
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

-- [[ FLOATING MOBILE BUTTONS — NEVER FREEZES ]] --
local MobileGui = Instance.new("ScreenGui")
MobileGui.Name = "LunarMobileUI"
MobileGui.Parent = TargetGuiParent
MobileGui.ResetOnSpawn = false
MobileGui.DisplayOrder = 99999

local Layout = Instance.new("Frame", MobileGui)
Layout.Size = UDim2.new(0, 200, 0, 50)
Layout.Position = UDim2.new(0, 10, 0, 150) -- Perfect screen alignment for mobile
Layout.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", Layout)
UIList.FillDirection = Enum.FillDirection.Horizontal
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 10)

local function createPerfectButton(text, bgColor, order)
    local btn = Instance.new("TextButton", Layout)
    btn.Size = UDim2.new(0, 60, 0, 38)
    btn.BackgroundColor3 = bgColor
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextSize = 10
    btn.LayoutOrder = order
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.6
    return btn
end

local BtnSteal = createPerfectButton("STEAL: OFF", Color3.fromRGB(40, 40, 50), 1)
local BtnBat = createPerfectButton("BAT: OFF", Color3.fromRGB(40, 40, 50), 2)
local BtnPlay = createPerfectButton("START (R)", Color3.fromRGB(115, 90, 230), 3)

-- Interaction Listeners
BtnSteal.Activated:Connect(function()
    Config.AutoLoopSteal = not Config.AutoLoopSteal
    if Config.AutoLoopSteal then
        BtnSteal.Text = "STEAL: ON"
        BtnSteal.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    else
        BtnSteal.Text = "STEAL: OFF"
        BtnSteal.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end
end)

BtnBat.Activated:Connect(function()
    Config.AutoBat = not Config.AutoBat
    if Config.AutoBat then
        BtnBat.Text = "BAT: ON"
        BtnBat.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    else
        BtnBat.Text = "BAT: OFF"
        BtnBat.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end
end)

BtnPlay.Activated:Connect(function()
    if not Config.AutoplayActive and Config.CurrentDirection == "Right" then
        Config.AutoplayActive = true
        Config.CurrentDirection = "Right"
        BtnPlay.Text = "STOP"
        BtnPlay.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
    elseif Config.AutoplayActive and Config.CurrentDirection == "Right" then
        Config.CurrentDirection = "Left"
        BtnPlay.Text = "START (L)"
        Config.AutoplayActive = false
        BtnPlay.BackgroundColor3 = Color3.fromRGB(115, 90, 230)
    elseif not Config.AutoplayActive and Config.CurrentDirection == "Left" then
        Config.AutoplayActive = true
        Config.CurrentDirection = "Left"
        BtnPlay.Text = "STOP"
        BtnPlay.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
    else
        Config.CurrentDirection = "Right"
        BtnPlay.Text = "START (R)"
        Config.AutoplayActive = false
        BtnPlay.BackgroundColor3 = Color3.fromRGB(115, 90, 230)
    end
end)

-- [[ ZERO-LAG LEGIT PLAYER STEP SIMULATION ]] --
RunService.PreRender:Connect(function()
    if Character and Humanoid and RootPart and Humanoid.Health > 0 then
        if Config.AutoLoopSteal then autoGrabLogic() end

        local targetWalkSpeed = Config.NormalSpeed
        if Config.AutoLoopSteal or Config.AutoplayActive or Config.AutoBat then
            targetWalkSpeed = checkBrainrot() and Config.AfterGrabSpeed or Config.BeforeGrabSpeed
        end

        if Config.AutoplayActive and not Config.AutoBat then
            Humanoid.WalkSpeed = targetWalkSpeed
            local vectorMove = (Config.CurrentDirection == "Right") and Vector3.new(1, 0, 0) or Vector3.new(-1, 0, 0)
            Humanoid:Move(vectorMove, true)
        else
            if not Config.AutoBat then
                Humanoid.WalkSpeed = Config.NormalSpeed
            end
        end
    end
end)

-- [[ ULTRA SAFE BAT TARGET ENGAGEMENT ]] --
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
                local positionCorrection = Vector3.new(targetEnemy.Position.X, RootPart.Position.Y, targetEnemy.Position.Z)
                RootPart.CFrame = CFrame.lookAt(RootPart.Position, positionCorrection)
                
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

print("Lunar Hub | V22.0 Native Touch Deployed Successfully!")
