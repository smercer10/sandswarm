open! Base
open Stdio
open Sandswarm

let print_json_result = function
  | Ok v -> print_string (Yojson.to_string v)
  | Error m -> print_string m
;;

let%expect_test "decode_byte_string" =
  let test b = print_json_result (Bencode.decode_byte_string b) in
  test "";
  [%expect {| Delimiter is missing or invalid |}];
  test ":";
  [%expect {| Length is not a valid integer |}];
  test "0:";
  [%expect {| "" |}];
  test "10:Exact data";
  [%expect {| "Exact data" |}];
  test "8:Extra data";
  [%expect {| "Extra da" |}];
  test "19:$pec1al-ch@ract3rs!";
  [%expect {| "$pec1al-ch@ract3rs!" |}];
  test "16:Not enough data";
  [%expect {| Data is shorter than expected |}];
  test ":Missing length";
  [%expect {| Length is not a valid integer |}];
  test "1B:Non-numeric length";
  [%expect {| Length is not a valid integer |}];
  test "18.0:Non-integer length";
  [%expect {| Length is not a valid integer |}];
  test "-15:Negative length";
  [%expect {| Length is not a valid integer |}];
  test "13Missing colon";
  [%expect {| Delimiter is missing or invalid |}]
;;

let%expect_test "decode_integer" =
  let test b = print_json_result (Bencode.decode_integer b) in
  test "";
  [%expect {| Not enough data to decode |}];
  test "ie";
  [%expect {| Not enough data to decode |}];
  test "i0e";
  [%expect {| 0 |}];
  test "i1e";
  [%expect {| 1 |}];
  test "i2345e";
  [%expect {| 2345 |}];
  test "i-678e";
  [%expect {| -678 |}];
  test "910e";
  [%expect {| At least one delimiter is missing or invalid |}];
  test "i11";
  [%expect {| At least one delimiter is missing or invalid |}];
  test "1213i14e15";
  [%expect {| At least one delimiter is missing or invalid |}];
  test "i-0e";
  [%expect {| -0 is not a valid integer |}];
  test "i016e";
  [%expect {| Integers cannot be padded with 0 |}];
  test "i171B19e";
  [%expect {| Data is not a valid integer |}];
  test "i20.0e";
  [%expect {| Data is not a valid integer |}]
;;
