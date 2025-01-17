(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Module env := std.env.

Definition increase (number : i32) : unit :=
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [ ""; "\n" ]
      [ _crate.fmt.ArgumentV1::["new_display"] (number.["add"] 1) ]) ;;
  tt ;;
  tt.

Definition decrease (number : i32) : unit :=
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [ ""; "\n" ]
      [ _crate.fmt.ArgumentV1::["new_display"] (number.["sub"] 1) ]) ;;
  tt ;;
  tt.

Definition help (_ : unit) : unit :=
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [
        "usage:\nmatch_args <string>\n    Check whether given string is the answer.\nmatch_args {increase|decrease} <integer>\n    Increase or decrease given integer by one.\n"
      ]
      [  ]) ;;
  tt ;;
  tt.

Definition main (_ : unit) : unit :=
  let args := (env.args tt).["collect"] in
  match args.["len"] with
  | Int(1, Unsuffixed) =>
    _crate.io._print
      (_crate.fmt.Arguments::["new_v1"]
        [ "My name is 'match_args'. Try passing some arguments!\n" ]
        [  ]) ;;
    tt ;;
    tt
  | Int(2, Unsuffixed) =>
    match args[1].["parse"] with
    | Ok (Int(42, Unsuffixed)) =>
      _crate.io._print
        (_crate.fmt.Arguments::["new_v1"] [ "This is the answer!\n" ] [  ]) ;;
      tt
    | _ =>
      _crate.io._print
        (_crate.fmt.Arguments::["new_v1"]
          [ "This is not the answer.\n" ]
          [  ]) ;;
      tt
    end
  | Int(3, Unsuffixed) =>
    let cmd := args[1] in
    let num := args[2] in
    let number :=
      match num.["parse"] with
      | Ok (n) => n
      | Err (_) =>
        _crate.io._eprint
          (_crate.fmt.Arguments::["new_v1"]
            [ "error: second argument not an integer\n" ]
            [  ]) ;;
        tt ;;
        help tt ;;
        Return tt ;;
        tt
      end in
    match cmd[{|  |}] with
    | Str("increase", Cooked) => increase number
    | Str("decrease", Cooked) => decrease number
    | _ =>
      _crate.io._eprint
        (_crate.fmt.Arguments::["new_v1"]
          [ "error: invalid command\n" ]
          [  ]) ;;
      tt ;;
      help tt ;;
      tt
    end
  | _ =>
    help tt ;;
    tt
  end.
