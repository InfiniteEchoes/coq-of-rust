(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Definition multiply (first : ref i32) (second : ref i32) : i32 :=
  first.["mul"] second.

Definition choose_first (first : ref i32) (arg : ref i32) : ref i32 := first.

Definition main (_ : unit) : unit :=
  let first := 2 in
  let second := 3 in
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [ "The product is "; "\n" ]
      [ _crate.fmt.ArgumentV1::["new_display"] (multiply first second) ]) ;;
  tt ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [ ""; " is the first\n" ]
      [ _crate.fmt.ArgumentV1::["new_display"] (choose_first first second) ]) ;;
  tt ;;
  tt ;;
  tt.
