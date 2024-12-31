return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "csharpier", "netcoredbg" } },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "c_sharp" } },
  },
  {
    "Issafalcon/neotest-dotnet",
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.csharpier)
    end,
  },
  {
  "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      if not dap.adapters["netcoredbg"] then
        require("dap").adapters["netcoredbg"] = {
          type = "executable",
          command = vim.fn.exepath("netcoredbg"),
          args = { "--interpreter=vscode" },
          options = {
            detached = false,
          },
        }
      end
      for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {
            {
              type = "netcoredbg",
              name = "Launch file",
              request = "launch",
              ---@diagnostic disable-next-line: redundant-parameter
              program = function()
                return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
              end,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "Issafalcon/neotest-dotnet",
    },
    opts = {
      adapters = {
        ["neotest-dotnet"] = {
          -- Here we can set options for neotest-dotnet
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        cmake = { "cmakelint" },
      },
    },
  },
  -- {
  -- "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       omnisharp = {
  --         handlers = {
  --           ["textDocument/definition"] = function(...)
  --             return require("omnisharp_extended").handler(...)
  --           end,
  --         },
  --         keys = {
  --           {
  --             "gd",
  --             LazyVim.has("telescope.nvim") and function()
  --               require("omnisharp_extended").telescope_lsp_definitions()
  --             end or function()
  --               require("omnisharp_extended").lsp_definitions()
  --             end,
  --             desc = "Goto Definition",
  --           },
  --         },
  --         enable_roslyn_analyzers = true,
  --         organize_imports_on_format = true,
  --         enable_import_completion = true,
  --       },
  --     },
  --   },
  -- }
  {
  "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = {
          handlers = {
            ["textDocument/definition"] = function(...)
              return require("omnisharp_extended").handler(...)
            end,
            ["textDocument/typeDefinition"] = function(...)
              return require("omnisharp_extended").type_definition_handler(...)
            end,
            ["textDocument/references"] = function(...)
              return require("omnisharp_extended").references_handler(...)
            end,
            ["textDocument/implementation"] = function(...)
              return require("omnisharp_extended").implementation_handler(...)
            end,
          },
          keys = {
            {
              "gd",
              LazyVim.has("telescope.nvim") and function()
                require("omnisharp_extended").telescope_lsp_definitions()
              end or function()
                require("omnisharp_extended").lsp_definitions()
              end,
              desc = "Goto Definition",
            },
            -- Add a keybinding for formatting C# code with OmniSharp
            {
              "<leader>cf", -- Keybinding for formatting C#
              function()
                vim.lsp.buf.format({ async = true })
              end,
              desc = "Format C#",
            },
          },
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
          -- NEW
          settings = {
            FormattingOptions = {
              -- Enables support for reading code style, naming convention and analyzer
              -- settings from .editorconfig.
              EnableEditorConfigSupport = true,
              -- Specifies whether 'using' directives should be grouped and sorted during
              -- document formatting.
              OrganizeImports = nil,
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
              -- EnableAnalyzersSupport = nil,
              EnableAnalyzersSupport = true,
              -- Enables support for showing unimported types and unimported extension
              -- methods in completion lists. When committed, the appropriate using
              -- directive will be added at the top of the current file. This option can
              -- have a negative impact on initial completion responsiveness,
              -- particularly for the first few completion sessions after opening a
              -- solution.
              -- EnableImportCompletion = nil,
              EnableImportCompletion = true,
              -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
              -- true
              AnalyzeOpenDocumentsOnly = nil,
              EnableDecompilationSupport = true,
            },
          },
          -- NEW
        },
      },
    }
  }
}
