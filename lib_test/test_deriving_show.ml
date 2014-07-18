open OUnit2

let printer = fun x -> x

type a1 = int       [@@deriving Show]
type a2 = int32     [@@deriving Show]
type a3 = int64     [@@deriving Show]
type a4 = nativeint [@@deriving Show]
type a5 = float     [@@deriving Show]
type a6 = bool      [@@deriving Show]
type a7 = char      [@@deriving Show]
type a8 = string    [@@deriving Show]
type a9 = bytes     [@@deriving Show]
let test_alias ctxt =
  assert_equal ~printer "1"       (show_a1 1);
  assert_equal ~printer "1l"      (show_a2 1l);
  assert_equal ~printer "1L"      (show_a3 1L);
  assert_equal ~printer "1n"      (show_a4 1n);
  assert_equal ~printer "1."      (show_a5 1.);
  assert_equal ~printer "true"    (show_a6 true);
  assert_equal ~printer "'a'"     (show_a7 'a');
  assert_equal ~printer "\"foo\"" (show_a8 "foo");
  assert_equal ~printer "\"foo\"" (show_a9 "foo")

type v = Foo | Bar of int * string | Baz of string [@@deriving Show]
let test_variant ctxt =
  assert_equal ~printer "Foo"              (show_v Foo);
  assert_equal ~printer "Bar (1, \"foo\")" (show_v (Bar (1, "foo")));
  assert_equal ~printer "Baz \"foo\""      (show_v (Baz "foo"))

type pv = [ `Foo | `Bar of int * string ] [@@deriving Show]
let test_poly ctxt =
  assert_equal ~printer "`Foo"              (show_pv `Foo);
  assert_equal ~printer "`Bar (1, \"foo\")" (show_pv (`Bar (1, "foo")))

type pv' = [ `Baz | pv ] [@@deriving Show]
let test_poly_inherit ctxt =
  assert_equal ~printer "`Foo" (show_pv' `Foo);
  assert_equal ~printer "`Baz" (show_pv' `Baz)

type t = int * string [@@deriving Show]
let test_tuple ctxt =
  assert_equal ~printer "(1, \"foo\")" (show_t (1, "foo"))

type z = a1 [@@deriving Show]
let test_abstr ctxt =
  assert_equal ~printer "1" (show_z 1)

let suite = "Test deriving(Show)" >::: [
    "test_alias"        >:: test_alias;
    "test_variant"      >:: test_variant;
    "test_tuple"        >:: test_tuple;
    "test_abstr"        >:: test_abstr;
    "test_poly"         >:: test_poly;
    "test_poly_inherit" >:: test_poly_inherit;
  ]
