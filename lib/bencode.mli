open! Base

(** [decode_byte_string b] decodes a valid bencoded byte string [b] to JSON
    representation. Returns [Error] if the encoding is invalid. *)
val decode_byte_string : string -> ([> `String of string ], string) Result.t

(** [decode_integer b] decodes a valid bencoded integer [b] to JSON representation.
    Returns [Error] if the encoding is invalid. *)
val decode_integer : string -> ([> `Int of int ], string) Result.t
