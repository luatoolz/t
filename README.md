# lua pluggable types library
```lua
local t = require "t"
```
- conventions based
- nginx / docker images focused
- pluggable:
  - `t.xxx.yyy` objects
  - `t.is` type tester
  - `t.assert` extensions to `luassert`
  - `t.fn` function helpers

## possible bugs and fixes
- _G write guard:12: writing a global Lua variable ('mongo') which may lead to race conditions between concurrent requests, so prefer the use of 'local' variables
  -  https://github.com/leafo/lapis/issues/708
