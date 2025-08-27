-- 🌟 GUI Toggle Masterpack by Copilot & DASH
-- ⚠️ Untuk edukasi & eksperimen di private server

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- 🔘 Toggle Status
local toggle = {
    autoFarm = false,
    autoAimPvP = false,
    autoGrabFruit = false,
    espFruit = false,
    thunderstruck = false
}

-- 🖼️ GUI Setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "DASH_ToggleGUI"

local function createButton(name, posY, callback)
    local button = Instance.new("TextButton", screenGui)
    button.Size = UDim2.new(0, 200, 0, 40)
    button.Position = UDim2.new(0, 10, 0, posY)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.Text = "🔘 " .. name .. ": OFF"

    button.MouseButton1Click:Connect(function()
        toggle[name] = not toggle[name]
        button.Text = (toggle[name] and "✅ " or "🔘 ") .. name .. ": " .. (toggle[name] and "ON" or "OFF")
        callback(toggle[name])
    end)
end

-- 🧠 Fitur Callback
createButton("autoFarm", 10, function(state) print("Auto Farm: " .. tostring(state)) end)
createButton("autoAimPvP", 60, function(state) print("Auto Aim PvP: " .. tostring(state)) end)
createButton("autoGrabFruit", 110, function(state) print("Auto Grab Fruit: " .. tostring(state)) end)
createButton("espFruit", 160, function(state) print("ESP Buah: " .. tostring(state)) end)
createButton("thunderstruck", 210, function(state) print("Thunderstruck NPC: " .. tostring(state)) end)

-- 📌 NPC List (disingkat)
local npcTargets = {
    {name = "Bandit", minLevel = 0},
    {name = "Cake Pirate", minLevel = 2400},
    {name = "Thunderstruck", minLevel = 0}
}

function getTargetNPC()
    local level = player.Data.Level.Value
    local selected = nil
    for _, npc in ipairs(npcTargets) do
        if level >= npc.minLevel then
            selected = npc.name
        end
    end
    return selected
end

function findNPCByName(npcName)
    for _, obj in pairs(game.Workspace:GetChildren()) do
        if obj.Name == npcName and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
            return obj
        end
    end
    return nil
end

function autoFarmDynamic()
    local targetName = getTargetNPC()
    local npc = findNPCByName(targetName)
    if npc then
        character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
    end
end

function autoKillThunderstruck()
    for _, obj in pairs(game.Workspace:GetChildren()) do
        if obj.Name == "Thunderstruck" and obj:FindFirstChild("Humanoid") then
            character.HumanoidRootPart.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "X", false, game)
        end
    end
end

function autoAimPvP()
    local closest = nil
    local shortestDistance = math.huge
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (v.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closest = v
            end
        end
    end
    if closest then
        character.HumanoidRootPart.CFrame = closest.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "C", false, game)
    end
end

function scanAllFruits()
    local fruits = {}
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("Tool") and string.find(obj.Name, "Fruit") and obj:FindFirstChild("Handle") then
            table.insert(fruits, obj)
        end
    end
    return fruits
end

function autoGrabAllFruits()
    local fruits = scanAllFruits()
    for _, fruit in pairs(fruits) do
        character.HumanoidRootPart.CFrame = fruit.Handle.CFrame + Vector3.new(0, 2, 0)
        wait(0.5)
        firetouchinterest(character.HumanoidRootPart, fruit.Handle, 0)
        firetouchinterest(character.HumanoidRootPart, fruit.Handle, 1)
    end
end

function createESP(obj)
    if obj:FindFirstChild("Handle") then
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 100, 0, 40)
        billboard.Adornee = obj.Handle
        billboard.AlwaysOnTop = true
        billboard.Name = "FruitESP"

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = "🍍 " .. obj.Name
        label.TextColor3 = Color3.fromRGB(255, 255, 0)
        label.TextStrokeTransparency = 0.5
        label.Font = Enum.Font.GothamBold
        label.TextScaled = true
        label.Parent = billboard

        billboard.Parent = obj
    end
end

function scanAndMarkFruits()
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("Tool") and string.find(obj.Name, "Fruit") and not obj:FindFirstChild("FruitESP") then
            createESP(obj)
        end
    end
end

-- 🔁 LOOP -- 🌟 GUI Toggle Masterpack by Copilot & DASH
-- ⚠️ Untuk edukasi & eksperimen di private server

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- 🔘 Toggle Status
local toggle = {
    autoFarm = false,
    autoAimPvP = false,
    autoGrabFruit = false,
    espFruit = false,
    thunderstruck = false
}

-- 🖼️ GUI Setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "DASH_ToggleGUI"

local function createButton(name, posY, callback)
    local button = Instance.new("TextButton", screenGui)
    button.Size = UDim2.new(0, 200, 0, 40)
    button.Position = UDim2.new(0, 10, 0, posY)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.Text = "🔘 " .. name .. ": OFF"

    button.MouseButton1Click:Connect(function()
        toggle[name] = not toggle[name]
        button.Text = (toggle[name] and "✅ " or "🔘 ") .. name .. ": " .. (toggle[name] and "ON" or "OFF")
        callback(toggle[name])
    end)
end

-- 🧠 Fitur Callback
createButton("autoFarm", 10, function(state) print("Auto Farm: " .. tostring(state)) end)
createButton("autoAimPvP", 60, function(state) print("Auto Aim PvP: " .. tostring(state)) end)
createButton("autoGrabFruit", 110, function(state) print("Auto Grab Fruit: " .. tostring(state)) end)
createButton("espFruit", 160, function(state) print("ESP Buah: " .. tostring(state)) end)
createButton("thunderstruck", 210, function(state) print("Thunderstruck NPC: " .. tostring(state)) end)

-- 📌 NPC List (disingkat)
local npcTargets = {
    {name = "Bandit", minLevel = 0},
    {name = "Cake Pirate", minLevel = 2400},
    {name = "Thunderstruck", minLevel = 0}
}

function getTargetNPC()
    local level = player.Data.Level.Value
    local selected = nil
    for _, npc in ipairs(npcTargets) do
        if level >= npc.minLevel then
            selected = npc.name
        end
    end
    return selected
end

function findNPCByName(npcName)
    for _, obj in pairs(game.Workspace:GetChildren()) do
        if obj.Name == npcName and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
            return obj
        end
    end
    return nil
end

function autoFarmDynamic()
    local targetName = getTargetNPC()
    local npc = findNPCByName(targetName)
    if npc then
        character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
    end
end

function autoKillThunderstruck()
    for _, obj in pairs(game.Workspace:GetChildren()) do
        if obj.Name == "Thunderstruck" and obj:FindFirstChild("Humanoid") then
            character.HumanoidRootPart.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "X", false, game)
        end
    end
end

function autoAimPvP()
    local closest = nil
    local shortestDistance = math.huge
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (v.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closest = v
            end
        end
    end
    if closest then
        character.HumanoidRootPart.CFrame = closest.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "C", false, game)
    end
end

function scanAllFruits()
    local fruits = {}
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("Tool") and string.find(obj.Name, "Fruit") and obj:FindFirstChild("Handle") then
            table.insert(fruits, obj)
        end
    end
    return fruits
end

function autoGrabAllFruits()
    local fruits = scanAllFruits()
    for _, fruit in pairs(fruits) do
        character.HumanoidRootPart.CFrame = fruit.Handle.CFrame + Vector3.new(0, 2, 0)
        wait(0.5)
        firetouchinterest(character.HumanoidRootPart, fruit.Handle, 0)
        firetouchinterest(character.HumanoidRootPart, fruit.Handle, 1)
    end
end

function createESP(obj)
    if obj:FindFirstChild("Handle") then
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 100, 0, 40)
        billboard.Adornee = obj.Handle
        billboard.AlwaysOnTop = true
        billboard.Name = "FruitESP"

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = "🍍 " .. obj.Name
        label.TextColor3 = Color3.fromRGB(255, 255, 0)
        label.TextStrokeTransparency = 0.5
        label.Font = Enum.Font.GothamBold
        label.TextScaled = true
        label.Parent = billboard

        billboard.Parent = obj
    end
end

function scanAndMarkFruits()
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("Tool") and string.find(obj.Name, "Fruit") and not obj:FindFirstChild("FruitESP") then
            createESP(obj)
        end
    end
end

-- 🔁 LOOP UTAMA
while true do
    if toggle.autoFarm then autoFarmDynamic() end
    if toggle.thunderstruck then autoKillThunderstruck() end
    if toggle.autoAimPvP then autoAimPvP() end
    if toggle.autoGrabFruit then autoGrabAllFruits() end
    if toggle.espFruit then scanAndMarkFruits() end
    wait(5)
end
while true do
    if toggle.autoFarm then autoFarmDynamic() end
    if toggle.thunderstruck then autoKillThunderstruck() end
    if toggle.autoAimPvP then autoAimPvP() end
    if toggle.autoGrabFruit then autoGrabAllFruits() end
    if toggle.espFruit then scanAndMarkFruits() end
    wait(5)
end