(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Module error := std.error.

Module fmt := std.fmt.

Definition Result : Set := std.result.Result.

Module EmptyVec.
  Inductive t : Set := Build.
End EmptyVec.
Definition EmptyVec := EmptyVec.t.

Module Impl__crate_fmt_Debug_for_EmptyVec.
  Definition Self := EmptyVec.
  
  Definition fmt
      (self : ref Self)
      (f : mut_ref _crate.fmt.Formatter)
      : _crate.fmt.Result :=
    _crate.fmt.Formatter::["write_str"] f "EmptyVec".
  
  Global Instance Method_fmt : Notation.Dot "fmt" := {
    Notation.dot := fmt;
  }.
  
  Global Instance I : _crate.fmt.Debug.Trait Self := {
    _crate.fmt.Debug.fmt := fmt;
  }.
End Impl__crate_fmt_Debug_for_EmptyVec.

Module Impl_fmt_Display_for_EmptyVec.
  Definition Self := EmptyVec.
  
  Definition fmt (self : ref Self) (f : mut_ref fmt.Formatter) : fmt.Result :=
    f.["write_fmt"]
      (_crate.fmt.Arguments::["new_v1"]
        [ "invalid first item to double" ]
        [  ]).
  
  Global Instance Method_fmt : Notation.Dot "fmt" := {
    Notation.dot := fmt;
  }.
  
  Global Instance I : fmt.Display.Trait Self := {
    fmt.Display.fmt := fmt;
  }.
End Impl_fmt_Display_for_EmptyVec.

Module Impl_error_Error_for_EmptyVec.
  Definition Self := EmptyVec.
  
  Global Instance I : error.Error.Trait Self := error.Error.Build_Class _.
End Impl_error_Error_for_EmptyVec.

Definition double_first (vec : Vec) : Result :=
  let first :=
    match LangItem (vec.["first"].["ok_or"] EmptyVec.Build) with
    | Break {| Break.0 := residual; |} => Return (LangItem residual)
    | Continue {| Continue.0 := val; |} => val
    end in
  let parsed :=
    match LangItem first.["parse"] with
    | Break {| Break.0 := residual; |} => Return (LangItem residual)
    | Continue {| Continue.0 := val; |} => val
    end in
  Ok (2.["mul"] parsed).

Definition print (result : Result) : unit :=
  match result with
  | Ok (n) =>
    _crate.io._print
      (_crate.fmt.Arguments::["new_v1"]
        [ "The first doubled is "; "\n" ]
        [ _crate.fmt.ArgumentV1::["new_display"] n ]) ;;
    tt
  | Err (e) =>
    _crate.io._print
      (_crate.fmt.Arguments::["new_v1"]
        [ "Error: "; "\n" ]
        [ _crate.fmt.ArgumentV1::["new_display"] e ]) ;;
    tt
  end.

Definition main (_ : unit) : unit :=
  let numbers := Slice::["into_vec"] [ "42"; "93"; "18" ] in
  let empty := _crate.vec.Vec::["new"] tt in
  let strings := Slice::["into_vec"] [ "tofu"; "93"; "18" ] in
  print (double_first numbers) ;;
  print (double_first empty) ;;
  print (double_first strings) ;;
  tt.
