-- [nfnl] Compiled from nvim-10-lspconfig-lua.fnl by https://github.com/Olical/nfnl, do not edit.
local function lsp_keybinds(event)
  local fzf = require("fzf-lua")
  local map
  local function _1_(keys, func, desc)
    return vim.keymap.set("n", keys, func, {buffer = event.buf, desc = ("LSP: " .. desc)})
  end
  map = _1_
  local function _2_()
    return fzf.lsp_definitions()
  end
  map("gd", _2_, "[G]oto [D]efinition")
  local function _3_()
    return fzf.lsp_references()
  end
  map("gr", _3_, "[G]oto [R]eferences")
  local function _4_()
    return fzf.lsp_implementations()
  end
  map("gI", _4_, "[G]oto [I]mplementation")
  local function _5_()
    return fzf.lsp_typedefs()
  end
  map("<leader>D", _5_, "Type [D]efinition")
  local function _6_()
    return fzf.lsp_document_symbols()
  end
  map("<leader>ds", _6_, "[D]ocument [S]ymbols")
  local function _7_()
    return fzf.lsp_dynamic_workspace_symbols()
  end
  map("<leader>ws", _7_, "[W]orkspace [S]ymbols")
  local function _8_()
    return vim.lsp.buf.rename()
  end
  map("<leader>rn", _8_, "[R]e[n]ame")
  local function _9_()
    return vim.lsp.buf.code_action()
  end
  map("<leader>ca", _9_, "[C]ode [A]ction")
  local function _10_()
    return vim.lsp.buf.hover()
  end
  map("K", _10_, "Hover Documentation")
  local function _11_()
    return vim.lsp.buf.signature_help()
  end
  map("<C-h>", _11_, "Signature [h]elp")
  local function _12_()
    return vim.lsp.buf.declaration()
  end
  map("gD", _12_, "[G]oto [D]eclaration")
  do
    local bufopts = {noremap = true, silent = true, buffer = event.buf}
    local function _13_()
      return vim.diagnostic.open_float()
    end
    vim.keymap.set("n", "<space>e", _13_, bufopts, {desc = "LSP: Display Error"})
  end
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if (client and client.server_capabilities.documentHighlightProvider) then
    local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", {clear = false})
    vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {buffer = event.buf, group = highlight_augroup, callback = vim.lsp.buf.document_highlight})
    vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {buffer = event.buf, group = highlight_augroup, callback = vim.lsp.buf.clear_references})
    local function _14_(event2)
      vim.lsp.buf.clear_references()
      return vim.api.nvim_clear_autocmds({group = "kickstart-lsp-highlight", buffer = event2.buf})
    end
    vim.api.nvim_create_autocmd("LspDetach", {group = vim.api.nvim_create_augroup("kickstart-lsp-detach", {clear = true}), callback = _14_})
  else
  end
  if (client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint) then
    local function _16_()
      return vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end
    map("<leader>th", _16_, "[T]oggle Inlay [H]ints")
  else
  end
  if (client and (client.name == "ionide")) then
    local function _18_(e, r, c)
      return nil
    end
    vim.lsp.codelens.on_codelens = _18_
    return nil
  else
    return nil
  end
end
vim.api.nvim_create_autocmd("LspAttach", {group = vim.api.nvim_create_augroup("UserLspConfig", {clear = true}), callback = lsp_keybinds})
local lsp = require("lspconfig")
local capabilities
do
  local blink = require("blink.cmp")
  capabilities = blink.get_lsp_capabilities()
end
lsp.fennel_ls.setup({capabilities = capabilities})
lsp.nixd.setup({capabilities = capabilities})
lsp.clojure_lsp.setup({capabilities = capabilities})
lsp.lua_ls.setup({capabilities = capabilities})
lsp.basedpyright.setup({capabilities = capabilities})
lsp.hls.setup({capabilities = capabilities, cmd = {"haskell-language-server-wrapper", "--lsp"}, filetypes = {"haskell", "lhaskell"}})
return lsp.yamlls.setup({settings = {yaml = {schemas = {["https://raw.githubusercontent.com/oyvindberg/bleep/master/schema.json"] = "bleep.yaml"}}}})
