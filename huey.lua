
local esc = string.char(27)
local fg_reset = esc..'[39m'

local function fg(n)
  return ('%s[38;5;%dm'):format(esc, n)
end

local function rgb(r, g, b)
  return 16 + 36*r + 6*g + b
end

local function rgb_fn(r, g, b)
  local color = fg(rgb(r, g, b))
  return function(str)
    return color .. str .. fg_reset
  end
end

local function install(print)
  local fg_colors = {
    red = {5, 0, 0},
    blue = {0, 1, 5},
    green = {0, 5, 1},
    cyan = {0, 3, 4},
    white = {5, 5, 5},
    gray = {2, 2, 2},
    yellow = {5, 5, 0},
    pink = {5, 0, 4},
    black = {0, 0, 0},
  }

  if print == nil then
    print = _G.print
  end

  for name, color in pairs(fg_colors) do
    color = fg(rgb(unpack(color)))
    print[name] = function(...)
      print(color, unpack(arg), fg_reset)
    end
  end
end

return {
  rgb = rgb_fn,
  install = install,
}

