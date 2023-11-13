local M = {}

M.config = {
  relative = 'cursor',
  width = 40,
  height = 4,
  col = 3,
  row = 1,
  style = 'minimal',
  border = 'double',
  focusable = false
}

local function close_preview_autocmd(winnr, bufnr)
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    buffer = bufnr,
    group = vim.api.nvim_create_augroup('cursor_number_float_win' .. winnr, {
      clear = true,
    }),
    callback = function()
      pcall(vim.api.nvim_del_augroup_by_name, 'cursor_number_float_win' .. winnr)
      pcall(vim.api.nvim_win_close, winnr, true)
    end,
  })
end

function M:open(content)
  local bufnr = vim.api.nvim_get_current_buf()
  local existing_float = vim.F.npcall(vim.api.nvim_buf_get_var, bufnr, 'cursor_number_float_win')

  if existing_float and vim.api.nvim_win_is_valid(existing_float) then
    vim.api.nvim_win_close(existing_float, true)
  end

  local float_bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(float_bufnr, 0, -1, true, content)
  vim.api.nvim_buf_set_var(bufnr, 'cursor_number_float_win', float_bufnr)

  self.win = vim.api.nvim_open_win(float_bufnr, false, self.config)
  vim.api.nvim_set_option_value('winhl', 'Normal:MyHighlight', { win = self.win })

  close_preview_autocmd(self.win, bufnr)
end

return M
