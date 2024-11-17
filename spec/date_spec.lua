describe("date", function()
  local t, to, date, timestamp
  setup(function()
    t = require "t"
    to = t.to
    date = t.date
    timestamp = t.timestamp
  end)
  it("date", function()
    local ts = "Sat Feb 24 17:11:49 GMT 2024"
    assert.equal(to.number(date(ts)), timestamp(ts))
  end)
end)