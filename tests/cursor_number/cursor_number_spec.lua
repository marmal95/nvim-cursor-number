local plugin = require("cursor_number")
local module = require("cursor_number.module")

describe("parse", function()
  it("bin", function()
    assert.are.equal(module.parse("0b0100"), 4)
    assert.are.equal(module.parse("0B0110"), 6)
  end)

  it("oct", function()
    assert.are.equal(module.parse("0710"), 456)
  end)

  it("hex", function()
    assert.are.equal(module.parse("0x4F"), 79)
    assert.are.equal(module.parse("0x4A"), 74)
  end)

  it("dec", function()
    assert.are.equal(module.parse("123"), 123)
  end)
end)

describe("convert", function()
  it("dec", function()
    assert.are.same(module.convert(123),
      {
        "dec: 123",
        "bin: 1111011",
        "oct: 173",
        "hex: 7b"
      }
    )
  end)
end)
