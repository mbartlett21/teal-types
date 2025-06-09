local record lsqlite3
   interface DatabasePtr end
   interface Result end
   interface AACode end

   interface OpenFlags
      metamethod __bor: function(self, OpenFlags): OpenFlags
      metamethod __add: function(self, OpenFlags): OpenFlags
   end

   type SqlValue = string | number | integer
   type ParamValue = string | number | integer | boolean

   interface Statement

      columns: function(self): integer
      finalize: function(self): Result

      bind_parameter_count: function(self): integer
      bind_parameter_name: function(self, n: integer): string

      bind: function(self, n: integer, value ?: ParamValue): Result
      bind_blob: function(self, n: integer, value: string)

      bind_names: function(self, tbl: {(string|integer):ParamValue})
      bind_names: function(self, tbl: {string:ParamValue})
      bind_names: function(self, tbl: {ParamValue})

      -- count of parameters should match stmt:bind_parameter_count()
      bind_values: function(self, ...: ParamValue): Result

      -- note that types are the declared type, not the actual type
      get_named_types: function(self): {string:string}
      get_named_values: function(self): {string:ParamValue}

      get_name: function(self, n: integer): string
      get_names: function(self): {string}
      get_unames: function(self): string...

      -- note that types are the declared type, not the actual type
      get_type: function(self, n: integer): string
      get_types: function(self): {string}
      get_utypes: function(self): string...

      get_value: function(self, n: integer): SqlValue
      get_values: function(self): {SqlValue}
      get_uvalues: function(self): SqlValue...

      isopen: function(self): boolean

      reset: function(self): Result

      last_insert_rowid: function(self): integer

      -- returns BUSY | DONE | ROW | ERROR | MOSUSE
      step: function(self): Result

      nrows: function(self): function(Statement): ({string:SqlValue}), Statement
      rows:  function(self): function(Statement): ({SqlValue}), Statement
      urows: function(self): function(Statement): (SqlValue...), Statement
   end

   interface Context<A>
      user_data: function(self): A

      aggregate_count: function(self): integer
      get_aggregate_data: function(self): A
      set_aggregate_data: function(self, A)

      result: function(self, number | string)
      result_null: function(self)
      result_number: function(self, number)
      result_double: function(self, number)
      result_int: function(self, integer)
      result_text: function(self, string)
      result_blob: function(self, string)
      result_error: function(self, string)
   end

   interface Database
      busy_handler: function<A>(self, function(A, integer): (boolean), ? A)
      busy_timeout: function(self, integer)

      changes: function(self): integer
      total_changes: function(self): integer
      errcode: function(self): Result
      errmsg: function(self): string

      interrupt: function(self)

      close: function(self): Result
      close_vm: function(self, temponly: boolean)
      get_ptr: function(self): DatabasePtr
      create_aggregate: function<A>(self,
         name: string,
         nargs: integer,
         step: function(Context<A>, SqlValue...), -- errors should be done through error(...)x
         final: function(Context<A>),
         dat ?: A): boolean
      create_collation: function(self, name: string,
         func: function(string, string): integer): boolean
      create_function: function<A>(self,
         name: string,
         nargs: integer,
         func: function(Context<A>, SqlValue...), -- errors should be done through error(...)x
         dat ?: A): boolean
      load_extension: function(self, name ?: string, entry ?: string): boolean, string

      db_filename: function(self, name: string): string
      isopen: function(self): string
      last_insert_rowid: function(self): integer

      total_changes: function(self): integer
      trace: function<A>(self,
         func: function(A, string), -- errors are ignored
         udata ?: A)
      update_hook: function<A>(self,
         func: function(A, AACode, db: string, tn: string, row: integer), -- errors are ignored
         udata ?: A)
      commit_hook: function<A>(self,
         should_rollback: function(A): (boolean), -- errors == continue; no rollback
         udata ?: A)
      rollback_hook: function<A>(self,
         func: function(A), -- errors are ignored
         udata ?: A)

      progress_handler: function<A>(self,
         n: integer,
         should_abort: function(A): (boolean), -- errors == abort
         udata ?: A)

      prepare: function(self, sql: string): Statement

      exec: function<A>(self,
         sql: string,
         fn ?: function(A, integer, {any}, {string}): (Result),
         udata ?: A): Result

      nrows: function(self, sql: string): function(Statement): ({string:SqlValue}), Statement
      rows:  function(self, sql: string): function(Statement): ({SqlValue}), Statement
      urows: function(self, sql: string): function(Statement): (SqlValue...), Statement
   end

   interface DbBackup
      step: function(self, npages: integer): Result
      remaining: function(self): integer
      pagecount: function(self): integer
      finish: function(self): Result
   end

   OK:         Result -- 0
   ERROR:      Result -- 1
   INTERNAL:   Result -- 2
   PERM:       Result -- 3
   ABORT:      Result -- 4
   BUSY:       Result -- 5
   LOCKED:     Result -- 6
   NOMEM:      Result -- 7
   READONLY:   Result -- 8
   INTERRUPT:  Result -- 9
   IOERR:      Result -- 10
   CORRUPT:    Result -- 11
   NOTFOUND:   Result -- 12
   FULL:       Result -- 13
   CANTOPEN:   Result -- 14
   PROTOCOL:   Result -- 15
   EMPTY:      Result -- 16
   SCHEMA:     Result -- 17
   TOOBIG:     Result -- 18
   CONSTRAINT: Result -- 19
   MISMATCH:   Result -- 20
   MISUSE:     Result -- 21
   NOLFS:      Result -- 22
   FORMAT:     Result -- 24
   RANGE:      Result -- 25
   NOTADB:     Result -- 26
   ROW:        Result -- 100
   DONE:       Result -- 101

   CREATE_INDEX:        AACode --  1   Index Name      Table Name
   CREATE_TABLE:        AACode --  2   Table Name      NULL
   CREATE_TEMP_INDEX:   AACode --  3   Index Name      Table Name
   CREATE_TEMP_TABLE:   AACode --  4   Table Name      NULL
   CREATE_TEMP_TRIGGER: AACode --  5   Trigger Name    Table Name
   CREATE_TEMP_VIEW:    AACode --  6   View Name       NULL
   CREATE_TRIGGER:      AACode --  7   Trigger Name    Table Name
   CREATE_VIEW:         AACode --  8   View Name       NULL
   DELETE:              AACode --  9   Table Name      NULL
   DROP_INDEX:          AACode -- 10   Index Name      Table Name
   DROP_TABLE:          AACode -- 11   Table Name      NULL
   DROP_TEMP_INDEX:     AACode -- 12   Index Name      Table Name
   DROP_TEMP_TABLE:     AACode -- 13   Table Name      NULL
   DROP_TEMP_TRIGGER:   AACode -- 14   Trigger Name    Table Name
   DROP_TEMP_VIEW:      AACode -- 15   View Name       NULL
   DROP_TRIGGER:        AACode -- 16   Trigger Name    Table Name
   DROP_VIEW:           AACode -- 17   View Name       NULL
   INSERT:              AACode -- 18   Table Name      NULL
   PRAGMA:              AACode -- 19   Pragma Name     1st arg or NULL
   READ:                AACode -- 20   Table Name      Column Name
   SELECT:              AACode -- 21   NULL            NULL
   TRANSACTION:         AACode -- 22   Operation       NULL
   UPDATE:              AACode -- 23   Table Name      Column Name
   ATTACH:              AACode -- 24   Filename        NULL
   DETACH:              AACode -- 25   Database Name   NULL
   ALTER_TABLE:         AACode -- 26   Database Name   Table Name
   REINDEX:             AACode -- 27   Index Name      NULL
   ANALYZE:             AACode -- 28   Table Name      NULL
   CREATE_VTABLE:       AACode -- 29   Table Name      Module Name
   DROP_VTABLE:         AACode -- 30   Table Name      Module Name
   FUNCTION:            AACode -- 31   NULL            Function Name
   SAVEPOINT:           AACode -- 32   Operation       Savepoint Name
   RECURSIVE:           AACode -- 33   NULL            NULL


   OPEN_CREATE: OpenFlags
   OPEN_FULLMUTEX: OpenFlags
   OPEN_MEMORY: OpenFlags
   OPEN_NOMUTEX: OpenFlags
   OPEN_PRIVATECACHE: OpenFlags
   OPEN_READONLY: OpenFlags
   OPEN_READWRITE: OpenFlags
   OPEN_SHAREDCACHE: OpenFlags
   OPEN_URI: OpenFlags

   complete: function(s: string): boolean

   -- flags default to OPEN_READWRITE | OPEN_CREATE
   open: function(fn: string, flags ?: OpenFlags): Database, Result, string

   open_memory: function(): Database, Result, string

   open_ptr: function(DatabasePtr): Database

   backup_init: function(tgt: Database, tgt_name: string, src: Database, src_name: string): DbBackup

   temp_directory: function(new ?: string): string
   version: function(): string
   lversion: function(): string
end

return lsqlite3
