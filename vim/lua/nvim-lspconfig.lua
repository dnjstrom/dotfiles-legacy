-- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
-- https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c

local nvim_lsp = require('lspconfig')

-- Make a better format on save
local format_async = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end

    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()

        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)

        if bufnr == vim.api.nvim_get_current_buf() then
            vim.api.nvim_command("noautocmd :update")
        end
    end
end

vim.lsp.handlers["textDocument/formatting"] = format_async

-- show diagnostics on hover instead of inline
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    signs = true,
  }
)
vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
vim.cmd [[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]]

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting_sync()")


  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- Format on save if formatting is available
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec([[
       augroup LspAutocommands
         autocmd! * <buffer>
         " autocmd BufWritePre <buffer> LspOrganizeImports
         autocmd BufWritePre <buffer> LspFormatting
       augroup END
     ]], true)
  end
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "rust_analyzer" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

local organize_imports_sync = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(0)
    local params = {
        command = "_typescript.organizeImports",
        arguments = {name},
        title = ""
    }
    vim.lsp.buf_request_sync(bufnr, "workspace/executeCommand", params, 500)
end


-- Disable formatting for tsserver
nvim_lsp.tsserver.setup {
    init_options = {
      preferences = {
        importModuleSpecifierPreference = "relative"
      }
    },

    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
    end,

  commands = {
    LspOrganizeImports = {
      organize_imports_sync,
      description = "Organize imports (synchronously)"
    }
  }
}

-- Set up eslint, stylelint and prettier via diagnosticls
local linters = {
    eslint = {
        sourceName = "eslint",
        command = "eslint_d",
        rootPatterns = {".eslintrc.js", "package.json"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
        parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity"
        },
        securities = {[2] = "error", [1] = "warning"}
    },
    stylelint = {
        sourceName = "stylelint",
        command = "stylelint_d",
        rootPatterns = {".stylelintrc.js", "package.json"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath", "--formatter", "json"},
        parseJson = {
            errorsRoot = "[0].warnings",
            line = "line",
            column = "column",
            message = "${text}",
            security = "severity"
        },
        securities = {error = "error", warning = "warning"}
    },
}

local filetypes = {
    typescript = "eslint",
    typescriptreact = "eslint",
    css = "stylelint",
    scss = "stylelint",
}

local formatters = {
    eslint = {command = "eslint_d ", args = {"--fix-to-stdout", "--stdin", "--stdin-filename", "%filename"}},
    stylelint = {command = "stylelint_d ", args = {"--fix-to-stdout", "--stdin", "--stdin-filename", "%filename"}},
    prettier = {command = "prettier_d_slim", args = {"--stdin", "--stdin-filepath", "%filepath"}}
}

local formatFiletypes = {
    javascript =  "prettier",
    javascriptreact =  "prettier",
    typescript =  "prettier",
    typescriptreact =  "prettier",
    json = "prettier",
    css = "prettier" ,
    scss = "prettier" ,
    html = "prettier",
    yaml = "prettier",
    markdown = "prettier"
}

nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = vim.tbl_keys(formatFiletypes),
    init_options = {
        filetypes = filetypes,
        linters = linters,
        formatters = formatters,
        formatFiletypes = formatFiletypes
    }
}

