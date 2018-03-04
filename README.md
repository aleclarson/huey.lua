# huey v0.1.0

```lua
local huey = require('huey')

-- Wrap `_G.print`
local print = huey.install()

-- Wrap a custom function
local print = huey.install(function(msg)
  io.stdout:write(msg, '\n')
end)

print.red('this is red')
print.blue('im blue, da-bu-dee-da-bu-die')
```

These colors also have `pale_` variants:
- red
- blue
- green
- yellow
- cyan
- pink

Grayscale colors:
- white
- silver
- gray
- coal
- black

Call `huey.rgb(r, g, b)` to create a function
that wraps a string with the given RGB color.
Each argument must be a number from 0 - 5.

