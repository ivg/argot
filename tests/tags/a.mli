(** Test for tags.
    @copyright none
	@license lgplv3 *)

val poly : 'a list -> 'a
(** some info...
    @typevar 'a element *)

val nop : unit -> unit
(* @obvious *)

val do_nothing_1 : unit -> unit
(** @alias [nop] *)

val do_nothing_2 : unit -> unit
(** @synonym [nop] *)

val do_something : unit -> unit
(** @equivalent [M.do_something 0] *)

val f : int -> int
(** some info...
    @todo check that passed parameter is positive *)

val g : float -> float
(** @todoc before release *)

val h : bool -> bool
(** some info...
    @fixme should never raise an exception *)

val get : unit -> int
(** some info...
    @stateful uses a random generator *)

val apply : ('a -> unit) -> 'a list -> unit
(** some info...
    @threadunsafe use [apply_mt] in multithread application *)

val apply_mt : ('a -> unit) -> 'a list -> unit
(** some info...
    @threadsafe use [apply] in monothread application *)

val complex : float -> float -> (float * float)
(** some info...
    @attention will not work if...
    @note may also diverge when...
    @remark one should be aware... *)

val buggy : bool -> int
(** some info...
    @info additional info
    @bug when called with [false]
    @error when called with [true] *)

val fresh : string -> int
(** some info...
    @new handles the empty string
    @warning may not work if the string contains white spaces *)
