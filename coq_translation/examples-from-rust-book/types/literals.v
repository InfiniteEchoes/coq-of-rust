(* Generated by coq-of-rust *)
Require Import Coq.Strings.String.
Require Import Coq.ZArith.ZArith.
Local Open Scope Z.

Definition u8 : Set := Z.

(* Approximation *)
Definition f64 : Set := Z.

Definition main (_ : unit) :=
  let x := 1 in
  let y := 2 in
  let z := 3 (* 3 *) in
  let i := 1 in
  let f := 1 (* 1.0 *) in
  _crate.io._print
    (_crate::fmt::ImplArguments.new_v1
      ["size of `x` in bytes: ";"\n"]
      [_crate::fmt::ImplArgumentV1.new_display (std.mem.size_of_val x)]) ;;
  tt ;;
  _crate.io._print
    (_crate::fmt::ImplArguments.new_v1
      ["size of `y` in bytes: ";"\n"]
      [_crate::fmt::ImplArgumentV1.new_display (std.mem.size_of_val y)]) ;;
  tt ;;
  _crate.io._print
    (_crate::fmt::ImplArguments.new_v1
      ["size of `z` in bytes: ";"\n"]
      [_crate::fmt::ImplArgumentV1.new_display (std.mem.size_of_val z)]) ;;
  tt ;;
  _crate.io._print
    (_crate::fmt::ImplArguments.new_v1
      ["size of `i` in bytes: ";"\n"]
      [_crate::fmt::ImplArgumentV1.new_display (std.mem.size_of_val i)]) ;;
  tt ;;
  _crate.io._print
    (_crate::fmt::ImplArguments.new_v1
      ["size of `f` in bytes: ";"\n"]
      [_crate::fmt::ImplArgumentV1.new_display (std.mem.size_of_val f)]) ;;
  tt ;;
  tt.