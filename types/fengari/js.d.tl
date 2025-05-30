local record js
   -- javascript objects or symbols are stored as userdata
   interface Value
      is userdata

      metamethod __index: function(Value, string | integer): any
      metamethod __tostring: function(Value): string
      metamethod __newindex: function(Value, string | integer, any)
      metamethod __call: function(Value, ...: any): any

      metamethod __pairs: function(Value): (function(): (any...))
      metamethod __len: function(Value): integer
   end

   enum ProxyType
      "function"
      "arrow_function"
      "object"
   end

   enum Type
      "undefined"
      "object"
      "boolean"
      "number"
      "bigint"
      "string"
      "symbol"
      "function"
   end

   _VERSION: string
   _VERSION_NUM: string
   _RELEASE: string

   null: Value
   global: Value
   new: function(Value, ...: any): Value
   of: function(Value): (function(Value): (any), Value)

   -- additional items can be made with metatable entries below:
   --
   -- construct: function(self, ...): self
   -- defineProperty: function(self, prop, desc)
   -- getOwnPropertyDescriptor: function(self, prop)
   -- getPrototypeOf: function(self)
   -- ownKeys: function(self)
   -- setPrototypeOf: function(self, prototype)
   --
   -- other functions are handled specially:
   --
   -- deleteProperty: function(self, prop) => self[prop] = nil
   -- get: function(self, prop) => self[prop]
   -- has: function(self, k) => self[k] ~= nil
   -- set: function(self, k, v) => self[k] = v
   --
   createproxy: function(x: any, type ?: ProxyType): Value

   tonumber: function(any): number
   tostring: function(any): string
   instanceof: function(x: Value, class: Value): boolean
   typeof: function(any): Type
end

return js
