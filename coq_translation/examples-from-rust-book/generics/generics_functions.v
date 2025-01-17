(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Module A.
  Inductive t : Set := Build.
End A.
Definition A := A.t.

Module S.
  Inductive t : Set := Build (_ : A).
  
  Global Instance Get_0 : IndexedField.Class t 0 _ := {
    IndexedField.get '(Build x0) := x0;
  }.
End S.
Definition S := S.t.

Module SGen.
  Inductive t : Set := Build (_ : T).
  
  Global Instance Get_0 : IndexedField.Class t 0 _ := {
    IndexedField.get '(Build x0) := x0;
  }.
End SGen.
Definition SGen := SGen.t.

Definition reg_fn (_s : S) : unit := tt.

Definition gen_spec_t (_s : SGen) : unit := tt.

Definition gen_spec_i32 (_s : SGen) : unit := tt.

Definition generic {T : Set} (_s : SGen) : unit := tt.

Definition main (_ : unit) : unit :=
  reg_fn (S.Build A.Build) ;;
  gen_spec_t (SGen.Build A.Build) ;;
  gen_spec_i32 (SGen.Build 6) ;;
  generic (SGen.Build a) ;;
  generic (SGen.Build c) ;;
  tt.
