(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Module fs := std.fs.

Module File := std.fs.File.
Definition File := File.t.

Module OpenOptions := std.fs.OpenOptions.
Definition OpenOptions := OpenOptions.t.

Module io := std.io.

Import std.io.prelude.

Module unix := std.os.unix.

Module Path := std.path.Path.
Definition Path := Path.t.

Definition cat (path : ref Path) : io.Result :=
  let f :=
    match LangItem (File::["open"] path) with
    | Break {| Break.0 := residual; |} => Return (LangItem residual)
    | Continue {| Continue.0 := val; |} => val
    end in
  let s := String::["new"] tt in
  match f.["read_to_string"] s with
  | Ok (_) => Ok s
  | Err (e) => Err e
  end.

Definition echo (s : ref str) (path : ref Path) : io.Result :=
  let f :=
    match LangItem (File::["create"] path) with
    | Break {| Break.0 := residual; |} => Return (LangItem residual)
    | Continue {| Continue.0 := val; |} => val
    end in
  f.["write_all"] s.["as_bytes"].

Definition touch (path : ref Path) : io.Result :=
  match
    (((OpenOptions::["new"] tt).["create"] true).["write"] true).["open"] path
  with
  | Ok (_) => Ok ()
  | Err (e) => Err e
  end.

Definition main (_ : unit) : unit :=
  _crate.io._print (_crate.fmt.Arguments::["new_v1"] [ "`mkdir a`\n" ] [  ]) ;;
  tt ;;
  match fs.create_dir "a" with
  | Err (why) =>
    _crate.io._print
      (_crate.fmt.Arguments::["new_v1"]
        [ "! "; "\n" ]
        [ _crate.fmt.ArgumentV1::["new_debug"] why.["kind"] ]) ;;
    tt
  | Ok (_) => tt
  end ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"] [ "`echo hello > a/b.txt`\n" ] [  ]) ;;
  tt ;;
  (echo "hello" (Path::["new"] "a/b.txt")).["unwrap_or_else"]
    (fun why =>
      _crate.io._print
        (_crate.fmt.Arguments::["new_v1"]
          [ "! "; "\n" ]
          [ _crate.fmt.ArgumentV1::["new_debug"] why.["kind"] ]) ;;
      tt ;;
      tt) ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"] [ "`mkdir -p a/c/d`\n" ] [  ]) ;;
  tt ;;
  (fs.create_dir_all "a/c/d").["unwrap_or_else"]
    (fun why =>
      _crate.io._print
        (_crate.fmt.Arguments::["new_v1"]
          [ "! "; "\n" ]
          [ _crate.fmt.ArgumentV1::["new_debug"] why.["kind"] ]) ;;
      tt ;;
      tt) ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"] [ "`touch a/c/e.txt`\n" ] [  ]) ;;
  tt ;;
  (touch (Path::["new"] "a/c/e.txt")).["unwrap_or_else"]
    (fun why =>
      _crate.io._print
        (_crate.fmt.Arguments::["new_v1"]
          [ "! "; "\n" ]
          [ _crate.fmt.ArgumentV1::["new_debug"] why.["kind"] ]) ;;
      tt ;;
      tt) ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [ "`ln -s ../b.txt a/c/b.txt`\n" ]
      [  ]) ;;
  tt ;;
  if (true : bool) then
    (unix.fs.symlink "../b.txt" "a/c/b.txt").["unwrap_or_else"]
      (fun why =>
        _crate.io._print
          (_crate.fmt.Arguments::["new_v1"]
            [ "! "; "\n" ]
            [ _crate.fmt.ArgumentV1::["new_debug"] why.["kind"] ]) ;;
        tt ;;
        tt) ;;
    tt
  else
    tt ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"] [ "`cat a/c/b.txt`\n" ] [  ]) ;;
  tt ;;
  match cat (Path::["new"] "a/c/b.txt") with
  | Err (why) =>
    _crate.io._print
      (_crate.fmt.Arguments::["new_v1"]
        [ "! "; "\n" ]
        [ _crate.fmt.ArgumentV1::["new_debug"] why.["kind"] ]) ;;
    tt
  | Ok (s) =>
    _crate.io._print
      (_crate.fmt.Arguments::["new_v1"]
        [ "> "; "\n" ]
        [ _crate.fmt.ArgumentV1::["new_display"] s ]) ;;
    tt
  end ;;
  _crate.io._print (_crate.fmt.Arguments::["new_v1"] [ "`ls a`\n" ] [  ]) ;;
  tt ;;
  match fs.read_dir "a" with
  | Err (why) =>
    _crate.io._print
      (_crate.fmt.Arguments::["new_v1"]
        [ "! "; "\n" ]
        [ _crate.fmt.ArgumentV1::["new_debug"] why.["kind"] ]) ;;
    tt
  | Ok (paths) =>
    match LangItem paths with
    | iter =>
      loop
        match LangItem iter with
        | None => Break
        | Some {| Some.0 := path; |} =>
          _crate.io._print
            (_crate.fmt.Arguments::["new_v1"]
              [ "> "; "\n" ]
              [ _crate.fmt.ArgumentV1::["new_debug"] path.["unwrap"].["path"]
              ]) ;;
          tt ;;
          tt
        end ;;
        tt
        from
        for
    end
  end ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"] [ "`rm a/c/e.txt`\n" ] [  ]) ;;
  tt ;;
  (fs.remove_file "a/c/e.txt").["unwrap_or_else"]
    (fun why =>
      _crate.io._print
        (_crate.fmt.Arguments::["new_v1"]
          [ "! "; "\n" ]
          [ _crate.fmt.ArgumentV1::["new_debug"] why.["kind"] ]) ;;
      tt ;;
      tt) ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"] [ "`rmdir a/c/d`\n" ] [  ]) ;;
  tt ;;
  (fs.remove_dir "a/c/d").["unwrap_or_else"]
    (fun why =>
      _crate.io._print
        (_crate.fmt.Arguments::["new_v1"]
          [ "! "; "\n" ]
          [ _crate.fmt.ArgumentV1::["new_debug"] why.["kind"] ]) ;;
      tt ;;
      tt) ;;
  tt.
