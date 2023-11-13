---@class MyModule
local M = {}

M.config = {

}

---@param args Config?
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

---@param curword string
M.convert = function(curword)
  local module = require("cursor_number.module")

  local dec_num = module.parse(curword)

  if not dec_num then
    vim.notify('No numeric value under cursor.', vim.log.levels.WARN)
    return
  end

  local content = module.convert(dec_num)
  require('cursor_number.float'):open(content)
end

return M
