(* Generated by coq-of-rust *)
Require Import Coq.Strings.String.
Require Import Coq.ZArith.ZArith.
Local Open Scope Z.

Definition u8 : Set := Z.

(* Approximation *)
Definition f64 : Set := Z.

Definition call_me (_ : unit) :=
  f tt ;;
  tt.

Definition function (_ : unit) :=
  _crate.io._print
    (_crate::fmt::ImplArguments.new_v1 ["I'm a function!\n"] []) ;;
  tt ;;
  tt.

Definition main (_ : unit) :=
  let closure := fun  => _crate.io._print
    (_crate::fmt::ImplArguments.new_v1 ["I'm a closure!\n"] []) ;;
  tt in
  call_me closure ;;
  call_me function ;;
  tt.