-- Talha • Script (Yatay Dikdörtgen Mobil GUI - Brookhaven Özel)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Durum Değişkenleri ⚙️
local speedActive, flyActive, espActive, noclipActive, invisibleActive = false, false, false, false, false
local carSpeedActive, carFlyActive, unlockDoorsActive = false, false, false
local watchingPlayer = nil

local NORMAL_SPEED, BOOST_SPEED, FLY_SPEED = 16, 60, 50
local CAR_BOOST_SPEED = 150

-- Character Değiştiğinde Referansları Güncelle
localPlayer.CharacterAdded:Connect(function(newChar)
	character = newChar
	humanoid = newChar:WaitForChild("Humanoid")
	rootPart = newChar:WaitForChild("HumanoidRootPart")
end)

-- UI OLUŞTURMA 🖼️
local screenGui = script.Parent

-- İsme Özel Ana Açma/Kapama Butonu 🔘
local toggleMenuBtn = Instance.new("TextButton")
toggleMenuBtn.Name = "ToggleMenuBtn"
toggleMenuBtn.Size = UDim2.new(0, 110, 0, 26)
toggleMenuBtn.Position = UDim2.new(0, 10, 0.1, 0)
toggleMenuBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleMenuBtn.Text = "Talha • Script ⚙️"
toggleMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleMenuBtn.TextSize = 10
toggleMenuBtn.Parent = screenGui

-- Yatay Ana Çerçeve (Kompakt Dikdörtgen) 📦
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 105)
mainFrame.Position = UDim2.new(0, 10, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BackgroundTransparency = 0.15
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- SEKMELER 🗂️
local tabGeneralBtn = Instance.new("TextButton")
tabGeneralBtn.Size = UDim2.new(0.25, 0, 0, 20)
tabGeneralBtn.Position = UDim2.new(0, 0, 0, 0)
tabGeneralBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tabGeneralBtn.Text = "Genel ⚡"
tabGeneralBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tabGeneralBtn.TextSize = 8
tabGeneralBtn.Parent = mainFrame

local tabTrollBtn = Instance.new("TextButton")
tabTrollBtn.Size = UDim2.new(0.25, 0, 0, 20)
tabTrollBtn.Position = UDim2.new(0.25, 0, 0, 0)
tabTrollBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
tabTrollBtn.Text = "Troll 😜"
tabTrollBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tabTrollBtn.TextSize = 8
tabTrollBtn.Parent = mainFrame

local tabFunBtn = Instance.new("TextButton")
tabFunBtn.Size = UDim2.new(0.25, 0, 0, 20)
tabFunBtn.Position = UDim2.new(0.5, 0, 0, 0)
tabFunBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
tabFunBtn.Text = "Eğlence 🎭"
tabFunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tabFunBtn.TextSize = 8
tabFunBtn.Parent = mainFrame

local tabBrookBtn = Instance.new("TextButton")
tabBrookBtn.Size = UDim2.new(0.25, 0, 0, 20)
tabBrookBtn.Position = UDim2.new(0.75, 0, 0, 0)
tabBrookBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
tabBrookBtn.Text = "Brookhaven 🏡"
tabBrookBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tabBrookBtn.TextSize = 8
tabBrookBtn.Parent = mainFrame

-- SEKME İÇERİKLERİ 📁
local generalFrame = Instance.new("Frame")
generalFrame.Size = UDim2.new(1, 0, 1, -35)
generalFrame.Position = UDim2.new(0, 0, 0, 20)
generalFrame.BackgroundTransparency = 1
generalFrame.Parent = mainFrame

local trollFrame = Instance.new("Frame")
trollFrame.Size = UDim2.new(1, 0, 1, -35)
trollFrame.Position = UDim2.new(0, 0, 0, 20)
trollFrame.BackgroundTransparency = 1
trollFrame.Visible = false
trollFrame.Parent = mainFrame

local funFrame = Instance.new("Frame")
funFrame.Size = UDim2.new(1, 0, 1, -35)
funFrame.Position = UDim2.new(0, 0, 0, 20)
funFrame.BackgroundTransparency = 1
funFrame.Visible = false
funFrame.Parent = mainFrame

local brookFrame = Instance.new("Frame")
brookFrame.Size = UDim2.new(1, 0, 1, -35)
brookFrame.Position = UDim2.new(0, 0, 0, 20)
brookFrame.BackgroundTransparency = 1
brookFrame.Visible = false
brookFrame.Parent = mainFrame

-- GENEL ELEMANLARI ⚡
local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(0, 80, 0, 26)
speedBtn.Position = UDim2.new(0, 5, 0, 6)
speedBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
speedBtn.Text = "HIZ ⚡"
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.TextSize = 10
speedBtn.Parent = generalFrame

local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0, 80, 0, 26)
flyBtn.Position = UDim2.new(0, 93, 0, 6)
flyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
flyBtn.Text = "UÇMA 🕊️"
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.TextSize = 10
flyBtn.Parent = generalFrame

local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0, 80, 0, 26)
espBtn.Position = UDim2.new(0, 181, 0, 6)
espBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
espBtn.Text = "ESP 👁️"
espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espBtn.TextSize = 10
espBtn.Parent = generalFrame

local watchBox = Instance.new("TextBox")
watchBox.Size = UDim2.new(0, 168, 0, 24)
watchBox.Position = UDim2.new(0, 5, 0, 38)
watchBox.PlaceholderText = "İzlenecek Oyuncu Adı..."
watchBox.Text = ""
watchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
watchBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
watchBox.TextSize = 10
watchBox.Parent = generalFrame

local watchBtn = Instance.new("TextButton")
watchBtn.Size = UDim2.new(0, 80, 0, 24)
watchBtn.Position = UDim2.new(0, 181, 0, 38)
watchBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
watchBtn.Text = "İZLE 🎥"
watchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
watchBtn.TextSize = 10
watchBtn.Parent = generalFrame

-- TROLL ELEMANLARI 💥
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

-- EĞLENCE ELEMANLARI 🎭
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

-- BROOKHAVEN ELEMANLARI 🏡
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

-- EN ALT HOŞGELDİNİZ YAZISI ✨
local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Name = "WelcomeLabel"
welcomeLabel.Size = UDim2.new(1, 0, 0, 15)
welcomeLabel.Position = UDim2.new(0, 0, 1, -15)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.Text = "^ Hoşgeldiniz ^"
welcomeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
welcomeLabel.TextSize = 9
welcomeLabel.Font = Enum.Font.SourceSansItalic
welcomeLabel.Parent = mainFrame

----------------------------------------------------
-- SEKME DEĞİŞTİRME İŞLEVLERİ
----------------------------------------------------
local function resetTabs()
	generalFrame.Visible = false
	trollFrame.Visible = false
	funFrame.Visible = false
	brookFrame.Visible = false
	tabGeneralBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	tabTrollBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	tabFunBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	tabBrookBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
end

tabGeneralBtn.MouseButton1Click:Connect(function()
	resetTabs()
	generalFrame.Visible = true
	tabGeneralBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

tabTrollBtn.MouseButton1Click:Connect(function()
	resetTabs()
	trollFrame.Visible = true
	tabTrollBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

tabFunBtn.MouseButton1Click:Connect(function()
	resetTabs()
	funFrame.Visible = true
	tabFunBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

tabBrookBtn.MouseButton1Click:Connect(function()
	resetTabs()
	brookFrame.Visible = true
	tabBrookBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

toggleMenuBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

----------------------------------------------------
-- GENEL İŞLEVLER
----------------------------------------------------
speedBtn.MouseButton1Click:Connect(function()
	speedActive = not speedActive
	humanoid.WalkSpeed = speedActive and BOOST_SPEED or NORMAL_SPEED
	speedBtn.Text = speedActive and "HIZ: AÇIK ⚡" or "HIZ ⚡"
	speedBtn.BackgroundColor3 = speedActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

local bodyVelocity, bodyGyro
flyBtn.MouseButton1Click:Connect(function()
	flyActive = not flyActive
	if flyActive then
		flyBtn.Text = "UÇMA: AÇIK 🕊️"
		flyBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
		bodyVelocity = Instance.new("BodyVelocity", rootPart)
		bodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
		bodyVelocity.Velocity = Vector3.zero
		bodyGyro = Instance.new("BodyGyro", rootPart)
		bodyGyro.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
		bodyGyro.CFrame = rootPart.CFrame
	else
		flyBtn.Text = "UÇMA 🕊️"
		flyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
		if bodyVelocity then bodyVelocity:Destroy() end
		if bodyGyro then bodyGyro:Destroy() end
	end
end)

local function updateESP()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= localPlayer and p.Character then
			local highlight = p.Character:FindFirstChild("ESPHighlight")
			if espActive and not highlight then
				highlight = Instance.new("Highlight")
				highlight.Name = "ESPHighlight"
				highlight.FillColor = Color3.fromRGB(255, 0, 0)
				highlight.Parent = p.Character
			elseif not espActive and highlight then
				highlight:Destroy()
			end
		end
	end
end

espBtn.MouseButton1Click:Connect(function()
	espActive = not espActive
	espBtn.Text = espActive and "ESP: AÇIK 👁️" or "ESP 👁️"
	espBtn.BackgroundColor3 = espActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
	updateESP()
end)

watchBtn.MouseButton1Click:Connect(function()
	local camera = workspace.CurrentCamera
	if watchingPlayer then
		watchingPlayer = nil
		camera.CameraSubject = humanoid
		watchBtn.Text = "İZLE 🎥"
		watchBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
	else
		local searchText = string.lower(watchBox.Text)
		for _, p in pairs(Players:GetPlayers()) do
			if string.find(string.lower(p.Name), searchText) or string.find(string.lower(p.DisplayName), searchText) then
				watchingPlayer = p
				camera.CameraSubject = p.Character.Humanoid
				watchBtn.Text = "BIRAK ❌"
				watchBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
				break
			end
		end
	end
end)

----------------------------------------------------
-- TROLL İŞLEVLERİ
----------------------------------------------------
local isFlinging = false
flingBtn.MouseButton1Click:Connect(function()
	if isFlinging then return end
	local searchText = string.lower(trollBox.Text)
	local targetPlayer = nil
	
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= localPlayer and (string.find(string.lower(p.Name), searchText) or string.find(string.lower(p.DisplayName), searchText)) then
			targetPlayer = p
			break
		end
	end
	
	if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		isFlinging = true
		flingBtn.Text = "FLING... 💥"
		local targetRoot = targetPlayer.Character.HumanoidRootPart
		
		local bva = Instance.new("BodyAngularVelocity")
		bva.Name = "FlingVelocity"
		bva.AngularVelocity = Vector3.new(0, 99999, 0)
		bva.MaxTorque = Vector3.new(0, math.huge, 0)
		bva.P = math.huge
		bva.Parent = rootPart
		
		local startTime = tick()
		while tick() - startTime < 2 and targetRoot and character and rootPart do
			rootPart.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 0)
			rootPart.Velocity = Vector3.new(9999, 9999, 9999)
			task.wait()
		end
		
		bva:Destroy()
		isFlinging = false
		flingBtn.Text = "FLING 💥"
	else
		trollBox.Text = "Yok!"
		task.wait(1)
		trollBox.Text = ""
	end
end)

----------------------------------------------------
-- EĞLENCE İŞLEVLERİ
----------------------------------------------------
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
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") or part:IsA("Decal") then
				if part.Name ~= "HumanoidRootPart" then
					part.Transparency = invisibleActive and 1 or 0
				end
			end
		end
	end
end)

tpBtn.MouseButton1Click:Connect(function()
	local searchText = string.lower(tpBox.Text)
	if searchText == "" then return end
	
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= localPlayer and (string.find(string.lower(p.Name), searchText) or string.find(string.lower(p.DisplayName), searchText)) then
			if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and rootPart then
				rootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
				tpBox.Text = "Işınlandı!"
				task.wait(1)
				tpBox.Text = ""
				break
			end
		end
	end
end)

----------------------------------------------------
-- BROOKHAVEN İŞLEVLERİ (Vehicle Boost, Car Fly, Unlock Doors)
----------------------------------------------------
carSpeedBtn.MouseButton1Click:Connect(function()
	carSpeedActive = not carSpeedActive
	carSpeedBtn.Text = carSpeedActive and "BOOST: AÇIK 🚀" or "VEHICLE BOOST 🚀"
	carSpeedBtn.BackgroundColor3 = carSpeedActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

local carBodyVel, carBodyGyro
carFlyBtn.MouseButton1Click:Connect(function()
	carFlyActive = not carFlyActive
	carFlyBtn.Text = carFlyActive and "CAR FLY: AÇIK 🚗" or "CAR FLY 🚗"
	carFlyBtn.BackgroundColor3 = carFlyActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
	
	local seat = humanoid.SeatPart
	if carFlyActive and seat and seat:IsA("VehicleSeat") then
		local vehicle = seat.Parent
		local primaryPart = vehicle.PrimaryPart or seat
		
		carBodyVel = Instance.new("BodyVelocity", primaryPart)
		carBodyVel.MaxForce = Vector3.new(1e6, 1e6, 1e6)
		carBodyVel.Velocity = Vector3.zero
		
		carBodyGyro = Instance.new("BodyGyro", primaryPart)
		carBodyGyro.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
		carBodyGyro.CFrame = primaryPart.CFrame
	else
		if carBodyVel then carBodyVel:Destroy() end
		if carBodyGyro then carBodyGyro:Destroy() end
	end
end)

unlockDoorsBtn.MouseButton1Click:Connect(function()
	unlockDoorsActive = not unlockDoorsActive
	unlockDoorsBtn.Text = unlockDoorsActive and "UNLOCK: AÇIK 🔓" or "UNLOCK DOORS 🔓"
	unlockDoorsBtn.BackgroundColor3 = unlockDoorsActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

----------------------------------------------------
-- DÖNGÜSEL GÜNCELLEMELER (RunService) 📲
----------------------------------------------------
RunService.Stepped:Connect(function()
	-- Noclip
	if noclipActive and character then
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
	
	-- Unlock Doors (Yakındaki kapıların kilitlerini/engellerini açar)
	if unlockDoorsActive then
		for _, obj in pairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") and (string.find(string.lower(obj.Name), "door") or string.find(string.lower(obj.Name), "gate")) then
				obj.CanCollide = false
			end
		end
	end
end)

RunService.RenderStepped:Connect(function()
	-- Uçma
	if flyActive and rootPart and bodyVelocity and bodyGyro then
		local camera = workspace.CurrentCamera
		if humanoid.MoveDirection.Magnitude > 0 then
			bodyVelocity.Velocity = camera.CFrame.LookVector * FLY_SPEED
		else
			bodyVelocity.Velocity = Vector3.zero
		end
		bodyGyro.CFrame = camera.CFrame
	end
	
	-- Vehicle Speed Booster & Car Fly
	local seat = humanoid.SeatPart
	if seat and seat:IsA("VehicleSeat") then
		if carSpeedActive then
			seat.MaxSpeed = CAR_BOOST_SPEED
			seat.Torque = 100
		end
		
		if carFlyActive and carBodyVel and carBodyGyro then
			local camera = workspace.CurrentCamera
			if seat.Throttle ~= 0 or seat.Steer ~= 0 then
				carBodyVel.Velocity = camera.CFrame.LookVector * 80
			else
				carBodyVel.Velocity = Vector3.zero
			end
			carBodyGyro.CFrame = camera.CFrame
		end
	end
end)
