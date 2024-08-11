local config = {}

function config.cmp()
  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
      and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  local function snippet_replace(snippet, fn)
    return snippet:gsub('%$%b{}', function(m)
      local n, name = m:match('^%${(%d+):(.+)}$')
      return n and fn({ n = n, text = name }) or m
    end) or snippet
  end

  local function snippet_preview(snippet)
    local ok, parsed = pcall(function()
      return vim.lsp._snippet_grammar.parse(snippet)
    end)
    return ok and tostring(parsed)
      or snippet_replace(snippet, function(placeholder)
        return snippet_preview(placeholder.text)
      end):gsub('%$0', '')
  end

  local function snippet_fix(snippet)
    local texts = {} ---@type table<number, string>
    return snippet_replace(snippet, function(placeholder)
      texts[placeholder.n] = texts[placeholder.n] or snippet_preview(placeholder.text)
      return '${' .. placeholder.n .. ':' .. texts[placeholder.n] .. '}'
    end)
  end

  local function expand(snippet)
    local session = vim.snippet.active() and vim.snippet._session or nil

    local ok, err = pcall(vim.snippet.expand, snippet)
    if not ok then
      local fixed = snippet_fix(snippet)
      ok = pcall(vim.snippet.expand, fixed)

      local msg = ok and 'Failed to parse snippet,\nbut was able to fix it automatically.'
        or ('Failed to parse snippet.\n' .. err)
      vim.notify(
        ([[%s
            ```%s
            %s
            ```]]):format(msg, vim.bo.filetype, snippet),
        vim.log.levels.WARN
      )
    end

    -- Restore top-level session when needed
    if session then
      vim.snippet._session = session
    end
  end

  require('snippets').setup({ search_paths = { vim.fn.stdpath('config') .. '/snippets/' } })

  local cmp = require('cmp')
  cmp.setup({
    window = {
      completion = {
        winhighlight = 'Normal:CmpWin,FloatBorder:CmpWin,Search:None',
        col_offset = -3,
        side_padding = 0,
        border = 'rounded',
        scrollbar = true,
      },
      documentation = {
        winhighlight = 'Normal:CmpWin,FloatBorder:CmpWin,Search:None',
        border = 'rounded',
        scrollbar = true,
      },
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(_, vim_item)
        vim_item.menu = ' ' .. (vim_item.kind or '')
        vim_item.kind = _G.kind_icons[vim_item.kind] or ''
        return vim_item
      end,
    },
    snippet = {
      expand = function(args)
        expand(args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = 'snippets', priority = 100 },
      { name = 'nvim_lsp' },
      { name = 'buffer' },
    }),
    mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.snippet.active({ direction = 1 }) then
          vim.schedule(function()
            vim.snippet.jump(1)
          end)
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.snippet.active({ direction = -1 }) then
          vim.schedule(function()
            vim.snippet.jump(-1)
          end)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    experimental = {
      ghost_text = true,
    },
  })
end

return config
