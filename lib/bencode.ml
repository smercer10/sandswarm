let decode_string_to_json s =
  let delim_idx = String.index s ':' in
  let len = int_of_string (String.sub s 0 delim_idx) in
  let data = String.sub s (delim_idx + 1) len in
  `String data
;;
