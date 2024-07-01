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
