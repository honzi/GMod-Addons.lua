function AddCommandButtons(panel, commands, x, y)
    for i, command in ipairs(commands) do
        y = y + 23

        CreateButton(
          panel,
          command,
          x,
          y,
          function()
              RunConsoleCommand(
                command,
                ""
              )
          end
        )
    end
end

function AddCommandCheckBoxes(panel, commands, x, y)
    for i, command in ipairs(commands) do
        y = y + 23

        CreateCheckBox(
          panel,
          GetConVar(command):GetInt(),
          x,
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
          x + 16,
          y
        )
    end
end

function AddCommandTextEntries(panel, commands, defaults, x, y)
    for i, command in ipairs(commands) do
        y = y + 23

        CreateTextEntry(
          panel,
          command .. '(' .. defaults[i] .. ')',
          GetConVar(command):GetInt(),
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

function CreateButton(panel, text, x, y, onclick)
    local button = vgui.Create(
      "DButton",
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
end

function CreateCheckBox(panel, value, x, y, onchange)
    local button = vgui.Create(
      "DCheckBox",
      panel
    )
    button:SetPos(
      x,
      y
    )
    button:SetValue(value)
    button.OnChange = onchange
end

function CreateTextEntry(panel, text, value, x, y, onenter)
    local textEntry = vgui.Create(
      "DTextEntry",
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
      text,
      x + 51,
      y
    )
end

function CreateTextLabel(panel, value, x, y)
    local textLabel = vgui.Create(
      "DLabel",
      panel
    )
    textLabel:SetPos(
      x,
      y
    )
    textLabel:SetText(value)
    textLabel:SetTextColor(Color(0, 0, 0))
    textLabel:SizeToContents()
end

hook.Add(
  "PopulateToolMenu",
  "CustomMenuSettings",
  function()
      spawnmenu.AddToolMenuOption(
        "iterami",
        "iterami",
        "Commands",
        "Commands",
        "",
        "",
        function(panel)
            panel:ClearControls()

            AddCommandButtons(
              panel,
              {
                'buddha',
                'disconnect',
                'firstperson',
                'flush',
                'givecurrentammo',
                'god',
                'kill',
                'noclip',
                'notarget',
                'r_cleardecals',
                'thirdperson',
              },
              0,
              0
            )

            AddCommandCheckBoxes(
              panel,
              {
                'ai_expression_optimization',
                'cl_ejectbrass',
                'cl_ragdoll_collide',
                'cl_show_splashes',
                'cl_showfps',
                'cl_showpos',
                'fog_enable_water_fog',
                'net_graph',
                'r_3dsky',
                'r_drawparticles',
                'r_drawrain',
                'r_eyes',
                'r_shadows',
                'r_teeth',
                'sv_allow_votes',
                'sv_alltalk',
                'sv_footsteps',
                'sv_ladder_useonly',
                'sv_voiceenable',
                'violence_ablood',
                'violence_agibs',
                'violence_hblood',
                'violence_hgibs',
              },
              152,
              0
            )

            AddCommandTextEntries(
              panel,
              {
                'sv_friction',
                'sv_gravity',
                'sv_maxvelocity',
                'sv_noclipspeed',
              },
              {
                8,
                600,
                3500,
                5,
              },
              0,
              253
            )
        end
      )
  end
)

print("GMod-iterami-Addon loaded")
