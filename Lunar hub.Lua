-- [[ Lunar Hub | V23.0 Sleek Premium Mobile Safe Edition ]] --
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

-- Purge previous ugly UI iterations cleanly
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

-- [[ PREMIUM CLEAN MOBILE INTERFACE ]] --
local MobileGui = Instance.new("ScreenGui")
MobileGui.Name = "LunarMobileUI"
MobileGui.Parent = TargetGuiParent
MobileGui.ResetOnSpawn = false
MobileGui.DisplayOrder = 99999

-- Styled Master Horizontal Control Deck
local Deck = Instance.new("Frame", MobileGui)
Deck.Size = UDim2.new(0, 240, 0, 36)
Deck.Position = UDim2.new(0, 15, 0, 145) -- Neat placement right under Roblox bar
Deck.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
Deck.BackgroundTransparency = 0.25
Deck.Active = true
Deck.Draggable = true -- Drag it anywhere if it blocks your view!
Instance.new("UICorner", Deck).CornerRadius = UDim.new(0, 8)

local DeckStroke = Instance.new("UIStroke", Deck)
DeckStroke.Color = Color3.fromRGB(115, 90, 230)
DeckStroke.Transparency = 0.4

local UIList = Instance.new("UIListLayout", Deck)
UIList.FillDirection = Enum.FillDirection.Horizontal
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 6)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.VerticalAlignment = Enum.VerticalAlignment.Center

local function createPremiumBtn(text, order)
    local btn = Instance.new("TextButton", Deck)
    btn.Size = UDim2.new(0, 72, 0, 26)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.BackgroundTransparency = 0.1
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextSize = 10
    btn.LayoutOrder = order
    
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(60, 60, 80)
    stroke.Transparency = 0.5
    return btn
end

local BtnSteal = createPremiumBtn("STEAL: OFF", 1)
local BtnBat = createPremiumBtn("BAT: OFF", 2)
local BtnPlay = createPremiumBtn("START (R)", 3)
BtnPlay.TextColor3 = Color3.fromRGB(180, 150, 255)

-- Smooth UI State Controllers
BtnSteal.Activated:Connect(function()
    Config.AutoLoopSteal = not Config.AutoLoopSteal
    if Config.AutoLoopSteal then
        BtnSteal.Text = "STEAL: ON"
        BtnSteal.TextColor3 = Color3.fromRGB(80, 255, 150)
        BtnSteal.BackgroundColor3 = Color3.fromRGB(20, 45, 30)
    else
        BtnSteal.Text = "STEAL: OFF"
        BtnSteal.TextColor3 = Color3.fromRGB(200, 200, 220)
        BtnSteal.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    end
end)

BtnBat.Activated:Connect(function()
    Config.AutoBat = not Config.AutoBat
    if Config.AutoBat then
        BtnBat.Text = "BAT: ON"
        BtnBat.TextColor3 = Color3.fromRGB(80, 255, 150)
        BtnBat.BackgroundColor3 = Color3.fromRGB(20, 45, 30)
    else
        BtnBat.Text = "BAT: OFF"
        BtnBat.TextColor3 = Color3.fromRGB(200, 200, 220)
        BtnBat.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    end
end)

BtnPlay.Activated:Connect(function()
    if not Config.AutoplayActive and Config.CurrentDirection == "Right" then
        Config.AutoplayActive = true
        Config.CurrentDirection = "Right"
        BtnPlay.Text = "STOP"
        BtnPlay.TextColor3 = Color3.fromRGB(255, 100, 100)
        BtnPlay.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
    elseif Config.AutoplayActive and Config.CurrentDirection == "Right" then
        Config.CurrentDirection = "Left"
        BtnPlay.Text = "START (L)"
        Config.AutoplayActive = false
        BtnPlay.TextColor3 = Color3.fromRGB(180, 150, 255)
        BtnPlay.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    elseif not Config.AutoplayActive and Config.CurrentDirection == "Left" then
        Config.AutoplayActive = true
        Config.CurrentDirection = "Left"
        BtnPlay.Text = "STOP"
        BtnPlay.TextColor3 = Color3.fromRGB(255, 100, 100)
        BtnPlay.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
    else
        Config.CurrentDirection = "Right"
        BtnPlay.Text = "START (R)"
        Config.AutoplayActive = false
        BtnPlay.TextColor3 = Color3.fromRGB(180, 150, 255)
        BtnPlay.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    end
end)

-- [[ MOVEMENT ROUTINES ]] --
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

print("Lunar Hub | V23.0 Premium Deck Injected Safely!")
