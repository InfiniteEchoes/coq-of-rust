(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Module checked.
  Module MathError.
    Inductive t : Set :=
    | DivisionByZero
    | NonPositiveLogarithm
    | NegativeSquareRoot.
  End MathError.
  Definition MathError := MathError.t.
  
  Module Impl__crate_fmt_Debug_for_MathError.
    Definition Self := MathError.
    
    Definition fmt
        (self : ref Self)
        (f : mut_ref _crate.fmt.Formatter)
        : _crate.fmt.Result :=
      match self with
      | MathError.DivisionByZero =>
        _crate.fmt.Formatter::["write_str"] f "DivisionByZero"
      | MathError.NonPositiveLogarithm =>
        _crate.fmt.Formatter::["write_str"] f "NonPositiveLogarithm"
      | MathError.NegativeSquareRoot =>
        _crate.fmt.Formatter::["write_str"] f "NegativeSquareRoot"
      end.
    
    Global Instance Method_fmt : Notation.Dot "fmt" := {
      Notation.dot := fmt;
    }.
    
    Global Instance I : _crate.fmt.Debug.Trait Self := {
      _crate.fmt.Debug.fmt := fmt;
    }.
  End Impl__crate_fmt_Debug_for_MathError.
  
  Definition MathResult : Set := Result.
  
  Definition div (x : f64) (y : f64) : MathResult :=
    if (y.["eq"] 0 (* 0.0 *) : bool) then
      Err MathError.DivisionByZero
    else
      Ok (x.["div"] y).
  
  Definition sqrt (x : f64) : MathResult :=
    if (x.["lt"] 0 (* 0.0 *) : bool) then
      Err MathError.NegativeSquareRoot
    else
      Ok x.["sqrt"].
  
  Definition ln (x : f64) : MathResult :=
    if (x.["le"] 0 (* 0.0 *) : bool) then
      Err MathError.NonPositiveLogarithm
    else
      Ok x.["ln"].
  
  Definition op_ (x : f64) (y : f64) : MathResult :=
    let ratio :=
      match LangItem (div x y) with
      | Break {| Break.0 := residual; |} => Return (LangItem residual)
      | Continue {| Continue.0 := val; |} => val
      end in
    let ln :=
      match LangItem (ln ratio) with
      | Break {| Break.0 := residual; |} => Return (LangItem residual)
      | Continue {| Continue.0 := val; |} => val
      end in
    sqrt ln.
  
  Definition op (x : f64) (y : f64) : unit :=
    match op_ x y with
    | Err (why) =>
      _crate.rt.panic_display
        match why with
        | MathError.NonPositiveLogarithm => "logarithm of non-positive number"
        | MathError.DivisionByZero => "division by zero"
        | MathError.NegativeSquareRoot => "square root of negative number"
        end
    | Ok (value) =>
      _crate.io._print
        (_crate.fmt.Arguments::["new_v1"]
          [ ""; "\n" ]
          [ _crate.fmt.ArgumentV1::["new_display"] value ]) ;;
      tt
    end.
End checked.

Module MathError.
  Inductive t : Set :=
  | DivisionByZero
  | NonPositiveLogarithm
  | NegativeSquareRoot.
End MathError.
Definition MathError := MathError.t.

Module Impl__crate_fmt_Debug_for_MathError.
  Definition Self := MathError.
  
  Definition fmt
      (self : ref Self)
      (f : mut_ref _crate.fmt.Formatter)
      : _crate.fmt.Result :=
    match self with
    | MathError.DivisionByZero =>
      _crate.fmt.Formatter::["write_str"] f "DivisionByZero"
    | MathError.NonPositiveLogarithm =>
      _crate.fmt.Formatter::["write_str"] f "NonPositiveLogarithm"
    | MathError.NegativeSquareRoot =>
      _crate.fmt.Formatter::["write_str"] f "NegativeSquareRoot"
    end.
  
  Global Instance Method_fmt : Notation.Dot "fmt" := {
    Notation.dot := fmt;
  }.
  
  Global Instance I : _crate.fmt.Debug.Trait Self := {
    _crate.fmt.Debug.fmt := fmt;
  }.
End Impl__crate_fmt_Debug_for_MathError.

Definition MathResult : Set := Result.

Definition div (x : f64) (y : f64) : MathResult :=
  if (y.["eq"] 0 (* 0.0 *) : bool) then
    Err MathError.DivisionByZero
  else
    Ok (x.["div"] y).

Definition sqrt (x : f64) : MathResult :=
  if (x.["lt"] 0 (* 0.0 *) : bool) then
    Err MathError.NegativeSquareRoot
  else
    Ok x.["sqrt"].

Definition ln (x : f64) : MathResult :=
  if (x.["le"] 0 (* 0.0 *) : bool) then
    Err MathError.NonPositiveLogarithm
  else
    Ok x.["ln"].

Definition op_ (x : f64) (y : f64) : MathResult :=
  let ratio :=
    match LangItem (div x y) with
    | Break {| Break.0 := residual; |} => Return (LangItem residual)
    | Continue {| Continue.0 := val; |} => val
    end in
  let ln :=
    match LangItem (ln ratio) with
    | Break {| Break.0 := residual; |} => Return (LangItem residual)
    | Continue {| Continue.0 := val; |} => val
    end in
  sqrt ln.

Definition op (x : f64) (y : f64) : unit :=
  match op_ x y with
  | Err (why) =>
    _crate.rt.panic_display
      match why with
      | MathError.NonPositiveLogarithm => "logarithm of non-positive number"
      | MathError.DivisionByZero => "division by zero"
      | MathError.NegativeSquareRoot => "square root of negative number"
      end
  | Ok (value) =>
    _crate.io._print
      (_crate.fmt.Arguments::["new_v1"]
        [ ""; "\n" ]
        [ _crate.fmt.ArgumentV1::["new_display"] value ]) ;;
    tt
  end.

Definition main (_ : unit) : unit :=
  checked.op 1 (* 1.0 *) 10 (* 10.0 *) ;;
  tt.
