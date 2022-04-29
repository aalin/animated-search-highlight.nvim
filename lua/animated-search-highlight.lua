local DEFAULT_OPTIONS = {
  fg1 = "#7c5803",
  fg2 = "#8d6303",
  bg1 = "#fcdd93",
  bg2 = "#fabd2f",
}

local M = {
  options = DEFAULT_OPTIONS
}

function M.setup(options)
  if options then
    M.options = options
  else
    M.options = DEFAULT_OPTIONS
  end

  M.start()
end

local timer = vim.loop.new_timer()

function M.start()
  timer:start(0, 20, vim.schedule_wrap(function ()
    local status, err = pcall(M.animate)

    if err then
      M.stop()
      error(err)
    end
  end))
end

function M.stop()
  timer:stop()
end

local function rgb_to_hex(rgb)
  return string.format(
    "#%02x%02x%02x",
    math.floor(rgb.r * 255),
    math.floor(rgb.g * 255),
    math.floor(rgb.b * 255)
  )
end

local function rgb(r, g, b)
  return { r = r, g = g, b = b, }
end

local function hex_to_rgb(hex)
  return rgb(
    tonumber(hex:sub(2, 3), 16) / 255,
    tonumber(hex:sub(4, 5), 16) / 255,
    tonumber(hex:sub(6, 7), 16) / 255
  )
end

local function lerp(a, b, t)
  return a + (b - a) * t
end

local function mix(rgb1, rgb2, t)
  return rgb(
    lerp(rgb1.r, rgb2.r, t),
    lerp(rgb1.g, rgb2.g, t),
    lerp(rgb1.b, rgb2.b, t)
  )
end

local tick = 0

function M.animate()
  if not vim.o.hlsearch then
    return
  end

  local x = math.sin(tick / 5.0) * 0.5 + 0.5
  local gui = x < 0.5 and "NONE" or "bold"

  local guifg = rgb_to_hex(mix(
    hex_to_rgb(M.options.fg1),
    hex_to_rgb(M.options.fg2),
    x
  ))

  local guibg = rgb_to_hex(mix(
    hex_to_rgb(M.options.bg1),
    hex_to_rgb(M.options.bg2),
    x
  ))

  vim.cmd(string.format(
    [[
      highlight IncSearch gui=%s guifg=%s guibg=%s
      highlight Search gui=%s guifg=%s guibg=%s
    ]],
    gui, guifg, guibg,
    gui, guifg, guibg
  ))

  tick = tick + 1
end

return M
