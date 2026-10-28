-- Montano Hub | v1.0 [Official Release + Working Languages] 🚀
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success or not Rayfield then
    warn("Ошибка загрузки UI библиотеки!")
    return
end

if not _G.MontanoSettings then
    _G.MontanoSettings = {
        CurrentLang = "RU",
        CurrentTheme = "Amethyst",
        AimbotEnabled = false,
        AimMode = "Аимбот",
        Wallhack = true,
        ESPBoxes = false,
        ESPTracers = false,
        ESPHealth = false,
        ESPDistance = true,
        ESPNames = true,
        ESPSkeleton = true,
        FOVBreathe = true,
        HitSound = true,
        WallCheck = false,
        FOV = 150,
        ShowFOV = true,
        FOVColor = Color3.fromRGB(255, 120, 0),
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
    }
end

local Settings = _G.MontanoSettings
_G.MontanoIsPro = false

-- 15 ключей для PRO версии
local ValidKeys = {
    ["MONTANO1"] = true, ["MONTANO2"] = true, ["MONTANO3"] = true,
    ["MONTANO4"] = true, ["MONTANO5"] = true, ["MONTANO6"] = true,
    ["MONTANO7"] = true, ["MONTANO8"] = true, ["MONTANO9"] = true,
    ["MONTANO10"] = true, ["MONTANO11"] = true, ["MONTANO12"] = true,
    ["MONTANO13"] = true, ["MONTANO14"] = true, ["MONTANO15"] = true,
}

local HitAudio = Instance.new("Sound")
HitAudio.SoundId = "rbxassetid://4817809188"
HitAudio.Volume = 2
HitAudio.Parent = SoundService

-- Словари языков
local Locales = {
    RU = {
        Title = "🔥 Montano Hub v1.0 [Official Release] 🚀",
        TabHome = "Главная",
        TabCombat = "Бой [PRO 💎]",
        TabVisuals = "Визуал",
        TabMovement = "Движение",
        TabRadio = "Радио [PRO 💎]",
        TabSettings = "Настройки",
        KeySection = "🔑 Система ключей (Активация PRO)",
        KeyInput = "Введите PRO ключ",
        KeyPlaceholder = "Введите ключ сюда...",
        LangLabel = "Выбор языка (Language)",
        ThemeLabel = "Выбор темы оформления"
    },
    UA = {
        Title = "🔥 Montano Hub v1.0 [Official Release] 🚀",
        TabHome = "Головна",
        TabCombat = "Бій [PRO 💎]",
        TabVisuals = "Візуал",
        TabMovement = "Рух",
        TabRadio = "Радіо [PRO 💎]",
        TabSettings = "Налаштування",
        KeySection = "🔑 Система ключів (Активація PRO)",
        KeyInput = "Введіть PRO ключ",
        KeyPlaceholder = "Введіть ключ сюди...",
        LangLabel = "Вибір мови (Language)",
        ThemeLabel = "Вибір теми оформлення"
    },
    EN = {
        Title = "🔥 Montano Hub v1.0 [Official Release] 🚀",
        TabHome = "Home",
        TabCombat = "Combat [PRO 💎]",
        TabVisuals = "Visuals",
        TabMovement = "Movement",
        TabRadio = "Radio [PRO 💎]",
        TabSettings = "Settings",
        KeySection = "🔑 Key System (PRO Activation)",
        KeyInput = "Enter PRO Key",
        KeyPlaceholder = "Enter key here...",
        LangLabel = "Language Selection",
        ThemeLabel = "Theme Selection"
    }
}

local T = Locales[Settings.CurrentLang] or Locales.RU

local Window = Rayfield:CreateWindow({
   Name = T.Title,
   LoadingTitle = "Запуск Montano Hub...",
   LoadingSubtitle = "by Montano",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
   Theme = Settings.CurrentTheme
})

Rayfield:Notify({
    Title = "🚀 Montano Hub v1.0",
    Content = "Успешно запущен! Введите ключ в Настройках для PRO.",
    Duration = 5,
    Image = 6023426915
})

local RadioSound = SoundService:FindFirstChild("MontanoRadio") or Instance.new("Sound")
RadioSound.Name = "MontanoRadio"
RadioSound.Volume = 1
RadioSound.Looped = true
RadioSound.Parent = SoundService

local FOVCircle = _G.MontanoFOV or Drawing.new("Circle")
_G.MontanoFOV = FOVCircle
FOVCircle.Thickness = 1.5
FOVCircle.Color = Settings.FOVColor
FOVCircle.Filled = false
FOVCircle.Transparency = 0.7
FOVCircle.NumSides = 32

local ESPVisuals = {}

local function RemoveESP(player)
    if ESPVisuals[player] then
        for _, obj in pairs(ESPVisuals[player]) do
            pcall(function() obj:Remove() end)
        end
        ESPVisuals[player] = nil
    end
end

Players.PlayerRemoving:Connect(RemoveESP)

-- ВКЛАДКА: HOME
local HomeTab = Window:CreateTab(T.TabHome, 6023426915)
HomeTab:CreateSection("🔥 Официальный релиз Montano Hub v1.0")
HomeTab:CreateParagraph({Title = "Статус сборки", Content = "🛡️ Режим: Free (Доступны валхак, боксы и скорость)"})
HomeTab:CreateButton({
    Name = "📋 Скопировать ссылку на Telegram",
    Callback = function()
        pcall(function() setclipboard("https://t.me/Montanahub123") end)
        Rayfield:Notify({Title = "Montano Hub", Content = "Ссылка скопирована!", Duration = 3})
    end,
})

-- ВКЛАДКА: COMBAT (PRO)
local CombatTab = Window:CreateTab(T.TabCombat, 4483362458)
CombatTab:CreateToggle({Name = "Включить Аимбот", CurrentValue = Settings.AimbotEnabled, Callback = function(Value)
    if Value and not _G.MontanoIsPro then
        Rayfield:Notify({Title = "🔒 PRO", Content = "Требуется PRO ключ в Настройках!", Duration = 4})
        Settings.AimbotEnabled = false
        return
    end
    Settings.AimbotEnabled = Value 
end})
CombatTab:CreateToggle({Name = "Звук попадания (HitSound)", CurrentValue = Settings.HitSound, Callback = function(Value)
    if not _G.MontanoIsPro then Rayfield:Notify({Title = "🔒 PRO", Content = "Нужен PRO ключ!", Duration = 3}) return end
    Settings.HitSound = Value 
end})
CombatTab:CreateToggle({Name = "Проверка стен (WallCheck)", CurrentValue = Settings.WallCheck, Callback = function(Value) Settings.WallCheck = Value end})
CombatTab:CreateDropdown({Name = "Режим работы", Options = {"Аимбот", "Сайлент Аим"}, CurrentOption = {Settings.AimMode}, Callback = function(Option) Settings.AimMode = Option[1] end})
CombatTab:CreateDropdown({Name = "Часть тела (Target Bone)", Options = {"Голова", "Торс (Грудь)"}, CurrentOption = {"Голова"}, Callback = function(Option)
    if Option[1] == "Голова" then Settings.TargetPart = "Head" else Settings.TargetPart = "HumanoidRootPart" end
end})
CombatTab:CreateDropdown({Name = "Тип наводки", Options = {"Плавный (Smooth)", "Резкий (Snap)"}, CurrentOption = {"Плавный (Smooth)"}, Callback = function(Option)
    if Option[1]:find("Резкий") then Settings.AimType = "Snap" else Settings.AimType = "Smooth" end
end})
CombatTab:CreateSlider({Name = "Плавность наводки", Range = {1, 20}, Increment = 1, Suffix = " шаг", CurrentValue = Settings.Smoothness, Callback = function(Value) Settings.Smoothness = Value end})
CombatTab:CreateSlider({Name = "Размер круга FOV", Range = {20, 400}, Increment = 5, Suffix = " px", CurrentValue = Settings.FOV, Callback = function(Value) Settings.FOV = Value; FOVCircle.Radius = Value end})
CombatTab:CreateToggle({Name = "Эффект дыхания FOV", CurrentValue = Settings.FOVBreathe, Callback = function(Value) Settings.FOVBreathe = Value end})

-- ВКЛАДКА: VISUALS
local VisualsTab = Window:CreateTab(T.TabVisuals, 4483362458)
VisualsTab:CreateToggle({Name = "Валхак (Chams) [Free 🟢]", CurrentValue = Settings.Wallhack, Callback = function(Value) Settings.Wallhack = Value end})
VisualsTab:CreateToggle({Name = "Боксы (ESP Box) [Free 🟢]", CurrentValue = Settings.ESPBoxes, Callback = function(Value) Settings.ESPBoxes = Value end})
VisualsTab:CreateToggle({Name = "Линии (ESP Tracers) [PRO 💎]", CurrentValue = Settings.ESPTracers, Callback = function(Value)
    if Value and not _G.MontanoIsPro then Rayfield:Notify({Title = "🔒 PRO", Content = "Нужен PRO ключ!", Duration = 4}) Settings.ESPTracers = false return end
    Settings.ESPTracers = Value 
end})
VisualsTab:CreateToggle({Name = "Здоровье (ESP HP) [PRO 💎]", CurrentValue = Settings.ESPHealth, Callback = function(Value)
    if Value and not _G.MontanoIsPro then Rayfield:Notify({Title = "🔒 PRO", Content = "Нужен PRO ключ!", Duration = 4}) Settings.ESPHealth = false return end
    Settings.ESPHealth = Value 
end})
VisualsTab:CreateToggle({Name = "Дистанция в метрах [PRO 💎]", CurrentValue = Settings.ESPDistance, Callback = function(Value)
    if Value and not _G.MontanoIsPro then Rayfield:Notify({Title = "🔒 PRO", Content = "Нужен PRO ключ!", Duration = 4}) Settings.ESPDistance = false return end
    Settings.ESPDistance = Value 
end})
VisualsTab:CreateToggle({Name = "Имена игроков (ESP Names) [PRO 💎]", CurrentValue = Settings.ESPNames, Callback = function(Value)
    if Value and not _G.MontanoIsPro then Rayfield:Notify({Title = "🔒 PRO", Content = "Нужен PRO ключ!", Duration = 4}) Settings.ESPNames = false return end
    Settings.ESPNames = Value 
end})
VisualsTab:CreateToggle({Name = "Скелет игроков (ESP Skeleton) [PRO 💎]", CurrentValue = Settings.ESPSkeleton, Callback = function(Value)
    if Value and not _G.MontanoIsPro then Rayfield:Notify({Title = "🔒 PRO", Content = "Нужен PRO ключ!", Duration = 4}) Settings.ESPSkeleton = false return end
    Settings.ESPSkeleton = Value 
end})
VisualsTab:CreateToggle({Name = "Отображать круг FOV [PRO 💎]", CurrentValue = Settings.ShowFOV, Callback = function(Value) Settings.ShowFOV = Value end})

-- ВКЛАДКА: MOVEMENT
local MovementTab = Window:CreateTab(T.TabMovement, 4483362458)
MovementTab:CreateToggle({Name = "Включить Speedhack [Free 🟢]", CurrentValue = Settings.SpeedHackEnabled, Callback = function(Value) Settings.SpeedHackEnabled = Value end})
MovementTab:CreateSlider({Name = "Скорость бега [Free 🟢]", Range = {16, 200}, Increment = 2, Suffix = " speed", CurrentValue = Settings.WalkSpeed, Callback = function(Value) Settings.WalkSpeed = Value end})
MovementTab:CreateToggle({Name = "Включить высокий прыжок [Free 🟢]", CurrentValue = Settings.JumpHackEnabled, Callback = function(Value) Settings.JumpHackEnabled = Value end})
MovementTab:CreateSlider({Name = "Сила прыжка [Free 🟢]", Range = {50, 300}, Increment = 5, Suffix = " power", CurrentValue = Settings.JumpPower, Callback = function(Value) Settings.JumpPower = Value end})
MovementTab:CreateToggle({Name = "Бесконечный прыжок (InfJump) [PRO 💎]", CurrentValue = Settings.InfJump, Callback = function(Value)
    if Value and not _G.MontanoIsPro then Rayfield:Notify({Title = "🔒 PRO", Content = "Нужен PRO ключ!", Duration = 4}) Settings.InfJump = false return end
    Settings.InfJump = Value 
end})
MovementTab:CreateToggle({Name = "Проход сквозь стены (Noclip) [PRO 💎]", CurrentValue = Settings.Noclip, Callback = function(Value)
    if Value and not _G.MontanoIsPro then Rayfield:Notify({Title = "🔒 PRO", Content = "Нужен PRO ключ!", Duration = 4}) Settings.Noclip = false return end
    Settings.Noclip = Value 
end})

-- ВКЛАДКА: RADIO (PRO)
local MusicTab = Window:CreateTab(T.TabRadio, 4483362458)
MusicTab:CreateInput({Name = "Код музыки (Audio ID)", PlaceholderText = "Введите ID трека...", RemoveTextAfterFocusLost = false, Callback = function(Text)
    if not _G.MontanoIsPro then Rayfield:Notify({Title = "🔒 PRO", Content = "Нужен PRO ключ!", Duration = 4}) return end
    local MusicID = tonumber(Text)
    if MusicID then RadioSound.SoundId = "rbxassetid://" .. tostring(MusicID); RadioSound:Play() end
end})
MusicTab:CreateToggle({Name = "Воспроизведение музыки", CurrentValue = RadioSound.IsPlaying, Callback = function(Value)
    if Value and not _G.MontanoIsPro then Rayfield:Notify({Title = "🔒 PRO", Content = "Нужен PRO ключ!", Duration = 4}) RadioSound:Pause() return end
    if Value then RadioSound:Resume() else RadioSound:Pause() end
end})

-- ВКЛАДКА: SETTINGS (С выбором языков и тем)
local SettingsTab = Window:CreateTab(T.TabSettings, 4483362458)
SettingsTab:CreateSection(T.KeySection)
SettingsTab:CreateInput({
    Name = T.KeyInput,
    PlaceholderText = "Введите ключ сюда...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local cleanKey = string.upper(string.gsub(Text, "%s+", ""))
        if ValidKeys[cleanKey] then
            _G.MontanoIsPro = true
            Rayfield:Notify({Title = "Успешно! 🚀", Content = "PRO функции разблокированы!", Duration = 5, Image = 6023426915})
        else
            Rayfield:Notify({Title = "Ошибка ❌", Content = "Неверный ключ!", Duration = 4, Image = 6023426915})
        end
    end,
})

SettingsTab:CreateSection("⚙️ Кастомизация интерфейса")
SettingsTab:CreateDropdown({
    Name = T.LangLabel,
    Options = {"Русский", "Українська", "English"},
    CurrentOption = {Settings.CurrentLang == "UA" and "Українська" or (Settings.CurrentLang == "EN" and "English" or "Русский")},
    Callback = function(Option)
        if Option[1] == "Українська" then Settings.CurrentLang = "UA"
        elseif Option[1] == "English" then Settings.CurrentLang = "EN"
        else Settings.CurrentLang = "RU" end
        Rayfield:Notify({Title = "Язык изменен", Content = "Перезапустите хуб для применения языка", Duration = 3})
    end
})

SettingsTab:CreateDropdown({
    Name = T.ThemeLabel,
    Options = {"Фиолетовая (Amethyst 🟣)", "Темная (Default)", "Светлая (Light)", "Серая (Serenity)", "Синяя (DarkBlue)"},
    CurrentOption = {"Фиолетовая (Amethyst 🟣)"},
    Callback = function(Option)
        local themeName = Option[1]
        if themeName:find("Фиолетовая") then Settings.CurrentTheme = "Amethyst"
        elseif themeName:find("Светлая") then Settings.CurrentTheme = "Light"
        elseif themeName:find("Серая") then Settings.CurrentTheme = "Serenity"
        elseif themeName:find("Синяя") then Settings.CurrentTheme = "DarkBlue"
        else Settings.CurrentTheme = "Default" end
        Rayfield:Notify({Title = "Тема измененная", Content = "Перезапустите хуб для применения темы", Duration = 3})
    end
})

SettingsTab:CreateButton({Name = "Закрыть меню", Callback = function() Rayfield:Destroy() end})

UserInputService.JumpRequest:Connect(function()
    if Settings.InfJump and _G.MontanoIsPro and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

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

if _G.MontanoConnection then _G.MontanoConnection:Disconnect() end
local lastTarget = nil

_G.MontanoConnection = RunService.RenderStepped:Connect(function()
    if Settings.AimbotEnabled and Settings.ShowFOV and _G.MontanoIsPro then
        FOVCircle.Visible = true
        if Settings.FOVBreathe then
            local tickTime = tick() * 3
            FOVCircle.Radius = Settings.FOV + math.sin(tickTime) * 12
            local hue = (tickTime * 0.1) % 1
            FOVCircle.Color = Color3.fromHSV(hue, 0.8, 1)
        else
            FOVCircle.Radius = Settings.FOV
            FOVCircle.Color = Settings.FOVColor
        end
    else
        FOVCircle.Visible = false
    end

    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if Settings.SpeedHackEnabled then hum.WalkSpeed = Settings.WalkSpeed end
        if Settings.JumpHackEnabled then hum.UseJumpPower = true; hum.JumpPower = Settings.JumpPower end
    end

    if Settings.Noclip and _G.MontanoIsPro and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    if Settings.AimbotEnabled and Settings.AimMode == "Аимбот" and _G.MontanoIsPro then
        local Target = GetClosestTarget()
        if Target then
            if Settings.HitSound and Target ~= lastTarget then
                HitAudio:Play()
                lastTarget = Target
            end
            local TargetCFrame = CFrame.new(Camera.CFrame.Position, Target.Position)
            if Settings.AimType == "Snap" then Camera.CFrame = TargetCFrame else Camera.CFrame = Camera.CFrame:Lerp(TargetCFrame, 1 / Settings.Smoothness) end
        else
            lastTarget = nil
        end
    end

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") then
                local char = v.Character
                local hum = char.Humanoid
                local rootPart = char.HumanoidRootPart

                if not ESPVisuals[v] then
                    ESPVisuals[v] = {
                        Box = Drawing.new("Square"),
                        Tracer = Drawing.new("Line"),
                        HealthBar = Drawing.new("Line"),
                        HealthText = Drawing.new("Text"),
                        DistanceText = Drawing.new("Text"),
                        NameText = Drawing.new("Text"),
                        HeadToTorso = Drawing.new("Line"),
                        TorsoToLeftArm = Drawing.new("Line"),
                        TorsoToRightArm = Drawing.new("Line"),
                        TorsoToLeftLeg = Drawing.new("Line"),
                        TorsoToRightLeg = Drawing.new("Line")
                    }
                    local esp = ESPVisuals[v]
                    esp.Box.Thickness = 1.5; esp.Box.Filled = false
                    esp.Tracer.Thickness = 1; esp.HealthBar.Thickness = 2.5
                    esp.HealthText.Size = 13; esp.HealthText.Center = true; esp.HealthText.Outline = true; esp.HealthText.Color = Color3.fromRGB(0, 255, 0)
                    esp.DistanceText.Size = 13; esp.DistanceText.Center = true; esp.DistanceText.Outline = true; esp.DistanceText.Color = Color3.fromRGB(255, 120, 0)
                    esp.NameText.Size = 14; esp.NameText.Center = true; esp.NameText.Outline = true; esp.NameText.Color = Color3.fromRGB(255, 255, 255)

                    for _, bone in pairs({esp.HeadToTorso, esp.TorsoToLeftArm, esp.TorsoToRightArm, esp.TorsoToLeftLeg, esp.TorsoToRightLeg}) do
                        bone.Thickness = 1.5; bone.Color = Color3.fromRGB(255, 255, 255)
                    end
                end

                local esp = ESPVisuals[v]
                local head = char:FindFirstChild("Head")
                local upperTorso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
                local leftArm = char:FindFirstChild("Left Arm") or char:FindFirstChild("LeftHand")
                local rightArm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand")
                local leftLeg = char:FindFirstChild("Left Leg") or char:FindFirstChild("LeftFoot")
                local rightLeg = char:FindFirstChild("Right Leg") or char:FindFirstChild("RightFoot")

                if hum.Health > 0 and head then
                    local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)

                    if onScreen then
                        local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                        local legPos = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))
                        local height = math.abs(headPos.Y - legPos.Y)
                        local width = height / 2

                        -- Боксы (Free)
                        if Settings.ESPBoxes then
                            esp.Box.Visible = true
                            esp.Box.Size = Vector2.new(width, height)
                            esp.Box.Position = Vector2.new(vector.X - width / 2, headPos.Y)
                        else
                            esp.Box.Visible = false
                        end

                        -- Здоровье / HP (PRO)
                        if Settings.ESPHealth and _G.MontanoIsPro then
                            local healthPercent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                            local barHeight = height * healthPercent
                            
                            esp.HealthBar.Visible = true
                            esp.HealthBar.From = Vector2.new(vector.X - width / 2 - 6, legPos.Y)
                            esp.HealthBar.To = Vector2.new(vector.X - width / 2 - 6, legPos.Y - barHeight)
                            esp.HealthBar.Color = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)

                            esp.HealthText.Visible = true
                            esp.HealthText.Text = math.floor(hum.Health) .. " HP"
                            esp.HealthText.Position = Vector2.new(vector.X - width / 2 - 25, legPos.Y - height / 2)
                        else
                            esp.HealthBar.Visible = false
                            esp.HealthText.Visible = false
                        end

                        -- Трейсеры (PRO)
                        if Settings.ESPTracers and _G.MontanoIsPro then
                            esp.Tracer.Visible = true
                            esp.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                            esp.Tracer.To = Vector2.new(vector.X, legPos.Y)
                        else
                            esp.Tracer.Visible = false
                        end

                        -- Дистанция (PRO)
                        if Settings.ESPDistance and _G.MontanoIsPro and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local myRoot = LocalPlayer.Character.HumanoidRootPart
                            local distStuds = (myRoot.Position - rootPart.Position).Magnitude
                            local distMeters = math.floor(distStuds / 3.57)

                            esp.DistanceText.Visible = true
                            esp.DistanceText.Text = distMeters .. "m 🚀"
                            esp.DistanceText.Position = Vector2.new(vector.X, legPos.Y + 2)
                        else
                            esp.DistanceText.Visible = false
                        end

                        -- Имена (PRO)
                        if Settings.ESPNames and _G.MontanoIsPro then
                            esp.NameText.Visible = true
                            esp.NameText.Text = v.Name
                            esp.NameText.Position = Vector2.new(vector.X, headPos.Y - 18)
                        else
                            esp.NameText.Visible = false
                        end

                        -- Скелет (PRO)
                        if Settings.ESPSkeleton and _G.MontanoIsPro and upperTorso and leftArm and rightArm and leftLeg and rightLeg then
                            local tPos = Camera:WorldToViewportPoint(upperTorso.Position)
                            local hPos = Camera:WorldToViewportPoint(head.Position)
                            local lArm = Camera:WorldToViewportPoint(leftArm.Position)
                            local rArm = Camera:WorldToViewportPoint(rightArm.Position)
                            local lLeg = Camera:WorldToViewportPoint(leftLeg.Position)
                            local rLeg = Camera:WorldToViewportPoint(rightLeg.Position)

                            esp.HeadToTorso.Visible = true; esp.HeadToTorso.From = Vector2.new(hPos.X, hPos.Y); esp.HeadToTorso.To = Vector2.new(tPos.X, tPos.Y)
                            esp.TorsoToLeftArm.Visible = true; esp.TorsoToLeftArm.From = Vector2.new(tPos.X, tPos.Y); esp.TorsoToLeftArm.To = Vector2.new(lArm.X, lArm.Y)
                            esp.TorsoToRightArm.Visible = true; esp.TorsoToRightArm.From = Vector2.new(tPos.X, tPos.Y); esp.TorsoToRightArm.To = Vector2.new(rArm.X, rArm.Y)
                            esp.TorsoToLeftLeg.Visible = true; esp.TorsoToLeftLeg.From = Vector2.new(tPos.X, tPos.Y); esp.TorsoToLeftLeg.To = Vector2.new(lLeg.X, lLeg.Y)
                            esp.TorsoToRightLeg.Visible = true; esp.TorsoToRightLeg.From = Vector2.new(tPos.X, tPos.Y); esp.TorsoToRightLeg.To = Vector2.new(rLeg.X, rLeg.Y)
                        else
                            esp.HeadToTorso.Visible = false; esp.TorsoToLeftArm.Visible = false; esp.TorsoToRightArm.Visible = false; esp.TorsoToLeftLeg.Visible = false; esp.TorsoToRightLeg.Visible = false
                        end
                    else
                        esp.Box.Visible = false; esp.Tracer.Visible = false; esp.HealthBar.Visible = false; esp.HealthText.Visible = false; esp.DistanceText.Visible = false; esp.NameText.Visible = false
                        esp.HeadToTorso.Visible = false; esp.TorsoToLeftArm.Visible = false; esp.TorsoToRightArm.Visible = false; esp.TorsoToLeftLeg.Visible = false; esp.TorsoToRightLeg.Visible = false
                    end
                end

                -- Chams (Free)
                local Highlight = char:FindFirstChild("HubHighlight")
                if Settings.Wallhack then
                    if not Highlight then
                        Highlight = Instance.new("Highlight")
                        Highlight.Name = "HubHighlight"
                        Highlight.FillColor = Color3.fromRGB(150, 40, 220)
                        Highlight.OutlineColor = Color3.fromRGB(255, 120, 0)
                        Highlight.FillTransparency = 0.5
                        Highlight.Parent = char
                    end
                else
                    if Highlight then Highlight:Destroy() end
                end
            end
        end
    end
end)
