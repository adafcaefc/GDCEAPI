
# GDCEAPI

**Simple and easy to use Geometry Dash API made in Cheat Engine Lua and Assembly.**

----

**GDDocs** is a project built to openly give advanced information and readable information for aspiring developers looking to interface with Geometry Dash. Primarily, we aim to create this as a website for people to learn more about the inner workings of geometry dash, along with it's data.

## Example
**You will require Cheat Engine `>=7.1` to run this API.**

```lua
require 'API.lua'

if setFPS(60) then 
  showMessageBox("FPS is set to <cg>60</c>", "Success!", 400)
end
```
