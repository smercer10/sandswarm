open! Base
open Angstrom

let json_of_str s = `String s
let json_of_int i = `Int i
let json_of_lst l = `List l
let json_of_dic d = `Assoc d

let bstr =
  let* len = take_while1 Char.is_digit >>| Int.of_string in
  char ':' *> take len >>| json_of_str
;;

let is_valid_int sign dgts =
  not
    ((String.equal sign "-" && String.equal dgts "0")
     || (Char.equal dgts.[0] '0' && String.length dgts > 1))
;;

let bint =
  char 'i'
  *>
  let* sign = option "" (string "-") in
  let* dgts = take_while1 Char.is_digit in
  char 'e'
  *>
  if is_valid_int sign dgts
  then return (sign ^ dgts |> Int.of_string |> json_of_int)
  else fail "Integer encoding is invalid"
;;

let bval =
  fix (fun bval ->
    let blst = char 'l' *> many bval <* char 'e' >>| json_of_lst in
    let bdic =
      char 'd' *> many (both bstr bval)
      <* char 'e'
      >>| List.map ~f:(fun (k, v) ->
        match k with
        | `String s -> s, v)
      >>| json_of_dic
    in
    choice ~failure_msg:"Value encoding is invalid" [ bstr; bint; blst; bdic ])
;;
