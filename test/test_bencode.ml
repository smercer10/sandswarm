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
  test "9:ExactData";
  [%expect {| "ExactData" |}];
  test "7:ExtraData";
  [%expect {| "ExtraDa" |}];
  test "18:$pecial-Ch@ract3rs";
  [%expect {| "$pecial-Ch@ract3rs" |}];
  test "15:NotEnoughData";
  [%expect {| Data is too short |}];
  test "I6:NonNumericLength";
  [%expect {| Length is invalid |}];
  test "16.0:NonIntegerLength";
  [%expect {| Length is invalid |}];
  test "-14:NegativeLength";
  [%expect {| Length is invalid |}];
  test "12MissingColon";
  [%expect {| String format is invalid |}]
;;
