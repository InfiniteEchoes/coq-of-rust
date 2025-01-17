(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Import crate.List.

Module List.
  Inductive t : Set :=
  | Cons (_ : u32) (_ : Box)
  | Nil.
End List.
Definition List := List.t.

Module ImplList.
  Definition Self := List.
  
  Definition new (_ : unit) : List := Nil.
  
  Global Instance AssociatedFunction_new : Notation.DoubleColon Self "new" := {
    Notation.double_colon := new;
  }.
  
  Definition prepend (self : Self) (elem : u32) : List :=
    Cons elem (Box::["new"] self).
  
  Global Instance Method_prepend : Notation.Dot "prepend" := {
    Notation.dot := prepend;
  }.
  
  Definition len (self : ref Self) : u32 :=
    match deref self with
    | Cons (_, tail) => 1.["add"] tail.["len"]
    | Nil => 0
    end.
  
  Global Instance Method_len : Notation.Dot "len" := {
    Notation.dot := len;
  }.
  
  Definition stringify (self : ref Self) : String :=
    match deref self with
    | Cons (head, tail) =>
      let res :=
        _crate.fmt.format
          (_crate.fmt.Arguments::["new_v1"]
            [ ""; ", " ]
            [
              _crate.fmt.ArgumentV1::["new_display"] head;
              _crate.fmt.ArgumentV1::["new_display"] tail.["stringify"]
            ]) in
      res
    | Nil =>
      let res :=
        _crate.fmt.format (_crate.fmt.Arguments::["new_v1"] [ "Nil" ] [  ]) in
      res
    end.
  
  Global Instance Method_stringify : Notation.Dot "stringify" := {
    Notation.dot := stringify;
  }.
End ImplList.

Definition main (_ : unit) : unit :=
  let list := List::["new"] tt in
  assign list (list.["prepend"] 1) ;;
  assign list (list.["prepend"] 2) ;;
  assign list (list.["prepend"] 3) ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [ "linked list has length: "; "\n" ]
      [ _crate.fmt.ArgumentV1::["new_display"] list.["len"] ]) ;;
  tt ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [ ""; "\n" ]
      [ _crate.fmt.ArgumentV1::["new_display"] list.["stringify"] ]) ;;
  tt ;;
  tt.
