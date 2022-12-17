-- Icons management
local Icons       = {}

Icons.common      = {
  bitcoin         = '',
  language        = '',
  setting         = '', -- אּ 
  vim             = '', --    
  search          = '', --   ﰍ 
  arrow           = '', --   ﰲ ﯀ ﰴ
  file            = '',
  image           = '',
  copy            = '',
  font            = '',
  mark            = '',
  plugin          = '',
  package         = '',
  question        = '', --  
  git             = '',
  bookmarkSign    = '',
}

Icons.lsp         = {
  hint            = '', -- 
  info            = '', -- 
  warning         = '', -- 
  error           = '', -- 
  text            = '',
  method          = '',
  func            = '',
  constructor     = '',
  field           = '', --  ﴲ
  variable        = '',
  class           = '',
  interface       = 'ﰮ',
  module          = '',
  property        = '',
  unit            = '',
  value           = '',
  enum            = '',
  keyword         = '',
  snippet         = '',
  color           = '',
  file            = '',
  reference       = '',
  folder          = '',
  enumMember      = '',
  constant        = 'ﲀ',
  struct          = 'ﳤ',
  event           = '',
  operator        = '',
  typeParameter   = '',
  path            = '',
  buffer          = '',
  calc            = '',
  vsnip           = '',
}

Icons.lspkind = {
  Class         = Icons.lsp.class,
  Color         = Icons.lsp.color,
  Constant      = Icons.lsp.constant,
  Constructor   = Icons.lsp.constructor,
  Enum          = Icons.lsp.Enum,
  EnumMember    = Icons.lsp.enumMember,
  Event         = Icons.lsp.event,
  Field         = Icons.lsp.field,
  File          = Icons.lsp.file,
  Folder        = Icons.lsp.folder,
  Function      = Icons.lsp.func,
  Interface     = Icons.lsp.interface,
  Keyword       = Icons.lsp.keyword,
  Method        = Icons.lsp.method,
  Module        = Icons.lsp.module,
  Operator      = Icons.lsp.operator,
  Property      = Icons.lsp.property,
  Reference     = Icons.lsp.reference,
  Snippet       = Icons.lsp.snippet,
  Struct        = Icons.lsp.struct,
  Text          = Icons.lsp.text,
  TypeParameter = Icons.lsp.typeParameter,
  Unit          = Icons.lsp.unit,
  Value         = Icons.lsp.value,
  Variable      = Icons.lsp.variable,
}

Icons.file        = {
  default         = '',
  symlink         = '',
}

Icons.git         = {
  unstaged        = '',
  staged          = '',
  unmerged        = '',
  renamed         = '',
  untracked       = 'ﱡ',
  deleted         = '',
  ignored         = '',
  branch          = '',
  gitsigns_add    = '▎',
  gitsigns_change = '▎',
  gitsigns_delete = '', --  
}

Icons.folder      = {
  arrow_open      = '',
  arrow_closed    = '',
  default         = '',
  open            = '',
  empty           = '',
  empty_open      = '',
  symlink         = '',
  symlink_open    = '',
}

local border = {
  scrollbar = '█',

  -- h         = '─',
  -- v         = '│',
  -- lt        = '┌',
  -- lb        = '└',
  -- rt        = '┐',
  -- rb        = '┘',

  h    = '─',
  v    = '│',
  lt   = '╭',
  lb   = '╰',
  rt   = '╮',
  rb   = '╯',
  rm   = '┤',
  lm   = '├',

  -- h    = '━',
  -- v    = '┃',
  -- lt   = '┏',
  -- lb   = '┗',
  -- rt   = '┓',
  -- rb   = '┛',
  -- rm   = '┫',
  -- lm   = '┣',
}

Icons.borderchars = border

Icons.cmp_borderchars = { border.lt, border.h, border.rt, border.v, border.rb, border.h, border.lb, border.v }

return Icons;
