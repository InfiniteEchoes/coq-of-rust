(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Definition main (_ : unit) : unit :=
  let number := 4 in
  match number with
  | i =>
    _crate.io._print (_crate.fmt.Arguments::["new_v1"] [ "Zero\n" ] [  ]) ;;
    tt
  | i =>
    _crate.io._print
      (_crate.fmt.Arguments::["new_v1"] [ "Greater than zero\n" ] [  ]) ;;
    tt
  | _ => _crate.panicking.unreachable_display "Should never happen."
  end.
