(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Module Number.
  Inductive t : Set :=
  | Zero
  | One
  | Two.
End Number.
Definition Number := Number.t.

Module Color.
  Inductive t : Set :=
  | Red
  | Green
  | Blue.
End Color.
Definition Color := Color.t.

Definition main (_ : unit) : unit :=
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [ "zero is "; "\n" ]
      [ _crate.fmt.ArgumentV1::["new_display"] (cast Number.Zero i32) ]) ;;
  tt ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [ "one is "; "\n" ]
      [ _crate.fmt.ArgumentV1::["new_display"] (cast Number.One i32) ]) ;;
  tt ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1_formatted"]
      [ "roses are #"; "\n" ]
      [ _crate.fmt.ArgumentV1::["new_lower_hex"] (cast Color.Red i32) ]
      [
        {|
          _crate.fmt.rt.v1.Argument.position := 0;
          _crate.fmt.rt.v1.Argument.format :=
            {|
              _crate.fmt.rt.v1.FormatSpec.fill :=  ;
              _crate.fmt.rt.v1.FormatSpec.align :=
                _crate.fmt.rt.v1.Alignment.Unknown;
              _crate.fmt.rt.v1.FormatSpec.flags := 8;
              _crate.fmt.rt.v1.FormatSpec.precision :=
                _crate.fmt.rt.v1.Count.Implied;
              _crate.fmt.rt.v1.FormatSpec.width := _crate.fmt.rt.v1.Count.Is 6;
            |};
        |}
      ]
      (_crate.fmt.UnsafeArg::["new"] tt)) ;;
  tt ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1_formatted"]
      [ "violets are #"; "\n" ]
      [ _crate.fmt.ArgumentV1::["new_lower_hex"] (cast Color.Blue i32) ]
      [
        {|
          _crate.fmt.rt.v1.Argument.position := 0;
          _crate.fmt.rt.v1.Argument.format :=
            {|
              _crate.fmt.rt.v1.FormatSpec.fill :=  ;
              _crate.fmt.rt.v1.FormatSpec.align :=
                _crate.fmt.rt.v1.Alignment.Unknown;
              _crate.fmt.rt.v1.FormatSpec.flags := 8;
              _crate.fmt.rt.v1.FormatSpec.precision :=
                _crate.fmt.rt.v1.Count.Implied;
              _crate.fmt.rt.v1.FormatSpec.width := _crate.fmt.rt.v1.Count.Is 6;
            |};
        |}
      ]
      (_crate.fmt.UnsafeArg::["new"] tt)) ;;
  tt ;;
  tt.
