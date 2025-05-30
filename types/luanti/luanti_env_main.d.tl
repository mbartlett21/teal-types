local interface NodeDef


end

global record vector
   x: number
   y: number
   z: number
end

global record core
   enum MapgenAlias
      -- required aliases
      "mapgen_stone"
      "mapgen_water_source"
      "mapgen_river_water_source"

      -- optional aliases for non-V6 (required for V6)
      "mapgen_lava_source"
      "mapgen_cobble"

      -- required aliases for V6
      "mapgen_dirt"
      "mapgen_dirt_with_grass"
      "mapgen_sand"
      "mapgen_tree"
      "mapgen_leaves"
      "mapgen_apple"

      -- optional aliases for V6
      "mapgen_gravel"
      "mapgen_desert_stone"
      "mapgen_desert_sand"
      "mapgen_dirt_with_snow"
      "mapgen_snowblock"
      "mapgen_snow"
      "mapgen_ice"
      "mapgen_jungletree"
      "mapgen_jungleleaves"
      "mapgen_junglegrass"
      "mapgen_pine_tree"
      "mapgen_pine_needles"
      "mapgen_stair_cobble"
      "mapgen_mossycobble"
      "mapgen_stair_desert_stone"
      "mapgen_singlenode"
   end

   get_color_escape_sequence: function(c: ColorString): string
   colorize: function(c: ColorString, message: string): string
   get_background_escape_sequence: function(c: ColorString): string
   strip_foreground_colors: function(string): string
   strip_background_colors: function(string): string
   strip_colors: function(string): string

   wrap_text: function(s: string, limit: integer, as_table: boolean): {string} | string
   wrap_text: function(s: string, limit: integer): string

   pos_to_string: function(vector, decimal_places ?: integer): string
   string_to_pos: function(string): vector

   string_to_area: function(string, ? vector): vector, vector

   formspec_escape: function(string): string
   is_yes: function(string | number): boolean
   is_nan: function(number): boolean
   get_us_time: function(): number

   pointed_thing_to_face_pos: function(placer, pointed_thing): vector
   get_tool_wear_after_use: function(uses: integer, initial_wear: number): number
   get_dig_params: function(groups: {Group}, tool_capabilities: TODO, wear ?: number): TODO
   get_hit_params: function(groups: {Group}, tool_capabilities: TODO, time_from_last_punch ?: number, wear ?: number): TODO

   type TrStr = string

   translate: function(domain: string, str: string, ...: string): TrStr
   translate_n: function(domain: string, str: string, str_plural: string, n: integer, ...: string): TrStr
   get_translator: function(domain: string): (function(string, ...: string): (TrStr), function(string, string, integer, ...: string): (TrStr))

   get_translated_string: function(lang: string, trstr: TrStr): string

   get_voxel_manip: function(p1 ?: vector, p2 ?: vector): VoxelManip

   CONTENT_UNKNOWN: integer
   CONTENT_AIR: integer
   CONTENT_IGNORE: integer

   enum VoxelManipEnum "voxelmanip" end
   get_mapgen_object: function(VoxelManipEnum): VoxelManip
   enum GenNotifyEnum "gennotify" end
   get_mapgen_object: function(GenNotifyEnum): GenNotifyTable

   get_current_modname: function(): string
   get_modname: function(string): string
   get_modnames: function(): {string}

   interface GameInfo
      id: string
      title: string
      author: string
      path: string
   end
   get_game_info: function(): GameInfo

   get_worldpath: function(): string
   get_mod_data_path: function(): string
   is_singleplayer: function(): boolean

   enum Feature
      "glasslike_framed"
      "nodebox_as_selectionbox"
      "get_all_craft_recipes_works"
      "use_texture_alpha"
      "no_legacy_abms"
      "texture_names_parens"
      "area_store_custom_ids"
      "add_entity_with_staticdata"
      "no_chat_message_prediction"
      "object_use_texture_alpha"
      "object_independent_selectionbox"
      "httpfetch_binary_data"
      "formspec_version_element"
      "area_store_persistent_ids"
      "pathfinder_works"
      "object_step_has_moveresult"
      "direct_velocity_on_players"
      "use_texture_alpha_string_modes"
      "degrotate_240_steps"
      "abm_min_max_y"
      "dynamic_add_media_table"
      "particlespawner_tweenable"
      "get_sky_as_table"
      "get_light_data_buffer"
      "mod_storage_on_disk"
      "compress_zstd"
      "sound_params_start_time"
      "physics_overrides_v2"
      "hud_def_type_field"
      "random_state_restore"
      "after_order_expiry_registration"
      "wallmounted_rotate"
      "item_specific_pointabilities"
      "blocking_pointability_type"
      "dynamic_add_media_startup"
      "dynamic_add_media_filepath"
      "lsystem_decoration_type"
      "item_meta_range"
      "node_interaction_actor"
      "moveresult_new_pos"
      "override_item_remove_fields"
      "hotbar_hud_element"
      "bulk_lbms"
      "abm_without_neighbors"
      "biome_weights"
      "particle_blend_clip"
      "remove_item_match_meta"
      "httpfetch_additional_methods"
   end

   type Features = {Feature:boolean}

   features: Features

   has_feature: function(string | {Feature:boolean}): boolean, {Feature:boolean}

   interface PlayerInfo
      address: string            -- IP address of client
      ip_version: integer        -- IPv4 / IPv6
      connection_uptime: integer -- seconds since client connected
      protocol_version: integer  -- protocol version used by client
      formspec_version: integer  -- supported formspec version
      lang_code: string          -- Language code used for translation

      -- the following keys can be missing if no stats have been collected yet
      min_rtt: number            -- minimum round trip time
      max_rtt: number            -- maximum round trip time
      avg_rtt: number            -- average round trip time
      min_jitter: number         -- minimum packet time jitter
      max_jitter: number         -- maximum packet time jitter
      avg_jitter: number         -- average packet time jitter

      -- The version information is provided by the client and may be spoofed
      -- or inconsistent in engine forks. You must not use this for checking
      -- feature availability of clients. Instead, do use the fields
      -- `protocol_version` and `formspec_version` where it matters.
      -- Use `core.protocol_versions` to map Luanti versions to protocol versions.
      -- This version string is only suitable for analysis purposes.
      version_string: string     -- full version string
   end

   get_player_information: function(string): PlayerInfo

   protocol_versions: {string:integer}

   interface XY<T>
      x: T
      y: T
   end

   interface PlayerWindowInfo
      -- Current size of the in-game render target (pixels).
      --
      -- This is usually the window size, but may be smaller in certain situations,
      -- such as side-by-side mode.
      size: XY<integer>

      -- Estimated maximum formspec size before Luanti will start shrinking the
      -- formspec to fit. For a fullscreen formspec, use this formspec size and
      -- `padding[0,0]`. `bgcolor[;true]` is also recommended.
      max_formspec_size: XY<number>

      -- GUI Scaling multiplier
      -- Equal to the setting `gui_scaling` multiplied by `dpi / 96`
      real_gui_scaling: number

      -- HUD Scaling multiplier
      -- Equal to the setting `hud_scaling` multiplied by `dpi / 96`
      real_hud_scaling: number

      -- Whether the touchscreen controls are enabled.
      -- Usually (but not always) `true` on Android.
      -- Requires at least version 5.9.0 on the client. For older clients, it
      -- is always set to `false`.
      touch_controls: boolean
   end

   get_player_window_information: function(string): PlayerWindowInfo

   mkdir: function(string): boolean
   rmdir: function(string, recursive?: boolean): boolean
   cpdir: function(fr: string, dst: string): boolean
   mvdir: function(fr: string, dst: string): boolean
   get_dir_list: function(string, isdir ?: boolean): {string}
   safe_file_write: function(string, ct: string): boolean
   get_version: function(): table -- TODO
   sha1: function(data: string, raw ?: boolean): string
   sha256: function(data: string, raw ?: boolean): string
   colorspec_to_colorstring: function(ColorSpec): ColorString
   colorspec_to_bytes: function(ColorSpec): string
   colorspec_to_table: function(ColorSpec): TODO
   colorspec_to_int: function(ColorSpec): integer
   time_to_day_night_ratio: function(number): number
   encode_png: function(w: integer, h: integer, data: {ColorSpec} | string, comp ?: integer): string
   urlencode: function(string): string

   interface Class end
   class: function(super ?: Class): Class
   super: function(cl: Class): Class
   is_instance: function(obj: table, cl: Class)

   enum LogLevel
      "none"
      "error"
      "warning"
      "action"
      "info"
      "verbose"
   end

   debug: function(...: string)
   log: function(lvl: LogLevel, dat: string)
   log: function(dat: string)

   register_node: function(name: string, def: NodeDef)
   register_craftitem: function(name: string, def: CraftItemDef)
   register_tool: function(name: string, def: ToolDef)
   override_item: function(name: string, redef: ItemDef, del_fields: {string})
   unregister_item: function(name: string)

   register_entity: function(name: string, def: EntityDef)
   register_abm: function(AbmDef)
   register_lbm: function(LbmDef)

   register_alias: function(alias: string, original_name: string)
   register_alias_force: function(alias: string, original_name: string)
   register_ore: function(OreDef): integer
   register_biome: function(BiomeDef): integer
   unregister_biome: function(name: string)
   register_decoration: function(DecorDef): integer
   register_schematic: function(SchemDef): integer
   clear_registered_biomes: function()
   clear_registered_decorations: function()
   clear_registered_ores: function()
   clear_registered_schematics: function()

   register_craft: function(RecipeDef)
   clear_craft: function(RecipeDef): boolean -- note only input or output
   register_chatcommand: function(string, ChatCommDef)
   override_chatcommand: function(string, ChatCommDef)
   unregister_chatcommand: function(string)

   register_privilege: function(string, PrivDef | string)
   register_authentication_handler: function(AuthHandlerDef)

   register_globalstep:          function(function(dtime: number))
   register_on_mods_loaded:      function(function())
   register_on_shutdown:         function(function())
   register_on_placenode:        function(function(pos: vector, newnode: TODO, placer: ObjectRef, oldnode: TODO, itemstack: ItemStack, pointed_thing: TODO): boolean)
   register_on_dignode:          function(function(pos: vector, oldnode: TODO, digger: ObjectRef))
   register_on_punchnode:        function(function(pos: vector, node: TODO, puncher: ObjectRef, pointed_thing: TODO))
   register_on_generated:        function(function(minp: vector, maxp: vector, blockseed: integer)) -- note: you should use mapgen one whenever possible
   register_on_newplayer:        function(function(player: ObjectRef))
   register_on_punchplayer:      function(function(player: ObjectRef, hitter: ObjectRef, time_from_last_punch: number, tool_capabilities: TODO, dir: vector, damage: number): boolean)
   register_on_rightclickplayer: function(function(player: ObjectRef, clicker: ObjectRef))
   register_on_player_hpchange:  function(function(player: ObjectRef, hp_change: number, reason: PlayerHPChangeReason): (number, boolean), modifier ?: boolean)
   register_on_dieplayer:        function(function(player: ObjectRef, reason: PlayerHPChangeReason))
   register_on_respawnplayer:    function(function(player: ObjectRef))
   register_on_prejoinplayer:    function(function(name: string, ip: string): string)
   register_on_joinplayer:       function(function(player: ObjectRef, last_login: number))
   register_on_leaveplayer:      function(function(player: ObjectRef, timed_out: boolean))
   register_on_authplayer:       function(function(name: string, ip: string, is_success: boolean))
   register_on_cheat:            function(function(player: ObjectRef, cheat: CheatType))
   register_on_chat_message:     function(function(name: string, message: string))
   register_on_chatcommand:      function(function(name: string, command: string, params: string))
   register_on_player_receive_fields: function(function(player: ObjectRef, formname: string, fields: {string:any}))
   register_on_craft:            function(function(itemstack: ItemStack, player: ObjectRef, old_craft_grid: TODO, craft_inv: TODO): ItemStack)
   register_craft_predict:       function(function(itemstack: ItemStack, player: ObjectRef, old_craft_grid: TODO, craft_inv: TODO): ItemStack)
   register_allow_player_inventory_action: function(function(player: ObjectRef, action: Action, inventory: InvRef, inventory_info: InvInfo))
   register_on_player_inventory_action:    function(function(player: ObjectRef, action: Action, ioventory: InvRef, inventory_info: InvInfo))
   register_on_protection_violation: function(function(pos: vector, name: string))
   register_on_item_eat: function(function(hp_change: number, replace_with_item: TODO, itemstack: ItemStack, user: ObjectRef, pointed_thing: TODO): ItemStack)
   register_on_item_pickup
   register_on_priv_grant
   register_on_priv_revoke
   register_can_bypass_userlimit
   register_on_modchannel_message
   register_on_liquid_transformed
   register_on_mapblocks_changed

   settings: {string:any} -- TODO
   -- setting_get_pos: function(string): vector

   string_to_privs: function(string, delim ?: string): {string:boolean}
   privs_to_string: functoin({string:boolean}, delim ?: string): string
   get_player_privs: function(name: string): {string:boolean}
   check_player_privs: function(player_or_name: Player | string, {string:boolean}): boolean, {string:boolean}
   check_player_privs: function(player_or_name: Player | string, string, ...: string): boolean, {string:boolean}
   check_password_entry: function(name: string, entry: string, password: string): boolean
   get_password_hash: function(name: string, raw_password: string): string
   get_player_ip: function(name: string): string


   registered_nodes: {string:NodeDef}
end

local record LuantiGlobals
   dump2: function(obj: any, name ?: string, dumped ?: table): string
   dump: function(value: any, indent ?: string): string
end

global dump2 = LuantiGlobals.dump2
global dump = LuantiGlobals.dump

-- luanti does extension methods on the main Lua libraries
global record ltable
   copy: function<T>(T): T
      = macroexp(...) return ((table as table).copy as function)(...) end
   copy_with_metatables: function<T>(T): T
      = macroexp(...) return ((table as table).copy_with_metatables as function)(...) end
   shallow_copy: function<T>(T): T
      = macroexp(...) return ((table as table).shallow_copy as function)(...) end
   indexof: function<T>({T}, T): integer
      = macroexp(...) return ((table as table).indexof as function)(...) end
   keyof: function<K, T>({K:T}, T): K
      = macroexp(...) return ((table as table).keyof as function)(...) end
   insert_all: function<T>(to: {T}, from: {T})
      = macroexp(...) return ((table as table).insert_all as function)(...) end
   merge: function<T>(...: {T}): {T}
      = macroexp(...) return ((table as table).merge as function)(...) end

   key_value_swap: function<K, V>({K:V}): {V:K}
      = macroexp(...) return ((table as table).key_value_swap as function)(...) end
   shuffle: function<T>(tbl: {T}, from ?: integer, to ?: integer, random_fn ?: function(integer, integer): integer)
      = macroexp(...) return ((table as table).shuffle as function)(...) end
end

-- -- table extension:
-- table.copy: function<T is table>(t: T): T
-- table.copy_with_metatables: function<T is table>(t: T): T
-- table.shallow_copy: function<T is table>(t: T): T
-- table.indexof: function<T>({T}, T): integer
-- table.keyof: function<K, T>({K:T}, T): K
-- table.insert_all: function<T>(to: {T}, from: {T})
-- table.merge: function<T>(...: {T}): {T}

-- table.key_value_swap: function<K, V>({K:V}): {V:K}
-- table.shuffle: function<T>(tbl: {T}, from ?: integer, to ?: integer, random_fn ?: function(integer, integer): integer)


global record lmath
   hypot: function(number, number): number
      = macroexp(...) return ((math as table).hypot as function)(...) end
   sign: function(number, tol ?: number): integer
      = macroexp(...) return ((math as table).sign as function)(...) end
   factorial: function(integer): integer
      = macroexp(...) return ((math as table).factorial as function)(...) end
   round: function(number): integer
      = macroexp(...) return ((math as table).round as function)(...) end
end

global record lstring
   split: function(str: string, sep ?: string, include_empty ?: boolean, max_splits ?: integer, sep_is_pattern ?: boolean): {string}
      = macroexp(...) return ((string as table).split as function)(...) end
   trim: function(str: string): string
      = macroexp(...) return ((string as table).trim as function)(...) end
end
