function AddCommandButtons(panel, commands)
    y = 0

    for i, command in ipairs(commands) do
        y = y + 23

        CreateButton(
          panel,
          command,
          0,
          y,
          function()
              RunConsoleCommand(
                command,
                ''
              )
          end
        )
    end
end

function AddCommandCheckBoxes(panel, commands)
    y = 0

    for i, command in ipairs(commands) do
        y = y + 23

        CreateCheckBox(
          panel,
          GetConVar(command):GetInt(),
          0,
          y,
          function(this)
              local value = 0
              if this:GetChecked() then
                  value = 1
              end

              RunConsoleCommand(
                command,
                value
              )
          end
        )

        CreateTextLabel(
          panel,
          command,
          16,
          y
        )
    end
end

function AddCommandTextEntries(panel, commands, defaults, values)
    y = 0

    for i, command in ipairs(commands) do
        y = y + 23

        CreateTextEntry(
          panel,
          command,
          defaults[i],
          values[i],
          0,
          y,
          function(self)
              RunConsoleCommand(
                command,
                self:GetValue()
              )
          end
        )
    end
end

function AddInformationButtons(panel, labels)
    y = 0

    for i, label in ipairs(labels) do
        y = y + 23

        local compiled = CompileString(
          'return ' .. labels[i],
          'info',
          false
        )

        local textLabel = CreateTextLabel(
          panel,
          tostring(compiled()),
          155,
          y
        )

        CreateButton(
          panel,
          label,
          0,
          y,
          function()
              textLabel:SetText(tostring(compiled()))
              textLabel:SizeToContents()
          end
        )
    end
end

function CreateButton(panel, text, x, y, onclick)
    local button = vgui.Create(
      'DButton',
      panel
    )
    button:SetSize(
      150,
      23
    )
    button:SetPos(
      x,
      y
    )
    button:SetText(text)
    button.DoClick = onclick

    return button
end

function CreateCheckBox(panel, value, x, y, onchange)
    local button = vgui.Create(
      'DCheckBox',
      panel
    )
    button:SetPos(
      x,
      y
    )
    button:SetValue(value)
    button.OnChange = onchange

    return button
end

function CreateTextEntry(panel, text, default, value, x, y, onenter)
    local textEntry = vgui.Create(
      'DTextEntry',
      panel
    )
    textEntry:SetSize(
      50,
      23
    )
    textEntry:SetPos(
      x,
      y
    )
    textEntry:SetText(value)
    textEntry.OnEnter = onenter

    CreateTextLabel(
      panel,
      text .. ' ' .. default,
      x + 51,
      y
    )

    return textEntry
end

function CreateTextLabel(panel, value, x, y)
    local textLabel = vgui.Create(
      'DLabel',
      panel
    )
    textLabel:SetPos(
      x,
      y
    )
    textLabel:SetText(value)
    textLabel:SetTextColor(Color(0, 0, 0))
    textLabel:SizeToContents()

    return textLabel
end

hook.Add(
  'PopulateToolMenu',
  'CustomMenuSettings',
  function()
      spawnmenu.AddToolMenuOption(
        'iterami',
        'iterami',
        'Command Buttons',
        'Command Buttons',
        '',
        '',
        function(panel)
            panel:ClearControls()

            AddCommandButtons(
              panel,
              {
                'ai_disable',
                'ai_nodes',
                'buddha',
                'ch_createairboat',
                'ch_createjalopy',
                'ch_createjeep',
                'disconnect',
                'endmovie',
                'firstperson',
                'flush',
                'givecurrentammo',
                'god',
                'kill',
                'noclip',
                'notarget',
                'pause',
                'r_cleardecals',
                'restart',
                'shake',
                'startmovie',
                'thirdperson',
              }
            )
        end
      )

      spawnmenu.AddToolMenuOption(
        'iterami',
        'iterami',
        'Command Checkboxes',
        'Command Checkboxes',
        '',
        '',
        function(panel)
            panel:ClearControls()

            AddCommandCheckBoxes(
              panel,
              {
                'ai_expression_optimization',
                'ai_ignoreplayers',
                'cl_draw_airboat_wake',
                'cl_drawhud',
                'cl_ejectbrass',
                'cl_localnetworkbackdoor',
                'cl_ragdoll_collide',
                'cl_show_splashes',
                'cl_showfps',
                'cl_showpos',
                'fog_enable_water_fog',
                'mat_drawwater',
                'mat_wireframe',
                'net_graph',
                'npc_citizen_auto_player_squad',
                'r_3dsky',
                'r_drawdecals',
                'r_drawentities',
                'r_drawparticles',
                'r_drawrain',
                'r_drawskybox',
                'r_drawviewmodel',
                'r_drawworld',
                'r_eyes',
                'r_shadows',
                'r_skybox',
                'r_snowenable',
                'r_teeth',
                'sv_allow_votes',
                'sv_alltalk',
                'sv_footsteps',
                'sv_ladder_useonly',
                'sv_voiceenable',
                'vcollide_wireframe',
                'violence_ablood',
                'violence_agibs',
                'violence_hblood',
                'violence_hgibs',
              }
            )
        end
      )

      spawnmenu.AddToolMenuOption(
        'iterami',
        'iterami',
        'Command Text Entries',
        'Command Text Entries',
        '',
        '',
        function(panel)
            panel:ClearControls()

            AddCommandTextEntries(
              panel,
              {
                'air_density',
                'hurtme',
                'impulse',
                'player_throwforce',
                'r_rainalpha',
                'r_raindensity',
                'r_rainlength',
                'r_rainspeed',
                'r_rainwidth',
                'r_snowfallspeed',
                'r_snowparticles',
                'sv_friction',
                'sv_gravity',
                'sv_maxvelocity',
                'sv_noclipspeed',
              },
              {
                2,
                '',
                '',
                1000,
                0.25,
                0.001,
                0.075,
                1500,
                2,
                1.5,
                500,
                8,
                600,
                3500,
                5,
              },
              {
                physenv.GetAirDensity(),
                '',
                '',
                GetConVar('player_throwforce'):GetFloat(),
                GetConVar('r_rainalpha'):GetFloat(),
                GetConVar('r_raindensity'):GetFloat(),
                GetConVar('r_rainlength'):GetFloat(),
                GetConVar('r_rainspeed'):GetFloat(),
                GetConVar('r_rainwidth'):GetFloat(),
                GetConVar('r_snowfallspeed'):GetFloat(),
                GetConVar('r_snowparticles'):GetFloat(),
                GetConVar('sv_friction'):GetFloat(),
                GetConVar('sv_gravity'):GetFloat(),
                GetConVar('sv_maxvelocity'):GetFloat(),
                GetConVar('sv_noclipspeed'):GetFloat(),
              }
            )
        end
      )

      spawnmenu.AddToolMenuOption(
        'iterami',
        'iterami',
        'Information',
        'Information',
        '',
        '',
        function(panel)
            panel:ClearControls()

            AddInformationButtons(
              panel,
              {
                'engine.ActiveGamemode()',
                'engine.IsPlayingDemo()',
                'engine.IsRecordingDemo()',
                'engine.TickCount()',
                '1 / engine.TickInterval()',
                'Entity(1):GetFOV()',
                'Entity(1):GetName()',
                'Entity(1):IsAdmin()',
                'Entity(1):IsSuperAdmin()',
                'ents.GetCount()',
                'frame_blend.IsActive()',
                'game.GetIPAddress()',
                'game.GetMap()',
                'game.GetSkillLevel()',
                'game.GetTimeScale()',
                'game.IsDedicated()',
                'game.MaxPlayers()',
                'game.SinglePlayer()',
                'GetHostName()',
                'gui.IsConsoleVisible()',
                'gui.IsGameUIVisible()',
                'os.time()',
                'player:GetCount()',
                'system.AppTime()',
                'system.BatteryPower()',
                'system.GetCountry()',
                'system.IsLinux()',
                'system.IsOSX()',
                'system.IsWindowed()',
                'system.IsWindows()',
              }
            )
        end
      )
  end
)

print('GMod-iterami-Addon loaded')
