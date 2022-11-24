-- 约定插件文件位置在lua/plugins
-- lua/plugins/
-- └── themes
--     └── gruvbox.lua
function getPluginsPaths()
  local fn = vim.fn
  local pluginConfigsDir = fn.stdpath('config') .. '/lua/plugins'
  local tmp = vim.split(fn.globpath(pluginConfigsDir, '**/*.lua'), '\n')
  local paths = {}
  for _, value in ipairs(tmp) do
    local fpath = value:sub(#pluginConfigsDir - 6, -1)
    table.insert(paths, fpath)
  end
  return paths
end

local function loadPlugins(use)
  local tmp = getPluginsPaths();
  for _, value in ipairs(tmp) do
    local config = require(value:sub(0,#value-4))
    use(config)
  end
end

return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')
  loadPlugins(use)
end)
