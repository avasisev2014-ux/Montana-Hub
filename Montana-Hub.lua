-- Montano Hub | v0.9.1 (Halloween Purple Edition 🎃💜)
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Хэллоуинская заставка
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MontanoLoader"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(1, 0, 1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 10, 30) -- Глубокий фиолетово-ночной фон
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 600, 0, 50)
Title.Position = UDim2.new(0.5, -300, 0.4, -40)
Title.Text = "🎃 MONTANO HUB: v0.9.1 HALLOWEEN 🕷️"
Title.TextColor3 = Color3.fromRGB(255, 120, 0) -- Тыквенный акцент
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1
Title.Parent = Frame

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0, 400, 0, 30)
Subtitle.Position = UDim2.new(0.5, -200, 0.4, 10)
Subtitle.Text = "Добро пожаловать в темноту, " .. LocalPlayer.Name .. "..."
Subtitle.TextColor3 = Color3.fromRGB(180, 80, 255) -- Магический фиолетовый
Subtitle.TextSize = 16
Subtitle.Font = Enum.Font.Gotham
Subtitle.BackgroundTransparency = 1
Subtitle.Parent = Frame

local ConfirmBtn = Instance.new("TextButton")
ConfirmBtn.Size = UDim2.new(0, 240, 0, 50)
ConfirmBtn.Position = UDim2.new(0.5, -120, 0.55, 0)
ConfirmBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 220)
ConfirmBtn.Text = "ВОЙТИ В ХАБ 🎃"
ConfirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmBtn.TextSize = 16
ConfirmBtn.Font = Enum.Font.GothamBold
ConfirmBtn.Parent = Frame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ConfirmBtn

-- Звук
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
            CurrentTheme = "Amethyst", -- Фиолетовая тема по умолчанию (Halloween стиль!)
            AimbotEnabled = false,
            AimMode = "Аимбот",
            Wallhack = true,
            ESPBoxes = false,
            ESPTracers = false,
            ESPHealth = false,
            ESPDistance = true,
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

    local Locales = {
        RU = {
            WindowTitle = "🎃 Montano Hub v0.9.1 [Halloween] 🕷️",
            Loading = "Загрузка магии...",
            TabHome = "Главная",
            TabCombat = "Бой",
            TabVisuals = "Визуал",
            TabMovement = "Движение",
            TabRadio = "Радио",
            TabSettings = "Настройки",
            HomeSection = "Информация о проекте (v0.9.1)",
            VersionInfo = "Montano Hub v0.9.1 🎃\nПраздничное обновление с фиолетовой темой!\nTelegram: https://t.me/Montanahub123",
            CopyTgBtn = "📋 Скопировать ссылку на Telegram",
            CopyNotify = "Ссылка скопирована в буфер обмена!",
            ToggleAimbot = "Включить Аимбот",
            WallCheck = "Проверка стен",
            ModeLabel = "Режим работы",
            ModeAimbot = "Аимбот",
            ModeSilent = "Сайлент Аим",
            TargetPart = "Часть тела",
            AimType = "Тип наводки",
            AimSmooth = "Плавный",
            AimSnap = "Резкий",
            Smoothness = "Плавность наводки",
            FOVSize = "Размер круга FOV (от 20 px)",
            ShowFOVToggle = "Отображать круг FOV",
            FOVColorLabel = "Цвет круга FOV",
            Wallhack = "Валхак (Chams)",
            ESPBoxes = "Боксы (ESP Box)",
            ESPTracers = "Линии (ESP Tracers)",
            ESPHealth = "Здоровье (ESP HP)",
            ESPDistance = "Дистанция в метрах (🎃)",
            SpeedToggle = "Включить Speedhack",
            SpeedSlider = "Скорость бега",
            JumpToggle = "Включить высокий прыжок",
            JumpSlider = "Сила прыжка",
            InfJumpToggle = "Бесконечный прыжок",
            NoclipToggle = "Проход сквозь стены (Noclip)",
            RadioID = "Код музыки (Audio ID)",
            RadioPlay = "Воспроизведение музыки",
            RadioVol = "Громкость музыки",
            LangLabel = "Выбор языка",
            ThemeLabel = "Выбор темы (Фиолетовая по умолчанию 🟣)",
            ApplyBtn = "Применить изменения"
        },
        UA = {
            WindowTitle = "🎃 Montano Hub v0.9.1 [Halloween] 🕷️",
            Loading = "Завантаження магії...",
            TabHome = "Головна",
            TabCombat = "Бій",
            TabVisuals = "Візуал",
            TabMovement = "Рух",
            TabRadio = "Радіо",
            TabSettings = "Налаштування",
            HomeSection = "Інформація про проєкт (v0.9.1)",
            VersionInfo = "Montano Hub v0.9.1 🎃\nСвяткове оновлення з фіолетовою темою!\nTelegram: https://t.me/Montanahub123",
            CopyTgBtn = "📋 Скопіювати посилання на Telegram",
            CopyNotify = "Посилання скопійовано!",
            ToggleAimbot = "Увімкнути Аімбот",
            WallCheck = "Перевірка стін",
            ModeLabel = "Режим роботи",
            ModeAimbot = "Аімбот",
            ModeSilent = "Сайлент Аім",
            TargetPart = "Частина тіла",
            AimType = "Тип наведення",
            AimSmooth = "Плавний",
            AimSnap = "Різкий",
            Smoothness = "Плавність наведення",
            FOVSize = "Розмір кола FOV (від 20 px)",
            ShowFOVToggle = "Відображати коло FOV",
            FOVColorLabel = "Колір кола FOV",
            Wallhack = "Валхак (Chams)",
            ESPBoxes = "Бокси (ESP Box)",
            ESPTracers = "Лінії (ESP Tracers)",
            ESPHealth = "Здоров'я (ESP HP)",
            ESPDistance = "Дистанція в метрах (🎃)",
            SpeedToggle = "Увімкнути Speedhack",
            SpeedSlider = "Швидкість бігу",
            JumpToggle = "Увімкнути високий стрибок",
            JumpSlider = "Сила стрибка",
            InfJumpToggle = "Нескінченний стрибок",
            NoclipToggle = "Прохід крізь стіни (Noclip)",
            RadioID = "Код музыки (Audio ID)",
            RadioPlay = "Відтворення музики",
            RadioVol = "Гучність музики",
            LangLabel = "Вибір мови",
            ThemeLabel = "Вибір теми",
            ApplyBtn = "Застосувати зміни"
        },
        EN = {
            WindowTitle = "🎃 Montano Hub v0.9.1 [Halloween] 🕷️",
            Loading = "Loading Magic...",
            TabHome = "Home",
            TabCombat = "Combat",
            TabVisuals = "Visuals",
            TabMovement = "Movement",
            TabRadio = "Radio",
            TabSettings = "Settings",
            HomeSection = "Project Information (v0.9.1)",
            VersionInfo = "Montano Hub v0.9.1 🎃\nSpecial Purple Theme Update!\nTelegram: https://t.me/Montanahub123",
            CopyTgBtn = "📋 Copy Telegram Link",
            CopyNotify = "Telegram link copied!",
            ToggleAimbot = "Enable Aimbot",
            WallCheck = "Wall Check",
            ModeLabel = "Mode",
            ModeAimbot = "Aimbot",
            ModeSilent = "Silent Aim",
            TargetPart = "Target Bone",
            AimType = "Aim Type",
            AimSmooth = "Smooth",
            AimSnap = "Snap",
            Smoothness = "Aim Smoothness",
            FOVSize = "FOV Circle Size (from 20 px)",
            ShowFOVToggle = "Show FOV Circle",
            FOVColorLabel = "FOV Circle Color",
            Wallhack = "Wallhack (Chams)",
            ESPBoxes = "Boxes (ESP Box)",
            ESPTracers = "Tracers (ESP Lines)",
            ESPHealth = "Health Bar (ESP HP)",
            ESPDistance = "Distance in meters (🎃)",
            SpeedToggle = "Enable Speedhack",
            SpeedSlider = "Walk Speed",
            JumpToggle = "Enable High Jump",
            JumpSlider = "Jump Power",
            InfJumpToggle = "Infinite Jump",
            NoclipToggle = "Noclip (Through Walls)",
            RadioID = "Music ID",
            RadioPlay = "Play Music",
            RadioVol = "Music Volume",
            LangLabel = "Language Selection",
            ThemeLabel = "Theme Selection",
            ApplyBtn = "Apply Changes"
        }
    }

    local T = Locales[Settings.CurrentLang]

    local Window = Rayfield:CreateWindow({
       Name = T.WindowTitle,
       LoadingTitle = T.Loading,
       ConfigurationSaving = { Enabled = false },
       KeySystem = false,
       Theme = Settings.CurrentTheme
    })

    Rayfield:Notify({
        Title = "🎃 Montano Hub v0.9.1",
        Content = "Фиолетовая хэллоуинская тема активна!",
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
    HomeTab:CreateSection(T.HomeSection)
    HomeTab:CreateParagraph({Title = "🎃 Montano Hub [v0.9.1 Halloween]", Content = T.VersionInfo})
    HomeTab:CreateButton({
        Name = T.CopyTgBtn,
        Callback = function()
            setclipboard("https://t.me/Montanahub123")
            Rayfield:Notify({
                Title = "Montano Hub 🎃",
                Content = T.CopyNotify,
                Duration = 3.5,
                Image = 6023426915
            })
        end,
    })

    -- ВКЛАДКА: COMBAT
    local CombatTab = Window:CreateTab(T.TabCombat, 4483362458)
    CombatTab:CreateToggle({Name = T.ToggleAimbot, CurrentValue = Settings.AimbotEnabled, Callback = function(Value) Settings.AimbotEnabled = Value end})
    CombatTab:CreateToggle({Name = T.WallCheck, CurrentValue = Settings.WallCheck, Callback = function(Value) Settings.WallCheck = Value end})
    CombatTab:CreateDropdown({Name = T.ModeLabel, Options = {T.ModeAimbot, T.ModeSilent}, CurrentOption = {T.ModeAimbot}, Callback = function(Option)
        if Option[1]:find("Сайлент") or Option[1]:find("Silent") then Settings.AimMode = "Сайлент Аим" else Settings.AimMode = "Аимбот" end
    end})
    CombatTab:CreateDropdown({Name = T.TargetPart, Options = {"Голова", "Торс (Грудь)", "Левая нога", "Правая нога"}, CurrentOption = {"Голова"}, Callback = function(Option)
        local selected = Option[1]
        if selected == "Голова" then Settings.TargetPart = "Head"
        elseif selected == "Торс (Грудь)" then Settings.TargetPart = "HumanoidRootPart"
        elseif selected == "Левая нога" then Settings.TargetPart = "Left Leg"
        elseif selected == "Правая нога" then Settings.TargetPart = "Right Leg" end
    end})
    CombatTab:CreateDropdown({Name = T.AimType, Options = {T.AimSmooth, T.AimSnap}, CurrentOption = {Settings.AimType == "Snap" and T.AimSnap or T.AimSmooth}, Callback = function(Option)
        if Option[1]:find("Резкий") or Option[1]:find("Snap") or Option[1]:find("Різкий") then Settings.AimType = "Snap" else Settings.AimType = "Smooth" end
    end})
    CombatTab:CreateSlider({Name = T.Smoothness, Range = {1, 20}, Increment = 1, Suffix = " шаг", CurrentValue = Settings.Smoothness, Callback = function(Value) Settings.Smoothness = Value end})
    
    -- FOV от 20 px
    CombatTab:CreateSlider({Name = T.FOVSize, Range = {20, 400}, Increment = 5, Suffix = " px", CurrentValue = Settings.FOV, Callback = function(Value) Settings.FOV = Value; FOVCircle.Radius = Value end})

    -- ВКЛАДКА: VISUALS
    local VisualsTab = Window:CreateTab(T.TabVisuals, 4483362458)
    VisualsTab:CreateToggle({Name = T.Wallhack, CurrentValue = Settings.Wallhack, Callback = function(Value) Settings.Wallhack = Value end})
    VisualsTab:CreateToggle({Name = T.ESPBoxes, CurrentValue = Settings.ESPBoxes, Callback = function(Value) Settings.ESPBoxes = Value end})
    VisualsTab:CreateToggle({Name = T.ESPTracers, CurrentValue = Settings.ESPTracers, Callback = function(Value) Settings.ESPTracers = Value end})
    VisualsTab:CreateToggle({Name = T.ESPHealth, CurrentValue = Settings.ESPHealth, Callback = function(Value) Settings.ESPHealth = Value end})
    VisualsTab:CreateToggle({Name = T.ESPDistance, CurrentValue = Settings.ESPDistance, Callback = function(Value) Settings.ESPDistance = Value end})
    VisualsTab:CreateToggle({Name = T.ShowFOVToggle, CurrentValue = Settings.ShowFOV, Callback = function(Value) Settings.ShowFOV = Value end})
    VisualsTab:CreateDropdown({Name = T.FOVColorLabel, Options = {"Тыквенный (Оранжевый)", "Кровавый (Красный)", "Магический (Зеленый)", "Призрачный (Белый)"}, CurrentOption = {"Тыквенный (Оранжевый)"}, Callback = function(Option)
        local c = Option[1]
        if c:find("Кровавый") then Settings.FOVColor = Color3.fromRGB(255, 0, 0)
        elseif c:find("Магический") then Settings.FOVColor = Color3.fromRGB(0, 255, 100)
        elseif c:find("Призрачный") then Settings.FOVColor = Color3.fromRGB(255, 255, 255)
        else Settings.FOVColor = Color3.fromRGB(255, 120, 0) end
        FOVCircle.Color = Settings.FOVColor
    end})

    -- ВКЛАДКА: MOVEMENT
    local MovementTab = Window:CreateTab(T.TabMovement, 4483362458)
    MovementTab:CreateToggle({Name = T.SpeedToggle, CurrentValue = Settings.SpeedHackEnabled, Callback = function(Value) Settings.SpeedHackEnabled = Value end})
    MovementTab:CreateSlider({Name = T.SpeedSlider, Range = {16, 200}, Increment = 2, Suffix = " speed", CurrentValue = Settings.WalkSpeed, Callback = function(Value) Settings.WalkSpeed = Value end})
    MovementTab:CreateToggle({Name = T.JumpToggle, CurrentValue = Settings.JumpHackEnabled, Callback = function(Value) Settings.JumpHackEnabled = Value end})
    MovementTab:CreateSlider({Name = T.JumpSlider, Range = {50, 300}, Increment = 5, Suffix = " power", CurrentValue = Settings.JumpPower, Callback = function(Value) Settings.JumpPower = Value end})
    MovementTab:CreateToggle({Name = T.InfJumpToggle, CurrentValue = Settings.InfJump, Callback = function(Value) Settings.InfJump = Value end})
    MovementTab:CreateToggle({Name = T.NoclipToggle, CurrentValue = Settings.Noclip, Callback = function(Value) Settings.Noclip = Value end})

    -- ВКЛАДКА: RADIO
    local MusicTab = Window:CreateTab(T.TabRadio, 4483362458)
    MusicTab:CreateInput({Name = T.RadioID, PlaceholderText = "Введите ID трека...", RemoveTextAfterFocusLost = false, Callback = function(Text)
        local MusicID = tonumber(Text)
        if MusicID then RadioSound.SoundId = "rbxassetid://" .. tostring(MusicID); RadioSound:Play() end
    end})
    MusicTab:CreateToggle({Name = T.RadioPlay, CurrentValue = RadioSound.IsPlaying, Callback = function(Value)
        if Value then RadioSound:Resume() else RadioSound:Pause() end
    end})
    MusicTab:CreateSlider({Name = T.RadioVol, Range = {0, 10}, Increment = 1, Suffix = "", CurrentValue = math.floor(RadioSound.Volume * 5), Callback = function(Value) RadioSound.Volume = Value / 5 end})

    -- ВКЛАДКА: SETTINGS (С выбором тем, где фиолетовая Amethyst — первая/по умолчанию)
    local SettingsTab = Window:CreateTab(T.TabSettings, 4483362458)
    SettingsTab:CreateDropdown({Name = T.LangLabel, Options = {"Русский", "Українська", "English"}, CurrentOption = {Settings.CurrentLang == "UA" and "Українська" or (Settings.CurrentLang == "EN" and "English" or "Русский")}, Callback = function(Option)
        if Option[1] == "Українська" then Settings.CurrentLang = "UA" elseif Option[1] == "English" then Settings.CurrentLang = "EN" else Settings.CurrentLang = "RU" end
    end})
    SettingsTab:CreateDropdown({Name = T.ThemeLabel, Options = {"Фиолетовая (Amethyst - Halloween 🟣)", "Темная (Default)", "Светлая (Light)", "Серая (Serenity)", "Синяя (DarkBlue)"}, CurrentOption = {"Фиолетовая (Amethyst - Halloween 🟣)"}, Callback = function(Option)
        local themeName = Option[1]
        if themeName:find("Фиолетовая") or themeName:find("Amethyst") then Settings.CurrentTheme = "Amethyst"
        elseif themeName:find("Светлая") or themeName:find("Light") then Settings.CurrentTheme = "Light"
        elseif themeName:find("Серая") or themeName:find("Serenity") then Settings.CurrentTheme = "Serenity"
        elseif themeName:find("Синяя") or themeName:find("DarkBlue") then Settings.CurrentTheme = "DarkBlue"
        else Settings.CurrentTheme = "Default" end
    end})
    SettingsTab:CreateButton({Name = T.ApplyBtn, Callback = function()
        Rayfield:Destroy()
    end})

    UserInputService.JumpRequest:Connect(function()
        if Settings.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)

    local VirtualUser = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        if Settings.AntiAFK then
            VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
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

    _G.MontanoConnection = RunService.RenderStepped:Connect(function()
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        FOVCircle.Visible = Settings.AimbotEnabled and Settings.ShowFOV

        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if Settings.SpeedHackEnabled then hum.WalkSpeed = Settings.WalkSpeed end
            if Settings.JumpHackEnabled then hum.UseJumpPower = true; hum.JumpPower = Settings.JumpPower end
        end

        if Settings.Noclip then
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end

        if Settings.AimbotEnabled and Settings.AimMode == "Аимбот" then
            local Target = GetClosestTarget()
            if Target then
                local TargetCFrame = CFrame.new(Camera.CFrame.Position, Target.Position)
                if Settings.AimType == "Snap" then Camera.CFrame = TargetCFrame else Camera.CFrame = Camera.CFrame:Lerp(TargetCFrame, 1 / Settings.Smoothness) end
            end
        end

        local activePlayers = {}

        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer then
                activePlayers[v] = true
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
                            DistanceText = Drawing.new("Text")
                        }
                        local esp = ESPVisuals[v]
                        esp.Box.Thickness = 1.5
                        esp.Box.Filled = false
                        esp.Tracer.Thickness = 1
                        esp.HealthBar.Thickness = 2.5
                        esp.HealthText.Size = 13
                        esp.HealthText.Center = true
                        esp.HealthText.Outline = true
                        esp.HealthText.Color = Color3.fromRGB(0, 255, 0)

                        esp.DistanceText.Size = 13
                        esp.DistanceText.Center = true
                        esp.DistanceText.Outline = true
                        esp.DistanceText.Color = Color3.fromRGB(255, 120, 0)
                    end

                    local esp = ESPVisuals[v]
                    local head = char:FindFirstChild("Head")

                    if hum.Health > 0 and head then
                        local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)

                        if onScreen then
                            local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                            local legPos = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))
                            local height = math.abs(headPos.Y - legPos.Y)
                            local width = height / 2

                            -- 1. Боксы
                            if Settings.ESPBoxes then
                                esp.Box.Visible = true
                                esp.Box.Size = Vector2.new(width, height)
                                esp.Box.Position = Vector2.new(vector.X - width / 2, headPos.Y)
                                esp.Box.Color = Color3.fromRGB(255, 120, 0)
                            else
                                esp.Box.Visible = false
                            end

                            -- 2. Трейсеры
                            if Settings.ESPTracers then
                                esp.Tracer.Visible = true
                                esp.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                                esp.Tracer.To = Vector2.new(vector.X, legPos.Y)
                                esp.Tracer.Color = Color3.fromRGB(255, 120, 0)
                            else
                                esp.Tracer.Visible = false
                            end

                            -- 3. HP
                            if Settings.ESPHealth then
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

                            -- 4. Дистанция в метрах
                            if Settings.ESPDistance and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                local myRoot = LocalPlayer.Character.HumanoidRootPart
                                local distStuds = (myRoot.Position - rootPart.Position).Magnitude
                                local distMeters = math.floor(distStuds / 3.57)

                                esp.DistanceText.Visible = true
                                esp.DistanceText.Text = distMeters .. "m 🎃"
                                esp.DistanceText.Position = Vector2.new(vector.X, legPos.Y + 2)
                            else
                                esp.DistanceText.Visible = false
                            end
                        else
                            esp.Box.Visible = false
                            esp.Tracer.Visible = false
                            esp.HealthBar.Visible = false
                            esp.HealthText.Visible = false
                            esp.DistanceText.Visible = false
                        end
                    else
                        esp.Box.Visible = false
                        esp.Tracer.Visible = false
                        esp.HealthBar.Visible = false
                        esp.HealthText.Visible = false
                        esp.DistanceText.Visible = false
                    end

                    -- Chams
                    local Highlight = char:FindFirstChild("HubHighlight")
                    if Settings.Wallhack then
                        if not Highlight then
                            Highlight = Instance.new("Highlight")
                            Highlight.Name = "HubHighlight"
                            Highlight.FillColor = Color3.fromRGB(150, 40, 220)
                            Highlight.OutlineColor = Color3.fromRGB(255, 120, 0)
                            Highlight.FillTransparency = 0.5
                            Highlight.OutlineTransparency = 0
                            Highlight.Parent = char
                        end
                    else
                        if Highlight then Highlight:Destroy() end
                    end
                else
                    if ESPVisuals[v] then
                        ESPVisuals[v].Box.Visible = false
                        ESPVisuals[v].Tracer.Visible = false
                        ESPVisuals[v].HealthBar.Visible = false
                        ESPVisuals[v].HealthText.Visible = false
                        ESPVisuals[v].DistanceText.Visible = false
                    end
                end
            end
        end

        for player, _ in pairs(ESPVisuals) do
            if not activePlayers[player] then
                RemoveESP(player)
            end
        end
    end)
end

ConfirmBtn.MouseButton1Click:Connect(function()
    LoadHub()
end)
