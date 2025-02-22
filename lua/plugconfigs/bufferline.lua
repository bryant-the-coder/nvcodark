local M = {}
local present, bufferline = pcall(require, 'bufferline')
local config = require('config')
local tables_utils = require('utils.tables')

if not present then
  return {
    setup = function ()
      error('[WARN/plugins/bufferline]: Cannot import bufferline')
    end
  }
end

function M.enable ()
  bufferline.setup(tables_utils.extend({
    highlights = {
      fill = {
        guibg = {
          attribute = "bg",
          highlight = "NvimTreeNormal"
        },
        guifg = {
          attribute = "fg",
          highlight = "Normal",
        },
      },
    },
    options = {
      numbers = "none",
      close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
      right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
      middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
      -- NOTE: this plugin is designed with this icon in mind,
      -- and so changing this is NOT recommended, this is intended
      -- as an escape hatch for people who cannot bear it for whatever reason
      indicator_icon = '▎',
      buffer_close_icon = '',
      modified_icon = '●',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      max_name_length = 18,
      max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
      tab_size = 18,
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = true,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        return "("..count..")"
      end,
      offsets = {{filetype = "NvimTree", text = ""}},
      show_buffer_icons = true, -- disable filetype icons for buffers
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      -- can also be a table containing 2 custom separators
      -- [focused and unfocused]. eg: { '|', '|' }
      always_show_bufferline = true,
    },
  }, config.tabbar.options))
end

function M.setup ()
  if config.tabbar.backend == 'bufferline' then
    M.enable()
  end
end

return M
