return {
  'morhetz/gruvbox',

  config = function ()
    Utils.Shared.cmd({
      'syntax on',
      'colorscheme gruvbox',

      'hi clear ErrorMsg',
      'hi link MsgArea GruvboxGray',
      'hi link ErrorMsg GruvboxRed',
      'hi Comment gui=italic',
      'hi SignColumn ctermbg=237 guibg=NONE',
      'hi link GitGutterAdd GruvboxGreen',
      'hi link GitGutterChange GruvboxAqua',
      'hi link GitGutterDelete GruvboxRed',
      'hi link GitGutterChangeDelete GruvboxAqua',
      'hi Visual guifg=NONE ctermfg=NONE guibg=#404b3d ctermbg=239 gui=NONE cterm=NONE',
      'hi VisualNOS guifg=#504945 ctermfg=239 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE',
      'hi IncSearch guifg=NONE ctermfg=NONE guibg=#79655a ctermbg=241 gui=NONE cterm=NONE',
      'hi BufferTabpageFill guifg=#7c6f64 guibg=#32302f',
      'hi EndOfBuffer ctermfg=235 guifg=#282828',
      'hi VertSplit ctermfg=241 ctermbg=235 guifg=#32302f guibg=#32302f',
      'hi link GitSignsCurrentLineBlame GruvboxGray',
      'hi Search guifg=NONE ctermfg=NONE guibg=#593f2a ctermbg=239 gui=NONE cterm=NONE',
    })
  end
}
