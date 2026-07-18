-- Hide default startup message
vim.opt.shortmess:append("I")
-- ──────────────────────────────────────────────────────────────
-- Header highlighting
-- ──────────────────────────────────────────────────────────────

local HEADER_COLORS = {
  Aqua   = { fg = "#89B482", lines = { 1, 2 } },
  Blue   = { fg = "#7DAEA3", lines = { 3, 4 } },
  Yellow = { fg = "#D8A657", lines = { 5, 6 } },
  Red    = { fg = "#EA6962", lines = { 7, 8 } },
}

local function color_header(start_line, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local ns = vim.api.nvim_create_namespace("dashboard_header")

  for group, cfg in pairs(HEADER_COLORS) do
    vim.api.nvim_set_hl(0, group, { fg = cfg.fg })

    for _, offset in ipairs(cfg.lines) do
      local line = start_line + offset - 1 -- 0-based
      vim.api.nvim_buf_add_highlight(bufnr, ns, group, line, 0, -1)
    end
  end

  -- Clear highlights on leave
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = bufnr,
    once = true,
    callback = function()
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    end,
  })
end

-- ──────────────────────────────────────────────────────────────
-- Centering utilities
-- ──────────────────────────────────────────────────────────────

local function center_line(line, width)
  local pad = math.floor((width - vim.api.nvim_strwidth(line)) / 2)
  return pad > 0 and (string.rep(" ", pad) .. line) or line
end

local function center_logo(lines)
  local win = 0
  local height = vim.api.nvim_win_get_height(win)
  local width = vim.api.nvim_win_get_width(win)

  -- Horizontal centering
  for i, line in ipairs(lines) do
    lines[i] = center_line(line, width)
  end

  -- Vertical centering
  local top_padding = math.max(0, math.floor((height - #lines) / 2))
  local padded = {}

  for _ = 1, top_padding do
    padded[#padded + 1] = ""
  end

  vim.list_extend(padded, lines)

  vim.api.nvim_buf_set_lines(0, 0, -1, false, padded)
  return top_padding
end

-- ──────────────────────────────────────────────────────────────
-- Buffer setup
-- ──────────────────────────────────────────────────────────────

local function disable_line_numbers()
  local win = vim.api.nvim_get_current_win()
  local prev = {
    number = vim.wo[win].number,
    relativenumber = vim.wo[win].relativenumber,
  }

  vim.wo[win].number = false
  vim.wo[win].relativenumber = false

  vim.api.nvim_create_autocmd("BufWinLeave", {
    once = true,
    callback = function()
      vim.wo[win].number = prev.number
      vim.wo[win].relativenumber = prev.relativenumber
    end,
  })
end

-- ──────────────────────────────────────────────────────────────
-- Dashboard
-- ──────────────────────────────────────────────────────────────

local function open_dashboard()
  vim.cmd("enew")

  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false

  disable_line_numbers()
  pcall(vim.cmd, "DisableWhitespace")

  local logo = {
    "      .       .   *            * ",
    "███╗   ██╗██╗   ██╗██╗███╗ ✦ ███╗",
    "████╗  ██║██║   ██║██║████╗ ████║",
    "██╔██╗ ██║██║ ✦ ██║██║██╔████╔██║",
    "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
    "██║ ╚████║.╚████╔╝ ██║██║ ╚═╝ ██║",
    "╚═╝ . ╚═══╝ ╚═══╝  ╚═╝╚═╝  *  ╚═╝",
    "    *    .      ✦          .     ",
  }

  local top = center_logo(logo)
  color_header(top, buf)
end

-- Only show dashboard when no file args are passed
if vim.fn.argc() == 0 then
  vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = open_dashboard,
  })
end
