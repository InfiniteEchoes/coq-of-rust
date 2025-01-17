(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Module Fruit.
  Inductive t : Set :=
  | Apple
  | Orange
  | Banana
  | Kiwi
  | Lemon.
End Fruit.
Definition Fruit := Fruit.t.

Module Impl__crate_fmt_Debug_for_Fruit.
  Definition Self := Fruit.
  
  Definition fmt
      (self : ref Self)
      (f : mut_ref _crate.fmt.Formatter)
      : _crate.fmt.Result :=
    match self with
    | Fruit.Apple => _crate.fmt.Formatter::["write_str"] f "Apple"
    | Fruit.Orange => _crate.fmt.Formatter::["write_str"] f "Orange"
    | Fruit.Banana => _crate.fmt.Formatter::["write_str"] f "Banana"
    | Fruit.Kiwi => _crate.fmt.Formatter::["write_str"] f "Kiwi"
    | Fruit.Lemon => _crate.fmt.Formatter::["write_str"] f "Lemon"
    end.
  
  Global Instance Method_fmt : Notation.Dot "fmt" := {
    Notation.dot := fmt;
  }.
  
  Global Instance I : _crate.fmt.Debug.Trait Self := {
    _crate.fmt.Debug.fmt := fmt;
  }.
End Impl__crate_fmt_Debug_for_Fruit.

Definition main (_ : unit) : unit :=
  let apple := Some Fruit.Apple in
  let no_fruit := None in
  let get_kiwi_as_fallback :=
    fun  =>
      _crate.io._print
        (_crate.fmt.Arguments::["new_v1"]
          [ "Providing kiwi as fallback\n" ]
          [  ]) ;;
      tt ;;
      Some Fruit.Kiwi in
  let get_lemon_as_fallback :=
    fun  =>
      _crate.io._print
        (_crate.fmt.Arguments::["new_v1"]
          [ "Providing lemon as fallback\n" ]
          [  ]) ;;
      tt ;;
      Some Fruit.Lemon in
  let first_available_fruit :=
    (no_fruit.["or_else"] get_kiwi_as_fallback).["or_else"]
      get_lemon_as_fallback in
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [ "first_available_fruit: "; "\n" ]
      [ _crate.fmt.ArgumentV1::["new_debug"] first_available_fruit ]) ;;
  tt ;;
  tt.
