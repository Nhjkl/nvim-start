local function split(str, reps)
  local resultStrList = {}
  string.gsub(str, '[^' .. reps .. ']+', function(w)
    table.insert(resultStrList, w)
  end)
  return resultStrList
end

local function dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  return unpack(objects)
end

local function writeFile(optionPath, context)
  local file = io.open(optionPath, 'w')
  io.output(file)
  io.write(context)
  io.close(file)
end

local function generatePluginOptionFile()
  local tmp = Utils.Shared.getPluginsPaths()
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

    local config = require(value:sub(0, #value - 4))
    local pluginKey = config[1]
    options[pluginKey] = not (config['disable'])

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

  if isWriteFile or not (ok) then
    writeFile(optionPath, optionsStr)
  end

  return options
end

local function setPluginsManagerOptions()
  Utils.Shared.cmd({
    [[
      augroup plugins_manager
        autocmd!
        autocmd BufEnter **/packloader/plugins_manager.lua nnoremap <silent><buffer><nowait> ,t :lua Utils.Helper.toggleTrueOrFalse()<cr>
        autocmd BufEnter **/packloader/plugins_manager.lua nnoremap <silent><buffer><nowait> ,g :lua Utils.Helper.openPluginGithub()<cr>
        autocmd BufEnter **/packloader/plugins_manager.lua nnoremap <silent><buffer><nowait> ,b :lua Utils.Helper.openPluginReadme()<cr>
        autocmd BufEnter **/packloader/plugins_manager.lua nnoremap <silent><buffer><nowait> ,c :lua Utils.Helper.openPluginConfigFile()<cr>
      augroup End
    ]],
    [[
      autocmd BufEnter **/packloader/plugins_manager.lua syntax match pluginsManagerOptionTrue '\v\[.*true.*$'
      autocmd BufEnter **/packloader/plugins_manager.lua syntax match pluginsManagerOptionFalse '\v\[.*false.*$'
    ]]
  })
end

local function loadPlugins(use)
  local tmp = Utils.Shared.getPluginsPaths()
  local options = generatePluginOptionFile()
  setPluginsManagerOptions()
  for _, value in ipairs(tmp) do
    local config = require(value:sub(0, #value - 4))
    if (not (config['disable']) and options[config[1]]) then
      use(config)
    end
  end
end

return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')
  loadPlugins(use)
end)
