(* Generated by coq-of-rust *)
Require Import Coq.Strings.String.
Require Import Coq.ZArith.ZArith.
Local Open Scope Z.

Definition u8 : Set := Z.

(* Approximation *)
Definition f64 : Set := Z.

Definition main (_ : unit) :=
  Stmt_item.

Module Person.
  Record t : Set := {
    name : String;
    age : Box;
  }.
End Person.
Definition Person : Set := Person.t.

(* Impl [Person] of trait [_crate.fmt.Debug]*)
Module ImplPerson.
  Definition
    fmt
    (self : ref Self)
    (f : ref _crate.fmt.Formatter)
    : _crate.fmt.Result :=
    _crate::fmt::ImplFormatter.debug_struct_field2_finish
      f
      "Person"
      "name"
      self.name
      "age"
      self.age.
End ImplPerson.
(* End impl [Person] *)