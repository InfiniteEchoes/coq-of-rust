(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Definition drink (beverage : ref str) : unit :=
  if (beverage.["eq"] "lemonade" : bool) then
    _crate.rt.begin_panic "AAAaaaaa!!!!" ;;
    tt
  else
    tt ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [ "Some refreshing "; " is all I need.\n" ]
      [ _crate.fmt.ArgumentV1::["new_display"] beverage ]) ;;
  tt ;;
  tt.

Definition main (_ : unit) : unit :=
  drink "water" ;;
  drink "lemonade" ;;
  tt.
