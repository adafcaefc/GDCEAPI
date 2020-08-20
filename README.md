
# GDCEAPI

**Simple and easy to use Geometry Dash API made in Cheat Engine Lua and Assembly.**

----


## Example
**You will require Cheat Engine `>=7.1` to run this API.**

```lua
require 'API.lua'

FPS_VALUE = 144

if setFPS(FPS_VALUE) then 
  showMessageBox(("FPS is set to <cg>%i</c>"):format(FPS_VALUE), "Success!", 400)
end
```
