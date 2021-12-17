local lspkind = {}

local kind_symbols = {
  Class = "  ",
  -- Class = " ",
  Color = "  ",
  Constant = "  ",
  Constructor = "  ",
  Default = "  ",
  Enum = "  ",
  EnumMember = "  ",
  Event = "  ",
  Field = "  ",
  -- Field = "  ",
  -- File = " ",
  File = "  ",
  -- Folder = " ",
  Folder = "  ",
  Function = "ƒ  ",
  Interface = "  ",
  -- Keyword = " ",
  Keyword = "  ",
  Method = "  ",
  Module = "  ",
  Operator = "  ",
  Property = "  ",
  -- Reference = " ",
  Reference = "  ",
  Snippet = "  ",
  Struct = "  ",
  Text = "  ",
  TypeParameter = "  ",
  Unit = "塞  ",
  Value = "  ",
  Variable = "  ",
  Package = "  ",
  Namespace = "  ",
  Number = "  ",
  Boolean = "  ",
  Object = "  ",
}

lspkind.icons = {
  error = " ",
  warn = " ",
  info = "",
  hint = " ",
  code_action = "",
  test = "",
  docs = "",
  clock = " ",
  calendar = " ",
  buffer = " ",
  settings = " ",
  ls_inactive = "轢",
  ls_active = "歷",
  question = "",
  screen = "冷",
  dart = " ",
  config = " ",
  git = "",
  magic = " ",
}

function lspkind.cmp_kind(kind)
  return kind_symbols[kind] or ""
end

function lspkind.symbols()
  return kind_symbols
end

return lspkind
