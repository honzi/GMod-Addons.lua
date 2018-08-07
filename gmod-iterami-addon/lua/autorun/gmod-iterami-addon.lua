print("loading GMod-iterami-Addon...")

hook.Add(
  "PopulateToolMenu",
  "CustomMenuSettings",
  function()
      spawnmenu.AddToolMenuOption(
        "iterami",
        "Settings",
        "GMod-iterami-Addon",
        "GMod-iterami-Addon",
        "",
        "",
        function(panel)
            panel:ClearControls()
        end
      )
  end
)

print("done loading GMod-iterami-Addon")
