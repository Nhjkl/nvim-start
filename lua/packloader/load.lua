-- 约定插件文件位置在lua/plugins
-- lua/plugins/
-- └── themes
--     └── gruvbox.lua
local function getPluginsPaths()
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

local function split(str, reps)
  local resultStrList = {}
  string.gsub(str,'[^'..reps..']+',function ( w )
    table.insert(resultStrList,w)
  end)
  return resultStrList
end

local function dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  return unpack(objects)
end

local function writeFile(optionPath, context)
  local file = io.open(optionPath, 'w')
  io.output(file)
  io.write(context)
  io.close(file)
end

local function generatePluginOptionFile()
  local tmp = getPluginsPaths()
  local options = {}
  local optionPath = vim.fn.stdpath('config') .. '/lua/packloader/plugins_manager.lua'
  local isWriteFile = false
  local ok, opt = pcall(require, 'packloader.plugins_manager')
  local optionsStr = '-- 该文件为自动生成，光标移动到插件所在行按下\n'
        optionsStr = optionsStr .. '-- ,t  控制插件启用或关闭\n'
        optionsStr = optionsStr .. '-- ,c  打开配置文件\n'
        optionsStr = optionsStr .. '-- ,b  打开插件源代码readme.md\n'
        optionsStr = optionsStr .. '-- ,g  通过浏览器打开插件源代码github\n'

        optionsStr = optionsStr .. '\nreturn {\n'

  local flg = ''

  for _, value in ipairs(tmp) do
    local type = '  -- ' .. split(value, '/')[2] .. '\n'

    if flg ~= type then
      flg = type
      optionsStr = optionsStr .. type
    end

    local config = require(value:sub(0,#value-4))
    local pluginKey = config[1]
    options[pluginKey] = not(config['disable'])

    if ok then
      if opt[pluginKey] == nil then
        isWriteFile = true
      else
        if opt[pluginKey] ~= options[pluginKey] then
          options[pluginKey] = opt[pluginKey]
        end
      end
    end

    optionsStr = optionsStr .. '  [\'' .. pluginKey .. '\'] = ' .. dump(options[pluginKey]) .. ',' .. '\n'
  end

  optionsStr = optionsStr .. '}'

  if ok then
    for key in pairs(opt) do
      if options[key] == nil then
        isWriteFile = true
        break
      end
    end
  end

  if isWriteFile or not(ok) then
    writeFile(optionPath, optionsStr)
  end

  return options
end

local function loadPlugins(use)
  local tmp = getPluginsPaths();
  local options = generatePluginOptionFile();
  for _, value in ipairs(tmp) do
    local config = require(value:sub(0,#value-4))
    if (not(config['disable']) and options[config[1]]) then
      use(config)
    end
  end
end

return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')
  loadPlugins(use)
end)
