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
          0,
          x,
          y,
          function(this)
              if this:GetChecked() then
                  RunConsoleCommand(
                    command,
                    "1"
                  )
              else
                  RunConsoleCommand(
                    command,
                    "0"
                  )
              end
          end
        )

        CreateTextLabel(
          panel,
          command,
          x + 20,
          y
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
      x + 55,
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
                'clear',
                'disconnect',
                'firstperson',
                'flush',
                'givecurrentammo',
                'god',
                'kill',
                'noclip',
                'notarget',
                'quit',
                'r_cleardecals',
                'thirdperson',
              },
              0,
              0
            )

            CreateTextEntry(
              panel,
              'sv_gravity (600)',
              '600',
              150,
              23,
              function(self)
                  RunConsoleCommand(
                    "sv_gravity",
                    self:GetValue()
                  )
              end
            )

            AddCommandCheckBoxes(
              panel,
              {
                'cl_showfps',
                'cl_showpos',
                'net_graph',
              },
              155,
              23
            )
        end
      )
  end
)

print("GMod-iterami-Addon loaded")
