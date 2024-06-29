open! Base

(** [bval] is an [Angstrom] parser for bencoded values. For valid inputs, a JSON
    representation of the value is returned. If the input has invalid encoding, the
    parser will fail. *)
val bval : Yojson.Basic.t Angstrom.t
