(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Definition foo (_ : unit) : unit :=
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [ "You called "; "()\n" ]
      [ _crate.fmt.ArgumentV1::["new_debug"] "foo" ]) ;;
  tt ;;
  tt.

Definition bar (_ : unit) : unit :=
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [ "You called "; "()\n" ]
      [ _crate.fmt.ArgumentV1::["new_debug"] "bar" ]) ;;
  tt ;;
  tt.

Definition main (_ : unit) : unit :=
  foo tt ;;
  bar tt ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [ ""; " = "; "\n" ]
      [
        _crate.fmt.ArgumentV1::["new_debug"] "1u32 + 1";
        _crate.fmt.ArgumentV1::["new_debug"] (1.["add"] 1)
      ]) ;;
  tt ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [ ""; " = "; "\n" ]
      [
        _crate.fmt.ArgumentV1::["new_debug"]
          "{ let x = 1u32; x * x + 2 * x - 1 }";
        _crate.fmt.ArgumentV1::["new_debug"]
          let x := 1 in
          ((x.["mul"] x).["add"] (2.["mul"] x)).["sub"] 1
      ]) ;;
  tt ;;
  tt.
