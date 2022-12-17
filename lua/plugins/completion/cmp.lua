return {
  'hrsh7th/nvim-cmp',

  event = "InsertEnter *",

  requires = {
    { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
    { "hrsh7th/cmp-path", after = "nvim-cmp" },
    { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
  },

  config = function ()
    local cmp = require('cmp')

    local mapping = cmp.mapping;

    local kind_icons = Utils.Icons.lspkind

    local cmp_borderchars = Utils.Icons.cmp_borderchars

    local lspkind = {
      kind_icons = kind_icons,
      source_names = {
        emoji       = "(Emoji)",
        path        = "(Path)",
        calc        = "(Calc)",
        cmp_tabnine = "(Tabnine)",
        buffer      = "(Buffer)",
      },
      duplicates = {
        buffer = 1,
        path = 1
      },
      duplicates_default = 0,

    }

    local config = {
      formatting = {
        format = function(entry, vim_item)
          vim_item.kind = lspkind.kind_icons[vim_item.kind]
          vim_item.menu = lspkind.source_names[entry.source.name]
          vim_item.dup = lspkind.duplicates[entry.source.name]
            or lspkind.duplicates_default
          return vim_item
        end,
      },

      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },

      experimental = {
        ghost_text = true,
        native_menu = false,
      },

      window = {
        completion = cmp.config.window.bordered({
          border = cmp_borderchars,
          winhighlight = 'Normal:Normal,FloatBorder:GruvboxGray,CursorLine:Visual,Search:None'
        }),

        documentation = cmp.config.window.bordered({
          border = cmp_borderchars,
          winhighlight = 'Normal:Normal,FloatBorder:GruvboxGray,CursorLine:Visual,Search:None'
        }),
      },

      sources =  cmp.config.sources({
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
      }),

      mapping = {
        ['<CR>']    = mapping.confirm({ select = true }),
        ['<C-f>']   = mapping(mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-j>']   = mapping(mapping.select_next_item(), { 'i', 's' }),
        ['<C-k>']   = mapping(mapping.select_prev_item(), { 'i', 's' }),
        ["<Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
        ["<S-Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end
      },
    }

    cmp.setup(config)
  end
}
