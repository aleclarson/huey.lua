
local esc = string.char(27)
local fg_reset = esc .. '[39m'

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
    pale_red = {5, 0, 1},
    blue = {0, 1, 5},
    pale_blue = {3, 3, 5},
    green = {0, 5, 1},
    pale_green = {0, 5, 3},
    yellow = {5, 5, 0},
    pale_yellow = {5, 5, 2},
    cyan = {0, 3, 4},
    pale_cyan = {1, 4, 5},
    pink = {5, 0, 4},
    pale_pink = {5, 1, 4},
    white = {5, 5, 5},
    silver = {4, 4, 4},
    gray = {2, 2, 2},
    coal = {1, 1, 1},
    black = {0, 0, 0},
  }

  if print == nil then print = _G.print end
  local term = setmetatable({}, {
    __call = function(self, ...)
      local args = {...}
      return print(table.concat(args, ' '))
    end,
  })
  for name, color in pairs(fg_colors) do
    color = fg(rgb(unpack(color)))
    term[name] = function(...)
      local args = {...}
      return print(color .. table.concat(args, ' ') .. fg_reset)
    end
  end
  return term
end

return {
  rgb = rgb_fn,
  install = install,
}

