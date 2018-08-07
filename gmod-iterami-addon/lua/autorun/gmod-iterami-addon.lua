print("loading GMod-iterami-Addon...")

hook.Add(
  "PopulateToolMenu",
  "CustomMenuSettings",
  function()
      function AddCommandButtons(commands, panel)
          local y = 0;
          for i, command in ipairs(commands) do
              y = y + 23

              local button = vgui.Create(
                "DButton",
                panel
              )
              button:SetSize(
                100,
                23
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

      spawnmenu.AddToolMenuOption(
        "iterami",
        "Commands",
        "GMod",
        "GMod",
        "",
        "",
        function(panel)
            panel:ClearControls()

            AddCommandButtons(
              {
                'clear',
                'disconnect',
                'flush',
                'quit',
              },
              panel
            )
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

            AddCommandButtons(
              {
                'buddha',
                'firstperson',
                'givecurrentammo',
                'god',
                'kill',
                'noclip',
                'thirdperson',
              },
              panel
            )
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

            AddCommandButtons(
              {
                'r_cleardecals',
              },
              panel
            )
        end
      )
  end
)

print("done loading GMod-iterami-Addon")
