--[[
  插件管理工具使用 packer.nvim https://github.com/wbthomason/packer.nvim
  建议仔细阅读 packer.nvim 项目文档
]]

local fn = vim.fn
local exclude = vim.api.nvim_command
local hasPackerSync = false

-- packer runtimepath 设置到项目录帮忙阅读学习插件代码
-- 还有一点好处就是卸载配置的时候所安装的插件一起移除
-- 有好有坏吧，看个人习惯
local packerRtp = fn.stdpath('config') .. '/.packer'
local packageRoot = packerRtp .. '/pack'
local packerGitPath = 'https://github.com/wbthomason/packer.nvim'

-- set packer runtimepath
vim.o.rtp = vim.o.rtp .. ',' .. packerRtp
vim.o.packpath = vim.o.packpath .. ',' .. packerRtp

local installPath = packerRtp .. '/pack/packer/start/packer.nvim'
local compilePath = packerRtp .. '/plugin/packer_compiled.vim'

_G.__installPath__ = installPath
_G.__compilePath__ = compilePath

if fn.empty(fn.glob(installPath)) > 0 then -- 安装位置为空就下载 packer.nvim
  print('git cline ' .. packerGitPath)
  exclude('silent !git clone --depth 1 ' .. packerGitPath .. ' ' .. installPath)
  exclude('packadd packer.nvim')
  hasPackerSync = true
end

require('packer').init({
  package_root = packageRoot,
  compile_path = compilePath,
  git = { clone_timeout = 300 }
})

_G.removeCompiledFile = function()
  if fn.empty(fn.glob(compilePath)) == 0 then
    exclude('silent !rm -f ' .. compilePath)
  end
end

function _G.__packaddedHook__()
  if packer_plugins == nil then
    return
  end
  for _, opts in pairs(packer_plugins) do
    if vim.fn.empty(vim.fn.glob(opts.path)) > 0 then -- 插件未安装
      exclude('PackerSync')
      break
    end
  end
end

Utils.Shared.cmd({
  [[autocmd BufWritePost **/plugins/*.lua :lua removeCompiledFile()]], -- 写入plugins文件时，删除compile file, 这样重新进入时会重新编译
  [[autocmd BufWritePost **/packloader/plugins_manager.lua :lua removeCompiledFile()]],
  [[autocmd VimEnter * :lua __packaddedHook__()]]
})

-- plugins load
require('packloader.load')

if fn.empty(fn.glob(compilePath)) > 0 then
  if hasPackerSync then
    exclude('PackerSync')
  else
    exclude('PackerCompile')
  end
end
