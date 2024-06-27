(** [decode_string_to_json s] decodes a valid bencoded string [s] to JSON representation.
    Returns [Error] if the bencoded string is invalid. *)
val decode_string_to_json : string -> ([> `String of string ], string) Result.t
