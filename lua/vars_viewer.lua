local M = {}

local options = {
    text_prefix = "",
    virt_text_win_col = 60,
    separator = " ",
}

local api = vim.api
local require_ok, locals = pcall(require, 'nvim-treesitter.locals')
local _, ts_utils = pcall(require, 'nvim-treesitter.ts_utils')
local _, utils = pcall(require, 'nvim-treesitter.utils')
local _, parsers = pcall(require, 'nvim-treesitter.parsers')
local _, queries = pcall(require, 'nvim-treesitter.query')

local old_variables = {}
function M.view(buf, variables, current_line, hl_namespace) 
  local lang = parsers.get_buf_lang(buf)

  if not parsers.has_parser(lang) or not queries.has_locals(lang) then
    return
  end

  local scope_nodes = locals.get_scopes(buf)
  local definition_nodes = locals.get_locals(buf)

  local virt_lines = {}

  local node_ids = {}
  for _, d in pairs(definition_nodes) do
    local node = (options.all_references and utils.get_at_path(d, 'reference.node'))
      or utils.get_at_path(d, 'definition.var.node')
      or utils.get_at_path(d, 'definition.parameter.node')
      or utils.get_at_path(d, 'definition.function.node')
    if node then
      local name = vim.treesitter.query.get_node_text(node, buf)
      local var_line, var_col = node:start()

      local evaluated = variables[name]
      if
        evaluated
        and not (options.filter_references_pattern and evaluated:find(options.filter_references_pattern))
      then -- evaluated local with same name exists
        -- is this name really the local or is it in another scope?
        -- TODO: handle closures
        local in_scope = var_line < current_line
        for _, scope in ipairs(scope_nodes) do
          if
            ts_utils.is_in_node_range(scope, var_line, var_col)
            and not ts_utils.is_in_node_range(scope, current_line, 0)
          then
            in_scope = false
            break
          end
        end

        if in_scope then
          if options.only_first_definition and not options.all_references then
            variables[name] = nil
          end
          if not node_ids[node:id()] then
            node_ids[node:id()] = true
            local has_changed = false
            local old_value = old_variables[name]
            if old_value == nil or old_value ~= evaluated then
                has_changed = true
            end
            local text = name .. ' = ' .. evaluated
            if options.commented then
              text = vim.o.commentstring:gsub('%%s', text)
            end
            text = options.text_prefix .. text

            if virt_lines[node:start()] then
              if options.virt_lines then
                text = ' ' .. options.separator .. text
              end
            else
              virt_lines[node:start()] = {}
            end
            table.insert(virt_lines[node:start()], {
              text,
              has_changed and 'NvimGdbVirtualTextChanged' or 'NvimGdbVirtualText',
              node = node,
            })
          end
        end
      end
    end
  end
  
  old_variables = variables

  for line, content in pairs(virt_lines) do
    -- Filtering necessary with all_references: there can be more than on reference on one line
    if options.all_references then
      local avoid_duplicates = {}
      content = vim.tbl_filter(function(c)
        local text = c[1]
        local was_duplicate = avoid_duplicates[text]
        avoid_duplicates[text] = true
        return not was_duplicate
      end, content)
    end
    if options.virt_lines then
      vim.api.nvim_buf_set_extmark(
        buf,
        hl_namespace,
        line,
        0,
        { virt_lines = { content }, virt_lines_above = options.virt_lines_above }
      )
    else
      local line_text = api.nvim_buf_get_lines(buf, line, line + 1, true)[1]
      local win_col = math.max(options.virt_text_win_col or 0, #line_text + 1)
      for i, virt_text in ipairs(content) do
        local node_range = { virt_text.node:range() }
        if i < #content then
          virt_text[1] = virt_text[1] .. options.separator
        end
        virt_text.node = nil
        vim.api.nvim_buf_set_extmark(buf, hl_namespace, node_range[1], node_range[2], {
          end_line = node_range[3],
          end_col = node_range[4],
          hl_mode = 'combine',
          virt_text = { virt_text },
          virt_text_pos = options.virt_text_pos,
          virt_text_win_col = options.virt_text_win_col and win_col,
        })
        win_col = win_col + #virt_text[1] + 1
      end
    end
  end
end

return M
