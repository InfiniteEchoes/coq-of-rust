(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Definition main (_ : unit) : unit :=
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"] [ "Hello World!\n" ] [  ]) ;;
  tt ;;
  tt.
