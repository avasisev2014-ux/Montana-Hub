-- Montano Hub | Fully Fixed Version (Wallhack, Settings, Radio, Custom FOV & Crosshair)
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Экран загрузки / Заставка
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MontanoLoader"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(1, 0, 1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 400, 0, 50)
Title.Position = UDim2.new(0.5, -200, 0.4, -40)
Title.Text = "Montano Hub Loading..."
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1
Title.Parent = Frame

local ConfirmBtn = Instance.new("TextButton")
ConfirmBtn.Size = UDim2.new(0, 220, 0, 50)
ConfirmBtn.Position = UDim2.new(0.5, -110, 0.55, 0)
ConfirmBtn.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
ConfirmBtn.Text = "ПРОДОЛЖИТЬ"
ConfirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmBtn.TextSize = 18
ConfirmBtn.Font = Enum.Font.GothamBold
ConfirmBtn.Parent = Frame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ConfirmBtn

-- Стартовый звук
local Sound = Instance.new("Sound")
Sound.SoundId = "rbxassetid://111646190557344"
Sound.Volume = 2
Sound.Parent = SoundService
Sound:Play()

local function LoadHub()
    ScreenGui:Destroy()
    Sound:Destroy()
    
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    if not _G.MontanoSettings then
        _G.MontanoSettings = {
            CurrentLang = "RU",
            CurrentTheme = "Default",
            AimbotEnabled = false,
            Wallhack = true,
            WallCheck = false,
            FOV = 150,
            ShowFOV = true,
            FOVColor = Color3.fromRGB(255, 255, 255),
            TargetPart = "Head",
            AimType = "Smooth",
            Smoothness = 5,
            WalkSpeed = 16,
            SpeedHackEnabled = false,
            JumpPower = 50,
            JumpHackEnabled = false,
            InfJump = false,
            Noclip = false,
            AntiAFK = true,
            CameraFOV = 70,
            EnableCustomFOV = false,
            CrosshairEnabled = true,
            CrosshairStyle = "Крестик",
            CrosshairColor = Color3.fromRGB(255, 0, 0),
            CrosshairSize = 10,
            CrosshairGap = 3
        }
    end

    local Settings = _G.MontanoSettings

    local Window = Rayfield:CreateWindow({
       Name = "Montano Hub",
       LoadingTitle = "Загрузка...",
       ConfigurationSaving = { Enabled = false },
       KeySystem = false,
       Theme = Settings.CurrentTheme
    })

    -- Радио
    local RadioSound = SoundService:FindFirstChild("MontanoRadio") or Instance.new("Sound")
    RadioSound.Name = "MontanoRadio"
    RadioSound.Volume = 1
    RadioSound.Looped = true
    RadioSound.Parent = SoundService

    -- Прицел (Drawing API)
    local CrosshairLines = {
        Top = Drawing.new("Line"),
        Bottom = Drawing.new("Line"),
        Left = Drawing.new("Line"),
        Right = Drawing.new("Line"),
        CenterDot = Drawing.new("Circle")
    }

    for _, line in pairs(CrosshairLines) do
        if line.Thickness then line.Thickness = 1.5 end
        line.Visible = false
    end

    local FOVCircle = _G.MontanoFOV or Drawing.new("Circle")
    _G.MontanoFOV = FOVCircle
    FOVCircle.Thickness = 1.5
    FOVCircle.Color = Settings.FOVColor
    FOVCircle.Filled = false
    FOVCircle.Transparency = 0.7
    FOVCircle.NumSides = 32

    -- Вкладка: Бой
    local CombatTab = Window:CreateTab("Бой", 4483362458)
    CombatTab:CreateToggle({Name = "Включить Аимбот", CurrentValue = Settings.AimbotEnabled, Callback = function(Value) Settings.AimbotEnabled = Value end})
    CombatTab:CreateToggle({Name = "Проверка стен", CurrentValue = Settings.WallCheck, Callback = function(Value) Settings.WallCheck = Value end})
    CombatTab:CreateSlider({Name = "Плавность наводки", Range = {1, 20}, Increment = 1, Suffix = "", CurrentValue = Settings.Smoothness, Callback = function(Value) Settings.Smoothness = Value end})
    CombatTab:CreateSlider({Name = "Размер круга FOV Аима", Range = {50, 400}, Increment = 10, Suffix = " px", CurrentValue = Settings.FOV, Callback = function(Value) Settings.FOV = Value; FOVCircle.Radius = Value end})

    -- Вкладка: Визуал
    local VisualsTab = Window:CreateTab("Визуал", 4483362458)
    VisualsTab:CreateToggle({Name = "Валхак (Wallhack)", CurrentValue = Settings.Wallhack, Callback = function(Value) Settings.Wallhack = Value end})
    VisualsTab:CreateToggle({Name = "Отображать круг FOV Аима", CurrentValue = Settings.ShowFOV, Callback = function(Value) Settings.ShowFOV = Value end})

    VisualsTab:CreateSection("Угол обзора (Custom FOV)")
    VisualsTab:CreateToggle({Name = "Включить Кастомный FOV", CurrentValue = Settings.EnableCustomFOV, Callback = function(Value) Settings.EnableCustomFOV = Value end})
    VisualsTab:CreateSlider({Name = "Угол обзора Камеры", Range = {70, 120}, Increment = 1, Suffix = "°", CurrentValue = Settings.CameraFOV, Callback = function(Value) Settings.CameraFOV = Value end})

    VisualsTab:CreateSection("Кастомный Прицел (Crosshair)")
    VisualsTab:CreateToggle({Name = "Включить Прицел", CurrentValue = Settings.CrosshairEnabled, Callback = function(Value) Settings.CrosshairEnabled = Value end})
    VisualsTab:CreateDropdown({Name = "Стиль прицела", Options = {"Крестик", "Точка"}, CurrentOption = {Settings.CrosshairStyle}, Callback = function(Option) Settings.CrosshairStyle = Option[1] end})
    VisualsTab:CreateDropdown({Name = "Цвет прицела", Options = {"Красный", "Зеленый", "Голубой", "Желтый", "Белый"}, CurrentOption = {"Красный"}, Callback = function(Option)
        local c = Option[1]
        if c == "Красный" then Settings.CrosshairColor = Color3.fromRGB(255, 0, 0)
        elseif c == "Зеленый" then Settings.CrosshairColor = Color3.fromRGB(0, 255, 0)
        elseif c == "Голубой" then Settings.CrosshairColor = Color3.fromRGB(0, 200, 255)
        elseif c == "Желтый" then Settings.CrosshairColor = Color3.fromRGB(255, 255, 0)
        else Settings.CrosshairColor = Color3.fromRGB(255, 255, 255) end
    end})
    VisualsTab:CreateSlider({Name = "Размер прицела", Range = {4, 25}, Increment = 1, Suffix = "px", CurrentValue = Settings.CrosshairSize, Callback = function(Value) Settings.CrosshairSize = Value end})

    -- Вкладка: Движение
    local MovementTab = Window:CreateTab("Движение", 4483362458)
    MovementTab:CreateToggle({Name = "Включить Speedhack", CurrentValue = Settings.SpeedHackEnabled, Callback = function(Value) Settings.SpeedHackEnabled = Value end})
    MovementTab:CreateSlider({Name = "Скорость бега", Range = {16, 200}, Increment = 2, Suffix = "", CurrentValue = Settings.WalkSpeed, Callback = function(Value) Settings.WalkSpeed = Value end})
    MovementTab:CreateToggle({Name = "Проход сквозь стены (Noclip)", CurrentValue = Settings.Noclip, Callback = function(Value) Settings.Noclip = Value end})

    -- Вкладка: Радио
    local MusicTab = Window:CreateTab("Радио", 4483362458)
    MusicTab:CreateInput({Name = "Код музыки (Audio ID)", PlaceholderText = "Введите ID...", RemoveTextAfterFocusLost = false, Callback = function(Text)
        local MusicID = tonumber(Text)
        if MusicID then RadioSound.SoundId = "rbxassetid://" .. tostring(MusicID); RadioSound:Play() end
    end})
    MusicTab:CreateToggle({Name = "Воспроизведение музыки", CurrentValue = RadioSound.IsPlaying, Callback = function(Value)
        if Value then RadioSound:Resume() else RadioSound:Pause() end
    end})
    MusicTab:CreateSlider({Name = "Громкость музыки", Range = {0, 10}, Increment = 1, Suffix = "", CurrentValue = math.floor(RadioSound.Volume * 5), Callback = function(Value) RadioSound.Volume = Value / 5 end})

    -- Вкладка: Настройки
    local SettingsTab = Window:CreateTab("Настройки", 4483362458)
    SettingsTab:CreateDropdown({Name = "Выбор языка", Options = {"Русский", "Українська", "English"}, CurrentOption = {Settings.CurrentLang == "UA" and "Українська" or (Settings.CurrentLang == "EN" and "English" or "Русский")}, Callback = function(Option)
        if Option[1] == "Українська" then Settings.CurrentLang = "UA" elseif Option[1] == "English" then Settings.CurrentLang = "EN" else Settings.CurrentLang = "RU" end
    end})
    SettingsTab:CreateDropdown({Name = "Выбор темы", Options = {"Темная (Default)", "Светлая (Light)", "Серая (Serenity)", "Синяя (DarkBlue)", "Фиолетовая (Amethyst)"}, CurrentOption = {"Темная (Default)"}, Callback = function(Option)
        local themeName = Option[1]
        if themeName:find("Светлая") or themeName:find("Light") then Settings.CurrentTheme = "Light"
        elseif themeName:find("Серая") or themeName:find("Serenity") then Settings.CurrentTheme = "Serenity"
        elseif themeName:find("Синяя") or themeName:find("DarkBlue") then Settings.CurrentTheme = "DarkBlue"
        elseif themeName:find("Фиолетовая") or themeName:find("Amethyst") then Settings.CurrentTheme = "Amethyst"
        else Settings.CurrentTheme = "Default" end
    end})
    SettingsTab:CreateButton({Name = "Перезапустить UI", Callback = function()
        Rayfield:Destroy()
        task.wait(0.2)
        LoadHub()
    end})

    -- Логика Аимбота
    local function IsVisible(part)
        if not Settings.WallCheck then return true end
        local parts = Camera:GetPartsObscuringTarget({part.Position}, {LocalPlayer.Character, part.Parent})
        return #parts == 0
    end

    local function GetClosestTarget()
        local Closest = nil
        local MaxDist = Settings.FOV
        local ScreenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                local Part = v.Character:FindFirstChild(Settings.TargetPart) or v.Character:FindFirstChild("HumanoidRootPart")
                if Part then
                    local ScreenPos, OnScreen = Camera:WorldToViewportPoint(Part.Position)
                    if OnScreen and IsVisible(Part) then
                        local Dist = (Vector2.new(ScreenPos.X, ScreenPos.Y) - ScreenCenter).Magnitude
                        if Dist < MaxDist then MaxDist = Dist; Closest = Part end
                    end
                end
            end
        end
        return Closest
    end

    -- Надежный Wallhack (Highlight)
    local function ApplyWallhack(v)
        if v ~= LocalPlayer and v.Character then
            local hl = v.Character:FindFirstChild("MontanoHighlight")
            if Settings.Wallhack then
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "MontanoHighlight"
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.FillTransparency = 0.5
                    hl.OutlineTransparency = 0
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.Parent = v.Character
                end
            else
                if hl then hl:Destroy() end
            end
        end
    end

    -- Подключение к новым игрокам для Wallhack
    for _, v in pairs(Players:GetPlayers()) do
        ApplyWallhack(v)
        v.CharacterAdded:Connect(function()
            task.wait(0.5)
            ApplyWallhack(v)
        end)
    end
    Players.PlayerAdded:Connect(function(v)
        v.CharacterAdded:Connect(function()
            task.wait(0.5)
            ApplyWallhack(v)
        end)
    end)

    -- Главный цикл
    if _G.MontanoConnection then _G.MontanoConnection:Disconnect() end

    _G.MontanoConnection = RunService.RenderStepped:Connect(function()
        if Settings.EnableCustomFOV then Camera.FieldOfView = Settings.CameraFOV end

        -- Проверка Wallhack для всех
        for _, v in pairs(Players:GetPlayers()) do
            ApplyWallhack(v)
        end

        -- Спидхак
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            if Settings.SpeedHackEnabled then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Settings.WalkSpeed
            end
        end

        -- Прицел
        local Center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        if Settings.CrosshairEnabled then
            local color = Settings.CrosshairColor
            local size = Settings.CrosshairSize
            local gap = Settings.CrosshairGap

            if Settings.CrosshairStyle == "Крестик" then
                CrosshairLines.Top.Visible = true; CrosshairLines.Top.From = Center - Vector2.new(0, gap); CrosshairLines.Top.To = Center - Vector2.new(0, gap + size); CrosshairLines.Top.Color = color
                CrosshairLines.Bottom.Visible = true; CrosshairLines.Bottom.From = Center + Vector2.new(0, gap); CrosshairLines.Bottom.To = Center + Vector2.new(0, gap + size); CrosshairLines.Bottom.Color = color
                CrosshairLines.Left.Visible = true; CrosshairLines.Left.From = Center - Vector2.new(gap, 0); CrosshairLines.Left.To = Center - Vector2.new(gap + size, 0); CrosshairLines.Left.Color = color
                CrosshairLines.Right.Visible = true; CrosshairLines.Right.From = Center + Vector2.new(gap, 0); CrosshairLines.Right.To = Center + Vector2.new(gap + size, 0); CrosshairLines.Right.Color = color
                CrosshairLines.CenterDot.Visible = false
            elseif Settings.CrosshairStyle == "Точка" then
                for k, v in pairs(CrosshairLines) do v.Visible = false end
                CrosshairLines.CenterDot.Visible = true
                CrosshairLines.CenterDot.Position = Center
                CrosshairLines.CenterDot.Radius = size / 3
                CrosshairLines.CenterDot.Color = color
                CrosshairLines.CenterDot.Filled = true
            end
        else
            for k, v in pairs(CrosshairLines) do v.Visible = false end
        end

        FOVCircle.Position = Center
        FOVCircle.Visible = Settings.AimbotEnabled and Settings.ShowFOV

        if Settings.AimbotEnabled then
            local Target = GetClosestTarget()
            if Target then
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, Target.Position), 1 / Settings.Smoothness)
            end
        end

        if Settings.Noclip and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end

ConfirmBtn.MouseButton1Click:Connect(function()
    LoadHub()
end)
