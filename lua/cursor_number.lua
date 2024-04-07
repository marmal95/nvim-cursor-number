---@class MyModule
local M = {}

M.config = {

}

local function create_user_commands()
  vim.api.nvim_create_user_command("ConvertCursorNumberBin",
    function()
      M.convert(vim.fn.expand('<cword>'), 2)
    end, {})
  vim.api.nvim_create_user_command("ConvertCursorNumberOct",
    function()
      M.convert(vim.fn.expand('<cword>'), 8)
    end, {})
  vim.api.nvim_create_user_command("ConvertCursorNumberHex",
    function()
      M.convert(vim.fn.expand('<cword>'), 16)
    end, {})
  vim.api.nvim_create_user_command("ConvertCursorNumber",
    function()
      M.convert(vim.fn.expand('<cword>'), nil)
    end, {})
end

---@param args Config?
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
  create_user_commands()
end

---@param curword string
M.convert = function(curword, number_system)
  local module = require("cursor_number.module")

  local dec_num = module.parse(curword, number_system)

  if not dec_num then
    vim.notify('No proper numeric value under cursor.', vim.log.levels.WARN)
    return
  end

  local content = module.convert(dec_num)
  require('cursor_number.float'):open(content)
end

return M
