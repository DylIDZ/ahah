local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

-- Create and configure blur effect
local blur = Instance.new("BlurEffect", Lighting)
blur.Size = 0
TweenService:Create(blur, TweenInfo.new(0.8, Enum.EasingStyle.Cubic), {Size = 24}):Play()

-- Create base GUI elements
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "AstraluxLoader"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundTransparency = 1

-- Create stylish background
local bg = Instance.new("Frame", frame)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
bg.BackgroundTransparency = 1
bg.ZIndex = 0

-- Add gradient background
local bgGradient = Instance.new("UIGradient", bg)
bgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 0, 0))
})
bgGradient.Rotation = 45
TweenService:Create(bg, TweenInfo.new(0.8, Enum.EasingStyle.Cubic), {BackgroundTransparency = 0}):Play()

-- Create particle effects
for i = 1, 20 do
    local particle = Instance.new("Frame", bg)
    particle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    particle.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
    particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
    particle.BackgroundTransparency = 0.8
    particle.ZIndex = 1
    
    -- Add glow to particles
    local particleGlow = Instance.new("UIGradient", particle)
    particleGlow.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    })
    
    -- Animate particles
    spawn(function()
        while particle.Parent do
            local randomDuration = math.random(2, 4)
            local newX = math.random()
            local newY = math.random()
            
            TweenService:Create(particle, TweenInfo.new(randomDuration, Enum.EasingStyle.Linear), {
                Position = UDim2.new(newX, 0, newY, 0),
                BackgroundTransparency = math.random(70, 90)/100
            }):Play()
            
            wait(randomDuration)
        end
    end)
end

-- Create animated lines
for i = 1, 8 do
    local line = Instance.new("Frame", bg)
    line.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, math.random(), 0)
    line.BackgroundTransparency = 0.9
    line.ZIndex = 1
    
    -- Add gradient to lines
    local lineGradient = Instance.new("UIGradient", line)
    lineGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 50, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    })
    lineGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0.7),
        NumberSequenceKeypoint.new(1, 1)
    })
    
    -- Animate lines
    spawn(function()
        local offset = 0
        while line.Parent do
            TweenService:Create(lineGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                Offset = Vector2.new(offset, 0)
            }):Play()
            offset = offset + 1
            if offset >= 1 then offset = 0 end
            wait(2)
        end
    end)
end

-- Create main glow effect
local glow = Instance.new("ImageLabel", frame)
glow.Size = UDim2.new(0, 800, 0, 200)
glow.Position = UDim2.new(0.5, -400, 0.5, -100)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://131274595"
glow.ImageColor3 = Color3.fromRGB(255, 0, 0)
glow.ImageTransparency = 1
glow.ZIndex = 1

-- Animate glow
TweenService:Create(glow, TweenInfo.new(1, Enum.EasingStyle.Cubic), {ImageTransparency = 0.7}):Play()
spawn(function()
    while glow.Parent do
        TweenService:Create(glow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 850, 0, 220)}):Play()
        wait(1)
        TweenService:Create(glow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 800, 0, 200)}):Play()
        wait(1)
    end
end)

local word = "ASTRALUX"
local letters = {}

local function tweenOutAndDestroy()
    -- Fade out particles and lines
    for _, child in pairs(bg:GetChildren()) do
        if child:IsA("Frame") then
            TweenService:Create(child, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        end
    end
    
    -- Fade out glow
    TweenService:Create(glow, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
    
    -- Fade out letters with different delays
    for i, label in ipairs(letters) do
        TweenService:Create(label, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            TextTransparency = 1,
            TextSize = 20,
            Position = label.Position + UDim2.new(0, 0, 0.2, 0)
        }):Play()
        wait(0.05)
    end
    
    -- Fade out background and blur
    TweenService:Create(bg, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
    TweenService:Create(blur, TweenInfo.new(0.8), {Size = 0}):Play()
    
    wait(0.8)
    screenGui:Destroy()
    blur:Destroy()
end

-- Create and animate letters
for i = 1, #word do
    local char = word:sub(i, i)
    
    local label = Instance.new("TextLabel")
    label.Text = char
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0.5
    label.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
    label.TextTransparency = 1
    label.TextScaled = false
    label.TextSize = 20
    label.Size = UDim2.new(0, 65, 0, 65)
    label.AnchorPoint = Vector2.new(0.5, 0.5)
    label.Position = UDim2.new(0.5, (i - (#word / 2 + 0.5)) * 70, 0.5, 50)
    label.BackgroundTransparency = 1
    label.ZIndex = 2
    label.Parent = frame
    
    -- Add gradient
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 100)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 30, 30))
    })
    gradient.Rotation = 90
    gradient.Parent = label
    
    -- Create bounce-in animation
    local startPos = label.Position
    label.Position = label.Position + UDim2.new(0, 0, -0.5, 0)
    
    -- Sequence of tweens
    TweenService:Create(label, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, i * 0.1), {
        TextTransparency = 0,
        TextSize = 60,
        Position = startPos
    }):Play()
    
    -- Add hover effect
    spawn(function()
        while label.Parent do
            TweenService:Create(label, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Position = startPos + UDim2.new(0, 0, 0, math.random(-3, 3))
            }):Play()
            wait(1)
        end
    end)
    
    -- Add rotation to gradient
    spawn(function()
        local rotation = 90
        while label.Parent do
            gradient.Rotation = rotation
            rotation = rotation + 1
            if rotation >= 360 then rotation = 0 end
            wait(0.05)
        end
    end)
    
    table.insert(letters, label)
    wait(0.1)
end

wait(2.5)
tweenOutAndDestroy()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/LanFouWyne/Astralux/refs/heads/main/Library/Ui/AstraluxUI.lua"))()

-- Create Main Window using x2zu UI
local Window = Library:Window({
    Title = "PetaPeta by Astralux",
    Desc = "Semi-automatic",
    Icon = 105059922903197, -- You can change this Icon ID
    Theme = "Dark", 
    Config = {
        Keybind = Enum.KeyCode.LeftControl, -- Changed to LeftControl as requested
        Size = UDim2.new(0, 580, 0, 460) -- Size similar to the original
    },
    CloseUIButton = {
        Enabled = true,
        Text = "Astralux"
    }
})

-- Create Main Tab
local MainTab = Window:Tab({Title = "Main", Icon = "star"})

-- Helper function to create compatible notifications
local function notify(args)
    Window:Notify({
        Title = args.Title,
        Desc = args.Content,
        Time = args.Duration or 3
    })
end

-- Function to create visual highlight
local function applyHighlight(object, color)
    if not object:FindFirstChildOfClass("Highlight") then
        local hl = Instance.new("Highlight")
        hl.FillColor = color
        hl.FillTransparency = 0.2
        hl.OutlineTransparency = 1
        hl.Parent = object
    end
end

local function removeHighlight(object)
    local highlight = object:FindFirstChildOfClass("Highlight")
    if highlight then
        highlight:Destroy()
    end
end

-- Status for toggles
local espToggleState = false
local proximityBypassState = true
local teleportToEnemyState = true

MainTab:Section({ Title = "General" })

-- Toggle ESP
-- === ESP CONFIG ===
local ESPEnabled = false
local ESPObjects = {}

local ESPSettings = {
    Default = {
        Color = Color3.fromRGB(255, 100, 100),
        Transparency = 0.4,
        TextColor = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        MaxDistance = 1000,
        FixedSize = true,
        BaseSize = UDim2.new(0, 100, 0, 40)
    }
}

local function getPart(obj)
    if obj:IsA("Model") then
        return obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
    elseif obj:IsA("BasePart") then
        return obj
    end
end

local function getDistance(pos)
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        return (root.Position - pos).Magnitude
    end
    return math.huge
end

local function createESP(obj, labelText, color)
    if ESPObjects[obj] or not obj or not obj:IsDescendantOf(Workspace) then return end
    local part = getPart(obj)
    if not part then return end

    local gui = Instance.new("BillboardGui")
    gui.Name = "ESP"
    gui.Adornee = part
    gui.Size = ESPSettings.Default.BaseSize
    gui.AlwaysOnTop = true
    gui.LightInfluence = 0
    gui.MaxDistance = ESPSettings.Default.MaxDistance
    gui.Parent = part

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = color or ESPSettings.Default.Color
    frame.BackgroundTransparency = ESPSettings.Default.Transparency
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local stroke = Instance.new("UIStroke")
    stroke.Color = color or ESPSettings.Default.Color
    stroke.Thickness = 2
    stroke.Parent = frame

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.TextColor3 = ESPSettings.Default.TextColor
    text.TextStrokeTransparency = 0.4
    text.TextStrokeColor3 = Color3.new(0, 0, 0)
    text.Font = Enum.Font.GothamBold
    text.Text = labelText or obj.Name
    text.TextScaled = true
    text.Parent = frame

    ESPObjects[obj] = gui
end

local function removeESP(obj)
    if ESPObjects[obj] then
        ESPObjects[obj]:Destroy()
        ESPObjects[obj] = nil
    end
end

local function clearAllESP()
    for obj, gui in pairs(ESPObjects) do
        if gui then gui:Destroy() end
    end
    ESPObjects = {}
end

local function scanForObjects()
    if not ESPEnabled then return end
    clearAllESP()

    local targets = {}
    local server = Workspace:FindFirstChild("Server")
    if server and server:FindFirstChild("SpawnedItems") then
        for _, item in pairs(server.SpawnedItems:GetChildren()) do
            table.insert(targets, item)
        end
    end

    local enemy = Workspace:FindFirstChild("Client") and Workspace.Client:FindFirstChild("Enemy")
    if enemy then
        for _, obj in pairs(enemy:GetChildren()) do
            table.insert(targets, obj)
        end
    end

    -- Dolls, Keys, Safes in workspace or Server/MapGenerated
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("BasePart") then
            if obj.Name:match("Doll") or obj.Name == "Safe" or obj.Name == "Key" or obj.Name == "HintPaper" or obj.Name == "BoxBottom" then
                table.insert(targets, obj)
            end
        end
    end

    for _, obj in ipairs(targets) do
        createESP(obj, obj.Name)
    end
end

-- Update ESP setiap frame (hapus yang hilang)
RunService.RenderStepped:Connect(function()
    if not ESPEnabled then return end
    for obj, gui in pairs(ESPObjects) do
        if not obj:IsDescendantOf(Workspace) then
            removeESP(obj)
        end
    end
end)

-- Toggle ESP (satu tombol untuk semua)
MainTab:Toggle({
    Title = "ESP",
    Desc = "Toggle ESP untuk semua objek (Zeni, Musuh, Item, dll)",
    Value = false,
    Callback = function(state)
        ESPEnabled = state
        if state then
            scanForObjects()
        else
            clearAllESP()
        end
    end
})


-- Toggle ProximityBypass
MainTab:Toggle({
    Title = "Bypass Proximity Prompt",
    Desc = "Skip Proximity Prompt",
    Value = false,
    Callback = function(value)
        proximityBypassState = value
        if proximityBypassState then
            -- Enable bypass
            for _, prompt in ipairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    -- Save OriginalHoldDuration if not already saved
                    if not prompt:GetAttribute("OriginalHoldDuration") then
                        prompt:SetAttribute("OriginalHoldDuration", prompt.HoldDuration)
                    end
                    prompt.HoldDuration = 0
                end
            end
            
            -- Monitor new prompts
            local connection
            connection = workspace.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("ProximityPrompt") and proximityBypassState then
                    if not descendant:GetAttribute("OriginalHoldDuration") then
                        descendant:SetAttribute("OriginalHoldDuration", descendant.HoldDuration)
                    end
                    descendant.HoldDuration = 0
                end
            end)
            
            -- Save connection for later cleanup
            getgenv().ProximityBypassConnection = connection
            
            notify{
                Title = "Bypass Proximity",
                Content = "Proximity prompt bypass activated",
                Duration = 3
            }
        else
            -- Disable bypass
            for _, prompt in ipairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    -- Restore OriginalHoldDuration
                    prompt.HoldDuration = prompt:GetAttribute("OriginalHoldDuration") or 1
                    prompt:SetAttribute("OriginalHoldDuration", nil) -- Remove attribute
                end
            end
            
            -- Clean up connection
            if getgenv().ProximityBypassConnection then
                getgenv().ProximityBypassConnection:Disconnect()
                getgenv().ProximityBypassConnection = nil
            end
            
            notify{
                Title = "Bypass Proximity",
                Content = "Proximity prompt bypass deactivated",
                Duration = 3
            }
        end
    end
})

-- Toggle Dynamic Enemy Follow
MainTab:Toggle({
    Title = "Follow Enemy (Hold Ofuda)",
    Desc = "Teleport player to enemy (requires holding Ofuda)",
    Value = false,
    Callback = function(value)
        -- Always clean up any existing loop first to prevent parallel loop execution
        if getgenv().EnemyFollowLoop then
            getgenv().EnemyFollowLoop:Disconnect()
            getgenv().EnemyFollowLoop = nil
        end

        teleportToEnemyState = value
        if teleportToEnemyState then
            -- Enable teleport to enemy
            notify{
                Title = "Follow Enemy",
                Content = "Enemy following activated",
                Duration = 3
            }

            -- Check Ofuda once when enabling feature and notify if missing
            task.wait(0.1) -- Give a moment for game status to be accurate
            local character = game.Players.LocalPlayer.Character
            local hasOfudaEquippedOnEnable = false
            if character then
                for _, child in ipairs(character:GetChildren()) do
                    if child:IsA("Tool") and (string.match(child.Name:lower(), "ofuda") or string.match(child.Name:lower(), "talisman")) then
                        hasOfudaEquippedOnEnable = true
                        break
                    end
                end
            end

            if not hasOfudaEquippedOnEnable then
                notify{
                    Title = "Follow Enemy",
                    Content = "You need to equip an Ofuda!",
                    Duration = 3
                }
            end

            -- Robust function to locate the enemy across all stages
            local function findEnemy()
                -- Method 1: Check standard client path
                local clientEnemy = workspace:FindFirstChild("Client")
                clientEnemy = clientEnemy and clientEnemy:FindFirstChild("Enemy")
                clientEnemy = clientEnemy and clientEnemy:FindFirstChild("ClientEnemy")
                local model = clientEnemy and clientEnemy:FindFirstChild("EnemyModel")
                if model then return model end

                -- Method 2: Check server path
                local serverEnemy = workspace:FindFirstChild("Server")
                serverEnemy = serverEnemy and serverEnemy:FindFirstChild("Enemy")
                local sModel = serverEnemy and serverEnemy:FindFirstChild("Enemy")
                if sModel then return sModel end

                -- Method 3: Search recursively for known enemy names
                for _, name in ipairs({"EnemyModel", "EnemyModels", "ClientEnemy", "Enemy"}) do
                    local found = workspace:FindFirstChild(name, true)
                    if found then
                        if found:IsA("Model") then
                            return found
                        elseif found:IsA("Folder") then
                            for _, child in ipairs(found:GetChildren()) do
                                if child:IsA("Model") then return child end
                            end
                        end
                    end
                end

                -- Method 4: Scan workspace for any Model containing a Humanoid that is not a player or friendly NPC
                for _, desc in ipairs(workspace:GetDescendants()) do
                    if desc:IsA("Model") and desc:FindFirstChildOfClass("Humanoid") then
                        local isPlayer = false
                        for _, p in ipairs(game.Players:GetPlayers()) do
                            if p.Character == desc then
                                isPlayer = true
                                break
                            end
                        end
                        if not isPlayer and desc.Name ~= "Child" and desc.Name ~= "KidsNPC" and desc.Name ~= "CryWoman_C" and desc.Name ~= "OohiromaKids" and desc.Name ~= "NPC" then
                            return desc
                        end
                    end
                end
                return nil
            end

            local enemyFollowLoop
            enemyFollowLoop = game:GetService("RunService").Heartbeat:Connect(function()
                local character = game.Players.LocalPlayer.Character
                local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                
                -- Check if character still exists
                if not character or not character.Parent or not rootPart or not rootPart.Parent then
                    return
                end

                -- Silently check Ofuda without spamming notifications
                local hasOfudaEquipped = false
                for _, child in ipairs(character:GetChildren()) do
                    if child:IsA("Tool") and (string.match(child.Name:lower(), "ofuda") or string.match(child.Name:lower(), "talisman")) then
                        hasOfudaEquipped = true
                        break
                    end
                end

                if not hasOfudaEquipped then
                    return -- Silently stop if Ofuda is not held
                end
                
                local currentEnemy = findEnemy()
                
                -- Teleport to enemy automatically
                if currentEnemy then
                    -- Get latest enemy position and facing direction
                    local currentEnemyPosition
                    local enemyLookVector
                    local enemyHeight = 0
                    
                    -- Find HumanoidRootPart or main part of enemy
                    if currentEnemy:FindFirstChild("HumanoidRootPart") then
                        local enemyRootPart = currentEnemy.HumanoidRootPart
                        currentEnemyPosition = enemyRootPart.Position
                        enemyLookVector = enemyRootPart.CFrame.LookVector
                        
                        local humanoid = currentEnemy:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            enemyHeight = humanoid.HipHeight * 2
                        end
                    elseif typeof(currentEnemy.GetPivot) == "function" then
                        local enemyCFrame = currentEnemy:GetPivot()
                        currentEnemyPosition = enemyCFrame.Position
                        enemyLookVector = enemyCFrame.LookVector
                        
                        if currentEnemy:IsA("Model") then
                            enemyHeight = currentEnemy:GetExtentsSize().Y / 2
                        end
                    elseif currentEnemy:IsA("BasePart") then
                        currentEnemyPosition = currentEnemy.Position
                        enemyLookVector = currentEnemy.CFrame.LookVector
                        enemyHeight = currentEnemy.Size.Y / 2
                    else
                        -- Try to find main part of enemy and get height
                        for _, child in pairs(currentEnemy:GetDescendants()) do
                            if child:IsA("BasePart") and (child.Name:lower():find("head")) then
                                currentEnemyPosition = child.Position
                                enemyLookVector = child.CFrame.LookVector
                                enemyHeight = child.Size.Y * 0.8
                                break
                            elseif child:IsA("BasePart") and (child.Name:lower():find("torso") or child.Name:lower():find("upper")) then
                                currentEnemyPosition = child.Position
                                enemyLookVector = child.CFrame.LookVector
                                enemyHeight = child.Size.Y
                                break
                            elseif child:IsA("BasePart") and child.Name:lower():find("root") then
                                currentEnemyPosition = child.Position
                                enemyLookVector = child.CFrame.LookVector
                                break
                            end
                        end
                        
                        if not currentEnemyPosition then
                            for _, child in pairs(currentEnemy:GetDescendants()) do
                                if child:IsA("BasePart") then
                                    currentEnemyPosition = child.Position
                                    enemyLookVector = child.CFrame.LookVector
                                    enemyHeight = child.Size.Y / 2
                                    break
                                end
                            end
                        end
                    end
                    
                    if enemyHeight < 1 then
                        enemyHeight = 5
                    end
                    
                    if currentEnemyPosition and enemyLookVector then
                        -- Check enemy distance from ofuda box
                        local ofudaBox = workspace.Server.SpawnedItems:FindFirstChild("OfudaBox2")
                        local isSafeToTeleport = true
                        
                        if ofudaBox then
                            local ofudaBoxPosition
                            
                            if typeof(ofudaBox.GetPivot) == "function" then
                                ofudaBoxPosition = ofudaBox:GetPivot().Position
                            elseif ofudaBox:IsA("BasePart") then
                                ofudaBoxPosition = ofudaBox.Position
                            else
                                for _, child in pairs(ofudaBox:GetDescendants()) do
                                    if child:IsA("BasePart") then
                                        ofudaBoxPosition = child.Position
                                        break
                                    end
                                end
                            end
                            
                            if ofudaBoxPosition then
                                local distanceToOfudaBox = (currentEnemyPosition - ofudaBoxPosition).Magnitude
                                if distanceToOfudaBox < 20 then
                                    isSafeToTeleport = false
                                    if not getgenv().WarningShown then
                                        notify{
                                            Title = "Warning",
                                            Content = "PetaPeta is near the Ofuda Box. Waiting for the enemy to move away from the Ofuda Box Room",
                                            Duration = 3
                                        }
                                        getgenv().WarningShown = true
                                        task.delay(5, function()
                                            getgenv().WarningShown = false
                                        end)
                                    end
                                end
                            end
                        end
                        
                        if isSafeToTeleport then
                            local distanceFromEnemy = -25
                            local targetPosition = currentEnemyPosition - (enemyLookVector * distanceFromEnemy)
                            targetPosition = Vector3.new(targetPosition.X, currentEnemyPosition.Y + (enemyHeight * 0.67), targetPosition.Z)
                            rootPart.CFrame = CFrame.new(targetPosition, currentEnemyPosition)
                            task.wait(0.03)
                        end
                    end
                end
            end)
            
            getgenv().EnemyFollowLoop = enemyFollowLoop
            
        else
            notify{
                Title = "Follow Enemy",
                Content = "Enemy following deactivated",
                Duration = 3
            }
        end
    end
})

MainTab:Section({ Title = "Player Settings" })

-- Function to apply ESP
local function applyESP()
    if espToggleState then
        local function scan(objects)
            for _, obj in ipairs(objects) do
                if obj:IsA("Model") and (obj.Name == "EnemyModel" or obj.Name == "EnemyModels") then
                    applyHighlight(obj, Color3.fromRGB(255, 100, 100))
                elseif obj:IsA("Model") then
                    if obj.Name == "DollBlackHead" then
                        applyHighlight(obj, Color3.fromRGB(35, 33, 126))
                    elseif obj.Name == "DollBlue" then
                        applyHighlight(obj, Color3.fromRGB(59, 72, 255))
                    elseif obj.Name == "DollRed" then
                        applyHighlight(obj, Color3.fromRGB(177, 46, 46))
                    elseif obj.Name == "DollYellow" then
                        applyHighlight(obj, Color3.fromRGB(210, 212, 52))
                    elseif obj.Name == "DollWhite" then
                        applyHighlight(obj, Color3.fromRGB(255, 255, 255))
                    elseif obj.Name == "DollHouseGimic" then
                        applyHighlight(obj, Color3.fromRGB(255, 192, 203))
                    end
                elseif obj:IsA("BasePart") then
                    if obj.Name == "BoxBottom" then
                        applyHighlight(obj, Color3.fromRGB(100, 255, 100))
                    elseif obj.Name == "Meshes/safe_Safe" then
                        applyHighlight(obj, Color3.fromRGB(255, 255, 0))
                    elseif obj.Name == "Key" then
                        applyHighlight(obj, Color3.fromRGB(255, 215, 0))
                    elseif obj.Name == "HintPaper" then
                        applyHighlight(obj, Color3.fromRGB(47, 231, 255))
                    end
                end
            end
        end

        scan(workspace:GetDescendants())
        if workspace:FindFirstChild("Server") and workspace.Server:FindFirstChild("SpawnedItems") then
            scan(workspace.Server.SpawnedItems:GetDescendants())
        end
    end
end

-- Monitor new objects added to workspace
workspace.DescendantAdded:Connect(function(obj)
    if espToggleState then
        if obj:IsA("Model") and (obj.Name == "EnemyModel" or obj.Name == "EnemyModels") then
            applyHighlight(obj, Color3.fromRGB(255, 100, 100))
        elseif obj:IsA("Model") then
            if obj.Name == "DollBlackHead" then
                applyHighlight(obj, Color3.fromRGB(23, 22, 77))
            elseif obj.Name == "DollBlue" then
                applyHighlight(obj, Color3.fromRGB(59, 72, 255))
            elseif obj.Name == "DollRed" then
                applyHighlight(obj, Color3.fromRGB(177, 46, 46))
            elseif obj.Name == "DollYellow" then
                applyHighlight(obj, Color3.fromRGB(210, 212, 52))
            elseif obj.Name == "DollWhite" then
                applyHighlight(obj, Color3.fromRGB(255, 255, 255))
            elseif obj.Name == "DollHouseGimic" then
                applyHighlight(obj, Color3.fromRGB(255, 192, 203))
            end
        elseif obj:IsA("BasePart") then
            if obj.Name == "BoxBottom" then
                applyHighlight(obj, Color3.fromRGB(100, 255, 100))
            elseif obj.Name == "Meshes/safe_Safe" then
                applyHighlight(obj, Color3.fromRGB(255, 0, 212))
            elseif obj.Name == "Key" then
                applyHighlight(obj, Color3.fromRGB(255, 215, 0))
            elseif obj.Name == "HintPaper" then
                applyHighlight(obj, Color3.fromRGB(80, 229, 255))
            end
        end
    end
end)

local selectedSpeed = 28

-- Function to set walk speed
local function setWalkSpeed(speed)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
    end
end

-- Create speed slider
MainTab:Slider({
    Title = "Speed Mods",
    Desc = "Change player walkspeed",
    Value = 28,
    Min = 16,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        selectedSpeed = Value
        setWalkSpeed(Value)
    end
})

-- Monitor character spawn
game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    setWalkSpeed(selectedSpeed)
    
    -- Monitor WalkSpeed changes
    humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if humanoid.WalkSpeed ~= selectedSpeed then
            humanoid.WalkSpeed = selectedSpeed
        end
    end)
end)

-- Initial setup for existing character
if game.Players.LocalPlayer.Character then
    local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        setWalkSpeed(selectedSpeed)
        humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            if humanoid.WalkSpeed ~= selectedSpeed then
                humanoid.WalkSpeed = selectedSpeed
            end
        end)
    end
end

MainTab:Section({ Title = "⚠️ Note" })
MainTab:Button({
    Title = "Info",
    Desc = "- ESP feature may be unstable\n- ESP only shown at stage 2\n- You need to equip Ofuda manually after using AutoComplete Feature",
    Callback = function() end
})

---
-- Auto Complete Stage 1
MainTab:Section({ Title = "Auto Complete Stage 1" })

MainTab:Button({
    Title = "Auto Complete Stage 1",
    Desc = "Complete all quests in stage 1",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")

        if not character or not rootPart then
            notify{
                Title = "Failed",
                Content = "Player character not found",
                Duration = 3
            }
            return
        end

        -- Helper function to interact with prompt
        local function interactWithPrompt(obj, itemType, maxAttempts)
            maxAttempts = maxAttempts or 5
            if not obj then return false end
            
            local prompt
            if obj:IsA("ProximityPrompt") then
                prompt = obj
            else
                prompt = obj:FindFirstChildOfClass("ProximityPrompt")
                
                if not prompt then
                    for _, descendant in pairs(obj:GetDescendants()) do
                        if descendant:IsA("ProximityPrompt") then
                            prompt = descendant
                            break
                        end
                    end
                end
            end
            
            if prompt then
                local promptParent = prompt.Parent
                local promptPos = nil
                if promptParent:IsA("BasePart") then
                    promptPos = promptParent.Position
                else
                    local part = promptParent:FindFirstChildWhichIsA("BasePart")
                    if part then
                        promptPos = part.Position
                    end
                end
                
                if promptPos then
                    local distance = (rootPart.Position - promptPos).Magnitude
                    if distance > prompt.MaxActivationDistance then
                        rootPart.CFrame = CFrame.new(promptPos + Vector3.new(0, 2, 0))
                        task.wait(0.2)
                    end
                end

                for i = 1, maxAttempts do
                    fireproximityprompt(prompt)
                    task.wait(0.1) -- Short delay for game processing
                    
                    -- Check if item was picked up or box was opened
                    if itemType == "key" then
                        -- Check if key is now in inventory or equipped
                        local success = player.Backpack:FindFirstChild("Key") or (character and character:FindFirstChild("Key"))
                        if success then return true end
                    elseif itemType == "ofudaBox" then
                        -- Check if OfudaBox2 is open (e.g., if it has an Ofuda child or if its status changed)
                        local success = obj:FindFirstChild("Ofuda") or workspace.Server.SpawnedItems:FindFirstChild("Ofuda")
                        if success then return true end
                    elseif itemType == "ofuda" then
                        -- Check if Ofuda is now in inventory or equipped
                        local success = player.Backpack:FindFirstChild("Ofuda") or (character and character:FindFirstChild("Ofuda"))
                        if success then return true end
                    else
                        return true -- For generic prompts if no specific check is needed
                    end
                end
            end
            return false
        end
        
        -- Step 1: Find and teleport to key
        notify{
            Title = "Stage 1",
            Content = "Step 1: Finding and collecting the key...",
            Duration = 2
        }
        
        local key = workspace.Server.SpawnedItems:FindFirstChild("Key")
        if not key then
            notify{
                Title = "Failed",
                Content = "Key not found in the world",
                Duration = 3
            }
            return
        end
        
        rootPart.CFrame = CFrame.new(key:GetPivot().Position + Vector3.new(0, 2, 0))
        task.wait(0.1)
        
        -- Step 2: Interact with key to take it
        notify{
            Title = "Stage 1",
            Content = "Step 2: Collecting key...",
            Duration = 2
        }
        
        local keyPickedUp = interactWithPrompt(key, "key")
        if not keyPickedUp then
            notify{
                Title = "Failed",
                Content = "Failed to collect key. Please collect it manually",
                Duration = 3
            }
            return
        end
        task.wait(0.1)
        
        -- Step 2.5: Complete key with reliability
        notify{
            Title = "Stage 1",
            Content = "Step 2.5: Equipping key...",
            Duration = 2
        }

        local keyTool = player.Backpack:FindFirstChild("Key")
        if not keyTool then
            for i = 1, 10 do task.wait(0.2) keyTool = player.Backpack:FindFirstChild("Key") if keyTool then break end end
        end

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if keyTool and humanoid then
            -- More reliable equip method
            humanoid:UnequipTools()
            task.wait(0.2)
            keyTool.Parent = character
            task.wait(0.1)
            if not character:FindFirstChild("Key") then
                humanoid:EquipTool(keyTool)
                task.wait(0.1)
            end

            if character:FindFirstChild("Key") then
                 notify{ Title = "Stage 1 Auto", Content = "Key successfully equipped!", Duration = 1 }
            else
                 notify{ Title = "Warning", Content = "Failed to equip key automatically. Please equip manually", Duration = 3 }
            end
        else
            notify{ Title = "Warning", Content = "Key not found in backpack for equipping", Duration = 3 }
        end
        
        -- Step 3: Teleport to ofuda box
        notify{
            Title = "Stage 1 Auto",
            Content = "Step 3: Moving to Ofuda box...",
            Duration = 2
        }
        
        local ofudaBox = workspace.Server.SpawnedItems:FindFirstChild("OfudaBox2")
        if not ofudaBox then
            notify{
                Title = "Failed",
                Content = "Ofuda box not found",
                Duration = 3
            }
            return
        end
        
        local ofudaBoxPosition = ofudaBox:GetPivot().Position
        local frontPosition = ofudaBoxPosition + (ofudaBox:GetPivot().LookVector * -3) -- Position in front of box
        rootPart.CFrame = CFrame.new(frontPosition, ofudaBoxPosition)
        task.wait(0.1)
                
        -- Step 4: Open ofuda box
        notify{
            Title = "Stage 1 Auto",
            Content = "Step 4: Opening Ofuda box...",
            Duration = 2
        }
        
        local boxOpened = interactWithPrompt(ofudaBox, "ofudaBox")
        if not boxOpened then
            notify{
                Title = "Failed",
                Content = "Failed to open Ofuda box. Make sure key is equipped and you're close enough",
                Duration = 3
            }
            return
        end
        task.wait(0.1) -- Wait for box to fully open and Ofuda to spawn
        
        -- Step 5: Find ofuda and take it
        notify{
            Title = "Stage 1 Auto",
            Content = "Step 5: Locating and collecting Ofuda...",
            Duration = 2
        }
        
        local ofudaItem = nil
        local maxOfudaAttempts = 10
        for attempt = 1, maxOfudaAttempts do
            ofudaItem = workspace.Server.SpawnedItems:FindFirstChild("Ofuda") or
                          workspace.Server.SpawnedItems:FindFirstChild("Ofuda Onya") or
                          workspace.Server.SpawnedItems:FindFirstChild("Talisman")

            if not ofudaItem then
                -- Broad search for any item containing "ofuda" or "talisman" in name or descendants
                for _, item in pairs(workspace.Server.SpawnedItems:GetChildren()) do
                    if string.match(item.Name:lower(), "ofuda") or string.match(item.Name:lower(), "talisman") then
                        ofudaItem = item
                        break
                    end
                end
            end

            if ofudaItem then break end
            task.wait(0.1) -- Short delay before next attempt
        end
        
        if not ofudaItem then
            notify{
                Title = "Failed",
                Content = "Ofuda not found after opening box",
                Duration = 3
            }
            return
        end

        -- Teleport directly to ofuda for reliable pickup
        rootPart.CFrame = CFrame.new(ofudaItem:GetPivot().Position + Vector3.new(0, 2, 0))
        task.wait(0.1)

        local ofudaPickedUp = interactWithPrompt(ofudaItem, "ofuda")
        if not ofudaPickedUp then
            notify{
                Title = "Failed",
                Content = "Failed to collect Ofuda",
                Duration = 3
            }
            return
        end
        task.wait(0.1) -- Reduced wait time

        -- Step 6: Complete ofuda using more reliable approach
        notify{
            Title = "Stage 1 Auto",
            Content = "Step 6: Equipping Ofuda...",
            Duration = 2
        }
        
        -- More reliable approach to equip ofuda
        local ofudaTool = player.Backpack:FindFirstChildOfClass("Tool", function(tool) 
            return string.match(tool.Name:lower(), "ofuda") or string.match(tool.Name:lower(), "talisman") 
        end)
        
        if ofudaTool then
            -- Try various approaches to ensure equip works
            local ofudaName = ofudaTool.Name
            
            -- Approach 1: Direct parent change
            ofudaTool.Parent = character
            task.wait(0.1)
            
            -- Check if successful
            if not character:FindFirstChild(ofudaName) then
                -- Approach 2: Use Humanoid EquipTool
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:EquipTool(ofudaTool)
                    task.wait(0.1)
                end
                
                -- Approach 3: Simulate slot selection
                if not character:FindFirstChild(ofudaName) then
                    for i = 1, 9 do 
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode[tostring(i)], false, game)
                        task.wait(0.1)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode[tostring(i)], false, game)
                        task.wait(0.1)
                        
                        if character:FindFirstChild(ofudaName) then
                            break 
                        end
                    end
                end
            end
            
            -- Final check
            if character:FindFirstChild(ofudaName) then
                notify{ Title = "Stage 1 Auto", Content = "Ofuda successfully equipped!", Duration = 1 }
            else
                notify{ Title = "Warning", Content = "Failed to equip Ofuda automatically. Please equip manually", Duration = 2 }
            end
        else
            notify{ Title = "Warning", Content = "Ofuda not found in backpack after collection", Duration = 2 }
        end

        if character:FindFirstChildOfClass("Tool", function(tool) return string.match(tool.Name:lower(), "ofuda") or string.match(tool.Name:lower(), "talisman") end) then
            notify{
                Title = "Stage 1 Auto",
                Content = "Stage 1 Auto Complete: Success! Key and Ofuda secured",
                Duration = 3
            }
        else
            notify{
                Title = "Stage 1 Auto",
                Content = "Stage 1 Auto Complete: Steps completed, but Ofuda may not be equipped",
                Duration = 3
            }
        end
    end
})

---
-- Auto Complete Stage 2/3
MainTab:Section({ Title = "Auto Complete Stage 2 and 3" })

-- Auto Complete Stage 2/3 HYBRID (Combining stable logic from NEW and ALTERNATIVE)
MainTab:Button({
    Title = "Auto Complete Stage 2/3",
    Desc = "Stable version that adapts to map stage changes",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")

        if not (character and humanoid and rootPart) then
            notify{ Title = "Failed", Content = "Player character not found", Duration = 3 }
            return
        end

        local function waitFor(desc, fn, timeout)
            local timer = 0
            repeat task.wait(0.2) timer += 0.2 until fn() or timer >= (timeout or 10)
            return fn()
        end

        local function interactWithPrompt(obj, itemType, maxAttempts)
            maxAttempts = maxAttempts or 5
            if not obj then return false end

            local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
            if not prompt then
                for _, d in pairs(obj:GetDescendants()) do
                    if d:IsA("ProximityPrompt") then prompt = d break end
                end
            end
            if not prompt then return false end

            local promptPos = prompt.Parent:IsA("BasePart") and prompt.Parent.Position or (prompt.Parent:FindFirstChildWhichIsA("BasePart") or {}).Position
            if promptPos and (rootPart.Position - promptPos).Magnitude > prompt.MaxActivationDistance then
                rootPart.CFrame = CFrame.new(promptPos + Vector3.new(0, 2, 0))
                task.wait(0.1)
            end

            for i = 1, maxAttempts do
                fireproximityprompt(prompt)
                task.wait(0.1)
                if itemType == "key" and (player.Backpack:FindFirstChild("Key") or character:FindFirstChild("Key")) then return true end
                if itemType == "ofuda" and (player.Backpack:FindFirstChildWhichIsA("Tool") or character:FindFirstChildWhichIsA("Tool")) then return true end
                if itemType == "ofudaBox" and workspace.Server.SpawnedItems:FindFirstChild("Ofuda") then return true end
            end
            return false
        end

        -- Find Safe
        notify{Title="Stage 2", Content="Searching for safe...", Duration=2}
        local safe = waitFor("safe", function()
            for _, room in pairs(workspace.Server.MapGenerated.Rooms:GetChildren()) do
                if room:FindFirstChild("Props") and room.Props:FindFirstChild("Safe") then
                    return room.Props.Safe
                end
            end
            return workspace:FindFirstChild("Safe", true)
        end)

        if not safe then notify{Title="Failed", Content="Safe not found", Duration=3} return end

        rootPart.CFrame = CFrame.new(safe:GetPivot().Position + safe:GetPivot().LookVector * 3, safe:GetPivot().Position)
        task.wait(0.1)

        -- Force open Safe if possible
        if safe:FindFirstChild("Unlocked") and safe.Unlocked:IsA("BoolValue") then
            safe.Unlocked.Value = true
            task.wait(0.1)
        end

        -- Wait for key to appear
        notify{Title="Stage 2", Content="Waiting for key to appear...", Duration=2}
        local key = waitFor("key", function()
            for _, room in pairs(workspace.Server.MapGenerated.Rooms:GetChildren()) do
                if room:FindFirstChild("Props") and room.Props:FindFirstChild("Safe") then
                    local k = room.Props.Safe:FindFirstChild("Key")
                    if k then return k end
                end
            end
            return workspace.Server.SpawnedItems:FindFirstChild("Key")
        end, 10)

        if not key then notify{Title="Failed", Content="Key not found", Duration=3} return end

        rootPart.CFrame = CFrame.new(key:GetPivot().Position + Vector3.new(0,2,0))
        task.wait(0.1)

        if not interactWithPrompt(key, "key") then
            notify{Title="Failed", Content="Failed to collect key", Duration=3} return
        end

        local tool = player.Backpack:FindFirstChild("Key")
        if tool then tool.Parent = character task.wait(0.3) end

        -- Go to OfudaBox
        local ofudaBox = workspace.Server.SpawnedItems:FindFirstChild("OfudaBox2")
        if not ofudaBox then notify{Title="Failed", Content="Ofuda box not found", Duration=3} return end
        rootPart.CFrame = CFrame.new(ofudaBox:GetPivot().Position + (ofudaBox:GetPivot().LookVector * -3), ofudaBox:GetPivot().Position)
        task.wait(0.1)
        interactWithPrompt(ofudaBox, "ofudaBox")

        -- Wait and take Ofuda
        notify{Title="Stage 2", Content="Searching for Ofuda...", Duration=2}
        local ofuda = waitFor("ofuda", function()
            return workspace.Server.SpawnedItems:FindFirstChild("Ofuda") or workspace.Server.SpawnedItems:FindFirstChild("Talisman")
        end)

        if not ofuda then notify{Title="Failed", Content="Ofuda not found", Duration=3} return end

        rootPart.CFrame = CFrame.new(ofuda:GetPivot().Position + Vector3.new(0, 2, 0))
        task.wait(0.1)

        if not interactWithPrompt(ofuda, "ofuda") then
            notify{Title="Failed", Content="Failed to collect Ofuda", Duration=3} return
        end

        -- Equip Ofuda
        local ofudaTool = player.Backpack:FindFirstChildWhichIsA("Tool")
        if ofudaTool then ofudaTool.Parent = character end

        notify{Title="Stage", Content="Stage 2/3 Auto Complete finished!", Duration=3}
    end
})

-- Stage 4 Completion
MainTab:Section({ Title = "Stage 4 Completion" })

-- Auto Complete Stage 4: Combined Doll Settings, Finish, and OldPhoto + Ofuda Collection
MainTab:Button({
    Title = "Auto Complete Stage 4",
    Desc = "Combined doll settings + finish + OldPhoto collection + Ofuda collection", 
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")

        if not (character and humanoid and rootPart) then
            notify{ Title = "Failed", Content = "Player character not found", Duration = 3 }
            return
        end

        local stage4Path = game:GetService("ReplicatedStorage").GameStatus.Stage4

        -- Set doll values
        local dollSettings = {
            ["DollBlack"] = {"Finished", "Installed", "Obtained", "HeadConnect", "HeadObtained"},
            ["DollBlue"] = {"Finished", "Installed", "Obtained"},
            ["DollWhite"] = {"Finished", "Installed", "Obtained"},
            ["DollRed"] = {"Finished", "Installed", "Obtained"},
            ["DollYellow"] = {"Finished", "Installed", "Obtained"}
        }

        for dollName, values in pairs(dollSettings) do
            for _, val in ipairs(values) do
                local fullName = dollName .. val
                local ref = stage4Path:FindFirstChild(fullName)
                if ref and ref:IsA("BoolValue") then
                    ref.Value = true
                end
            end
        end

        local allSet = stage4Path:FindFirstChild("DollAllSet")
        if allSet then allSet.Value = true end

        notify{ Title = "Stage 4", Content = "All dolls configured and DollAllSet activated", Duration = 1 }

        -- Complete doll sequence
        local dollAllSet = stage4Path:FindFirstChild("DollAllSet")
        if dollAllSet and dollAllSet:IsA("BoolValue") then
            dollAllSet.Value = true
            notify{ Title = "Stage 4", Content = "Doll sequence completed", Duration = 1 }
        end

        task.wait(0.1) -- Add delay to ensure update completes

        -- Teleport in front of doll house
        local dollHouse = nil
        for _, room in pairs(workspace.Server.MapGenerated.Rooms:GetChildren()) do
            if room:FindFirstChild("DollHouseGimic") then
                dollHouse = room.DollHouseGimic
                break
            end
        end

        if dollHouse then
            local cframe = dollHouse:GetPivot()
            local front = cframe.Position + (cframe.LookVector * 10)
            rootPart.CFrame = CFrame.new(front, cframe.Position)
            notify{ Title = "Teleport", Content = "Successfully teleported to doll house", Duration = 2 }
        end

        task.wait(0.1) -- Add delay before proceeding to pickup

        -- Strong item pickup function
        local function tryPickup(itemName)
            local item = nil
            for i = 1, 20 do
                item = workspace.Server.SpawnedItems:FindFirstChild(itemName)
                if item then break end
                task.wait(0.1)
            end

            if item then
                rootPart.CFrame = CFrame.new(item:GetPivot().Position + Vector3.new(0,2,0))
                task.wait(0.1)

                local prompt = item:FindFirstChildOfClass("ProximityPrompt")
                if not prompt then
                    for _, d in ipairs(item:GetDescendants()) do
                        if d:IsA("ProximityPrompt") then
                            prompt = d
                            break
                        end
                    end
                end

                if prompt then
                    for i = 1, 8 do
                        fireproximityprompt(prompt)
                        task.wait(0.1)
                        if not item:IsDescendantOf(workspace) then break end
                    end
                    notify{ Title = "Item", Content = itemName .. " successfully collected", Duration = 1 }
                    return true
                else
                    notify{ Title = "Failed", Content = "Prompt not found on " .. itemName, Duration = 1 }
                end
            else
                notify{ Title = "Failed", Content = itemName .. " not found in SpawnedItems", Duration = 1 }
            end
            return false
        end

        -- Collect OldPhoto
        if not tryPickup("OldPhoto") then return end

        task.wait(0.1) -- Extra delay before searching for Ofuda

        -- Wait and collect Ofuda after photo
        if not tryPickup("Ofuda") and not tryPickup("Talisman") then
            notify{ Title = "Failed", Content = "Ofuda did not appear after OldPhoto", Duration = 1 }
            return
        end

        local ofudaTool = player.Backpack:FindFirstChildWhichIsA("Tool")
        if ofudaTool then
            ofudaTool.Parent = character
            task.wait(0.1)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Two, false, game)
            task.wait(0.1)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Two, false, game)
            notify{ Title = "Equip", Content = "Ofuda successfully equipped to slot 2", Duration = 2 }
        end
    end
})

-- Stage 5 Completion
MainTab:Section({ Title = "Stage 5 Completion" })

MainTab:Button({
    Title = "Auto Complete Stage 5",
    Desc = "Complete the stage 5",
    Callback = function()
        -- Path to Stage 5
        local stage5Path = game:GetService("ReplicatedStorage").GameStatus.Stage5
        
        -- List of values to set based on requirements
        local valuesToSet = {
            "DialOpened",
            "DishInstalled",
            "DishObtained",
            "LighterInstalled",
            "LighterObtained",
            "RopeInstalled",
            "RopeObtained",
            "StageEnd"
        }
        
        local totalValues = #valuesToSet
        local successCount = 0
        
        -- Set all values to true
        for _, valueName in ipairs(valuesToSet) do
            local boolValue = stage5Path:FindFirstChild(valueName)
            if boolValue and boolValue:IsA("BoolValue") then
                boolValue.Value = true
                successCount = successCount + 1
            end
        end
        
        notify{
            Title = "Stage 5 Status",
            Content = "Set " .. successCount .. "/" .. totalValues .. " stage values",
            Duration = 3
        }
    end
})

---
-- Stage 6 Completion
MainTab:Section({ Title = "Stage 6 Completion" })

MainTab:Button({
    Title = "Auto Complete Stage 6",
    Desc = "Teleports you to the finish line",
    Callback = function()
        -- Find ShoeRack in the given path
        local shoeRack = workspace.Server.MapCore._1stFloor["1st_6"].Entrance:FindFirstChild("ShoeRack")
        
        if not shoeRack then
            -- Fallback: try to find in all Rooms
            for _, room in pairs(workspace.Server.MapGenerated.Rooms:GetChildren()) do
                if room:FindFirstChild("ShoeRack") then
                    shoeRack = room.ShoeRack
                    break
                end
            end
        end
        
        if shoeRack and game.Players.LocalPlayer.Character then
            local rootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                -- Get shoe rack position and orientation
                local shoeRackCFrame
                
                if typeof(shoeRack.GetPivot) == "function" then
                    shoeRackCFrame = shoeRack:GetPivot()
                elseif shoeRack:IsA("BasePart") then
                    shoeRackCFrame = shoeRack.CFrame
                elseif shoeRack:IsA("Model") then
                    local primaryPart = shoeRack.PrimaryPart
                    if primaryPart then
                        shoeRackCFrame = primaryPart.CFrame
                    else
                        -- Try to find a part to use as reference
                        for _, child in pairs(shoeRack:GetChildren()) do
                            if child:IsA("BasePart") then
                                shoeRackCFrame = child.CFrame
                                break
                            end
                        end
                    end
                end
                
                if shoeRackCFrame then
                    -- Position character 5 studs BEHIND the shoe rack
                    local backOffset = shoeRackCFrame.LookVector * -5
                    local teleportCFrame = shoeRackCFrame + backOffset
                    
                    -- Ensure character faces the shoe rack
                    teleportCFrame = CFrame.new(teleportCFrame.Position, shoeRackCFrame.Position)
                    
                    -- Teleport
                    rootPart.CFrame = teleportCFrame
                    
                    notify{
                        Title = "Teleported",
                        Content = "Successfully teleported to Finish Line",
                        Duration = 3
                    }
                else
                    notify{
                        Title = "Teleport Failed",
                        Content = "Could not determine Finish Line position",
                        Duration = 3
                    }
                end
            end
        else
            notify{
                Title = "Teleport Failed",
                Content = "Could not find Finish Line in the specified path",
                Duration = 3
            }
        end
    end
})

-- Stage 7 Completion
MainTab:Section({ Title = "Stage 7 Completion" })

MainTab:Button({
    Title = "Auto Complete Stage 7",
    Desc = "Solve chest, pick up key, unlock kids room, interact, and secure Ofuda",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")

        if not (character and humanoid and rootPart) then
            notify{ Title = "Failed", Content = "Player character not found", Duration = 3 }
            return
        end

        local EtoData = nil
        pcall(function()
            EtoData = require(game:GetService("ReplicatedStorage"):WaitForChild("GameConfig"):WaitForChild("EtoData"))
        end)

        local function getZodiacIndex(identifier)
            if not identifier then return 1 end
            local cleanId = tostring(identifier):lower()
            local digits = string.match(cleanId, "%d+")
            
            if EtoData then
                for i = 1, 12 do
                    local data = EtoData[i]
                    if data then
                        if typeof(data) == "table" then
                            if data.Name and tostring(data.Name):lower() == cleanId then return i end
                            if data.name and tostring(data.name):lower() == cleanId then return i end
                            for k, v in pairs(data) do
                                if typeof(v) == "string" then
                                    local vDigits = string.match(v, "%d+")
                                    if digits and vDigits and digits == vDigits then return i end
                                end
                            end
                        elseif typeof(data) == "string" then
                            if data:lower() == cleanId then return i end
                            local dataDigits = string.match(data, "%d+")
                            if digits and dataDigits and digits == dataDigits then return i end
                        end
                    end
                end
                
                -- Dictionary fallback
                for key, data in pairs(EtoData) do
                    local keyStr = tostring(key):lower()
                    if keyStr == cleanId then
                        if typeof(data) == "number" then return data end
                        if typeof(data) == "table" and data.Index then return data.Index end
                        if typeof(data) == "table" and data.index then return data.index end
                    end
                    if typeof(data) == "table" then
                        if data.Name and tostring(data.Name):lower() == cleanId then
                            if typeof(key) == "number" then return key end
                            if data.Index then return data.Index end
                            if data.index then return data.index end
                        end
                        for k, v in pairs(data) do
                            if typeof(v) == "string" then
                                local vDigits = string.match(v, "%d+")
                                if digits and vDigits and digits == vDigits then
                                    if typeof(key) == "number" then return key end
                                    if data.Index then return data.Index end
                                    if data.index then return data.index end
                                end
                            end
                        end
                    end
                end
            end
            
            local standardZodiac = {
                rat = 1, mouse = 1, ox = 2, cow = 2, tiger = 3, rabbit = 4, hare = 4,
                dragon = 5, snake = 6, horse = 7, sheep = 8, goat = 8, ram = 8,
                monkey = 9, rooster = 10, chicken = 10, bird = 10, dog = 11, pig = 12, boar = 12
            }
            return standardZodiac[cleanId] or 1
        end

        local function findItem(itemName)
            local item = workspace.Server.SpawnedItems:FindFirstChild(itemName)
            if not item then
                for _, desc in ipairs(workspace:GetDescendants()) do
                    if desc.Name == itemName and (desc:IsA("Model") or desc:IsA("BasePart")) then
                        if not desc:IsDescendantOf(player.Character) and not desc:IsDescendantOf(player.Backpack) then
                            item = desc
                            break
                        end
                    end
                end
            end
            return item
        end

        local function pickupItem(item)
            if not item then return false end
            for i = 1, 10 do
                if not item:IsDescendantOf(workspace) then return true end
                rootPart.CFrame = item:GetPivot() + Vector3.new(0, 2, 0)
                task.wait(0.1)
                local prompt = item:FindFirstChildOfClass("ProximityPrompt") or item:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt then
                    if fireproximityprompt then
                        fireproximityprompt(prompt)
                    else
                        prompt:InputHoldBegin()
                        task.wait(prompt.HoldDuration + 0.05)
                        prompt:InputHoldEnd()
                    end
                end
                task.wait(0.1)
            end
            return not item:IsDescendantOf(workspace)
        end

        -- Find DialShelf / Chest model
        local kinkoModel = nil
        for _, desc in ipairs(workspace:GetDescendants()) do
            if desc.Name == "DialShelf" then
                kinkoModel = desc.Parent
                break
            end
        end

        if not kinkoModel then
            notify{ Title = "Failed", Content = "DialShelf / Chest model not found", Duration = 3 }
            return
        end

        notify{ Title = "Stage 7", Content = "Scanning rooms for Eto clues...", Duration = 2 }

        -- Scan map for Eto and EtoNum pairs
        local code = {}
        local onsenEto = nil
        
        local roomsFolder = workspace.Server:FindFirstChild("MapGenerated")
        roomsFolder = roomsFolder and roomsFolder:FindFirstChild("Rooms")
        
        if roomsFolder then
            for _, room in ipairs(roomsFolder:GetChildren()) do
                for _, desc in ipairs(room:GetDescendants()) do
                    local etoPart = desc:FindFirstChild("Eto")
                    local etoNumPart = desc:FindFirstChild("EtoNum")
                    if etoPart and etoNumPart then
                        local etoLabel = etoPart:FindFirstChildWhichIsA("ImageLabel", true)
                        local numLabel = etoNumPart:FindFirstChildWhichIsA("ImageLabel", true)
                        
                        if etoLabel and numLabel then
                            if etoLabel.Name ~= "ImageLabel" and numLabel.Name ~= "ImageLabel" then
                                local animalName = etoLabel.Name
                                local orderNum = tonumber(numLabel.Name)
                                if orderNum then
                                    code[orderNum] = animalName
                                end
                            else
                                onsenEto = etoLabel.Image
                            end
                        end
                    end
                end
            end
        end

        -- Resolve Onsen Room animal name and remaining index
        if onsenEto then
            local onsenAnimal = nil
            if EtoData then
                local digits = string.match(onsenEto, "%d+")
                for i = 1, 12 do
                    local data = EtoData[i]
                    if typeof(data) == "table" and data.Name and data.Image then
                        local dataDigits = string.match(tostring(data.Image), "%d+")
                        if digits and dataDigits and digits == dataDigits then
                            onsenAnimal = data.Name
                            break
                        end
                    end
                end
            end
            
            onsenAnimal = onsenAnimal or onsenEto
            
            local usedNums = {}
            for i = 1, 3 do
                if code[i] then usedNums[i] = true end
            end
            local remainingNum = 1
            for i = 1, 3 do
                if not usedNums[i] then
                    remainingNum = i
                    break
                end
            end
            code[remainingNum] = onsenAnimal
        end

        -- Convert to zodiac indices
        local dialValues = {
            getZodiacIndex(code[1]),
            getZodiacIndex(code[2]),
            getZodiacIndex(code[3])
        }

        local codeText = string.format("%s (%d) - %s (%d) - %s (%d)", 
            tostring(code[1] or "Unknown"), dialValues[1],
            tostring(code[2] or "Unknown"), dialValues[2],
            tostring(code[3] or "Unknown"), dialValues[3]
        )
        notify{ Title = "Eto Code Found", Content = codeText, Duration = 5 }

        -- Submit code to Dial Shelf
        local dialEvent = game:GetService("ReplicatedStorage"):WaitForChild("Stage7EtoDialEvent")
        dialEvent:FireServer(dialValues, kinkoModel)
        notify{ Title = "Stage 7", Content = "Combination submitted. Waiting for key...", Duration = 2 }
        task.wait(1.0)

        -- Find and pick up the KidsRoomKey
        local key = findItem("KidsRoomKey") or findItem("Key")
        if key then
            notify{ Title = "Stage 7", Content = "Key found! Teleporting to pick up...", Duration = 2 }
            if pickupItem(key) then
                notify{ Title = "Stage 7", Content = "Key collected!", Duration = 2 }
            end
        else
            notify{ Title = "Stage 7", Content = "Key not found in workspace", Duration = 2 }
        end
        task.wait(0.5)

        -- Equip the key
        local backpackKey = player.Backpack:FindFirstChild("KidsRoomKey") or player.Backpack:FindFirstChild("Key")
        if backpackKey then
            backpackKey.Parent = character
            task.wait(0.2)
        end

        -- Find the lock and unlock Kids Room
        local lockModel = nil
        if roomsFolder then
            for _, room in ipairs(roomsFolder:GetChildren()) do
                local lock = room:FindFirstChild("Lock", true)
                if lock then
                    lockModel = lock
                    break
                end
            end
        end

        if lockModel then
            local unlockEvent = game:GetService("ReplicatedStorage"):WaitForChild("Stage7KidsRoomUnlockEvent")
            unlockEvent:FireServer(lockModel)
            notify{ Title = "Stage 7", Content = "Kids room unlocked!", Duration = 2 }
            task.wait(1.0)
        else
            notify{ Title = "Stage 7", Content = "Lock model not found or already unlocked", Duration = 2 }
        end

        -- Find and interact with Kids NPC
        local kidsNpc = nil
        if roomsFolder then
            for _, room in ipairs(roomsFolder:GetChildren()) do
                for _, desc in ipairs(room:GetDescendants()) do
                    if desc.Name == "KidsNPC" or desc.Name == "Child" or desc.Name == "CryWoman_C" then
                        kidsNpc = desc
                        break
                    end
                end
                if kidsNpc then break end
            end
        end

        if kidsNpc then
            local interactEvent = game:GetService("ReplicatedStorage"):WaitForChild("Stage7KidsInteractEvent")
            interactEvent:FireServer(kidsNpc)
            notify{ Title = "Stage 7", Content = "Interacted with Kids NPC! Waiting for Ofuda...", Duration = 2 }
            task.wait(2.0)
        else
            notify{ Title = "Stage 7", Content = "Kids NPC not found", Duration = 2 }
        end

        -- Find and pick up Ofuda
        local ofuda = findItem("Ofuda") or findItem("Talisman")
        if ofuda then
            notify{ Title = "Stage 7", Content = "Ofuda found! Teleporting to pick up...", Duration = 2 }
            if pickupItem(ofuda) then
                notify{ Title = "Stage 7", Content = "Ofuda collected!", Duration = 2 }
            end
        else
            notify{ Title = "Stage 7", Content = "Ofuda not found in workspace", Duration = 2 }
        end
        task.wait(0.5)

        -- Equip Ofuda
        local ofudaTool = player.Backpack:FindFirstChild("Ofuda") or player.Backpack:FindFirstChild("Talisman")
        if ofudaTool then
            ofudaTool.Parent = character
            task.wait(0.2)
            notify{ Title = "Stage 7 Complete", Content = "Ofuda equipped. Stage 7 auto-completion complete!", Duration = 3 }
        else
            notify{ Title = "Stage 7 Complete", Content = "Auto-completion finished!", Duration = 3 }
        end
    end
})

-- Stage 8 Completion
MainTab:Section({ Title = "Stage 8 Completion" })

MainTab:Button({
    Title = "Auto Complete Stage 8",
    Desc = "Collect Warifu, unlock Oohiroma, solve cushions, dishes, plates, and get Ofuda",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")

        if not (character and humanoid and rootPart) then
            notify{ Title = "Failed", Content = "Player character not found", Duration = 3 }
            return
        end

        local function findItem(itemName)
            local item = workspace.Server.SpawnedItems:FindFirstChild(itemName)
            if not item then
                for _, desc in ipairs(workspace:GetDescendants()) do
                    if desc.Name == itemName and (desc:IsA("Model") or desc:IsA("BasePart")) then
                        if not desc:IsDescendantOf(player.Character) and not desc:IsDescendantOf(player.Backpack) then
                            item = desc
                            break
                        end
                    end
                end
            end
            return item
        end

        local function pickupItem(item)
            if not item then return false end
            for i = 1, 10 do
                if not item:IsDescendantOf(workspace) then return true end
                rootPart.CFrame = item:GetPivot() + Vector3.new(0, 2, 0)
                task.wait(0.1)
                local prompt = item:FindFirstChildOfClass("ProximityPrompt") or item:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt then
                    if fireproximityprompt then
                        fireproximityprompt(prompt)
                    else
                        prompt:InputHoldBegin()
                        task.wait(prompt.HoldDuration + 0.05)
                        prompt:InputHoldEnd()
                    end
                end
                task.wait(0.1)
            end
            return not item:IsDescendantOf(workspace)
        end

        -- Step 1: Collect Wooden Key (Warifu)
        notify{ Title = "Stage 8", Content = "Searching for Wooden Key (Warifu)...", Duration = 2 }
        local warifu = findItem("Warifu")
        if warifu then
            pickupItem(warifu)
        end

        -- Equip Warifu
        local backpackWarifu = player.Backpack:FindFirstChild("Warifu")
        if backpackWarifu then
            backpackWarifu.Parent = character
            task.wait(0.2)
        end

        -- Step 2: Unlock Oohiroma
        local lockModel = nil
        local roomsFolder = workspace.Server:FindFirstChild("MapGenerated")
        roomsFolder = roomsFolder and roomsFolder:FindFirstChild("Rooms")
        
        if roomsFolder then
            for _, room in ipairs(roomsFolder:GetChildren()) do
                local lock = room:FindFirstChild("Lock", true)
                if lock then
                    lockModel = lock
                    break
                end
            end
        end

        if lockModel then
            local unlockEvent = game:GetService("ReplicatedStorage"):WaitForChild("Stage8OohiromaUnlockEvent")
            unlockEvent:FireServer(lockModel)
            notify{ Title = "Stage 8", Content = "Oohiroma unlocked!", Duration = 2 }
            task.wait(1.0)
        else
            notify{ Title = "Stage 8", Content = "Lock not found or already unlocked", Duration = 2 }
        end

        -- Step 3: Solve Cushion Rotation Puzzles
        notify{ Title = "Stage 8", Content = "Solving Cushion rotation puzzles...", Duration = 2 }
        if roomsFolder then
            for _, room in ipairs(roomsFolder:GetChildren()) do
                for _, desc in ipairs(room:GetDescendants()) do
                    if desc.Name == "Meshes/Cushion" and desc:IsA("BasePart") then
                        local prompt = desc:FindFirstChildOfClass("ProximityPrompt") or desc:FindFirstChildWhichIsA("ProximityPrompt", true)
                        if prompt and prompt.Enabled then
                            local gimmickModel = desc.Parent
                            local index = tonumber(string.match(gimmickModel.Name, "%d+"))
                            if index then
                                local rotateEvent = game:GetService("ReplicatedStorage"):WaitForChild("Stage8CushionRotateEvent")
                                local attempts = 0
                                while math.abs(math.round(desc.Orientation.Y) - 90) >= 1 and attempts < 15 do
                                    rotateEvent:FireServer(index)
                                    task.wait(0.1)
                                    attempts = attempts + 1
                                end
                            end
                        end
                    end
                end
            end
        end

        -- Step 4: Solve Dish Placing Puzzles
        notify{ Title = "Stage 8", Content = "Solving Dish placing puzzles...", Duration = 2 }
        if roomsFolder then
            for _, room in ipairs(roomsFolder:GetChildren()) do
                for _, gimmick in ipairs(room:GetChildren()) do
                    if string.match(gimmick.Name, "^Gimmick%d+$") then
                        local missingPlate = gimmick:GetAttribute("MissingPlate")
                        local index = tonumber(string.match(gimmick.Name, "%d+"))
                        local interactPoint = gimmick:FindFirstChild("InteractPoint")
                        local prompt = interactPoint and (interactPoint:FindFirstChildOfClass("ProximityPrompt") or interactPoint:FindFirstChildWhichIsA("ProximityPrompt", true))
                        
                        if missingPlate and index and prompt and prompt.Enabled then
                            local requiredDish = (missingPlate == "Plate4") and "Tyawan" or "Shiruwan"
                            local dishItem = findItem(requiredDish)
                            if dishItem then
                                pickupItem(dishItem)
                            end
                            local backpackDish = player.Backpack:FindFirstChild(requiredDish)
                            if backpackDish then
                                backpackDish.Parent = character
                                task.wait(0.2)
                            end
                            
                            local placeEvent = game:GetService("ReplicatedStorage"):WaitForChild("Stage8DishPlaceEvent")
                            placeEvent:FireServer(index)
                            task.wait(0.5)
                        end
                    end
                end
            end
        end

        -- Step 5: Solve Plate Swapping Puzzle
        notify{ Title = "Stage 8", Content = "Solving Plate swapping puzzle...", Duration = 2 }
        local activeRoom = nil
        local defaultRoom = nil

        if roomsFolder then
            for i = 1, 5 do
                local gimmick = nil
                for _, room in ipairs(roomsFolder:GetChildren()) do
                    gimmick = room:FindFirstChild("Gimmick" .. i)
                    if gimmick then break end
                end
                
                if gimmick then
                    local p1 = gimmick:FindFirstChild("Plate1")
                    local p2 = gimmick:FindFirstChild("Plate2")
                    local p3 = gimmick:FindFirstChild("Plate3")
                    local p4 = gimmick:FindFirstChild("Plate4")
                    local p5 = gimmick:FindFirstChild("Plate5")
                    if p1 and p2 and p3 and p4 and p5 then
                        local interactPoint = gimmick:FindFirstChild("InteractPoint")
                        local prompt = interactPoint and (interactPoint:FindFirstChildOfClass("ProximityPrompt") or interactPoint:FindFirstChildWhichIsA("ProximityPrompt", true))
                        if prompt and prompt.Enabled then
                            activeRoom = gimmick
                        else
                            defaultRoom = gimmick
                        end
                    end
                end
            end
        end

        -- Fallback default room search
        if activeRoom and not defaultRoom then
            for i = 1, 5 do
                local gimmick = nil
                for _, room in ipairs(roomsFolder:GetChildren()) do
                    gimmick = room:FindFirstChild("Gimmick" .. i)
                    if gimmick then break end
                end
                if gimmick and gimmick ~= activeRoom then
                    local p1 = gimmick:FindFirstChild("Plate1")
                    local p5 = gimmick:FindFirstChild("Plate5")
                    if p1 and p5 then
                        defaultRoom = gimmick
                        break
                    end
                end
            end
        end

        if activeRoom and defaultRoom then
            local targetPositions = {}
            for i = 1, 5 do
                local plate = defaultRoom:FindFirstChild("Plate" .. i)
                targetPositions[i] = plate:GetPivot().Position
            end

            local currentSlots = {}
            for i = 1, 5 do
                local plate = activeRoom:FindFirstChild("Plate" .. i)
                local platePos = plate:GetPivot().Position
                local bestSlot = 1
                local minDist = math.huge
                for k = 1, 5 do
                    local dist = (platePos - targetPositions[k]).Magnitude
                    if dist < minDist then
                        minDist = dist
                        bestSlot = k
                    end
                end
                currentSlots[i] = bestSlot
            end

            local function getPlateAtSlot(k)
                for i = 1, 5 do
                    if currentSlots[i] == k then
                        return i
                    end
                end
                return nil
            end

            local swapEvent = game:GetService("ReplicatedStorage"):WaitForChild("Stage8PlateSwapEvent")
            for k = 1, 5 do
                local plateIndex = getPlateAtSlot(k)
                if plateIndex and plateIndex ~= k then
                    local currentSlotOfPlateK = currentSlots[k]
                    swapEvent:FireServer(plateIndex, k)
                    currentSlots[plateIndex] = currentSlotOfPlateK
                    currentSlots[k] = k
                    task.wait(0.5)
                end
            end
        else
            notify{ Title = "Stage 8", Content = "Could not locate active/default plates room", Duration = 2 }
        end

        -- Step 6: Collect spawned Ofuda
        notify{ Title = "Stage 8", Content = "Waiting for Ofuda to spawn...", Duration = 2 }
        local ofuda = nil
        for i = 1, 30 do
            ofuda = findItem("Ofuda") or findItem("Talisman")
            if ofuda then break end
            task.wait(0.5)
        end

        if ofuda then
            notify{ Title = "Stage 8", Content = "Ofuda spawned! Teleporting to collect...", Duration = 2 }
            pickupItem(ofuda)
        else
            notify{ Title = "Stage 8", Content = "Ofuda not found in workspace", Duration = 2 }
        end

        -- Equip Ofuda
        local ofudaTool = player.Backpack:FindFirstChild("Ofuda") or player.Backpack:FindFirstChild("Talisman")
        if ofudaTool then
            ofudaTool.Parent = character
            task.wait(0.2)
            notify{ Title = "Stage 8 Complete", Content = "Ofuda equipped. Stage 8 complete!", Duration = 3 }
        else
            notify{ Title = "Stage 8 Complete", Content = "Auto-completion finished!", Duration = 3 }
        end
    end
})

---
-- Teleport Options
MainTab:Section({ Title = "Teleport Options" })

-- Teleport to Key
MainTab:Button({
    Title = "Teleport to Key",
    Desc = "Teleports you to the key location",
    Callback = function()
        local key = workspace.Server.SpawnedItems:FindFirstChild("Key")
        
        if key and game.Players.LocalPlayer.Character then
            local rootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                -- Teleport slightly above key to avoid getting stuck and face it
                local keyPosition = key:GetPivot().Position
                rootPart.CFrame = CFrame.new(keyPosition + Vector3.new(0, 3, 0), keyPosition)
                
                notify{
                    Title = "Teleported",
                    Content = "Successfully teleported to key",
                    Duration = 3
                }
            end
        else
            notify{
                Title = "Teleport Failed",
                Content = "Key not found in SpawnedItems",
                Duration = 3
            }
        end
    end
})

-- Teleport to Safe
MainTab:Button({
    Title = "Teleport to Safe",
    Desc = "Teleports you to the safe location",
    Callback = function()
        local safe = nil
        
        -- Search for Safe in all rooms
        for _, room in pairs(workspace.Server.MapGenerated.Rooms:GetChildren()) do
            if room:FindFirstChild("Props") then
                local safeInRoom = room.Props:FindFirstChild("Safe")
                if safeInRoom then
                    safe = safeInRoom
                    break
                end
            end
        end
        
        if safe and game.Players.LocalPlayer.Character then
            local rootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                -- Get safe position
                local safePosition
                
                if typeof(safe.GetPivot) == "function" then
                    safePosition = safe:GetPivot().Position
                else
                    -- Try to find a part to use as reference
                    for _, child in pairs(safe:GetDescendants()) do
                        if child:IsA("BasePart") then
                            safePosition = child.Position
                            break
                        end
                        -- Check Model and find primary part inside
                        if child:IsA("Model") and child.PrimaryPart then
                            safePosition = child.PrimaryPart.Position
                            break
                        end
                    end
                end
                
                if safePosition then
                    -- Teleport in front of safe and face it
                    rootPart.CFrame = CFrame.new(safePosition + Vector3.new(0, 1, 2), safePosition)
                    
                    notify{
                        Title = "Teleported",
                        Content = "Successfully teleported to safe",
                        Duration = 3
                    }
                else
                    notify{
                        Title = "Teleport Failed",
                        Content = "Could not determine safe position reliably",
                        Duration = 3
                    }
                end
            end
        else
            notify{
                Title = "Teleport Failed",
                Content = "Could not find safe in any room",
                Duration = 3
            }
        end
    end
})

-- Teleport to Ofuda Box
MainTab:Button({
    Title = "Teleport to Ofuda Box",
    Desc = "Teleports you to the Ofuda Box location",
    Callback = function()
        local ofudaBox = workspace.Server.SpawnedItems:FindFirstChild("OfudaBox2")
        
        if ofudaBox and game.Players.LocalPlayer.Character then
            local rootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                -- Teleport slightly above ofuda box to avoid getting stuck and face it
                local boxPosition = ofudaBox:GetPivot().Position
                rootPart.CFrame = CFrame.new(boxPosition + Vector3.new(0, 3, 0), boxPosition)
                
                notify{
                    Title = "Teleported",
                    Content = "Successfully teleported to Ofuda Box",
                    Duration = 3
                }
            end
        else
            notify{
                Title = "Teleport Failed",
                Content = "Could not find Ofuda Box",
                Duration = 3
            }
        end
    end
})

notify{
    Title = "Script Loaded",
    Content = "Enjoy!",
    Duration = 5
}

Window:SelectTab(1)
