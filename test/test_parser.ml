open! Base
open Stdio
open Angstrom
open Sandswarm.Parser

let%expect_test "bval" =
  let test v =
    let res = parse_string ~consume:All bval v in
    Yojson.Basic.pretty_to_channel Out_channel.stdout (Result.ok_or_failwith res)
  in
  (* Valid encodings *)
  test "5:hello";
  [%expect {| "hello" |}];
  test "0:";
  [%expect {| "" |}];
  test "i0e";
  [%expect {| 0 |}];
  test "i1e";
  [%expect {| 1 |}];
  test "i25e";
  [%expect {| 25 |}];
  test "i-50e";
  [%expect {| -50 |}];
  test "le";
  [%expect {| [] |}];
  test "li10e2:10e";
  [%expect {| [ 10, "10" ] |}];
  test "l5:Hello5:World1:!e";
  [%expect {| [ "Hello", "World", "!" ] |}];
  test "ll1:-i100eeli-100eee";
  [%expect {| [ [ "-", 100 ], [ -100 ] ] |}];
  test "de";
  [%expect {| {} |}];
  test "d3:jani1e3:febi2e3:mar1:3e";
  [%expect {| { "jan": 1, "feb": 2, "mar": "3" } |}];
  test "d4:thisle2:isde4:long2::(e";
  [%expect {| { "this": [], "is": {}, "long": ":(" } |}];
  let test_exn v =
    try test v with
    | _ -> print_string "Exception"
  in
  (* Invalid encodings *)
  test_exn ":hello";
  [%expect {| Exception |}];
  test_exn "7goodbye";
  [%expect {| Exception |}];
  test_exn ":";
  [%expect {| Exception |}];
  test_exn "i-0e";
  [%expect {| Exception |}];
  test_exn "i05e";
  [%expect {| Exception |}];
  test_exn "ie";
  [%expect {| Exception |}];
  test_exn "i1Le";
  [%expect {| Exception |}];
  test_exn "n30e";
  [%expect {| Exception |}];
  test_exn "lie";
  [%expect {| Exception |}];
  test_exn "lxi10eee";
  [%expect {| Exception |}];
  test_exn "di1e5:valuee";
  [%expect {| Exception |}];
  test_exn "d3:keye";
  [%expect {| Exception |}];
  test_exn "d1:ppi4ee";
  [%expect {| Exception |}]
;;
