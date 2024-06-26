(** [decode_string_to_json s] decodes a bencoded string [s] to JSON. *)
val decode_string_to_json : string -> Yojson.Basic.t
