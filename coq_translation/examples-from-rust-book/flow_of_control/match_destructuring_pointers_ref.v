(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Definition main (_ : unit) : unit :=
  let reference := 4 in
  match reference with
  | val =>
    _crate.io._print
      (_crate.fmt.Arguments::["new_v1"]
        [ "Got a value via destructuring: "; "\n" ]
        [ _crate.fmt.ArgumentV1::["new_debug"] val ]) ;;
    tt
  end ;;
  match deref reference with
  | val =>
    _crate.io._print
      (_crate.fmt.Arguments::["new_v1"]
        [ "Got a value via dereferencing: "; "\n" ]
        [ _crate.fmt.ArgumentV1::["new_debug"] val ]) ;;
    tt
  end ;;
  let _not_a_reference := 3 in
  let _is_a_reference := 3 in
  let value := 5 in
  let mut_value := 6 in
  match value with
  | r =>
    _crate.io._print
      (_crate.fmt.Arguments::["new_v1"]
        [ "Got a reference to a value: "; "\n" ]
        [ _crate.fmt.ArgumentV1::["new_debug"] r ]) ;;
    tt
  end ;;
  match mut_value with
  | m =>
    (deref m).["add_assign"] 10 ;;
    _crate.io._print
      (_crate.fmt.Arguments::["new_v1"]
        [ "We added 10. `mut_value`: "; "\n" ]
        [ _crate.fmt.ArgumentV1::["new_debug"] m ]) ;;
    tt ;;
    tt
  end.
