function AddCommandButtons(panel, commands, y)
    for i, command in ipairs(commands) do
        y = y + 23

        CreateButton(
          panel,
          command,
          0,
          y,
          290,
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
              local value = '0'
              if this:GetChecked() then
                  value = '1'
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
          end,
          40
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
          150,
          function()
              textLabel:SetText(tostring(compiled()))
              textLabel:SizeToContents()
          end
        )
    end

    return y
end

function CreateButton(panel, text, x, y, width, onclick)
    local button = vgui.Create(
      'DButton',
      panel
    )
    button:SetSize(
      width,
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

function CreateTextEntry(panel, text, default, value, x, y, onenter, width)
    local textEntry = vgui.Create(
      'DTextEntry',
      panel
    )
    textEntry:SetSize(
      width,
      23
    )
    textEntry:SetPos(
      x,
      y
    )
    textEntry:SetText(value)
    textEntry.OnEnter = onenter

    if text ~= '' then
        CreateTextLabel(
          panel,
          text .. ' ' .. default,
          x + width + 1,
          y
        )
    end

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
        'Honzi',
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
                'ai_resume',
                'npc_bipass',
                'npc_combat',
                'npc_destroy',
                'npc_destroy_unselected',
                'npc_enemies',
                'npc_focus',
                'npc_freeze',
                'npc_heal',
                'npc_kill',
                'npc_nearest',
                'npc_relationships',
                'npc_reset',
                'npc_route',
                'npc_select',
                'npc_steering',
                'npc_steering_all',
                'npc_viewcone',
              },
              y
            )

            y = AddCommandCheckBoxes(
              panel,
              {
                'ai_debug_actbusy',
                'ai_debug_avoidancebounds',
                'ai_debug_directnavprobe',
                'ai_debug_los',
                'ai_debug_shoot_positions',
                'ai_debug_squads',
                'ai_block_damage',
                'ai_expression_optimization',
                'ai_ignoreplayers',
                'ai_inhibit_spawners',
                'g_ai_citizen_show_enemy',
                'g_debug_hunter_charge',
                'g_debug_turret',
                'g_debug_turret_ceiling',
                'g_debug_vortigaunt_aim',
                'hunter_hate_attached_striderbusters',
                'hunter_hate_held_striderbusters',
                'hunter_show_weapon_los_condition',
                'hunter_stand_still',
                'npc_citizen_auto_player_squad',
                'npc_citizen_auto_player_squad_allow_use',
                'npc_citizen_explosive_resist',
                'npc_citizen_insignia',
                'npc_go_do_run',
                'strider_show_focus',
                'strider_show_weapon_los_condition',
                'strider_test_height',
              },
              y
            )

            y = AddCommandTextEntries(
              panel,
              {
                'g_helicopter_bullrush_bomb_enemy_distance',
                'g_helicopter_bullrush_bomb_speed',
                'g_helicopter_bullrush_bomb_time',
                'g_helicopter_bullrush_distance',
                'g_helicopter_bullrush_mega_bomb_health',
                'g_helicopter_bullrush_shoot_height',
                'g_helicopter_chargetime',
                'g_helicopter_idletime',
                'g_helicopter_maxfiringdist',
                'player_squad_autosummon_move_tolerance',
                'player_squad_autosummon_player_tolerance',
                'player_squad_autosummon_time',
                'player_squad_autosummon_time_after_combat',
                'sk_antlion_health',
                'sk_antlion_jump_damage',
                'sk_antlion_swipe_damage',
                'sk_antlionguard_dmg_charge',
                'sk_antlionguard_dmg_shove',
                'sk_antlionguard_health',
                'sk_barnacle_health',
                'sk_citizen_heal_ally',
                'sk_citizen_heal_ally_delay',
                'sk_citizen_heal_ally_min_pct',
                'sk_citizen_heal_player',
                'sk_citizen_heal_player_delay',
                'sk_citizen_heal_player_min_forced',
                'sk_citizen_heal_player_min_pct',
                'sk_citizen_player_stare_dist',
                'sk_citizen_stare_heal_time',
                'sk_headcrab_fast_health',
                'sk_headcrab_health',
                'sk_headcrab_melee_dmg',
                'sk_headcrab_poison_health',
                'sk_helicopter_burstcount',
                'sk_helicopter_drone_speed',
                'sk_helicopter_firingcone',
                'sk_helicopter_grenadedamage',
                'sk_helicopter_grenadeforce',
                'sk_helicopter_grenaderadius',
                'sk_helicopter_health',
                'sk_helicopter_roundsperburst',
                'sk_manhack_health',
                'sk_manhack_melee_dmg',
                'sk_npc_dmg_helicopter',
                'sk_npc_dmg_helicopter_to_plr',
                'sk_rollermine_shock',
                'sk_rollermine_stun_delay',
                'sk_stalker_health',
                'sk_stalker_melee_dmg',
                'sk_vortigaunt_zap_range',
              },
              {
                0,
                850,
                10,
                5000,
                0.25,
                650,
                2,
                3,
                2500,
                20,
                10,
                5,
                8,
                30,
                5,
                5,
                20,
                10,
                500,
                35,
                30,
                20,
                0.9,
                25,
                25,
                10,
                0.6,
                72,
                5,
                10,
                10,
                5,
                35,
                12,
                450,
                20,
                30,
                55000,
                275,
                5600,
                5,
                25,
                20,
                6,
                3,
                10,
                3,
                50,
                5,
                100,
              },
              {
                GetConVar('g_helicopter_bullrush_bomb_enemy_distance'):GetFloat(),
                GetConVar('g_helicopter_bullrush_bomb_speed'):GetFloat(),
                GetConVar('g_helicopter_bullrush_bomb_time'):GetFloat(),
                GetConVar('g_helicopter_bullrush_distance'):GetFloat(),
                GetConVar('g_helicopter_bullrush_mega_bomb_health'):GetFloat(),
                GetConVar('g_helicopter_bullrush_shoot_height'):GetFloat(),
                GetConVar('g_helicopter_chargetime'):GetFloat(),
                GetConVar('g_helicopter_idletime'):GetFloat(),
                GetConVar('g_helicopter_maxfiringdist'):GetFloat(),
                GetConVar('player_squad_autosummon_move_tolerance'):GetFloat(),
                GetConVar('player_squad_autosummon_player_tolerance'):GetFloat(),
                GetConVar('player_squad_autosummon_time'):GetFloat(),
                GetConVar('player_squad_autosummon_time_after_combat'):GetFloat(),
                GetConVar('sk_antlion_health'):GetFloat(),
                GetConVar('sk_antlion_jump_damage'):GetFloat(),
                GetConVar('sk_antlion_swipe_damage'):GetFloat(),
                GetConVar('sk_antlionguard_dmg_charge'):GetFloat(),
                GetConVar('sk_antlionguard_dmg_shove'):GetFloat(),
                GetConVar('sk_antlionguard_health'):GetFloat(),
                GetConVar('sk_barnacle_health'):GetFloat(),
                GetConVar('sk_citizen_heal_ally'):GetFloat(),
                GetConVar('sk_citizen_heal_ally_delay'):GetFloat(),
                GetConVar('sk_citizen_heal_ally_min_pct'):GetFloat(),
                GetConVar('sk_citizen_heal_player'):GetFloat(),
                GetConVar('sk_citizen_heal_player_delay'):GetFloat(),
                GetConVar('sk_citizen_heal_player_min_forced'):GetFloat(),
                GetConVar('sk_citizen_heal_player_min_pct'):GetFloat(),
                GetConVar('sk_citizen_player_stare_dist'):GetFloat(),
                GetConVar('sk_citizen_stare_heal_time'):GetFloat(),
                GetConVar('sk_headcrab_fast_health'):GetFloat(),
                GetConVar('sk_headcrab_health'):GetFloat(),
                GetConVar('sk_headcrab_melee_dmg'):GetFloat(),
                GetConVar('sk_headcrab_poison_health'):GetFloat(),
                GetConVar('sk_helicopter_burstcount'):GetFloat(),
                GetConVar('sk_helicopter_drone_speed'):GetFloat(),
                GetConVar('sk_helicopter_firingcone'):GetFloat(),
                GetConVar('sk_helicopter_grenadedamage'):GetFloat(),
                GetConVar('sk_helicopter_grenadeforce'):GetFloat(),
                GetConVar('sk_helicopter_grenaderadius'):GetFloat(),
                GetConVar('sk_helicopter_health'):GetFloat(),
                GetConVar('sk_helicopter_roundsperburst'):GetFloat(),
                GetConVar('sk_manhack_health'):GetFloat(),
                GetConVar('sk_manhack_melee_dmg'):GetFloat(),
                GetConVar('sk_npc_dmg_helicopter'):GetFloat(),
                GetConVar('sk_npc_dmg_helicopter_to_plr'):GetFloat(),
                GetConVar('sk_rollermine_shock'):GetFloat(),
                GetConVar('sk_rollermine_stun_delay'):GetFloat(),
                GetConVar('sk_stalker_health'):GetFloat(),
                GetConVar('sk_stalker_melee_dmg'):GetFloat(),
                GetConVar('sk_vortigaunt_zap_range'):GetFloat(),
              },
              y
            )
        end
      )

      spawnmenu.AddToolMenuOption(
        'Honzi',
        'Commands',
        'Blocked',
        'Blocked',
        '',
        '',
        function(panel)
            panel:ClearControls()

            y = 0

            y = AddCommandButtons(
              panel,
              {
                '_restart',
                'buildcubemaps',
                'clear',
                'debug_dump',
                'exit',
                'gamemode_reload',
                'gamemode_reload_cl',
                'gameui_hide',
                'hideconsole',
                'quit',
                'quti',
                'toggleconsole',
                'unbindall',
              },
              y
            )

            y = AddCommandCheckBoxes(
              panel,
              {
                'cl_allowdownload',
                'cl_allowupload',
                'cl_mouseenable',
                'cl_software_cursor',
                'con_enable',
                'crosshair',
                'sv_cheats',
                'voice_enable',
                'voice_modenable',
              },
              y
            )
        end
      )

      spawnmenu.AddToolMenuOption(
        'Honzi',
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
                'create_flashlight',
                'ent_cancelpendingentfires',
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
                'ent_messages_draw',
                'mat_surfaceid',
                'mat_surfacemat',
                'r_drawentities',
                'r_drawrenderboxes',
                'r_eyemove',
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

            y = AddCommandTextEntries(
              panel,
              {
                'blink_duration',
                'sk_airboat_drain_rate',
                'sk_airboat_max_ammo',
                'sk_airboat_recharge_rate',
                'sk_battery',
                'sk_healthcharger',
                'sk_healthkit',
                'sk_healthvial',
                'sk_jeep_gauss_damage',
                'sk_suitcharger',
                'sk_suitcharger_citadel',
                'sk_suitcharger_citadel_maxarmor',
              },
              {
                0.2,
                10,
                100,
                15,
                15,
                50,
                25,
                10,
                15,
                30,
                500,
                200,
              },
              {
                GetConVar('blink_duration'):GetFloat(),
                GetConVar('sk_airboat_drain_rate'):GetFloat(),
                GetConVar('sk_airboat_max_ammo'):GetFloat(),
                GetConVar('sk_airboat_recharge_rate'):GetFloat(),
                GetConVar('sk_battery'):GetFloat(),
                GetConVar('sk_healthcharger'):GetFloat(),
                GetConVar('sk_healthkit'):GetFloat(),
                GetConVar('sk_healthvial'):GetFloat(),
                GetConVar('sk_jeep_gauss_damage'):GetFloat(),
                GetConVar('sk_suitcharger'):GetFloat(),
                GetConVar('sk_suitcharger_citadel'):GetFloat(),
                GetConVar('sk_suitcharger_citadel_maxarmor'):GetFloat(),
              },
              y
            )
        end
      )

      spawnmenu.AddToolMenuOption(
        'Honzi',
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
                'showtriggers_toggle',
                'stopsound',
              },
              y
            )

            y = AddCommandCheckBoxes(
              panel,
              {
                'cl_leveloverview',
                'cl_show_splashes',
                'explosion_dlight',
                'fog_enable_water_fog',
                'mat_bumpmap',
                'mat_drawwater',
                'mat_filterlightmaps',
                'mat_filtertextures',
                'mat_fullbright',
                'mat_leafvis',
                'mat_normalmaps',
                'mat_normals',
                'mat_parallaxmap',
                'mat_reversedepth',
                'mat_showlowresimage',
                'mat_showmiplevels',
                'mat_specular',
                'mat_wireframe',
                'mat_yuv',
                'r_3dsky',
                'r_dispbuildable',
                'r_dispwalkable',
                'r_drawbrushmodels',
                'r_drawclipbrushes',
                'r_drawdecals',
                'r_drawdisp',
                'r_drawfuncdetail',
                'r_drawlightcache',
                'r_drawlightinfo',
                'r_drawlights',
                'r_drawmodeldecals',
                'r_drawmodellightorigin',
                'r_drawmodelstatsoverlay',
                'r_drawopaquerenderables',
                'r_drawparticles',
                'r_drawrain',
                'r_drawropes',
                'r_drawskybox',
                'r_drawtranslucentrenderables',
                'r_drawtranslucentworld',
                'r_drawworld',
                'r_lockpvs',
                'r_shadows',
                'r_skybox',
                'r_snowenable',
                'r_visambient',
                'rope_shake',
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
                'hunter_flechette_speed',
                'phys_timescale',
                'r_decals',
                'r_drawmodelstatsoverlaydistance',
                'r_maxdlights',
                'r_rainalpha',
                'r_raindensity',
                'r_rainlength',
                'r_rainspeed',
                'r_rainwidth',
                'r_snowfallspeed',
                'r_snowparticles',
                'scene_maxcaptionradius',
                'sv_friction',
                'sv_gravity',
                'sv_maxvelocity',
              },
              {
                2,
                0,
                2000,
                1,
                2048,
                500,
                32,
                0.25,
                0.001,
                0.075,
                1500,
                2,
                1.5,
                500,
                1200,
                8,
                600,
                3500,
              },
              {
                physenv.GetAirDensity(),
                GetConVar('cl_windspeed'):GetFloat(),
                GetConVar('hunter_flechette_speed'):GetFloat(),
                GetConVar('phys_timescale'):GetFloat(),
                GetConVar('r_decals'):GetFloat(),
                GetConVar('r_drawmodelstatsoverlaydistance'):GetFloat(),
                GetConVar('r_maxdlights'):GetFloat(),
                GetConVar('r_rainalpha'):GetFloat(),
                GetConVar('r_raindensity'):GetFloat(),
                GetConVar('r_rainlength'):GetFloat(),
                GetConVar('r_rainspeed'):GetFloat(),
                GetConVar('r_rainwidth'):GetFloat(),
                GetConVar('r_snowfallspeed'):GetFloat(),
                GetConVar('r_snowparticles'):GetFloat(),
                GetConVar('scene_maxcaptionradius'):GetFloat(),
                GetConVar('sv_friction'):GetFloat(),
                GetConVar('sv_gravity'):GetFloat(),
                GetConVar('sv_maxvelocity'):GetFloat(),
              },
              y
            )
        end
      )

      spawnmenu.AddToolMenuOption(
        'Honzi',
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
        'Honzi',
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
                'clear_debug_overlays',
                'disconnect',
                'endmovie',
                'explode',
                'firstperson',
                'flush',
                'givecurrentammo',
                'god',
                'hud_reloadscheme',
                'hunter_shoot_flechette',
                'kill',
                'language_reload',
                'menu_reload',
                'noclip',
                'notarget',
                'pause',
                'restart',
                'shake',
                'shake_stop',
                'startmovie',
                'thirdperson',
                'vox_reload',
              },
              y
            )

            y = AddCommandCheckBoxes(
              panel,
              {
                'cl_drawhud',
                'cl_localnetworkbackdoor',
                'cl_playerspraydisable',
                'cl_showfps',
                'cl_showpos',
                'coop',
                'developer',
                'enable_debug_overlays',
                'g_debug_physcannon',
                'mat_show_texture_memory_usage',
                'mp_flashlight',
                'net_graph',
                'r_drawviewmodel',
                'sv_allow_votes',
                'sv_alltalk',
                'sv_autoladderdismount',
                'sv_ladder_useonly',
                'sv_noclipduringpause',
                'sv_pausable',
                'sv_strict_notarget',
                'sv_voiceenable',
                'thirdperson_platformer',
                'thirdperson_screenspace',
              },
              y
            )

            y = AddCommandTextEntries(
              panel,
              {
                'cc_linger_time',
                'cc_predisplay_time',
                'cc_sentencecaptionnorepeat',
                'decalfrequency',
                'fadein',
                'fadeout',
                'host_timescale',
                'hurtme',
                'impulse',
                'jpeg_quality',
                'player_throwforce',
                'physcannon_maxforce',
                'physcannon_maxmass',
                'physcannon_minforce',
                'physcannon_pullforce',
                'sv_accelerate',
                'sv_airaccelerate',
                'sv_noclipspeed',
                'zoom_sensitivity_ratio',
              },
              {
                1,
                0.25,
                4,
                10,
                0,
                0,
                1,
                '',
                '',
                90,
                1000,
                1500,
                250,
                700,
                4000,
                10,
                10,
                5,
                1,
              },
              {
                GetConVar('cc_linger_time'):GetFloat(),
                GetConVar('cc_predisplay_time'):GetFloat(),
                GetConVar('cc_sentencecaptionnorepeat'):GetFloat(),
                GetConVar('decalfrequency'):GetFloat(),
                0,
                0,
                GetConVar('host_timescale'):GetFloat(),
                '',
                '',
                GetConVar('jpeg_quality'):GetFloat(),
                GetConVar('player_throwforce'):GetFloat(),
                GetConVar('physcannon_maxforce'):GetFloat(),
                GetConVar('physcannon_maxmass'):GetFloat(),
                GetConVar('physcannon_minforce'):GetFloat(),
                GetConVar('physcannon_pullforce'):GetFloat(),
                GetConVar('sv_accelerate'):GetFloat(),
                GetConVar('sv_airaccelerate'):GetFloat(),
                GetConVar('sv_noclipspeed'):GetFloat(),
                GetConVar('zoom_sensitivity_ratio'):GetFloat(),
              },
              y
            )
        end
      )

      spawnmenu.AddToolMenuOption(
        'Honzi',
        'Commands',
        'Snippets',
        'Snippets',
        '',
        '',
        function(panel)
            panel:ClearControls()

            y = 23

            CreateTextEntry(
              panel,
              '',
              '',
              'ent_setname a; ent_fire a enablegun 1;',
              0,
              y,
              function(self)
              end,
              290
            )
        end
      )
  end
)

print('Honzi's Addon loaded')
