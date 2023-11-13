vim.api.nvim_create_user_command("ConvertCursorNumber",
  function()
    require('cursor_number').convert(vim.fn.expand('<cword>'))
  end, {})
