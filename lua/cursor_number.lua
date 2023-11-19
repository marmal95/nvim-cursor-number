---@class MyModule
local M = {}

M.config = {

}

local function create_user_command()
  vim.api.nvim_create_user_command("ConvertCursorNumber",
    function()
      M.convert(vim.fn.expand('<cword>'))
    end, {})
end

---@param args Config?
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
  create_user_command()
end

---@param curword string
M.convert = function(curword)
  local module = require("cursor_number.module")

  local dec_num = module.parse(curword)

  if curword ~= tostring(dec_num) then
    vim.notify('Number too big.', vim.log.levels.WARN)
    return
  end

  if not dec_num then
    vim.notify('No numeric value under cursor.', vim.log.levels.WARN)
    return
  end

  local content = module.convert(dec_num)
  require('cursor_number.float'):open(content)
end

return M
