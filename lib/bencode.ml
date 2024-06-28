open! Base

let decode_byte_string b =
  match String.lsplit2 b ~on:':' with
  | Some (len, data) ->
    (match Int.of_string_opt len with
     | Some v when v >= 0 ->
       if String.length data >= v
       then Ok (`String (String.prefix data v))
       else Error "Data is shorter than expected"
     | _ -> Error "Length is invalid")
  | _ -> Error "Delimiter is missing or invalid"
;;

let decode_integer b =
  let len = String.length b in
  if len < 3
  then Error "Not enough bytes to decode"
  else if Char.( <> ) b.[0] 'i' || Char.( <> ) b.[len - 1] 'e'
  then Error "At least one delimiter is missing or invalid"
  else if Char.( = ) b.[1] '0' && len = 3
  then Error "Integers cannot be padded with 0"
  else (
    let num = String.sub b ~pos:1 ~len:(len - 2) in
    match Int.of_string_opt num with
    | Some -0 | None -> Error "Integer is invalid"
    | Some v -> Ok (`Int v))
;;
