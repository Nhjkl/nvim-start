Utils.Shared.cmd({
  [[autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]],  -- 光标停留在上次离开时的行
})
