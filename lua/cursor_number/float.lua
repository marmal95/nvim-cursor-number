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

function M:open(content)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, true, content)

  self.win = vim.api.nvim_open_win(buf, false, self.config)
  vim.api.nvim_set_option_value('winhl', 'Normal:MyHighlight', { win = self.win })

  vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function()
      if self.win and vim.api.nvim_win_is_valid(self.win) then
        vim.api.nvim_win_close(self.win, true)
      end
      return true
    end,
  })
end

return M
