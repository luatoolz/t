describe("logger", function()
  local t
  setup(function()
    t = require "t"
  end)
  it("std", function()
    assert.callable(t.logger)
    assert.callable(t.logger.info)
    assert.callable(t.logger.warn)
    assert.callable(t.logger.fatal)
  end)
end)
