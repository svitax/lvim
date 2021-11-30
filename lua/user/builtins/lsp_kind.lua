local lspkind = {}

local kind_symbols = {
  Class = "  ",
  -- Class = " ",
  Color = "  ",
  Constant = "  ",
  Constructor = "  ",
  Default = "  ",
  Enum = " 練 ",
  EnumMember = "  ",
  Event = "  ",
  -- Field = "  ",
  Field = "  ",
  -- File = " ",
  File = "  ",
  -- Folder = " ",
  Folder = "  ",
  Function = "  ",
  Interface = "  ",
  -- Keyword = " ",
  Keyword = "  ",
  Method = " ƒ ",
  Module = "  ",
  Operator = "  ",
  Property = "  ",
  -- Reference = " ",
  Reference = "  ",
  Snippet = "  ",
  Struct = "  ",
  Text = "  ",
  TypeParameter = "𝙏",
  Unit = " 塞 ",
  Value = "  ",
  Variable = "  ",
  Package = "  ",
  Namespace = "  ",
  Number = "#",
  Boolean = "⊨",
  Object = "⦿",
}

function lspkind.cmp_kind(kind)
  return kind_symbols[kind] or ""
end

function lspkind.symbols()
  return kind_symbols
end

return lspkind
