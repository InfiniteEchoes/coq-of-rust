(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Definition apply {F : Set} `{Fn.Trait () F} (f : F) : unit :=
  f tt ;;
  tt.

Definition main (_ : unit) : unit :=
  let x := 7 in
  let print :=
    fun  =>
      _crate.io._print
        (_crate.fmt.Arguments::["new_v1"]
          [ ""; "\n" ]
          [ _crate.fmt.ArgumentV1::["new_display"] x ]) ;;
      tt in
  apply print ;;
  tt.
