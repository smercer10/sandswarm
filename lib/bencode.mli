(** [decode_string_to_json s] decodes a bencoded string [s] to JSON representation. *)
val decode_string_to_json : string -> ([> `String of string ], string) Result.t
