1--[[ 
  Blox Fruits Menu (Semua Fitur Fix)
  - ESP Buah, Auto TP Buah, Notif Mythical
  - Auto Kill Thunder/Monkey
  - Teleport Island
  - Auto Raid (buy chip, pilih raid, auto kill)
  - Auto Haki/Instinct/V3
  - Semua ON/OFF aktif, update status langsung
  - Dijamin GUI & fitur jalan di executor mobile/PC
]]

-- ========== Helper ==========
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

function safeParent(gui)
    local ok = pcall(function() gui.Parent = player.PlayerGui end)
    if not ok or not gui.Parent then
        gui.Parent = game.CoreGui
    end
end

-- ========== GUI ==========
local scr = Instance.new("ScreenGui")
scr.Name = "BF_MainMenu"
scr.ResetOnSpawn = false
safeParent(scr)

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 340, 0, 420)
frame.Position = UDim2.new(0, 70, 0, 80)
frame.BackgroundColor3 = Color3.fromRGB(35,35,40)
frame.Visible = true
frame.Active = true
frame.Draggable = true
frame.Parent = scr

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,36)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,221,80)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 23
title.Text = "Blox Fruits Auto Menu"
title.TextStrokeTransparency = 0.7

-- ========== Toggle Show/Hide ==========
local toggleBtn = Instance.new("TextButton", scr)
toggleBtn.Size = UDim2.new(0,48,0,48)
toggleBtn.Position = UDim2.new(0, 15, 0, 90)
toggleBtn.BackgroundColor3 = Color3.fromRGB(60,60,90)
toggleBtn.TextColor3 = Color3.new(1,1,0)
toggleBtn.Text = "≡"
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 36
toggleBtn.ZIndex = 10
toggleBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- ========== State ==========
local states = {
    ESP = false,
    TP = false,
    THUNDER = false,
    AUTO_HAKI = false,
    AUTO_RAID = false,
}
local currentRaid = "Flame"
local raids = {"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human: Buddha","Sand","Bird: Phoenix","Dough"}

-- ========== Tombol ==========
local y = 40
function AddButton(name, stateKey, text)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1,-20,0,36)
    btn.Position = UDim2.new(0,10,0,y)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,80)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 19
    btn.Text = text..": OFF"
    btn.MouseButton1Click:Connect(function()
        states[stateKey] = not states[stateKey]
        btn.Text = text..": "..(states[stateKey] and "ON" or "OFF")
    end)
    y = y + 42
    return btn
end

AddButton("ESP", "ESP", "ESP Buah")
AddButton("TP", "TP", "Auto Teleport Buah")
AddButton("THUNDER", "THUNDER", "Auto Kill Thunder")
AddButton("AUTO_HAKI", "AUTO_HAKI", "Auto Haki/Instinct/V3")
AddButton("AUTO_RAID", "AUTO_RAID", "Auto Raid")

-- Raid Dropdown
local raidBtn = Instance.new("TextButton", frame)
raidBtn.Size = UDim2.new(1,-20,0,32)
raidBtn.Position = UDim2.new(0,10,0,y)
raidBtn.BackgroundColor3 = Color3.fromRGB(90,80,120)
raidBtn.TextColor3 = Color3.fromRGB(255,255,255)
raidBtn.Font = Enum.Font.SourceSansBold
raidBtn.TextSize = 16
raidBtn.Text = "Raid: "..currentRaid
raidBtn.MouseButton1Click:Connect(function()
    local idx = table.find(raids, currentRaid) or 1
    idx = idx + 1
    if idx > #raids then idx = 1 end
    currentRaid = raids[idx]
    raidBtn.Text = "Raid: "..currentRaid
end)
y = y + 36

-- Teleport Island Button
local tpIslandBtn = Instance.new("TextButton", frame)
tpIslandBtn.Size = UDim2.new(1,-20,0,36)
tpIslandBtn.Position = UDim2.new(0,10,0,y)
tpIslandBtn.BackgroundColor3 = Color3.fromRGB(110,110,90)
tpIslandBtn.TextColor3 = Color3.fromRGB(255,255,255)
tpIslandBtn.Font = Enum.Font.SourceSansBold
tpIslandBtn.TextSize = 18
tpIslandBtn.Text = "Teleport Island"
y = y + 40

-- ========== Teleport Island GUI ==========
local islands_sea1 = {["Starter Island"]=CFrame.new(1105, 16, 1647),["Jungle"]=CFrame.new(-1599, 36, 153),["Pirate Village"]=CFrame.new(-1120, 4, 3855),["Desert"]=CFrame.new(1095, 17, 4276),["Middle Island"]=CFrame.new(-531, 8, 4172),["Frozen Village"]=CFrame.new(114, 28, -1336),["Marine Fortress"]=CFrame.new(-4508, 20, 4268),["Skylands"]=CFrame.new(-4840, 717, -2622),["Prison"]=CFrame.new(5077, 41, 4745),["Colosseum"]=CFrame.new(-1837, 7, -2740),["Magma Village"]=CFrame.new(-5472, 15, 8513),["Underwater City"]=CFrame.new(3874, 5, -1898),["Fountain City"]=CFrame.new(5288, 44, 4037),["Shank's Room"]=CFrame.new(-1407, 29, -2855)}
local islands_sea2 = {["Kingdom of Rose"]=CFrame.new(1050, 17, 1165),["Green Zone"]=CFrame.new(-3846, 142, 355),["Graveyard"]=CFrame.new(-5413, 8, -1397),["Dark Arena"]=CFrame.new(5856, 5, -1106),["Snow Mountain"]=CFrame.new(1388, 29, -1297),["Hot and Cold"]=CFrame.new(-592, 6, -5077),["Cursed Ship"]=CFrame.new(923, 125, 32885),["Ice Castle"]=CFrame.new(5451, 28, -6536),["Forgotten Island"]=CFrame.new(-3052, 238, -10191),["Usoap's Island"]=CFrame.new(4745, 8, 2844)}
local islands_sea3 = {["Port Town"]=CFrame.new(-288, 44, 5536),["Hydra Island"]=CFrame.new(5228, 604, 345),["Great Tree"]=CFrame.new(2365, 25, -6458),["Floating Turtle"]=CFrame.new(-11099, 331, -8762),["Castle on the Sea"]=CFrame.new(-5500, 314, -2855),["Haunted Castle"]=CFrame.new(-9515, 142, 6062),["Sea of Treats"]=CFrame.new(-1868, 8, -12064),["Cake Land"]=CFrame.new(-2022, 36, -12029),["Tiki Outpost"]=CFrame.new(-16521, 98, -174)}
local allSeas = {["Sea 1"]=islands_sea1,["Sea 2"]=islands_sea2,["Sea 3"]=islands_sea3}
local seaNames = {"Sea 1","Sea 2","Sea 3"}

local tpFrame = Instance.new("Frame", scr)
tpFrame.Size = UDim2.new(0, 240, 0, 142)
tpFrame.Position = UDim2.new(0, 430, 0, 120)
tpFrame.BackgroundColor3 = Color3.fromRGB(60,60,60)
tpFrame.BackgroundTransparency = 0.1
tpFrame.Visible = false
tpFrame.Active = true
tpFrame.Draggable = true

local closeTp = Instance.new("TextButton", tpFrame)
closeTp.Size = UDim2.new(0,28,0,28)
closeTp.Position = UDim2.new(1,-32,0,4)
closeTp.BackgroundColor3 = Color3.fromRGB(120,60,60)
closeTp.Text = "X"
closeTp.Font = Enum.Font.SourceSansBold
closeTp.TextSize = 16

local seaDropdown = Instance.new("TextButton", tpFrame)
seaDropdown.Size = UDim2.new(0, 110, 0, 22)
seaDropdown.Position = UDim2.new(0, 10, 0, 8)
seaDropdown.BackgroundColor3 = Color3.fromRGB(80,80,100)
seaDropdown.TextColor3 = Color3.fromRGB(255,255,255)
seaDropdown.Font = Enum.Font.SourceSans
seaDropdown.TextSize = 15
seaDropdown.Text = "Sea 1"

local islandDropdown = Instance.new("TextButton", tpFrame)
islandDropdown.Size = UDim2.new(0, 180, 0, 22)
islandDropdown.Position = UDim2.new(0, 10, 0, 40)
islandDropdown.BackgroundColor3 = Color3.fromRGB(80,80,100)
islandDropdown.TextColor3 = Color3.fromRGB(255,255,255)
islandDropdown.Font = Enum.Font.SourceSans
islandDropdown.TextSize = 14
islandDropdown.Text = "Starter Island"

local teleportBtn = Instance.new("TextButton", tpFrame)
teleportBtn.Size = UDim2.new(0, 120, 0, 32)
teleportBtn.Position = UDim2.new(0, 60, 0, 90)
teleportBtn.BackgroundColor3 = Color3.fromRGB(60,120,80)
teleportBtn.TextColor3 = Color3.fromRGB(255,255,255)
teleportBtn.Font = Enum.Font.SourceSansBold
teleportBtn.Text = "Teleport"
teleportBtn.TextSize = 17

local currentSea, currentIsland = "Sea 1", "Starter Island"
tpIslandBtn.MouseButton1Click:Connect(function() tpFrame.Visible = not tpFrame.Visible end)
closeTp.MouseButton1Click:Connect(function() tpFrame.Visible = false end)
seaDropdown.MouseButton1Click:Connect(function()
    local new = table.find(seaNames, currentSea) or 1
    new = new + 1; if new > #seaNames then new = 1 end
    currentSea = seaNames[new]
    seaDropdown.Text = currentSea
    local isl = next(allSeas[currentSea])
    currentIsland = isl
    islandDropdown.Text = isl
end)
islandDropdown.MouseButton1Click:Connect(function()
    local islands = allSeas[currentSea]
    local keys, idx = {}, 1
    for k in pairs(islands) do table.insert(keys, k) end
    table.sort(keys)
    for i,v in ipairs(keys) do if v == currentIsland then idx = i break end end
    idx = idx + 1; if idx > #keys then idx = 1 end
    currentIsland = keys[idx]
    islandDropdown.Text = currentIsland
end)
teleportBtn.MouseButton1Click:Connect(function()
    local cframe = allSeas[currentSea][currentIsland]
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if cframe and hrp then hrp.CFrame = cframe + Vector3.new(0,5,0) end
end)
seaDropdown.Text = currentSea islandDropdown.Text = currentIsland

-- ========== FITUR UTAMA ==========
-- ESP & AUTO TP BUAH + NOTIF
local legendaryFruits = {["Dragon Fruit"]=true,["Leopard Fruit"]=true,["Dough Fruit"]=true,["Venom Fruit"]=true,["Shadow Fruit"]=true,["Spirit Fruit"]=true,["Control Fruit"]=true,["Mammoth Fruit"]=true,["T-Rex Fruit"]=true,["Kitsune Fruit"]=true,["Lightning Fruit"]=true,["Gravity Fruit"]=true,["Buddha Fruit"]=true,["Portal Fruit"]=true}

function addESPToFruit(fruit)
    if fruit:FindFirstChild("ESPLabel") then return end
    local bill = Instance.new("BillboardGui", fruit)
    bill.Name = "ESPLabel"
    bill.Size = UDim2.new(0, 150, 0, 40)
    bill.AlwaysOnTop = true
    bill.StudsOffset = Vector3.new(0,2,0)
    bill.Adornee = fruit:FindFirstChild("Handle") or fruit
    local nameLabel = Instance.new("TextLabel", bill)
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255,255,0)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextScaled = true
    nameLabel.Text = fruit.Name
    local distLabel = Instance.new("TextLabel", bill)
    distLabel.Position = UDim2.new(0,0,0.5,0)
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.TextColor3 = Color3.fromRGB(0,255,255)
    distLabel.TextStrokeTransparency = 0
    distLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    distLabel.Font = Enum.Font.SourceSansBold
    distLabel.TextScaled = true
    -- update distance setiap frame
    spawn(function()
        while fruit.Parent and bill.Parent and states.ESP do
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist = (hrp.Position - fruit.Position).Magnitude
                distLabel.Text = string.format("Jarak: %.1f m", dist/2)
            end
            wait(0.2)
        end
        if bill and bill.Parent then bill:Destroy() end
    end)
end

function removeESPFromFruit(fruit)
    local esp = fruit:FindFirstChild("ESPLabel")
    if esp then esp:Destroy() end
end

function updateAllFruitESP()
    for _,v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and string.find(v.Name, "Fruit") then
            if states.ESP then
                addESPToFruit(v)
            else
                removeESPFromFruit(v)
            end
        end
    end
end

function autoTPToNearestFruit()
    if not states.TP then return end
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local fruits = {}
    for _,v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and string.find(v.Name, "Fruit") then
            table.insert(fruits,v)
        end
    end
    if #fruits > 0 then
        table.sort(fruits, function(a,b)
            return (hrp.Position-a.Position).Magnitude < (hrp.Position-b.Position).Magnitude
        end)
        local nearest = fruits[1]
        if nearest then
            hrp.CFrame = nearest.CFrame + Vector3.new(0,3,0)
        end
    end
end

workspace.ChildAdded:Connect(function(child)
    if child:IsA("Tool") and string.find(child.Name, "Fruit") then
        wait(0.1)
        if states.ESP then addESPToFruit(child) end
        if states.TP then autoTPToNearestFruit() end
        if legendaryFruits[child.Name] then pcall(function()
            local notif = Instance.new("ScreenGui") notif.Name = "FruitNotif" safeParent(notif)
            local frame2 = Instance.new("Frame", notif) frame2.Size = UDim2.new(0, 350, 0, 70) frame2.Position = UDim2.new(0.5, -175, 0.13, 0) frame2.BackgroundColor3 = Color3.fromRGB(60,0,0) frame2.BackgroundTransparency = 0.1 frame2.BorderSizePixel = 0
            local label = Instance.new("TextLabel", frame2) label.Size = UDim2.new(1, 0, 1, 0) label.BackgroundTransparency = 1 label.TextColor3 = Color3.fromRGB(255,215,0) label.Font = Enum.Font.SourceSansBold label.TextStrokeTransparency = 0 label.TextSize = 26 label.Text = "‼️ BUAH LANGKA: " .. child.Name .. " ‼️"
            local sound = Instance.new("Sound", frame2) sound.SoundId = "rbxassetid://911882856" sound.Volume = 1 sound:Play()
            game:GetService("Debris"):AddItem(notif, 5)
        end) end
    end
end)

spawn(function()
    while true do
        updateAllFruitESP()
        if states.TP then autoTPToNearestFruit() end
        wait(1)
    end
end)

-- AUTO KILL THUNDER/MONKEY
local targetNPCNames = {["Thunder Stuck"]=true,["Thunderstuck"]=true,["Thunder_Stuck"]=true,["[Electrified] Monkey [Lv. 14]"]=true,["[Snowbandit] Monkey [Lv. 90]"]=true}
function attackTargetNPC()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    for _,npc in pairs(workspace:GetChildren()) do
        if states.THUNDER and targetNPCNames[npc.Name] and npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") then
            local humanoid = npc.Humanoid
            while states.THUNDER and humanoid.Health > 0 and npc.Parent and workspace:FindFirstChild(npc.Name) do
                hrp.CFrame = npc.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                wait(0.14)
            end
        end
    end
end
spawn(function()
    while true do
        if states.THUNDER then attackTargetNPC() end
        wait(0.5)
    end
end)

-- AUTO HAKI/INSTINCT/V3
local busoKey, instinctKey = Enum.KeyCode.J, Enum.KeyCode.K
local v3Keys = {["Human"]=Enum.KeyCode.T,["Mink"]=Enum.KeyCode.T,["Fishman"]=Enum.KeyCode.T,["Skypiea"]=Enum.KeyCode.T,["Ghoul"]=Enum.KeyCode.T,["Cyborg"]=Enum.KeyCode.T}
function pressKey(key)
    local vu = game:GetService("VirtualUser")
    vu:SetKeyDown(key.Name:lower()) wait(0.13)
    vu:SetKeyUp(key.Name:lower())
end
spawn(function()
    while true do
        if states.AUTO_HAKI then
            pressKey(busoKey) wait(0.5)
            pressKey(instinctKey) wait(0.5)
            local char = player.Character or player.CharacterAdded:Wait()
            local race = player.Data and player.Data.Race and player.Data.Race.Value or ""
            local v3Key = v3Keys[race]
            if v3Key then pressKey(v3Key) wait(0.2) end
        end
        wait(4)
    end
end)

-- AUTO RAID (BUY CHIP, PILIH RAID, AUTO KILL)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remotes = ReplicatedStorage:FindFirstChild("Remotes")
local buyChipRemote = remotes and remotes:FindFirstChild("CommF_")
function buyChipAndStartRaid(raidName)
    if buyChipRemote then
        local res1 = buyChipRemote:InvokeServer("RaidsNpc", "Select", raidName)
        wait(0.3)
        local res2 = buyChipRemote:InvokeServer("RaidsNpc", "Buy")
        wait(0.3)
        pcall(function() buyChipRemote:InvokeServer("RaidsNpc", "Start", raidName) end)
    end
end
function autoRaidAttackLoop()
    spawn(function()
        while true do
            if states.AUTO_RAID and workspace:FindFirstChild("Map") then
                for _, mob in pairs(workspace.Map:GetChildren()) do
                    if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                        local char = player.Character or player.CharacterAdded:Wait()
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        hrp.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                        wait(0.09)
                    end
                end
            end
            wait(0.25)
        end
    end)
end
autoRaidAttackLoop()
spawn(function()
    while true do
        if states.AUTO_RAID then
            if workspace:FindFirstChild("RaidEntrance") and (not workspace:FindFirstChild("Map")) then
                buyChipAndStartRaid(currentRaid)
            end
        end
        wait(4)
    end
end)