local a = core.filter.add
a("collision", { "collision", "position.x", "position.y", "position.rotation" })
a("dynamic_collision", { "_collision", "collision.dynamic" })
a("static_collision", { "_collision", "-_dynamic_collision" })
a("key_controls", { "keyboardcontrols" })
a("relative_position", { "relativeto.position" })
a("light_source", { "position", "light" })
a("light_wall", { "_collision", "LW" })
a("wiskers", { "position", "wiskers" })
a("player", { "player" })
a("clickable", { "collision" , "clickable"})
a("mouseplayer", { "dragonHead" })
a("dragonHead", { "dragonHead" })

a("mapPosition", { "mapPosition" })
a("camera", { "camera", "position" })
a("hoard", { "money.total" })
a("dwarf", { "dwarf" })
