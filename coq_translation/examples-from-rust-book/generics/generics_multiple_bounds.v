(* Generated by coq-of-rust *)
Require Import Coq.Strings.String.
Require Import Coq.ZArith.ZArith.
Local Open Scope Z.

Definition u8 : Set := Z.

(* Approximation *)
Definition f64 : Set := Z.

Definition compare_prints (_ : unit) :=
  _crate.io._print
    (_crate::fmt::ImplArguments.new_v1
      ["Debug: `";"`\n"]
      [_crate::fmt::ImplArgumentV1.new_debug t]) ;;
  tt ;;
  _crate.io._print
    (_crate::fmt::ImplArguments.new_v1
      ["Display: `";"`\n"]
      [_crate::fmt::ImplArgumentV1.new_display t]) ;;
  tt ;;
  tt.

Definition compare_types (_ : unit) :=
  _crate.io._print
    (_crate::fmt::ImplArguments.new_v1
      ["t: `";"`\n"]
      [_crate::fmt::ImplArgumentV1.new_debug t]) ;;
  tt ;;
  _crate.io._print
    (_crate::fmt::ImplArguments.new_v1
      ["u: `";"`\n"]
      [_crate::fmt::ImplArgumentV1.new_debug u]) ;;
  tt ;;
  tt.

Definition main (_ : unit) :=
  let string := "words" in
  let array := [1;2;3] in
  let vec := ComplexTypePath.into_vec [1;2;3] in
  compare_prints string ;;
  compare_types array vec ;;
  tt.