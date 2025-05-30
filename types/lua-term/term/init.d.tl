local Colors = require'term.colors'
local Cursor = require'term.cursor'

local record Term
   colors: Colors
   cursor: Cursor

   clear: function()
   cleareol: function()
   clearend: function()
end

return Term
