local M = {}

local function getCurrentLinePluginName(call)
  local pluginName = Utils.Shared.getCurrentLineMatchContent('\'.*\'')
  if not (pluginName) then
    return
  end
  call(pluginName)
end

function M.vsplitFile(path, type)
  vim.cmd('set splitright')
  vim.cmd('vsplit')
  if (type == 'readonly') then
    vim.cmd('e +set\\ readonly ' .. path)
  else
    vim.cmd('e ' .. path)
  end
end

function M.openBrowser(url)
  local _url = string.gsub(url, '%#', '\\#')
  print(_url)
  vim.cmd('silent !$BROWSER ' .. _url)
end

function M.openPluginGithub()
  getCurrentLinePluginName(function(pluginName)
    M.openBrowser([[https://github.com/]] .. pluginName)
  end)
end

function M.openPluginConfigFile()
  getCurrentLinePluginName(function(pluginName)
    local tmp = Utils.Shared.getPluginsPaths()
    for _, value in ipairs(tmp) do
      local config = require(value:sub(0, #value - 4))
      local pluginKey = config[1]
      if pluginKey == pluginName then
        M.vsplitFile('lua/' .. value)
      end
    end
  end)
end

function M.toggleTrueOrFalse()
  local isReadOnly = vim.bo.readonly
  if isReadOnly then
    vim.bo.readonly = false
  end
  local curLine = vim.fn.getline('.')
  local _curLine = curLine
  local isTrue = string.find(curLine, 'true')
  local isFalse = string.find(curLine, 'false')

  if (isTrue or isFalse) and not (isTrue and isFalse) then -- 一行中只有一个 true or false 触发
    if string.find(curLine, 'true') then
      _curLine = string.gsub(curLine, 'true', 'false')
    end
    if string.find(curLine, 'false') then
      _curLine = string.gsub(curLine, 'false', 'true')
    end
    vim.api.nvim_set_current_line(_curLine)
  end
  vim.cmd('w')
  vim.bo.readonly = isReadOnly
end

-- [打开插件的readme文件, 如果有]
function M.openPluginReadme()
  local pluginName = Utils.Shared.getCurrentLineMatchContent('/.*\'')
  if not(pluginName) then
    return
  end
  -- getCurrentLinePluginName(function(pluginName) -- 为什么用回调函数的方式 vim.fn.glob 匹配不到
    local packerRtp = vim.fn.stdpath('config') .. '/.packer'
    local readmePath = vim.fn.glob(packerRtp .. '/**/' .. pluginName .. '/README.md')
    if #readmePath > 0 and vim.fn.empty(readmePath[1]) > 0 then
      M.vsplitFile(readmePath, 'readonly')
    end
  -- end)
end

return M
