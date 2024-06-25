-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = {}

config.default_prog = { '/usr/bin/tmux' }

-- 993 colorschemes there, OMG
-- https://wezfurlong.org/wezterm/colorschemes/index.html
config.color_scheme = 'Gruvbox Material (Gogh)'

-- config.window_background_image = wezterm.config_dir .. '/background/stars.jpg'
-- config.window_background_image_hsb = {
--   -- Darken the background image by reducing it to 1/3rd
--   brightness = 0.3,
-- 
--   -- You can adjust the hue by scaling its value.
--   -- a multiplier of 1.0 leaves the value unchanged.
--   hue = 0.3,
-- 
--   -- You can adjust the saturation also.
--   saturation = 0.5,
--}

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.window_background_opacity = 1

-- fonts

config.font = wezterm.font_with_fallback({

  {family="UbuntuSansMono Nerd Font", weight="Regular"},

  -- Assumed to have Emoji Presentation
  -- Pixel sizes: [128]
  "Noto Color Emoji",
})

config.font_rules = {
  -- For Bold-but-not-italic text, use this relatively bold font, and override
  -- its color to a tomato-red color to make bold text really stand out.
  {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font_with_fallback {
      {family='UbuntuSansMono Nerd Font', weight='Medium'}
    },
  },
}

config.hide_tab_bar_if_only_one_tab = true
config.initial_cols = 110
config.initial_rows = 30

return config
