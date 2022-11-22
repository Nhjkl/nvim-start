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

local function add_global_keybinds(keybinds)
  for _, keybind in pairs(keybinds) do
    if (keybind[4] == nil) then
      keybind[4] = {}
    end
    local opts = getOpts(keybind[4])
    vim.api.nvim_set_keymap(keybind[1], keybind[2], keybind[3], opts)
  end
end

local VarType = {
  GLOBAL_VARIABLE = 'g',
  WINDOW_VARIABLE = 'w',
  BUFFER_VARIABLE = 'b',
  TAB_PAGE_VARIABLE = 't',
  VIM_VARIABLE = 'v',
}

local function add_variables(variable_type, variables)
  if type(variables) ~= 'table' then
    error('variables should be a type of "table"')
    return
  end

  local variable_map = vim[variable_type]

  for key, value in pairs(variables) do
    -- 等同于 vim[variable_type][key] = value
    -- 例如 vim.g.mapleader = ' '
    variable_map[key] = value
  end
end

function M.keybinds(keybinds)
  add_global_keybinds(keybinds)
end

function M.addGlobalVariable(variables)
  add_variables(VarType.GLOBAL_VARIABLE, variables)
end

return M
