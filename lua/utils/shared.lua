local M = {}

-- 'nsew' => { noremap = true, silent = true, expr = true, nowait = true }
local function getOpts(str)
  if type(str) == 'table' then
    return str
  end
  local optMap = {
    n = { noremap = true },
    s = { silent = true },
    e = { expr = true },
    w = { nowait = true },
  }
  local opts = {}
  for key in str:gmatch(".") do
    local item = optMap[key]
    if item then
      for k, v in pairs(item) do
        opts[k] = v
      end
    end
  end
  return opts
end

local add_global_keybinds = function(keybinds)
  for _, keybind in pairs(keybinds) do
    if (keybind[4] == nil) then
      keybind[4] = {}
    end
    local opts = getOpts(keybind[4])
    vim.api.nvim_set_keymap(keybind[1], keybind[2], keybind[3], opts)
  end
end

function M.keybinds(keybinds)
  add_global_keybinds(keybinds)
end

return M
