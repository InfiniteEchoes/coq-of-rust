(* Generated by coq-of-rust *)
Require Import Coq.Strings.String.
Require Import Coq.ZArith.ZArith.
Local Open Scope Z.

Definition u8 : Set := Z.

(* Approximation *)
Definition f64 : Set := Z.

Error Struct.

Definition S : Set :=
  A.

Definition SGen : Set :=
  T.

Definition reg_fn (_ : unit) :=
  tt.

Definition gen_spec_t (_ : unit) :=
  tt.

Definition gen_spec_i32 (_ : unit) :=
  tt.

Definition generic (_ : unit) :=
  tt.

Definition main (_ : unit) :=
  reg_fn (S A) ;;
  gen_spec_t (SGen A) ;;
  gen_spec_i32 (SGen 6) ;;
  generic (SGen a) ;;
  generic (SGen c) ;;
  tt.