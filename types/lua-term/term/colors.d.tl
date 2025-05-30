local record Colors
   interface Color
      value: string
      metamethod __call: function(self, string): string
      metamethod __tostring: function(self): string
      metamethod __concat: function(self, any): string
   end

   reset:      Color
   clear:      Color
   default:    Color
   bright:     Color
   dim:        Color
   underscore: Color
   blink:      Color
   reverse:    Color
   hidden:     Color

   black:   Color
   red:     Color
   green:   Color
   yellow:  Color
   blue:    Color
   magenta: Color
   cyan:    Color
   white:   Color

   onblack:   Color
   onred:     Color
   ongreen:   Color
   onyellow:  Color
   onblue:    Color
   onmagenta: Color
   oncyan:    Color
   onwhite:   Color
end

return Colors
