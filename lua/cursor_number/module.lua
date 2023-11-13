---@class M
local M = {}

---@param num number
local function to_binary(num)
  local bin = "" -- Create an empty string to store the binary form
  local rem      -- Declare a variable to store the remainder

  -- This loop iterates over the number, dividing it by 2 and storing the remainder each time
  -- It stops when the number has been divided down to 0
  while num > 0 do
    rem = num % 2             -- Get the remainder of the division
    bin = rem .. bin          -- Add the remainder to the string (in front, since we're iterating backwards)
    num = math.floor(num / 2) -- Divide the number by 2
  end

  return bin -- Return the string
end

---@param str string
---@param pattern string
local function starts_with(str, pattern)
  return string.lower(str):find('^' .. pattern) ~= nil
end

---@param cword string
M.parse = function(cword)
  if starts_with(cword, "0b") then
    return tonumber(string.sub(cword, 3, -1), 2)
  elseif starts_with(cword, "0x") then
    return tonumber(string.sub(cword, 3, -1), 16)
  elseif starts_with(cword, "0") then
    return tonumber(cword, 8)
  end
  return tonumber(cword, 10)
end

---@param dec_num number
M.convert = function(dec_num)
  return {
    "dec: " .. dec_num,
    "bin: " .. to_binary(dec_num),
    "oct: " .. string.format("%o", dec_num),
    "hex: " .. string.format("%x", dec_num),
  }
end

return M
