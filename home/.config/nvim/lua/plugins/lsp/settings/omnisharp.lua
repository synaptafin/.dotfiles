local settings = {
  FormattingOptions = {
    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
    EnableEditorConfigSupport = true,
    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    OrganizeImports = true,
  },
  MsBuild = {
    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    LoadProjectsOnDemand = nil,
  },
  RoslynExtensionsOptions = {
    -- Enables support for roslyn analyzers, code fixes and rulesets.
    EnableAnalyzersSupport = true, -- THIS ADED FIX FORMATTING ON EVERY SINGLE LINE IN CS FILES!
    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    EnableImportCompletion = nil,
    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    AnalyzeOpenDocumentsOnly = nil,
    enableDecompilationSupport = true,
  },
  Sdk = {
    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    IncludePrereleases = true,
  },
}

local omnisharp_dll_path = vim.env.HOME .. "/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll"

local opts = function(desc)
  return { noremap = true, silent = true, buffer = true, desc = desc }
end

local function override_keymap()
  vim.keymap.set('n', 'gd', function() require('omnisharp_extended').lsp_definition() end,
    opts("OmniExtend Go To Definition"))
  -- vim.keymap.set('n', 'gr', function() require('omnisharp_extended').telescope_lsp_references() end, opts("OmniExtend Go To Reference"))
  vim.keymap.set('n', 'gD', function() require('omnisharp_extended').telescope_lsp_type_definition() end,
    opts("OmniExtend Go To Type"))
  -- vim.keymap.set('n', 'gi', function() require('omnisharp_extended').telescope_lsp_implementation() end,
  --   opts("OmniExtend Go To Implementation"))
  vim.keymap.set('n', 'gi',
    require('plugins.fzf-lua').fzf_lua_implementations_with_opts,
    opts("Go To Implementation")
  )
  vim.keymap.set('n', 'gv',
    function() require('plugins.lsp.utilities').operation_in_split(require('omnisharp_extended').lsp_definition) end,
    opts("Go To Definition In Split")
  )
end

vim.api.nvim_create_augroup("OmnisharpLsp", { clear = true })
vim.api.nvim_create_autocmd(
  "BufEnter",
  {
    group = "OmnisharpLsp",
    pattern = { "*.cs", "*.vb" },
    callback = function()
      override_keymap()
    end
  }
)

return {
  cmd = { "dotnet", omnisharp_dll_path },
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
    ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
    ["textDocument/references"] = require('omnisharp_extended').references_handler,
    ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
  },
  settings = settings,
  enable_roslyn_analyzers = true, -- default false
  on_attach = function(_)
    vim.g.dotnetlsp = "omnisharp"
    vim.cmd('LspStart omnisharp')
  end
}
