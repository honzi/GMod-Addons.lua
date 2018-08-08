print("loading GMod-iterami-Addon...")

hook.Add(
  "PopulateToolMenu",
  "CustomMenuSettings",
  function()
      function CreateButton(panel, text, x, y, onclick)
          local button = vgui.Create(
            "DButton",
            panel
          )
          button:SetSize(
            100,
            23
          )
          button:SetPos(
            x,
            y
          )
          button:SetText(text)
          button.DoClick = onclick
      end

      function AddCommandButtons(commands, panel, x)
          local y = 0;
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
              {
                'clear',
                'disconnect',
                'flush',
                'quit',
              },
              panel,
              0
            )
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
              panel,
              100
            )
            AddCommandButtons(
              {
                'r_cleardecals',
              },
              panel,
              200
            )
        end
      )
  end
)

print("done loading GMod-iterami-Addon")
