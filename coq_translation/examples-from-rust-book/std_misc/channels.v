(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Import Root.std.prelude.rust_2015.

Module mpsc := std.sync.mpsc.

Module Receiver := std.sync.mpsc.Receiver.
Definition Receiver := Receiver.t.

Module Sender := std.sync.mpsc.Sender.
Definition Sender := Sender.t.

Module thread := std.thread.

Definition NTHREADS (_ : unit) := 3.

Definition main (_ : unit) : unit :=
  let (tx, rx) := mpsc.channel tt in
  let children := Vec::["new"] tt in
  match LangItem {| Range.start := 0; Range.end := NTHREADS; |} with
  | iter =>
    loop
      match LangItem iter with
      | None => Break
      | Some {| Some.0 := id; |} =>
        let thread_tx := tx.["clone"] in
        let child :=
          thread.spawn
            (fun  =>
              (thread_tx.["send"] id).["unwrap"] ;;
              _crate.io._print
                (_crate.fmt.Arguments::["new_v1"]
                  [ "thread "; " finished\n" ]
                  [ _crate.fmt.ArgumentV1::["new_display"] id ]) ;;
              tt ;;
              tt) in
        children.["push"] child ;;
        tt
      end ;;
      tt
      from
      for
  end ;;
  let ids := Vec::["with_capacity"] (cast NTHREADS usize) in
  match LangItem {| Range.start := 0; Range.end := NTHREADS; |} with
  | iter =>
    loop
      match LangItem iter with
      | None => Break
      | Some {| Some.0 := _; |} =>
        ids.["push"] rx.["recv"] ;;
        tt
      end ;;
      tt
      from
      for
  end ;;
  match LangItem children with
  | iter =>
    loop
      match LangItem iter with
      | None => Break
      | Some {| Some.0 := child; |} =>
        child.["join"].["expect"] "oops! the child thread panicked" ;;
        tt
      end ;;
      tt
      from
      for
  end ;;
  _crate.io._print
    (_crate.fmt.Arguments::["new_v1"]
      [ ""; "\n" ]
      [ _crate.fmt.ArgumentV1::["new_debug"] ids ]) ;;
  tt ;;
  tt.
