return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    ft = vim.g.fts,
    dependencies = {
      "folke/neodev.nvim",
      "nvimdev/lspsaga.nvim",
    },
    config = function()
      local servers = {
        bashls = {},
        clangd = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = {
                  "vim",
                  "require",
                },
              },
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        jedi_language_server = {},
        vimls = {},
      }

      local on_attach = function(_, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<leader>pd", "<cmd>Lspsaga peek_definition<CR>", "Peek Definition")
        nmap("<leader>pr", require("telescope.builtin").lsp_references, "Peek References")
        nmap("<c-k>", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
        nmap("<leader>wl", function()
          vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "Workspace List Folders")
        nmap("<leader>rn", "<cmd>Lspsaga rename ++project<cr>", "Rename")
        nmap("<leader>ca", "<cmd>Lspsaga code_action<CR>", "Code Action")
        nmap("<leader>ot", "<cmd>Lspsaga outline<CR>", "OutLine")
        nmap("F", "<cmd>Lspsaga finder ref<CR>", "[F]inder")
        nmap("<leader>dp", vim.diagnostic.goto_prev, "Diangostics Prev")
        nmap("<leader>dn", vim.diagnostic.goto_next, "Diangostics Next")
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("neodev").setup({
        lspconfig = true,
        override = function(_, library)
          library.enabled = true
          library.plugins = true
          library.types = true
        end,
      })

      require("lspsaga").setup({
        outline = {
          layout = "float",
          keys = {
            quit = 'Q',
            toggle_or_jump = '<cr>',
          }
        },
        finder = {
          keys = {
            quit = 'Q',
            shuttle = 'J',
            toggle_or_open = '<cr>',
          },
        },
        definition = {
          keys = {
            edit = '<C-c>j',
          }
        },
        code_action = {
          keys = {
            quit = 'Q',
          }
        },
      })

      for server, config in pairs(servers) do
        require("lspconfig")[server].setup(vim.tbl_deep_extend("keep", {
          on_attach = on_attach,
          capabilities = capabilities,
        }, config))
      end

      vim.diagnostic.config({
        virtual_text = {
          prefix = '❯',
        }
      })

      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
          }
          vim.diagnostic.open_float(nil, opts)
        end
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    ft = vim.g.fts,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
          "L3MON4D3/LuaSnip",
          dependencies = {
            "rafamadriz/friendly-snippets",
          },
        },
      },
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
    },
    config = function()
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
            and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      require("luasnip.loaders.from_snipmate").lazy_load({ path = { "~/.config/nvim/snippets" } })
      local luasnip = require("luasnip")
      local cmp = require("cmp")
      --local lspkind = require('lspkind')
      cmp.setup({
        window = {
          completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
            border = "rounded",
            scrollbar = true,
          },
          documentation = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            border = "rounded",
            scrollbar = true,
          },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind =
                require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"

            return kind
          end,
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
              -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
              -- they way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),

        experimental = {
          ghost_text = true,
        },
      })
    end,
  }
}
