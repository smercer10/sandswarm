open! Base
open Stdio
open Sandswarm

let print_json_result = function
  | Ok v -> print_string (Yojson.to_string v)
  | Error m -> print_string m
;;

let%expect_test "decode_string_to_json" =
  let test s = print_json_result (Bencode.decode_string_to_json s) in
  test "0:";
  [%expect {| "" |}];
  test "10:Exact data";
  [%expect {| "Exact data" |}];
  test "8:Extra data";
  [%expect {| "Extra da" |}];
  test "19:$pec1al-ch@ract3rs!";
  [%expect {| "$pec1al-ch@ract3rs!" |}];
  test "16:Not enough data";
  [%expect {| Data is too short |}];
  test ":Missing length";
  [%expect {| Length is invalid |}];
  test "1B:Non-numeric length";
  [%expect {| Length is invalid |}];
  test "18.0:Non-integer length";
  [%expect {| Length is invalid |}];
  test "-15:Negative length";
  [%expect {| Length is invalid |}];
  test "13Missing colon";
  [%expect {| String format is invalid |}]
;;
