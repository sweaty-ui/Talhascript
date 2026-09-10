--// 🇹🇷 TALHA • HUB
--// Mobile Friendly Hub
--// Kurucular: Talha

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

--==================================================
-- GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TalhaHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

--==================================================
-- ANA FRAME
--==================================================

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12,14,19)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5,-300,0.5,-190)
MainFrame.Size = UDim2.new(0,600,0,380)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,14)
MainCorner.Parent = MainFrame

--==================================================
-- ÜST BAR
--==================================================

local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(18,20,27)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1,0,0,65)

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0,14)
TopCorner.Parent = TopBar

local Logo = Instance.new("TextLabel")
Logo.Parent = TopBar
Logo.BackgroundColor3 = Color3.fromRGB(210,25,35)
Logo.Position = UDim2.new(0,12,0,10)
Logo.Size = UDim2.new(0,45,0,45)
Logo.Font = Enum.Font.GothamBlack
Logo.Text = "🇹🇷"
Logo.TextSize = 22
Logo.TextColor3 = Color3.fromRGB(255,255,255)

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0,10)
LogoCorner.Parent = Logo

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,68,0,7)
Title.Size = UDim2.new(0,270,0,32)
Title.Font = Enum.Font.GothamBold
Title.Text = "🇹🇷 Talha • Hub"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Left

local Subtitle = Instance.new("TextLabel")
Subtitle.Parent = TopBar
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0,68,0,36)
Subtitle.Size = UDim2.new(0,270,0,20)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "Kurucular: Talha"
Subtitle.TextColor3 = Color3.fromRGB(235,55,65)
Subtitle.TextSize = 13
Subtitle.TextXAlignment = Enum.TextXAlignment.Left

local MobileStatus = Instance.new("TextLabel")
MobileStatus.Parent = TopBar
MobileStatus.BackgroundColor3 = Color3.fromRGB(25,30,35)
MobileStatus.Position = UDim2.new(1,-175,0,14)
MobileStatus.Size = UDim2.new(0,125,0,37)
MobileStatus.Font = Enum.Font.GothamBold
MobileStatus.Text = "📱 Mobil Uyumlu"
MobileStatus.TextColor3 = Color3.fromRGB(220,220,225)
MobileStatus.TextSize = 11

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0,10)
StatusCorner.Parent = MobileStatus

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TopBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1,-48,0,8)
CloseButton.Size = UDim2.new(0,45,0,45)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255,70,80)
CloseButton.TextSize = 30

--==================================================
-- SOL MENÜ
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(16,18,24)
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0,0,0,65)
Sidebar.Size = UDim2.new(0,155,1,-65)

--==================================================
-- İÇERİK
--==================================================

local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(11,13,18)
ContentFrame.BorderSizePixel = 0
ContentFrame.Position = UDim2.new(0,155,0,65)
ContentFrame.Size = UDim2.new(1,-155,1,-65)
ContentFrame.CanvasSize = UDim2.new(0,0,0,0)
ContentFrame.ScrollBarThickness = 4

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Parent = ContentFrame
ContentLayout.Padding = UDim.new(0,10)

local ContentPadding = Instance.new("UIPadding")
ContentPadding.Parent = ContentFrame
ContentPadding.PaddingTop = UDim.new(0,15)
ContentPadding.PaddingLeft = UDim.new(0,15)
ContentPadding.PaddingRight = UDim.new(0,15)
ContentPadding.PaddingBottom = UDim.new(0,15)

ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	ContentFrame.CanvasSize = UDim2.new(
		0,
		0,
		0,
		ContentLayout.AbsoluteContentSize.Y + 30
	)
end)

--==================================================
-- DEĞİŞKENLER
--==================================================

local FlyEnabled = false
local FlyConnection = nil
local FlyVelocity = nil

local Protection = {
	AntiFling = false,
	AntiSit = false,
	AntiBug = false,
	AntiScript = false
}

local ProtectionConnection = nil

--==================================================
-- YARDIMCI FONKSİYONLAR
--==================================================

local function ClearContent()
	for _, object in ipairs(ContentFrame:GetChildren()) do
		if object:IsA("GuiObject")
			and object ~= ContentLayout
			and object ~= ContentPadding then
			object:Destroy()
		end
	end
end

local function GetCharacter()
	return Player.Character or Player.CharacterAdded:Wait()
end

local function GetHumanoid()
	local Character = GetCharacter()
	return Character:FindFirstChildOfClass("Humanoid")
end

local function AddTitle(text, emoji)

	local Label = Instance.new("TextLabel")
	Label.Parent = ContentFrame
	Label.BackgroundTransparency = 1
	Label.Size = UDim2.new(1,0,0,35)
	Label.Font = Enum.Font.GothamBold
	Label.Text = emoji .. "  " .. text
	Label.TextColor3 = Color3.fromRGB(255,255,255)
	Label.TextSize = 20
	Label.TextXAlignment = Enum.TextXAlignment.Left
	return Label
end

local function AddInfo(text)

	local Label = Instance.new("TextLabel")
	Label.Parent = ContentFrame
	Label.BackgroundTransparency = 1
	Label.Size = UDim2.new(1,0,0,45)
	Label.Font = Enum.Font.Gotham
	Label.Text = text
	Label.TextColor3 = Color3.fromRGB(170,175,185)
	Label.TextSize = 13
	Label.TextWrapped = true
	Label.TextXAlignment = Enum.TextXAlignment.Left
	return Label
end

local function AddFeature(text, description, callback)

	local Button = Instance.new("TextButton")
	Button.Parent = ContentFrame
	Button.BackgroundColor3 = Color3.fromRGB(23,26,34)
	Button.BorderSizePixel = 0
	Button.Size = UDim2.new(1,0,0,65)
	Button.Text = ""
	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,10)
	Corner.Parent = Button
	local Name = Instance.new("TextLabel")
	Name.Parent = Button
	Name.BackgroundTransparency = 1
	Name.Position = UDim2.new(0,15,0,8)
	Name.Size = UDim2.new(1,-30,0,23)
	Name.Font = Enum.Font.GothamBold
	Name.Text = text
	Name.TextColor3 = Color3.fromRGB(245,245,250)
	Name.TextSize = 14
	Name.TextXAlignment = Enum.TextXAlignment.Left
	local Desc = Instance.new("TextLabel")
	Desc.Parent = Button
	Desc.BackgroundTransparency = 1
	Desc.Position = UDim2.new(0,15,0,33)
	Desc.Size = UDim2.new(1,-30,0,22)
	Desc.Font = Enum.Font.Gotham
	Desc.Text = description
	Desc.TextColor3 = Color3.fromRGB(150,155,165)
	Desc.TextSize = 11
	Desc.TextXAlignment = Enum.TextXAlignment.Left
	Button.MouseButton1Click:Connect(callback)
	return Button
end

local function AddToggle(text, description, default, callback)

	local Holder = Instance.new("Frame")
	Holder.Parent = ContentFrame
	Holder.BackgroundColor3 = Color3.fromRGB(23,26,34)
	Holder.BorderSizePixel = 0
	Holder.Size = UDim2.new(1,0,0,65)
	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,10)
	Corner.Parent = Holder
	local Name = Instance.new("TextLabel")
	Name.Parent = Holder
	Name.BackgroundTransparency = 1
	Name.Position = UDim2.new(0,15,0,7)
	Name.Size = UDim2.new(1,-90,0,23)
	Name.Font = Enum.Font.GothamBold
	Name.Text = text
	Name.TextColor3 = Color3.fromRGB(245,245,250)
	Name.TextSize = 14
	Name.TextXAlignment = Enum.TextXAlignment.Left
	local Desc = Instance.new("TextLabel")
	Desc.Parent = Holder
	Desc.BackgroundTransparency = 1
	Desc.Position = UDim2.new(0,15,0,32)
	Desc.Size = UDim2.new(1,-90,0,20)
	Desc.Font = Enum.Font.Gotham
	Desc.Text = description
	Desc.TextColor3 = Color3.fromRGB(145,150,160)
	Desc.TextSize = 10
	Desc.TextXAlignment = Enum.TextXAlignment.Left
	local Toggle = Instance.new("TextButton")
	Toggle.Parent = Holder
	Toggle.Position = UDim2.new(1,-65,0.5,-14)
	Toggle.Size = UDim2.new(0,50,0,28)
	Toggle.Font = Enum.Font.GothamBold
	Toggle.TextSize = 10
	Toggle.BorderSizePixel = 0
	local ToggleCorner = Instance.new("UICorner")
	ToggleCorner.CornerRadius = UDim.new(1,0)
	ToggleCorner.Parent = Toggle
	local enabled = default
	local function Update()
		if enabled then
			Toggle.BackgroundColor3 = Color3.fromRGB(25,190,100)
			Toggle.Text = "AÇIK"
		else
			Toggle.BackgroundColor3 = Color3.fromRGB(65,68,75)
			Toggle.Text = "KAPALI"
		end
	end
	Update()
	Toggle.MouseButton1Click:Connect(function()
		enabled = not enabled
		Update()
		callback(enabled)
	end)
	return Holder
end

--==================================================
-- 🛩️ FLY SİSTEMİ
--==================================================

local function SetFly(enabled)

	FlyEnabled = enabled
	-- Eski bağlantıyı kapat
	if FlyConnection then
		FlyConnection:Disconnect()
		FlyConnection = nil
	end
	-- Eski kuvveti kaldır
	if FlyVelocity then
		FlyVelocity:Destroy()
		FlyVelocity = nil
	end
	local Character = Player.Character
	if not Character then
		return
	end
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	local Root = Character:FindFirstChild("HumanoidRootPart")
	if not Humanoid or not Root then
		return
	end
	if enabled then
		FlyVelocity = Instance.new("BodyVelocity")
		FlyVelocity.Name = "TalhaHubFly"
		FlyVelocity.MaxForce = Vector3.new(
			math.huge,
			math.huge,
			math.huge
		)
		FlyVelocity.Velocity = Vector3.zero
		FlyVelocity.Parent = Root
		Humanoid.PlatformStand = true
		FlyConnection = RunService.Heartbeat:Connect(function()
			if not FlyEnabled
				or not Root
				or not Root.Parent
				or not Humanoid
				or Humanoid.Health <= 0 then
				return
			end
			-- Mobil joystick hareketi
			local MoveDirection = Humanoid.MoveDirection
			if MoveDirection.Magnitude > 0 then
				FlyVelocity.Velocity = MoveDirection * 70
			else
				FlyVelocity.Velocity = Vector3.zero
			end
			-- Hareket yönüne bak
			if MoveDirection.Magnitude > 0 then
				Root.CFrame = CFrame.lookAt(
					Root.Position,
					Root.Position + MoveDirection
				)
			end
		end)
	else
		Humanoid.PlatformStand = false
	end
end

--==================================================
-- 🏠 ANA MENÜ
--==================================================

local function HomePage()

	ClearContent()
	AddTitle("Hoş Geldin!", "🇹🇷")
	AddInfo(
		"🇹🇷 Talha • Hub'a hoş geldin!\nKurucular: Talha"
	)
	AddFeature(
		"⚡ Hız (100)",
		"Karakterinin yürüme hızını artırır.",
		function()
			local Humanoid = GetHumanoid()
			if Humanoid then
				Humanoid.WalkSpeed = 100
			end
		end
	)
	AddFeature(
		"🦘 Zıplama (150)",
		"Karakterinin zıplama gücünü artırır.",
		function()
			local Humanoid = GetHumanoid()
			if Humanoid then
				Humanoid.UseJumpPower = true
				Humanoid.JumpPower = 150
			end
		end
	)
	AddFeature(
		"🛩️ Fly",
		"Mobil joystick ile havada hareket et.",
		function()
			SetFly(not FlyEnabled)
		end
	)
	AddFeature(
		"🔄 Normal Ayarlar",
		"Speed, JumpPower ve Fly ayarlarını sıfırlar.",
		function()
			SetFly(false)
			local Humanoid = GetHumanoid()
			if Humanoid then
				Humanoid.WalkSpeed = 16
				Humanoid.UseJumpPower = true
				Humanoid.JumpPower = 50
			end
		end
	)

end

--==================================================
-- ⚡ HAREKET
--==================================================

local function MovementPage()

	ClearContent()
	AddTitle("Hareket", "⚡")
	AddInfo(
		"Hareket özelliklerini buradan kontrol edebilirsin."
	)
	AddToggle(
		"⚡ Hız 100",
		"WalkSpeed değerini 100 yapar.",
		false,
		function(enabled)
			local Humanoid = GetHumanoid()
			if Humanoid then
				Humanoid.WalkSpeed = enabled and 100 or 16
			end
		end
	)
	AddToggle(
		"🦘 Zıplama 150",
		"JumpPower değerini 150 yapar.",
		false,
		function(enabled)
			local Humanoid = GetHumanoid()
			if Humanoid then
				Humanoid.UseJumpPower = true
				Humanoid.JumpPower = enabled and 150 or 50
			end
		end
	)
	-- 🛩️ FLY
	AddToggle(
		"🛩️ Fly",
		"Mobil joystick ile havada hareket et.",
		FlyEnabled,
		function(enabled)
			SetFly(enabled)
		end
	)
	AddFeature(
		"🔄 Hareketi Sıfırla",
		"Speed, JumpPower ve Fly ayarlarını sıfırlar.",
		function()
			SetFly(false)
			local Humanoid = GetHumanoid()
			if Humanoid then
				Humanoid.WalkSpeed = 16
				Humanoid.UseJumpPower = true
				Humanoid.JumpPower = 50
			end
		end
	)

end

--==================================================
-- 🛡️ KORUMA
--==================================================

local function StartProtection()

	if ProtectionConnection then
		ProtectionConnection:Disconnect()
	end
	ProtectionConnection = RunService.Heartbeat:Connect(function()
		local Character = Player.Character
		if not Character then
			return
		end
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local Root = Character:FindFirstChild("HumanoidRootPart")
		-- Anti-Sit
		if Protection.AntiSit and Humanoid then
			if Humanoid.Sit then
				Humanoid.Sit = false
			end
			if Humanoid:GetState() == Enum.HumanoidStateType.Seated then
				Humanoid:ChangeState(
					Enum.HumanoidStateType.GettingUp
				)
			end
		end
		-- Anti-Fling
		if Protection.AntiFling and Root then
			local Velocity = Root.AssemblyLinearVelocity
			if Velocity.Magnitude > 150 then
				Root.AssemblyLinearVelocity = Vector3.new(
					0,
					math.clamp(Velocity.Y,-50,50),
					0
				)
				Root.AssemblyAngularVelocity = Vector3.zero
			end
		end
		-- Anti-Bug
		if Protection.AntiBug and Humanoid then
			if Humanoid.Health > Humanoid.MaxHealth then
				Humanoid.Health = Humanoid.MaxHealth
			end
		end
	end)

end

local function ProtectionPage()

	ClearContent()
	AddTitle("Koruma", "🛡️")
	AddInfo(
		"Karakterini fiziksel ve istemci tarafındaki bazı sorunlardan korur."
	)
	AddToggle(
		"🛡️ Anti-Fling",
		"Yüksek fiziksel hızlardan kaynaklanan savrulmayı azaltır.",
		Protection.AntiFling,
		function(enabled)
			Protection.AntiFling = enabled
			StartProtection()
		end
	)
	AddToggle(
		"🪑 Anti-Sit",
		"Karakterin zorla oturtulmasını engeller.",
		Protection.AntiSit,
		function(enabled)
			Protection.AntiSit = enabled
			StartProtection()
		end
	)
	AddToggle(
		"🐞 Anti-Bug",
		"Bazı hatalı karakter durumlarını düzeltmeye çalışır.",
		Protection.AntiBug,
		function(enabled)
			Protection.AntiBug = enabled
			StartProtection()
		end
	)
	AddToggle(
		"💻 Anti-Script",
		"İstemci tarafında temel script koruması.",
		Protection.AntiScript,
		function(enabled)
			Protection.AntiScript = enabled
			-- Gerçek exploit/anti-cheat koruması
			-- sunucu tarafında yapılmalıdır.
		end
	)
	AddInfo("🟢 Koruma sistemi hazır.")

end

--==================================================
-- ⚙️ AYARLAR
--==================================================

local function SettingsPage()

	ClearContent()
	AddTitle("Ayarlar", "⚙️")
	AddFeature(
		"📱 Mobil Mod",
		"Arayüz mobil kullanım için optimize edilmiştir.",
		function()
			print("Mobil mod aktif.")
		end
	)
	AddFeature(
		"🔄 Arayüzü Yenile",
		"Talha • Hub ana menüsünü yeniden yükler.",
		function()
			HomePage()
		end
	)

end

--==================================================
-- ℹ️ BİLGİ
--==================================================

local function InfoPage()

	ClearContent()
	AddTitle("Bilgi", "ℹ️")
	AddInfo("🇹🇷 Talha • Hub")
	AddInfo("👑 Kurucular: Talha")
	AddInfo("📱 Mobil Uyumlu")
	AddInfo("🛡️ Koruma Sistemi")
	AddInfo("🛩️ Fly Sistemi")
	AddInfo("🔢 Versiyon: 1.0")

end

--==================================================
-- MENÜ BUTONLARI
--==================================================

local function AddMenuButton(text, y, callback)

	local Button = Instance.new("TextButton")
	Button.Parent = Sidebar
	Button.BackgroundColor3 = Color3.fromRGB(22,25,32)
	Button.BorderSizePixel = 0
	Button.Position = UDim2.new(0,10,0,y)
	Button.Size = UDim2.new(1,-20,0,42)
	Button.Font = Enum.Font.GothamBold
	Button.Text = text
	Button.TextColor3 = Color3.fromRGB(220,225,235)
	Button.TextSize = 13
	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,9)
	Corner.Parent = Button
	Button.MouseButton1Click:Connect(callback)
	return Button
end

AddMenuButton("🏠  Ana Menü",10,HomePage)
AddMenuButton("⚡  Hareket",60,MovementPage)
AddMenuButton("🛡️  Koruma",110,ProtectionPage)
AddMenuButton("⚙️  Ayarlar",160,SettingsPage)
AddMenuButton("ℹ️  Bilgi",210,InfoPage)

--==================================================
-- 📱 AÇ / KAPAT
--==================================================

local OpenButton = Instance.new("TextButton")
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(205,25,35)
OpenButton.BorderSizePixel = 0
OpenButton.Position = UDim2.new(0,15,0.5,-28)
OpenButton.Size = UDim2.new(0,56,0,56)
OpenButton.Font = Enum.Font.GothamBlack
OpenButton.Text = "🇹🇷"
OpenButton.TextSize = 25
OpenButton.Visible = false

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1,0)
OpenCorner.Parent = OpenButton

CloseButton.MouseButton1Click:Connect(function()

	MainFrame.Visible = false
	OpenButton.Visible = true

end)

OpenButton.MouseButton1Click:Connect(function()

	MainFrame.Visible = true
	OpenButton.Visible = false

end)

--==================================================
-- SÜRÜKLEME
--==================================================

local dragging = false
local dragStart
local startPosition

TopBar.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPosition = MainFrame.Position
	end

end)

UserInputService.InputChanged:Connect(function(input)

	if dragging and
		(input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch) then
		local Delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + Delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + Delta.Y
		)
	end

end)

UserInputService.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end

end)

--==================================================
-- RESPAWN SONRASI FLY KONTROLÜ
--==================================================

Player.CharacterAdded:Connect(function()

	task.wait(1)
	if FlyEnabled then
		SetFly(true)
	end

end)

--==================================================
-- BAŞLANGIÇ
--==================================================

HomePage()
StartProtection()
