local function generatePluginOptionStr(pluginsPaths, generatedOpts)
  local options = {}
  local optionsStr = '-- 该文件为自动生成，光标移动到插件所在行按下\n'
        optionsStr = optionsStr .. '-- ,t  控制插件启用或关闭\n'
        optionsStr = optionsStr .. '-- ,c  打开配置文件\n'
        optionsStr = optionsStr .. '-- ,b  打开插件源代码readme.md\n'
        optionsStr = optionsStr .. '-- ,g  通过浏览器打开插件源代码github\n'
        optionsStr = optionsStr .. '\nreturn {\n'
  local commentFlg = ''

  for _, value in ipairs(pluginsPaths) do
    local type = '  -- ' .. Utils.Shared.split(value, '/')[2] .. '\n'
    if commentFlg ~= type then
      commentFlg = type
      optionsStr = optionsStr .. type
    end
    local config = require(value:sub(0,#value-4))
    local pluginKey = config[1]
    options[pluginKey] = true
    if generatedOpts[pluginKey] ~= nil then
      options[pluginKey] = generatedOpts[pluginKey]
    else
      generatedOpts[pluginKey] = options[pluginKey]
    end
    optionsStr = optionsStr .. '  [\'' .. pluginKey .. '\'] = ' .. Utils.Shared.dump(options[pluginKey]) .. ',' .. '\n'
  end

  optionsStr = optionsStr .. '}'
  return optionsStr
end

local function tableLen(list)
  if list == nil then
    return 0
  end
  local n = 0;
  for _, _ in pairs(list) do
    n = n + 1
  end
  return n
end

local function generatePluginOptionFile()
  local pluginsPaths = Utils.Shared.getPluginsPaths()
  local ok, opt = pcall(require, 'packloader.plugins_manager')
  if not(ok) or #pluginsPaths ~= tableLen(opt) then
    local optionPath = vim.fn.stdpath('config') .. '/lua/packloader/plugins_manager.lua'
    local _opt = {}

    if (ok) then
      _opt = opt
    end
    local optionsStr = generatePluginOptionStr(pluginsPaths, _opt);
    Utils.Shared.writeFile(optionPath, optionsStr)
    Utils.Shared.cmd({ 'silent !rm -f ' .. __compilePath__ })
  end
  return opt
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
