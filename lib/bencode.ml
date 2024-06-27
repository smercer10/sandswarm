open Base

let decode_string_to_json s =
  match String.lsplit2 s ~on:':' with
  | Some (len, data) ->
    (match Int.of_string_opt len with
     | Some l ->
       if String.length data >= l
       then Ok (`String (String.prefix data l))
       else Error "Data is too short"
     | None -> Error "Length is invalid")
  | None -> Error "String format is invalid"
;;
