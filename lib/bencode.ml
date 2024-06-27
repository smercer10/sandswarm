open Base

let decode_string_to_json s =
  match String.lsplit2 s ~on:':' with
  | Some (len, data) ->
    (match Int.of_string_opt len with
     | Some int ->
       if String.length data >= int
       then Ok (`String (String.prefix data int))
       else Error "Data is too short"
     | None -> Error "Length is invalid")
  | None -> Error "String format is invalid"
;;
