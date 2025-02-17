local record Cursor
   jump:    function(FILE, integer, integer)
   jump:    function(integer, integer)

   goup:    function(FILE, integer)
   goup:    function(integer)

   godown:  function(FILE, integer)
   godown:  function(integer)

   goright: function(FILE, integer)
   goright: function(integer)

   goleft:  function(FILE, integer)
   goleft:  function(integer)

   save:    function(FILE)
   save:    function()

   restore: function(FILE)
   restore: function()
end

return Cursor
