function AddCommandButtons(panel, commands, y)
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

    return y
end

function AddCommandCheckBoxes(panel, commands, y)
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

    return y
end

function AddCommandTextEntries(panel, commands, defaults, values, y)
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

    return y
end

function AddInformationButtons(panel, labels, y)
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

    return y
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
        'Commands',
        'AI',
        'AI',
        '',
        '',
        function(panel)
            panel:ClearControls()

            y = 0

            y = AddCommandButtons(
              panel,
              {
                'ai_disable',
                'ai_nodes',
                'npc_reset',
              },
              y
            )

            y = AddCommandCheckBoxes(
              panel,
              {
                'ai_block_damage',
                'ai_expression_optimization',
                'ai_ignoreplayers',
                'npc_citizen_auto_player_squad',
              },
              y
            )
        end
      )

      spawnmenu.AddToolMenuOption(
        'iterami',
        'Commands',
        'Entities',
        'Entities',
        '',
        '',
        function(panel)
            panel:ClearControls()

            y = 0

            y = AddCommandButtons(
              panel,
              {
                'ch_createairboat',
                'ch_createjalopy',
                'ch_createjeep',
                'lua_reloadents',
                'vehicle_flushscript',
              },
              y
            )

            y = AddCommandCheckBoxes(
              panel,
              {
                'cl_draw_airboat_wake',
                'cl_ejectbrass',
                'cl_ragdoll_collide',
                'r_drawentities',
                'r_eyes',
                'r_teeth',
                'sv_footsteps',
                'violence_ablood',
                'violence_agibs',
                'violence_hblood',
                'violence_hgibs',
              },
              y
            )
        end
      )

      spawnmenu.AddToolMenuOption(
        'iterami',
        'Commands',
        'Environment',
        'Environment',
        '',
        '',
        function(panel)
            panel:ClearControls()

            y = 0;

            y = AddCommandButtons(
              panel,
              {
                'effects_reload',
                'mat_reloadallmaterials',
                'mat_reloadtextures',
                'r_cleardecals',
                'stopsound',
              },
              y
            )

            y = AddCommandCheckBoxes(
              panel,
              {
                'cl_show_splashes',
                'explosion_dlight',
                'fog_enable_water_fog',
                'mat_drawwater',
                'mat_fullbright',
                'mat_wireframe',
                'r_3dsky',
                'r_drawdecals',
                'r_drawdisp',
                'r_drawmodeldecals',
                'r_drawparticles',
                'r_drawrain',
                'r_drawropes',
                'r_drawskybox',
                'r_drawworld',
                'r_shadows',
                'r_skybox',
                'r_snowenable',
                'smoothstairs',
                'vcollide_wireframe',
              },
              y
            )

            y = AddCommandTextEntries(
              panel,
              {
                'air_density',
                'cl_windspeed',
                'r_decals',
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
              },
              {
                2,
                0,
                2048,
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
              },
              {
                physenv.GetAirDensity(),
                GetConVar('cl_windspeed'):GetFloat(),
                GetConVar('r_decals'):GetFloat(),
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
              },
              y
            )
        end
      )

      spawnmenu.AddToolMenuOption(
        'iterami',
        'Commands',
        'GMod',
        'GMod',
        '',
        '',
        function(panel)
            panel:ClearControls()

            y = 0

            y = AddCommandButtons(
              panel,
              {
                'disconnect',
                'endmovie',
                'flush',
                'language_reload',
                'menu_reload',
                'pause',
                'restart',
                'shake',
                'shake_stop',
                'startmovie',
                'vox_reload',
              },
              y
            )

            y = AddCommandCheckBoxes(
              panel,
              {
                'cl_localnetworkbackdoor',
                'cl_showfps',
                'cl_showpos',
                'net_graph',
                'sv_allow_votes',
                'sv_alltalk',
                'sv_voiceenable',
              },
              y
            )
        end
      )

      spawnmenu.AddToolMenuOption(
        'iterami',
        'Commands',
        'Information',
        'Information',
        '',
        '',
        function(panel)
            panel:ClearControls()

            y = 0

            y = AddInformationButtons(
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
              },
              y
            )
        end
      )

      spawnmenu.AddToolMenuOption(
        'iterami',
        'Commands',
        'Players',
        'Players',
        '',
        '',
        function(panel)
            panel:ClearControls()

            y = 0

            y = AddCommandButtons(
              panel,
              {
                'buddha',
                'camortho',
                'explode',
                'firstperson',
                'givecurrentammo',
                'god',
                'hud_reloadscheme',
                'kill',
                'noclip',
                'notarget',
                'thirdperson',
              },
              y
            )

            y = AddCommandCheckBoxes(
              panel,
              {
                'cl_drawhud',
                'cl_playerspraydisable',
                'coop',
                'r_drawviewmodel',
                'sv_ladder_useonly',
                'thirdperson_platformer',
                'thirdperson_screenspace',
              },
              y
            )

            y = AddCommandTextEntries(
              panel,
              {
                'hurtme',
                'impulse',
                'player_throwforce',
                'sv_noclipspeed',
                'zoom_sensitivity_ratio',
              },
              {
                '',
                '',
                1000,
                5,
                1,
              },
              {
                '',
                '',
                GetConVar('player_throwforce'):GetFloat(),
                GetConVar('sv_noclipspeed'):GetFloat(),
                GetConVar('zoom_sensitivity_ratio'):GetFloat(),
              },
              y
            )
        end
      )
  end
)

print('GMod-iterami-Addon loaded')
