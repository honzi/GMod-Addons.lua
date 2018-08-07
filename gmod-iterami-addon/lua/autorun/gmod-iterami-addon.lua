print("loading GMod-iterami-Addon...")

hook.Add(
  "PopulateToolMenu",
  "CustomMenuSettings",
  function()
      spawnmenu.AddToolMenuOption(
        "iterami",
        "Commands",
        "GMod",
        "GMod",
        "",
        "",
        function(panel)
            panel:ClearControls()

            local commands = {
              'clear',
              'disconnect',
              'flush',
              'quit',
            }
            local y = 0;
            for i, command in ipairs(commands) do
                y = y + 23

                local button = vgui.Create(
                  "DButton",
                  panel
                )
                button:SetPos(
                  0,
                  y
                )
                button:SetText(command)
                button.DoClick = function()
                    RunConsoleCommand(
                      command,
                      ""
                    )
                end
            end
        end
      )
      spawnmenu.AddToolMenuOption(
        "iterami",
        "Commands",
        "Player",
        "Player",
        "",
        "",
        function(panel)
            panel:ClearControls()

            local commands = {
              'god',
              'kill',
              'noclip',
            }
            local y = 0;
            for i, command in ipairs(commands) do
                y = y + 23

                local button = vgui.Create(
                  "DButton",
                  panel
                )
                button:SetPos(
                  0,
                  y
                )
                button:SetText(command)
                button.DoClick = function()
                    RunConsoleCommand(
                      command,
                      ""
                    )
                end
            end
        end
      )
      spawnmenu.AddToolMenuOption(
        "iterami",
        "Commands",
        "World",
        "World",
        "",
        "",
        function(panel)
            panel:ClearControls()

            local commands = {
              'r_cleardecals',
            }
            local y = 0;
            for i, command in ipairs(commands) do
                y = y + 23

                local button = vgui.Create(
                  "DButton",
                  panel
                )
                button:SetPos(
                  0,
                  y
                )
                button:SetText(command)
                button.DoClick = function()
                    RunConsoleCommand(
                      command,
                      ""
                    )
                end
            end
        end
      )
  end
)

print("done loading GMod-iterami-Addon")