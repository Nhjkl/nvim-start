return {
  'kyazdani42/nvim-tree.lua',

  cmd = { 'NvimTreeToggle', 'NvimTreeFindFile', 'NvimTreeOpen' },

  setup = function()
    Utils.Shared.addGlobalKeybinds({
      { 'n', '<leader>e', ':NvimTreeToggle<cr>', 'ns' },
      { 'n', '<leader>fe', ':NvimTreeFindFile<cr>', 'ns' },
    })
  end,

  config = function()
    Utils.Shared.loadDependencies({ 'nvim-web-devicons' });
    require('nvim-tree').setup()
  end,
}

