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

local function addGlobalKeybinds(keybinds)
  for _, keybind in pairs(keybinds) do
    if (keybind[4] == nil) then
      keybind[4] = {}
    end
    local opts = getOpts(keybind[4])
    vim.api.nvim_set_keymap(keybind[1], keybind[2], keybind[3], opts)
  end
end

local function addBufferKeybinds(keybinds)
  for _, keybind in pairs(keybinds) do
    if (keybind[5] == nil) then
      keybind[5] = {}
    end
    vim.api.nvim_buf_set_keymap(keybind[1], keybind[2], keybind[3], keybind[4], keybind[5])
  end
end

local VarType = {
  GLOBAL = 'g',
  WINDOW = 'w',
  BUFFER = 'b',
  TAB_PAGE = 't',
  VIM = 'v',
}

local function addVariables(variable_type, variables)
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

local OptionType = {
  GLOBAL = 'o',
  WINDOW = 'wo',
  BUFFER = 'bo'
}

local addOptions = function(optionType, id, options)
  if type(id) == 'table' then
    options = id
    id = 0
  end

  if type(options) ~= 'table' then
    error('options should be a type of "table"')
    return
  end

  for key, value in pairs(options) do
    -- adding options to vim
    -- id condition is there to make it compatible with global options
    -- global options has no id
    -- vim['o']['mouse'] = 4
    -- vim['wo'][10]['number'] = true
    if id == 0 then
      vim[optionType][key] = value
    else
      vim[optionType][id][key] = value
    end
  end
end

function M.cmd(commands)
  for _, value in ipairs(commands) do
    vim.cmd(value)
  end
end

function M.addGlobalOptions(options)
  addOptions(OptionType.GLOBAL, options)
end

function M.addWindowOptions(id, options)
  addOptions(OptionType.WINDOW, id, options)
end

function M.addBufferOptions(id, options)
  addOptions(OptionType.BUFFER, id, options)
end

function M.addGlobalKeybinds(keybinds)
  addGlobalKeybinds(keybinds)
end

function M.addBufferKeybinds(keybinds)
  addBufferKeybinds(keybinds)
end

function M.addGlobalVariable(variables)
  addVariables(VarType.GLOBAL, variables)
end

return M
