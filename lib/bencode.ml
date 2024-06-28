open! Base

let decode_string_to_json s =
  match String.lsplit2 s ~on:':' with
  | Some (len, data) ->
    (match Int.of_string_opt len with
     | Some exp_len when exp_len >= 0 ->
       if String.length data >= exp_len
       then Ok (`String (String.prefix data exp_len))
       else Error "Data is too short"
     | _ -> Error "Length is invalid")
  | _ -> Error "String format is invalid"
;;
