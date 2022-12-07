return {
  'akinsho/bufferline.nvim',

  tag = "v2.*",

  event = 'BufReadPre',

  config = function ()
    Utils.Shared.loadDependencies({ 'nvim-web-devicons' });
    vim.opt.termguicolors = true

    require("bufferline").setup({
      options = {
        offsets = {
          {
            filetype = "NvimTree",
            text = "Explorer",
            highlight = "PanelHeading",
            padding = 1,
          },
        },
      }
    })

    function _G.BufferCloseAllButCurrent()
      vim.cmd('BufferLineCloseLeft')
      vim.cmd('BufferLineCloseRight')
    end

    Utils.Shared.addGlobalKeybinds({
      { 'n', '<tab>'    , ':BufferLineCycleNext<cr>'       , 'ns' },
      { 'n', '<s-tab>'  , ':BufferLineCyclePrev<cr>'       , 'ns' },
      { 'n', '<leader>0', ':lua BufferCloseAllButCurrent()<cr>'  , 'ns' },
      { 'n', '<leader>k', ':BufferLinePickClose<cr>'        , 'ns' },
      -- { 'n', '<leader>w', ':BufferClose<cr>'               , 'ns' },
    })
  end
}
