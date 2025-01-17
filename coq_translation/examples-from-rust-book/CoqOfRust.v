(* This file is under MIT license:

The MIT License (MIT)

Copyright (c) 2023 Formal Land

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*)

Require Export Coq.Strings.Ascii.
Require Export Coq.Strings.String.
Require Export Coq.ZArith.ZArith.

(* Global settings for files importing this file *)
Global Set Primitive Projections.
Global Set Printing Projections.
Global Open Scope list_scope.
Global Open Scope string_scope.
Global Open Scope type_scope.
Global Open Scope Z_scope.

Export List.ListNotations.

Module Notation.
  (** A class to represent the notation [e1.e2]. This is mainly used to call
      methods, or access to named or indexed fields of structures.
      The kind is either a string or an integer. *)
  Class Dot {Kind : Set} (name : Kind) {T : Set} : Set := {
    dot : T;
  }.
  Arguments dot {Kind} name {T Dot}.

  (** A class to represent associated functions (the notation [e1::e2]). The
      kind might be [Set] functions associated to a type, or [Set -> Set] for
      functions associated to a trait. *)
  Class DoubleColon {Kind : Type} (type : Kind) (name : string) {T : Set} :
    Set := {
    double_colon : T;
  }.
  Arguments double_colon {Kind} type name {T DoubleColon}.
End Notation.

(** Note that we revert the arguments in this notation. *)
Notation "e1 .[ e2 ]" := (Notation.dot e2 e1)
  (at level 0).

Notation "e1 ::[ e2 ]" := (Notation.double_colon e1 e2)
  (at level 0).

(** A method is also an associated function for its type. *)
Global Instance AssociatedFunctionFromMethod
  (type : Set) (name : string) (T : Set)
  `(Notation.Dot (Kind := string) name (T := type -> T)) :
  Notation.DoubleColon type name (T := type -> T) := {
  Notation.double_colon := Notation.dot name;
}.

Definition defaultType (T : option Set) (Default : Set) : Set :=
  match T with
  | Some T => T
  | None => Default
  end.

Parameter axiom : forall {A : Set}, A.

Parameter cast : forall {A : Set}, A -> forall (B : Set), B.

Parameter sequence : forall {A B : Set}, A -> B -> B.

Notation "e1 ;; e2" := (sequence e1 e2)
  (at level 61, right associativity).

Parameter assign : forall {A : Set}, A -> A -> unit.

Definition u8 : Set := Z.
Definition u16 : Set := Z.
Definition u32 : Set := Z.
Definition u64 : Set := Z.
Definition u128 : Set := Z.

Definition i8 : Set := Z.
Definition i16 : Set := Z.
Definition i32 : Set := Z.
Definition i64 : Set := Z.
Definition i128 : Set := Z.

(* We approximate floating point numbers with integers *)
Definition f32 : Set := Z.
Definition f64 : Set := Z.

Definition str : Set := string.
Definition char : Set := ascii.
Definition String : Set := string.

Definition ref (A : Set) : Set := A.
Definition mut_ref : Set -> Set := ref.

Definition deref {A : Set} (r : ref A) : A := r.

Parameter eqb : forall {A : Set}, A -> A -> bool.

Module Root.
  Module std.
    Module prelude.
      Module rust_2015.
      End rust_2015.
    End prelude.
  End std.
End Root.

Module std.
  Module string.
    Module ToString.
      Class Trait (Self : Set) : Set := {
        to_string : ref Self -> String;
      }.

      Global Instance Method_to_string `(Trait) : Notation.Dot "to_string" := {
        Notation.dot := to_string;
      }.
    End ToString.
  End string.

  Module result.
    Module Result.
      Inductive t (T E : Set) : Set :=
      | Ok : T -> t T E
      | Err : E -> t T E.
      Arguments Ok {T E} _.
      Arguments Err {T E} _.
    End Result.
    Definition Result := Result.t.
  End result.

  Module fmt.
    Parameter Alignment : Set.

    Parameter Error : Set.

    Definition Result : Set := result.Result unit Error.

    Module Arguments.
      Parameter t : Set.
    End Arguments.
    Definition Arguments := Arguments.t.

    Module Write.
      Class Trait (Self : Set) : Set := {
        write_str : mut_ref Self -> ref str -> Result;
        write_char : mut_ref Self -> char -> Result;
        write_fmt : mut_ref Self -> Arguments -> Result;
      }.

      Global Instance Method_write_str `(Trait) : Notation.Dot "write_str" := {
        Notation.dot := write_str;
      }.
      Global Instance Method_write_char `(Trait) : Notation.Dot "write_char" := {
        Notation.dot := write_char;
      }.
      Global Instance Method_write_fmt `(Trait) : Notation.Dot "write_fmt" := {
        Notation.dot := write_fmt;
      }.
    End Write.

    Module Formatter.
      Parameter t : Set.
    End Formatter.
    Definition Formatter := Formatter.t.

    Module ImplFormatter.
      Parameter new : forall {W : Set} `{Write.Trait W}, mut_ref W -> Formatter.

      Global Instance Formatter_new {W : Set} `{Write.Trait W} :
        Notation.DoubleColon Formatter "new" := {
        Notation.double_colon := new;
      }.
    End ImplFormatter.

    Module Display.
      Class Trait (Self : Set) : Set := {
        fmt : ref Self -> mut_ref Formatter -> Result;
      }.
    End Display.

    Global Instance ToString_on_Display {Self : Set} `{Display.Trait Self} :
      string.ToString.Trait Self.
    Admitted.

    Module Debug.
      Class Trait (Self : Set) : Set := {
        fmt : ref Self -> mut_ref Formatter -> Result;
      }.
    End Debug.

    Module Octal.
      Class Trait (Self : Set) : Set := {
        fmt : ref Self -> mut_ref Formatter -> Result;
      }.
    End Octal.

    Module LowerHex.
      Class Trait (Self : Set) : Set := {
        fmt : ref Self -> mut_ref Formatter -> Result;
      }.
    End LowerHex.

    Module UpperHex.
      Class Trait (Self : Set) : Set := {
        fmt : ref Self -> mut_ref Formatter -> Result;
      }.
    End UpperHex.

    Module Pointer.
      Class Trait (Self : Set) : Set := {
        fmt : ref Self -> mut_ref Formatter -> Result;
      }.
    End Pointer.

    Module Binary.
      Class Trait (Self : Set) : Set := {
        fmt : ref Self -> mut_ref Formatter -> Result;
      }.
    End Binary.

    Module LowerExp.
      Class Trait (Self : Set) : Set := {
        fmt : ref Self -> mut_ref Formatter -> Result;
      }.
    End LowerExp.

    Module UpperExp.
      Class Trait (Self : Set) : Set := {
        fmt : ref Self -> mut_ref Formatter -> Result;
      }.
    End UpperExp.

    Module ArgumentV1.
      Parameter t : Set.
    End ArgumentV1.
    Definition ArgumentV1 := ArgumentV1.t.

    Module ImplArgumentV1.
      Definition Self := ArgumentV1.

      Parameter new :
        forall {T : Set},
        ref T -> (ref T -> mut_ref Formatter -> Result) -> Self.

      Global Instance ArgumentV1_new {T : Set} :
        Notation.DoubleColon ArgumentV1 "new" := {
        Notation.double_colon := new (T := T);
      }.

      Parameter new_display :
        forall {T : Set} `{Display.Trait T}, ref T -> Self.

      Global Instance ArgumentV1_new_display {T : Set} `{Display.Trait T} :
        Notation.DoubleColon ArgumentV1 "new_display" := {
        Notation.double_colon := new_display (T := T);
      }.

      Parameter new_debug :
        forall {T : Set} `{Debug.Trait T}, ref T -> Self.

      Global Instance ArgumentV1_new_debug {T : Set} `{Debug.Trait T} :
        Notation.DoubleColon ArgumentV1 "new_debug" := {
        Notation.double_colon := new_debug (T := T);
      }.

      Parameter new_octal :
        forall {T : Set} `{Octal.Trait T}, ref T -> Self.

      Global Instance ArgumentV1_new_octal {T : Set} `{Octal.Trait T} :
        Notation.DoubleColon ArgumentV1 "new_octal" := {
        Notation.double_colon := new_octal (T := T);
      }.

      Parameter new_lower_hex :
        forall {T : Set} `{LowerHex.Trait T}, ref T -> Self.

      Global Instance ArgumentV1_new_lower_hex {T : Set} `{LowerHex.Trait T} :
        Notation.DoubleColon ArgumentV1 "new_lower_hex" := {
        Notation.double_colon := new_lower_hex (T := T);
      }.

      Parameter new_upper_hex :
        forall {T : Set} `{UpperHex.Trait T}, ref T -> Self.

      Global Instance ArgumentV1_new_upper_hex {T : Set} `{UpperHex.Trait T} :
        Notation.DoubleColon ArgumentV1 "new_upper_hex" := {
        Notation.double_colon := new_upper_hex (T := T);
      }.

      Parameter new_pointer :
        forall {T : Set} `{Pointer.Trait T}, ref T -> Self.

      Global Instance ArgumentV1_new_pointer {T : Set} `{Pointer.Trait T} :
        Notation.DoubleColon ArgumentV1 "new_pointer" := {
        Notation.double_colon := new_pointer (T := T);
      }.

      Parameter new_binary :
        forall {T : Set} `{Binary.Trait T}, ref T -> Self.

      Global Instance ArgumentV1_new_binary {T : Set} `{Binary.Trait T} :
        Notation.DoubleColon ArgumentV1 "new_binary" := {
        Notation.double_colon := new_binary (T := T);
      }.

      Parameter new_lower_exp :
        forall {T : Set} `{LowerExp.Trait T}, ref T -> Self.

      Global Instance ArgumentV1_new_lower_exp {T : Set} `{LowerExp.Trait T} :
        Notation.DoubleColon ArgumentV1 "new_lower_exp" := {
        Notation.double_colon := new_lower_exp (T := T);
      }.

      Parameter new_upper_exp :
        forall {T : Set} `{UpperExp.Trait T}, ref T -> Self.

      Global Instance ArgumentV1_new_upper_exp {T : Set} `{UpperExp.Trait T} :
        Notation.DoubleColon ArgumentV1 "new_upper_exp" := {
        Notation.double_colon := new_upper_exp (T := T);
      }.
    End ImplArgumentV1.

    Module ImplArguments.
      Parameter new_v1 :
        ref (list (ref str)) -> ref (list ArgumentV1) -> Arguments.

      Global Instance Arguments_new_v1 :
        Notation.DoubleColon Arguments "new_v1" := {
        Notation.double_colon := new_v1;
      }.
    End ImplArguments.

    Global Instance Write_for_Formatter : Write.Trait Formatter.
    Admitted.
  End fmt.

  Module prelude.
    Module rust_2021.
      Module From.
        Class Trait (T : Set) (Self : Set) : Set := {
          from : T -> Self;
        }.
      End From.
    End rust_2021.
  End prelude.

  Module error.
    Module Error.
      Unset Primitive Projections.
      Class Trait (Self : Set) : Set := {
      }.
      Global Set Primitive Projections.
    End Error.
  End error.

  Module io.
  End io.

  Module ops.
    Module Add.
      Class Trait {Output : Set} (Self : Set) (Rhs : option Set) : Set := {
        Output := Output;
        Rhs := defaultType Rhs Self;
        add : Self -> Rhs -> Output;
      }.

      Global Instance Method_add `(Trait) : Notation.Dot "add" := {
        Notation.dot := add;
      }.
    End Add.

    Module AddAssign.
      Class Trait (Self : Set) (Rhs : option Set) : Set := {
        Rhs := defaultType Rhs Self;
        add_assign : mut_ref Self -> Rhs -> unit;
      }.

      Global Instance Method_add_assign `(Trait) : Notation.Dot "add_assign" := {
        Notation.dot := add_assign;
      }.
    End AddAssign.

    Module Sub.
      Class Trait {Output : Set} (Self : Set) (Rhs : option Set) : Set := {
        Output := Output;
        Rhs := defaultType Rhs Self;
        sub : Self -> Rhs -> Output;
      }.

      Global Instance Method_sub `(Trait) : Notation.Dot "sub" := {
        Notation.dot := sub;
      }.
    End Sub.

    Module SubAssign.
      Class Trait (Self : Set) (Rhs : option Set) : Set := {
        Rhs := defaultType Rhs Self;
        sub_assign : mut_ref Self -> Rhs -> unit;
      }.

      Global Instance Method_sub_assign `(Trait) : Notation.Dot "sub_assign" := {
        Notation.dot := sub_assign;
      }.
    End SubAssign.

    Module Mul.
      Class Trait {Output : Set} (Self : Set) (Rhs : option Set) : Set := {
        Output := Output;
        Rhs := defaultType Rhs Self;
        mul : Self -> Rhs -> Output;
      }.

      Global Instance Method_mul `(Trait) : Notation.Dot "mul" := {
        Notation.dot := mul;
      }.
    End Mul.

    Module MulAssign.
      Class Trait (Self : Set) (Rhs : option Set) : Set := {
        Rhs := defaultType Rhs Self;
        mul_assign : mut_ref Self -> Rhs -> unit;
      }.

      Global Instance Method_mul_assign `(Trait) : Notation.Dot "mul_assign" := {
        Notation.dot := mul_assign;
      }.
    End MulAssign.

    Module Div.
      Class Trait {Output : Set} (Self : Set) (Rhs : option Set) : Set := {
        Output := Output;
        Rhs := defaultType Rhs Self;
        div : Self -> Rhs -> Output;
      }.

      Global Instance Method_div `(Trait) : Notation.Dot "div" := {
        Notation.dot := div;
      }.
    End Div.

    Module DivAssign.
      Class Trait (Self : Set) (Rhs : option Set) : Set := {
        Rhs := defaultType Rhs Self;
        div_assign : mut_ref Self -> Rhs -> unit;
      }.

      Global Instance Method_div_assign `(Trait) : Notation.Dot "div_assign" := {
        Notation.dot := div_assign;
      }.
    End DivAssign.

    Module Rem.
      Class Trait {Output : Set} (Self : Set) (Rhs : option Set) : Set := {
        Output := Output;
        Rhs := defaultType Rhs Self;
        rem : Self -> Rhs -> Output;
      }.

      Global Instance Method_rem `(Trait) : Notation.Dot "rem" := {
        Notation.dot := rem;
      }.
    End Rem.

    Module RemAssign.
      Class Trait (Self : Set) (Rhs : option Set) : Set := {
        Rhs := defaultType Rhs Self;
        rem_assign : mut_ref Self -> Rhs -> unit;
      }.

      Global Instance Method_rem_assign `(Trait) : Notation.Dot "rem_assign" := {
        Notation.dot := rem_assign;
      }.
    End RemAssign.

    Module BitXor.
      Class Trait {Output : Set} (Self : Set) (Rhs : option Set) : Set := {
        Output := Output;
        Rhs := defaultType Rhs Self;
        bitxor : Self -> Rhs -> Output;
      }.

      Global Instance Method_bitxor `(Trait) : Notation.Dot "bitxor" := {
        Notation.dot := bitxor;
      }.
    End BitXor.

    Module BitXorAssign.
      Class Trait (Self : Set) (Rhs : option Set) : Set := {
        Rhs := defaultType Rhs Self;
        bitxor_assign : mut_ref Self -> Rhs -> unit;
      }.

      Global Instance Method_bitxor_assign `(Trait) : Notation.Dot "bitxor_assign" := {
        Notation.dot := bitxor_assign;
      }.
    End BitXorAssign.

    Module BitAnd.
      Class Trait {Output : Set} (Self : Set) (Rhs : option Set) : Set := {
        Output := Output;
        Rhs := defaultType Rhs Self;
        bitand : Self -> Rhs -> Output;
      }.

      Global Instance Method_bitand `(Trait) : Notation.Dot "bitand" := {
        Notation.dot := bitand;
      }.
    End BitAnd.

    Module BitAndAssign.
      Class Trait (Self : Set) (Rhs : option Set) : Set := {
        Rhs := defaultType Rhs Self;
        bitand_assign : mut_ref Self -> Rhs -> unit;
      }.

      Global Instance Method_bitand_assign `(Trait) : Notation.Dot "bitand_assign" := {
        Notation.dot := bitand_assign;
      }.
    End BitAndAssign.

    Module BitOr.
      Class Trait {Output : Set} (Self : Set) (Rhs : option Set) : Set := {
        Output := Output;
        Rhs := defaultType Rhs Self;
        bitor : Self -> Rhs -> Output;
      }.

      Global Instance Method_bitor `(Trait) : Notation.Dot "bitor" := {
        Notation.dot := bitor;
      }.
    End BitOr.

    Module BitOrAssign.
      Class Trait (Self : Set) (Rhs : option Set) : Set := {
        Rhs := defaultType Rhs Self;
        bitor_assign : mut_ref Self -> Rhs -> unit;
      }.

      Global Instance Method_bitor_assign `(Trait) : Notation.Dot "bitor_assign" := {
        Notation.dot := bitor_assign;
      }.
    End BitOrAssign.

    Module Shl.
      Class Trait {Output : Set} (Self : Set) (Rhs : option Set) : Set := {
        Output := Output;
        Rhs := defaultType Rhs Self;
        shl : Self -> Rhs -> Output;
      }.

      Global Instance Method_shl `(Trait) : Notation.Dot "shl" := {
        Notation.dot := shl;
      }.
    End Shl.

    Module ShlAssign.
      Class Trait (Self : Set) (Rhs : option Set) : Set := {
        Rhs := defaultType Rhs Self;
        shl_assign : mut_ref Self -> Rhs -> unit;
      }.

      Global Instance Method_shl_assign `(Trait) : Notation.Dot "shl_assign" := {
        Notation.dot := shl_assign;
      }.
    End ShlAssign.

    Module Shr.
      Class Trait {Output : Set} (Self : Set) (Rhs : option Set) : Set := {
        Output := Output;
        Rhs := defaultType Rhs Self;
        shr : Self -> Rhs -> Output;
      }.

      Global Instance Method_shr `(Trait) : Notation.Dot "shr" := {
        Notation.dot := shr;
      }.
    End Shr.

    Module ShrAssign.
      Class Trait (Self : Set) (Rhs : option Set) : Set := {
        Rhs := defaultType Rhs Self;
        shr_assign : mut_ref Self -> Rhs -> unit;
      }.

      Global Instance Method_shr_assign `(Trait) : Notation.Dot "shr_assign" := {
        Notation.dot := shr_assign;
      }.
    End ShrAssign.

    (* The trait implementations for [Z] are convenient but should be replaced
       by the implementations for the native types eventually. *)
    Module Impl_Add_for_Z.
      Definition add : Z -> Z -> Z := Z.add.

      Global Instance Method_add : Notation.Dot "add" := {
        Notation.dot := add;
      }.

      Global Instance Add_for_Z : Add.Trait Z None := {
        add := add;
      }.
    End Impl_Add_for_Z.

    Module Impl_AddAssign_for_Z.
      Parameter add_assign : mut_ref Z -> Z -> unit.

      Global Instance Method_add_assign : Notation.Dot "add_assign" := {
        Notation.dot := add_assign;
      }.

      Global Instance AddAssign_for_Z : AddAssign.Trait Z None := {
        add_assign := add_assign;
      }.
    End Impl_AddAssign_for_Z.

    Module Impl_Sub_for_Z.
      Definition sub : Z -> Z -> Z := Z.sub.

      Global Instance Method_sub : Notation.Dot "sub" := {
        Notation.dot := sub;
      }.

      Global Instance Sub_for_Z : Sub.Trait Z None := {
        sub := sub;
      }.
    End Impl_Sub_for_Z.

    Module Impl_SubAssign_for_Z.
      Parameter sub_assign : mut_ref Z -> Z -> unit.

      Global Instance Method_sub_assign : Notation.Dot "sub_assign" := {
        Notation.dot := sub_assign;
      }.

      Global Instance SubAssign_for_Z : SubAssign.Trait Z None := {
        sub_assign := sub_assign;
      }.
    End Impl_SubAssign_for_Z.

    Module Impl_Mul_for_Z.
      Definition mul : Z -> Z -> Z := Z.mul.

      Global Instance Method_mul : Notation.Dot "mul" := {
        Notation.dot := mul;
      }.

      Global Instance Mul_for_Z : Mul.Trait Z None := {
        mul := mul;
      }.
    End Impl_Mul_for_Z.

    Module Impl_MulAssign_for_Z.
      Parameter mul_assign : mut_ref Z -> Z -> unit.

      Global Instance Method_mul_assign : Notation.Dot "mul_assign" := {
        Notation.dot := mul_assign;
      }.

      Global Instance MulAssign_for_Z : MulAssign.Trait Z None := {
        mul_assign := mul_assign;
      }.
    End Impl_MulAssign_for_Z.

    Module Impl_Div_for_Z.
      Definition div : Z -> Z -> Z := Z.div.

      Global Instance Method_div : Notation.Dot "div" := {
        Notation.dot := div;
      }.

      Global Instance Div_for_Z : Div.Trait Z None := {
        div := div;
      }.
    End Impl_Div_for_Z.

    Module Impl_DivAssign_for_Z.
      Parameter div_assign : mut_ref Z -> Z -> unit.

      Global Instance Method_div_assign : Notation.Dot "div_assign" := {
        Notation.dot := div_assign;
      }.

      Global Instance DivAssign_for_Z : DivAssign.Trait Z None := {
        div_assign := div_assign;
      }.
    End Impl_DivAssign_for_Z.

    Module Impl_Rem_for_Z.
      Definition rem : Z -> Z -> Z := Z.rem.

      Global Instance Method_rem : Notation.Dot "rem" := {
        Notation.dot := rem;
      }.

      Global Instance Rem_for_Z : Rem.Trait Z None := {
        rem := rem;
      }.
    End Impl_Rem_for_Z.

    Module Impl_RemAssign_for_Z.
      Parameter rem_assign : mut_ref Z -> Z -> unit.

      Global Instance Method_rem_assign : Notation.Dot "rem_assign" := {
        Notation.dot := rem_assign;
      }.

      Global Instance RemAssign_for_Z : RemAssign.Trait Z None := {
        rem_assign := rem_assign;
      }.
    End Impl_RemAssign_for_Z.
  End ops.

  Module cmp.
    Module Ordering.
      Inductive t : Set :=
      | Less : t
      | Grreater : t
      | Equal : t.
    End Ordering.

    Module PartialEq.
      Class Trait (Self : Set) (Rhs : option Set) : Set := {
        Rhs := defaultType Rhs Self;

        eq : ref Self -> ref Rhs -> bool;
        ne : ref Self -> ref Rhs -> bool;
      }.

      Global Instance Method_eq `(Trait) : Notation.Dot "eq" := { 
        Notation.dot := eq;
      }.
      Global Instance Method_ne `(Trait) : Notation.Dot "ne" := { 
        Notation.dot := ne;
      }.
    End PartialEq.

    Module PartialOrd.
      Class Trait (Self : Set) (Rhs : option Set) : Set := {
        Rhs := defaultType Rhs Self;

        partial_cmp : ref Self -> ref Self -> option (Ordering.t);
        lt : ref Self -> ref Rhs -> bool;
        le : ref Self -> ref Rhs -> bool;
        gt : ref Self -> ref Rhs -> bool;
        ge : ref Self -> ref Rhs -> bool;
      }.

      Global Instance Method_partial_cmp `(Trait) : Notation.Dot "partial_cmp" := { 
        Notation.dot := partial_cmp;
      }.
      Global Instance Method_lt `(Trait) : Notation.Dot "lt" := { 
        Notation.dot := lt;
      }.
      Global Instance Method_le `(Trait) : Notation.Dot "le" := { 
        Notation.dot := le;
      }.
      Global Instance Method_gt `(Trait) : Notation.Dot "gt" := { 
        Notation.dot := gt;
      }.
      Global Instance Method_ge `(Trait) : Notation.Dot "ge" := { 
        Notation.dot := ge;
      }.
    End PartialOrd.
  End cmp.

End std.

Module str_Instances.
  Global Instance IDisplay : std.fmt.Display.Trait str.
  Admitted.
End str_Instances.

Module Z_Instances.
  Global Instance IDisplay : std.fmt.Display.Trait Z.
  Admitted.
End Z_Instances.

Module _crate.
  Module intrinsics.
    Parameter discriminant_value : forall {A : Set}, ref A -> u128.
  End intrinsics.

  Module marker.
    Module Copy.
      Unset Primitive Projections.
      Class Trait (Self : Set) : Set := {
      }.
      Global Set Primitive Projections.
    End Copy.

    Module StructuralEq.
      Unset Primitive Projections.
      Class Trait (Self : Set) : Set := {
      }.
      Global Set Primitive Projections.
    End StructuralEq.

    Module StructuralPartialEq.
      Unset Primitive Projections.
      Class Trait (Self : Set) : Set := {
      }.
      Global Set Primitive Projections.
    End StructuralPartialEq.
  End marker.

  Module clone.
    Module Clone.
      Class Trait (Self : Set) : Set := {
        clone : ref Self -> Self;
      }.
    End Clone.
  End clone.

  Module cmp.
    Module Eq.
      Class Trait (Self : Set) : Set := {
        assert_receiver_is_total_eq : ref Self -> unit;
      }.
    End Eq.

    Module PartialEq.
      Class Trait (Self : Set) : Set := {
        eq : ref Self -> ref Self -> bool;
      }.
    End PartialEq.
  End cmp.

  Module io.
    Parameter _print : forall {A : Set}, A -> unit.
  End io.

  Module fmt := std.fmt.

  Module log.
    Parameter sol_log : str -> unit.
  End log.
End _crate.

Module num_derive.
  Module FromPrimitive.
  End FromPrimitive.
End num_derive.

Module solana_program.
  Module decode_error.
    Module DecodeError.
      Class Class (E : Set) (Self : Set) : Set := {
        type_of : unit -> ref str;
      }.
    End DecodeError.
  End decode_error.

  Module msg.
  End msg.

  Module program_error.
    Module PrintProgramError.
      Class Class (Self : Set) : Set := {
        print : ref Self -> unit;
      }.
    End PrintProgramError.

    Module ProgramError.
      Inductive t : Set :=
      | Custom (_ : u32)
      | InvalidArgument
      | InvalidInstructionData
      | InvalidAccountData
      | AccountDataTooSmall
      | InsufficientFunds
      | IncorrectProgramId
      | MissingRequiredSignature
      | AccountAlreadyInitialized
      | UninitializedAccount
      | NotEnoughAccountKeys
      | AccountBorrowFailed
      | MaxSeedLengthExceeded
      | InvalidSeeds
      | BorshIoError (_ : String)
      | AccountNotRentExempt
      | UnsupportedSysvar
      | IllegalOwner
      | MaxAccountsDataSizeExceeded
      | InvalidRealloc.
    End ProgramError.
    Definition ProgramError := ProgramError.t.
  End program_error.
End solana_program.

Module thiserror.
  Module Error.
  End Error.
End thiserror.

Parameter _num_traits : Set.
Module _num_traits.
  Module FromPrimitive.
    Class Class (Self : Set) : Set := {
      from_i64 : i64 -> option Self;
      from_u64 : u64 -> option Self;
    }.
  End FromPrimitive.
End _num_traits.

Module crate.
  Parameter check_program_account : unit -> unit.
End crate.

Module rand.
  Parameter thread_rng : unit -> Set.
  Module Rng.
  End Rng.
End rand.
