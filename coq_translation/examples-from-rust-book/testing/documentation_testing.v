(* Generated by coq-of-rust *)
Require Import Coq.Strings.String.
Require Import Coq.ZArith.ZArith.
Local Open Scope Z.

Definition u8 : Set := Z.

(* Approximation *)
Definition f64 : Set := Z.

Definition add (_ : unit) :=
  add a b.

Definition div (_ : unit) :=
  if eq b 0 then
    _crate.rt.begin_panic "Divide-by-zero error" ;;
    tt
  else
    tt ;;
  div a b.