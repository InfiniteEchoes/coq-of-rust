(* Generated by coq-of-rust *)
Require Import Coq.Strings.String.
Require Import Coq.ZArith.ZArith.
Local Open Scope Z.

Definition u8 : Set := Z.

(* Approximation *)
Definition f64 : Set := Z.

Definition main (_ : unit) :=
  let logical := true in
  let a_float := 1 (* 1.0 *) in
  let an_integer := 5 in
  let default_float := 3 (* 3.0 *) in
  let default_integer := 7 in
  let inferred_type := 12 in
  assign inferred_type := 4294967296 ;;
  let mutable := 12 in
  assign mutable := 21 ;;
  let mutable := true in
  tt.