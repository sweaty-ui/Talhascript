-- Talha • Script ⚙️ (FIXED & FULL AUTOMATIC)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local localPlayer = Players.LocalPlayer
local character, humanoid, rootPart

local function updateCharacterRefs(char)
	character = char
	humanoid = char:WaitForChild("Humanoid")
	rootPart = char:WaitForChild("HumanoidRootPart")
end

if localPlayer.Character then
	updateCharacterRefs(localPlayer.Character)
end
localPlayer.CharacterAdded:Connect(updateCharacterRefs)

-- Durum Değişkenleri
local speedActive, flyActive, espActive, noclipActive, invisibleActive = false, false, false, false, false
local carSpeedActive, carFlyActive, unlockDoorsActive = false, false, false
local watchingPlayer = nil

local NORMAL_SPEED, BOOST_SPEED, FLY_SPEED = 16, 60, 50
local CAR_BOOST_SPEED = 150

-- OTO SCREEN GUI OLUŞTURUCU 📱
local playerGui = localPlayer:WaitForChild("PlayerGui")
local existingGui = playerGui:FindFirstChild("TalhaScriptGui")
if existingGui then existingGui:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TalhaScriptGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Ana Açma/Kapama Butonu 🔘
local toggleMenuBtn = Instance.new("TextButton")
toggleMenuBtn.Name = "ToggleMenuBtn"
toggleMenuBtn.Size = UDim2.new(0, 120, 0, 30)
toggleMenuBtn.Position = UDim2.new(0, 10, 0.1, 0)
toggleMenuBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
toggleMenuBtn.Text = "Talha • Script ⚙️"
toggleMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleMenuBtn.TextSize = 11
toggleMenuBtn.Parent = screenGui

-- Ana Çerçeve 📦
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 110)
mainFrame.Position = UDim2.new(0, 10, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- SEKMELER 🗂️
local function createTabBtn(text, pos)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.25, 0, 0, 20)
	btn.Position = UDim2.new(pos, 0, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 8
	btn.Parent = mainFrame
	return btn
end

local tabGenBtn = createTabBtn("Genel ⚡", 0)
local tabTrollBtn = createTabBtn("Troll 😜", 0.25)
local tabFunBtn = createTabBtn("Eğlence 🎭", 0.5)
local tabBrookBtn = createTabBtn("Brook 🏡", 0.75)

-- İÇERİK KUTULARI 📁
local function createFrame()
	local f = Instance.new("Frame")
	f.Size = UDim2.new(1, 0, 1, -35)
	f.Position = UDim2.new(0, 0, 0, 20)
	f.BackgroundTransparency = 1
	f.Visible = false
	f.Parent = mainFrame
	return f
end

local genFrame = createFrame()
local trollFrame = createFrame()
local funFrame = createFrame()
local brookFrame = createFrame()
genFrame.Visible = true

-- GENEL SEKMESİ ELEMANLARI
local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(0, 80, 0, 26)
speedBtn.Position = UDim2.new(0, 5, 0, 6)
speedBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
speedBtn.Text = "HIZ ⚡"
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.TextSize = 10
speedBtn.Parent = genFrame

local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0, 80, 0, 26)
flyBtn.Position = UDim2.new(0, 93, 0, 6)
flyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
flyBtn.Text = "UÇMA 🕊️"
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.TextSize = 10
flyBtn.Parent = genFrame

local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0, 80, 0, 26)
espBtn.Position = UDim2.new(0, 181, 0, 6)
espBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
espBtn.Text = "ESP 👁️"
espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espBtn.TextSize = 10
espBtn.Parent = genFrame

local watchBox = Instance.new("TextBox")
watchBox.Size = UDim2.new(0, 168, 0, 24)
watchBox.Position = UDim2.new(0, 5, 0, 38)
watchBox.PlaceholderText = "İzlenecek Oyuncu Adı..."
watchBox.Text = ""
watchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
watchBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
watchBox.TextSize = 10
watchBox.Parent = genFrame

local watchBtn = Instance.new("TextButton")
watchBtn.Size = UDim2.new(0, 80, 0, 24)
watchBtn.Position = UDim2.new(0, 181, 0, 38)
watchBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
watchBtn.Text = "İZLE 🎥"
watchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
watchBtn.TextSize = 10
watchBtn.Parent = genFrame

-- TROLL SEKMESİ ELEMANLARI
local trollBox = Instance.new("TextBox")
trollBox.Size = UDim2.new(0, 150, 0, 28)
trollBox.Position = UDim2.new(0, 10, 0, 20)
trollBox.PlaceholderText = "Flinglenecek Oyuncu..."
trollBox.Text = ""
trollBox.TextColor3 = Color3.fromRGB(255, 255, 255)
trollBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
trollBox.TextSize = 10
trollBox.Parent = trollFrame

local flingBtn = Instance.new("TextButton")
flingBtn.Size = UDim2.new(0, 85, 0, 28)
flingBtn.Position = UDim2.new(0, 170, 0, 20)
flingBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 200)
flingBtn.Text = "FLING 💥"
flingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flingBtn.TextSize = 10
flingBtn.Parent = trollFrame

-- EĞLENCE SEKMESİ ELEMANLARI
local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(0, 80, 0, 26)
noclipBtn.Position = UDim2.new(0, 5, 0, 6)
noclipBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
noclipBtn.Text = "NOCLIP 🧱"
noclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipBtn.TextSize = 9
noclipBtn.Parent = funFrame

local invisBtn = Instance.new("TextButton")
invisBtn.Size = UDim2.new(0, 80, 0, 26)
invisBtn.Position = UDim2.new(0, 93, 0, 6)
invisBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
invisBtn.Text = "INVISIBILITY 👻"
invisBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
invisBtn.TextSize = 8
invisBtn.Parent = funFrame

local tpBox = Instance.new("TextBox")
tpBox.Size = UDim2.new(0, 100, 0, 24)
tpBox.Position = UDim2.new(0, 5, 0, 38)
tpBox.PlaceholderText = "Işınlanılacak Ad..."
tpBox.Text = ""
tpBox.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tpBox.TextSize = 9
tpBox.Parent = funFrame

local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0, 70, 0, 24)
tpBtn.Position = UDim2.new(0, 110, 0, 38)
tpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
tpBtn.Text = "TP PLAYER 📍"
tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBtn.TextSize = 8
tpBtn.Parent = funFrame

-- BROOKHAVEN SEKMESİ ELEMANLARI
local carSpeedBtn = Instance.new("TextButton")
carSpeedBtn.Size = UDim2.new(0, 85, 0, 26)
carSpeedBtn.Position = UDim2.new(0, 5, 0, 6)
carSpeedBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
carSpeedBtn.Text = "VEHICLE BOOST 🚀"
carSpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
carSpeedBtn.TextSize = 7
carSpeedBtn.Parent = brookFrame

local carFlyBtn = Instance.new("TextButton")
carFlyBtn.Size = UDim2.new(0, 85, 0, 26)
carFlyBtn.Position = UDim2.new(0, 95, 0, 6)
carFlyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
carFlyBtn.Text = "CAR FLY 🚗"
carFlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
carFlyBtn.TextSize = 8
carFlyBtn.Parent = brookFrame

local unlockDoorsBtn = Instance.new("TextButton")
unlockDoorsBtn.Size = UDim2.new(0, 85, 0, 26)
unlockDoorsBtn.Position = UDim2.new(0, 185, 0, 6)
unlockDoorsBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
unlockDoorsBtn.Text = "UNLOCK DOORS 🔓"
unlockDoorsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
unlockDoorsBtn.TextSize = 7
unlockDoorsBtn.Parent = brookFrame

-- FOOTER YAZISI ✨
local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Size = UDim2.new(1, 0, 0, 15)
welcomeLabel.Position = UDim2.new(0, 0, 1, -15)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.Text = "^ Hoşgeldiniz ^"
welcomeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
welcomeLabel.TextSize = 9
welcomeLabel.Font = Enum.Font.SourceSansItalic
welcomeLabel.Parent = mainFrame

-- SEKME GEÇİŞLERİ 🔄
local function resetTabs()
	genFrame.Visible = false
	trollFrame.Visible = false
	funFrame.Visible = false
	brookFrame.Visible = false
	tabGenBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	tabTrollBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	tabFunBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	tabBrookBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
end

tabGenBtn.MouseButton1Click:Connect(function() resetTabs() genFrame.Visible = true tabGenBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end)
tabTrollBtn.MouseButton1Click:Connect(function() resetTabs() trollFrame.Visible = true tabTrollBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end)
tabFunBtn.MouseButton1Click:Connect(function() resetTabs() funFrame.Visible = true tabFunBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end)
tabBrookBtn.MouseButton1Click:Connect(function() resetTabs() brookFrame.Visible = true tabBrookBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end)

toggleMenuBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- ÖZELLİK MANTIĞI VE FİZİKLER ⚙️
speedBtn.MouseButton1Click:Connect(function()
	speedActive = not speedActive
	if humanoid then humanoid.WalkSpeed = speedActive and BOOST_SPEED or NORMAL_SPEED end
	speedBtn.Text = speedActive and "HIZ: AÇIK ⚡" or "HIZ ⚡"
	speedBtn.BackgroundColor3 = speedActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

local bodyVel, bodyGyro
flyBtn.MouseButton1Click:Connect(function()
	flyActive = not flyActive
	flyBtn.Text = flyActive and "UÇMA: AÇIK 🕊️" or "UÇMA 🕊️"
	flyBtn.BackgroundColor3 = flyActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
	
	if flyActive and rootPart then
		bodyVel = Instance.new("BodyVelocity")
		bodyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		bodyVel.Velocity = Vector3.zero
		bodyVel.Parent = rootPart
		
		bodyGyro = Instance.new("BodyGyro")
		bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
		bodyGyro.CFrame = rootPart.CFrame
		bodyGyro.Parent = rootPart
	else
		if bodyVel then bodyVel:Destroy() end
		if bodyGyro then bodyGyro:Destroy() end
	end
end)

espBtn.MouseButton1Click:Connect(function()
	espActive = not espActive
	espBtn.Text = espActive and "ESP: AÇIK 👁️" or "ESP 👁️"
	espBtn.BackgroundColor3 = espActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
	
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= localPlayer and p.Character then
			local h = p.Character:FindFirstChildOfClass("Highlight")
			if espActive and not h then
				h = Instance.new("Highlight")
				h.FillColor = Color3.fromRGB(255, 0, 0)
				h.Parent = p.Character
			elseif not espActive and h then
				h:Destroy()
			end
		end
	end
end)

watchBtn.MouseButton1Click:Connect(function()
	local cam = Workspace.CurrentCamera
	if watchingPlayer then
		watchingPlayer = nil
		if humanoid then cam.CameraSubject = humanoid end
		watchBtn.Text = "İZLE 🎥"
		watchBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
	else
		local txt = string.lower(watchBox.Text)
		for _, p in pairs(Players:GetPlayers()) do
			if string.find(string.lower(p.Name), txt) or string.find(string.lower(p.DisplayName), txt) then
				if p.Character and p.Character:FindFirstChild("Humanoid") then
					watchingPlayer = p
					cam.CameraSubject = p.Character.Humanoid
					watchBtn.Text = "BIRAK ❌"
					watchBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
					break
				end
			end
		end
	end
end)

flingBtn.MouseButton1Click:Connect(function()
	local txt = string.lower(trollBox.Text)
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= localPlayer and (string.find(string.lower(p.Name), txt) or string.find(string.lower(p.DisplayName), txt)) then
			if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and rootPart then
				local targetRoot = p.Character.HumanoidRootPart
				local bva = Instance.new("BodyAngularVelocity")
				bva.AngularVelocity = Vector3.new(0, 9999, 0)
				bva.MaxTorque = Vector3.new(0, math.huge, 0)
				bva.Parent = rootPart
				
				local st = tick()
				while tick() - st < 1.5 do
					rootPart.CFrame = targetRoot.CFrame
					task.wait()
				end
				bva:Destroy()
				break
			end
		end
	end
end)

noclipBtn.MouseButton1Click:Connect(function()
	noclipActive = not noclipActive
	noclipBtn.Text = noclipActive and "NOCLIP: AÇIK 🧱" or "NOCLIP 🧱"
	noclipBtn.BackgroundColor3 = noclipActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

invisBtn.MouseButton1Click:Connect(function()
	invisibleActive = not invisibleActive
	invisBtn.Text = invisibleActive and "INVIS: AÇIK 👻" or "INVISIBILITY 👻"
	invisBtn.BackgroundColor3 = invisibleActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
	if character then
		for _, v in pairs(character:GetDescendants()) do
			if (v:IsA("BasePart") or v:IsA("Decal")) and v.Name ~= "HumanoidRootPart" then
				v.Transparency = invisibleActive and 1 or 0
			end
		end
	end
end)

tpBtn.MouseButton1Click:Connect(function()
	local txt = string.lower(tpBox.Text)
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= localPlayer and (string.find(string.lower(p.Name), txt) or string.find(string.lower(p.DisplayName), txt)) then
			if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and rootPart then
				rootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
				break
			end
		end
	end
end)

carSpeedBtn.MouseButton1Click:Connect(function()
	carSpeedActive = not carSpeedActive
	carSpeedBtn.Text = carSpeedActive and "BOOST: AÇIK 🚀" or "VEHICLE BOOST 🚀"
	carSpeedBtn.BackgroundColor3 = carSpeedActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

unlockDoorsBtn.MouseButton1Click:Connect(function()
	unlockDoorsActive = not unlockDoorsActive
	unlockDoorsBtn.Text = unlockDoorsActive and "UNLOCK: AÇIK 🔓" or "UNLOCK DOORS 🔓"
	unlockDoorsBtn.BackgroundColor3 = unlockDoorsActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

-- LOOP UPDATES
RunService.Stepped:Connect(function()
	if noclipActive and character then
		for _, v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") then v.CanCollide = false end
		end
	end
	if unlockDoorsActive then
		for _, v in pairs(Workspace:GetDescendants()) do
			if v:IsA("BasePart") and (string.find(string.lower(v.Name), "door") or string.find(string.lower(v.Name), "gate")) then
				v.CanCollide = false
			end
		end
	end
end)

RunService.RenderStepped:Connect(function()
	if flyActive and rootPart and bodyVel and bodyGyro then
		local cam = Workspace.CurrentCamera
		if humanoid and humanoid.MoveDirection.Magnitude > 0 then
			bodyVel.Velocity = cam.CFrame.LookVector * FLY_SPEED
		else
			bodyVel.Velocity = Vector3.zero
		end
		bodyGyro.CFrame = cam.CFrame
	end
	
	if humanoid and humanoid.SeatPart and humanoid.SeatPart:IsA("VehicleSeat") then
		local seat = humanoid.SeatPart
		if carSpeedActive then
			seat.MaxSpeed = CAR_BOOST_SPEED
			seat.Torque = 100
		end
	end
end)
