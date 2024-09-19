local M = {}

function M.get(spec, _)
  local diag = spec.diag
  local diff = spec.diff

  return {
    Normal = { bg = spec.bg1, fg = spec.fg1 },
    NormalFloat = { bg = spec.bg0 },
    NormalNC = { link = "Normal" },
    Visual = { bg = spec.bg3 },
    VisualNOS = { link = "Visual" },

    EndOfBuffer = { fg = spec.bg1 },
    Title = { fg = spec.fg1, style = "bold" },
    Whitespace = { fg = spec.bg3 },
    NonText = { fg = spec.bg3 },
    Conceal = { link = "NonText" },
    SpecialKey = { link = "NonText" },

    CursorLine = { bg = spec.bg2 },
    CursorColumn = { link = "CursorLine" },
    CursorLineNr = { fg = spec.p2, style = "bold" },
    LineNr = { fg = spec.fg3 },
    ColorColumn = { bg = spec.bg3 },

    Cursor = { fg = spec.bg1, bg = spec.fg1 },
    lCursor = { link = "Cursor" },
    CursorIM = { link = "Cursor" },

    SignColumn = { fg = spec.fg3 },
    SignColumnSB = { link = "SignColumn" },

    FoldColumn = { fg = spec.fg3 },
    Folded = { fg = spec.fg3, bg = spec.bg2 },

    StatusLine = { fg = spec.bg2, bg = spec.fg2 },
    StatusLineNC = { fg = spec.fg0, bg = spec.bg0 },
    TabLine = { fg = spec.fg2, bg = spec.bg2 },
    TabLineFill = { bg = spec.bg0 },
    TabLineSel = { fg = spec.bg3, bg = spec.fg3 },

    WinSeparator = { link = "Normal" },
    WinBarNC = { bg = spec.bg0, fg = spec.fg3 },
    WinBar = { bg = spec.bg0, fg = spec.fg3, style = "bold" },
    VertSplit = { link = "WinSeparator" },

    FloatBorder = { fg = spec.fg1 },

    Search = { bg = spec.sel0, fg = spec.bg1 },
    Substitute = { bg = diag.error, fg = spec.bg1 },
    IncSearch = { bg = diag.info, fg = spec.bg1 },
    CurSearch = { link = "IncSearch" },

    SpellBad = { sp = diag.error, style = "undercurl" },
    SpellCap = { sp = diag.warn, style = "undercurl" },
    SpellLocal = { sp = diag.info, style = "undercurl" },
    SpellRare = { sp = diag.info, style = "undercurl" },

    DiffAdd = { bg = diff.add },
    DiffChange = { bg = diff.change },
    DiffDelete = { bg = diff.delete },
    DiffText = { bg = diff.text },

    Pmenu = { bg = spec.bg2 },
    PmenuSbar = { link = "Pmenu" },
    PmenuSel = { bg = spec.fg2, fg = spec.bg2 },
    PmenuThumb = { bg = spec.bg3 },
    WildMenu = { link = "Pmenu" },

    MsgArea = { fg = spec.fg2 },
    ModeMsg = { fg = diag.ok, style = "bold" },
    MoreMsg = { fg = diag.info, style = "bold" },
    Question = { link = "MoreMsg" },
    ErrorMsg = { fg = diag.error },
    WarningMsg = { fg = diag.warn },

    QuickFixLine = { bg = diag.info, fg = spec.bg2 },
    MatchParen = { fg = diag.warn, style = "bold" },
    Directory = { fg = spec.p1 },
  }
end

return M
