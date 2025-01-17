(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Module error := std.error.

Module Error := std.error.Error.

Module fmt := std.fmt.

Module ParseIntError := std.num.ParseIntError.
Definition ParseIntError := ParseIntError.t.

Definition Result : Set := std.result.Result.

Module DoubleError.
  Inductive t : Set :=
  | EmptyVec
  | Parse (_ : ParseIntError).
End DoubleError.
Definition DoubleError := DoubleError.t.

Module Impl__crate_fmt_Debug_for_DoubleError.
  Definition Self := DoubleError.
  
  Definition fmt
      (self : ref Self)
      (f : mut_ref _crate.fmt.Formatter)
      : _crate.fmt.Result :=
    match self with
    | DoubleError.EmptyVec => _crate.fmt.Formatter::["write_str"] f "EmptyVec"
    | DoubleError.Parse (__self_0) =>
      _crate.fmt.Formatter::["debug_tuple_field1_finish"] f "Parse" __self_0
    end.
  
  Global Instance Method_fmt : Notation.Dot "fmt" := {
    Notation.dot := fmt;
  }.
  
  Global Instance I : _crate.fmt.Debug.Trait Self := {
    _crate.fmt.Debug.fmt := fmt;
  }.
End Impl__crate_fmt_Debug_for_DoubleError.

Module Impl_fmt_Display_for_DoubleError.
  Definition Self := DoubleError.
  
  Definition fmt (self : ref Self) (f : mut_ref fmt.Formatter) : fmt.Result :=
    match deref self with
    | DoubleError.EmptyVec =>
      f.["write_fmt"]
        (_crate.fmt.Arguments::["new_v1"]
          [ "please use a vector with at least one element" ]
          [  ])
    | DoubleError.Parse () =>
      f.["write_fmt"]
        (_crate.fmt.Arguments::["new_v1"]
          [ "the provided string could not be parsed as int" ]
          [  ])
    end.
  
  Global Instance Method_fmt : Notation.Dot "fmt" := {
    Notation.dot := fmt;
  }.
  
  Global Instance I : fmt.Display.Trait Self := {
    fmt.Display.fmt := fmt;
  }.
End Impl_fmt_Display_for_DoubleError.

Module Impl_error_Error_for_DoubleError.
  Definition Self := DoubleError.
  
  Definition source (self : ref Self) : Option :=
    match deref self with
    | DoubleError.EmptyVec => None
    | DoubleError.Parse (e) => Some e
    end.
  
  Global Instance Method_source : Notation.Dot "source" := {
    Notation.dot := source;
  }.
  
  Global Instance I : error.Error.Trait Self := {
  }.
End Impl_error_Error_for_DoubleError.

Module Impl_From_for_DoubleError.
  Definition Self := DoubleError.
  
  Definition from (err : ParseIntError) : DoubleError := DoubleError.Parse err.
  
  Global Instance AssociatedFunction_from :
    Notation.DoubleColon Self "from" := {
    Notation.double_colon := from;
  }.
  
  Global Instance I : From.Trait Self ParseIntError := {
    From.from := from;
  }.
End Impl_From_for_DoubleError.

Definition double_first (vec : Vec) : Result :=
  let first :=
    match LangItem (vec.["first"].["ok_or"] DoubleError.EmptyVec) with
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
    tt ;;
    if (let_if Some (source) := e.["source"] : bool) then
      _crate.io._print
        (_crate.fmt.Arguments::["new_v1"]
          [ "  Caused by: "; "\n" ]
          [ _crate.fmt.ArgumentV1::["new_display"] source ]) ;;
      tt ;;
      tt
    else
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
