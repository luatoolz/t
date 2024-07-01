describe("typehandler", function()
  local t, bytyoe
  setup(function()
    require "compat53"
    t = require "t"
    typehandler = require "t.typehandler"
  end)
  it("type(self)", function()
    local tt = typehandler({
      ["nil"] = function(self, ...) return type(self) end,
      number = function(self, ...) return type(self) end,
      string = function(self, ...) return type(self) end,
      table = function(self, ...) return type(self) end,
    })
    assert.equal('nil', tt(nil))
    assert.equal('number', tt(5))
    assert.equal('string', tt("self"))
    assert.equal('table', tt({}))
  end)
end)
