# Notes from Elixir for Beginners

## 2. Hello World

### File Types

- `snake_case.ex`: A compiled `elixir` file.
- `snake_case.exs`: A script `elixir` file.

### Comments

```elixir
# This is a comment
```

### Executing a file

```console
✔ elixir hello_world.exs
```

### Executing the Interactive Elixir REPL

```console
✔ iex
```

### Help in `iex`

```console
iex(1)> h String.downcase
```

```console
iex(2)> h String
```

### Compiling from `iex`

```console
iex(1)> c "./2_hello_world.exs"
```

### Configuring `iex`

```console
✔ emacs ~/.iex.exs
```


## 3. Basic types

### Numbers

- **Integers**:
	- Unlimited size.
	- Can use a `_` separator.
- **Floats**:
	- 64-bit accuracy (about 16 digits)

### Integers, Octals, Hexadecimals and Binaries

```console
iex(1)> 123      # An Integer
123
iex(2)> 0o444    # An Octal `0o...`
292
iex(3)> 0xabc    # A Hexadecimal `0x...`
2748
iex(4)> 0b1011   # A Binary `0b...`
11
```

### Floats

```console
iex(1)> 123.0
123.0
iex(2)> 31415.0e-4
3.1415
```

### `/` vs `div`

```console
iex(1)> 10 / 2
5.0
iex(2)> div 10, 2
5
iex(3)> 10 / 3
3.3333333333333335
iex(4)> div 10, 3
3
```

### Atoms

Immutable Strings (or constants) used:

- As Keys.
- To reference `Erlang` functions.
- To reference functions within `Elixir`.

```console
iex(1)> :an_atom
:an_atom
iex(2)> :an_atom_is_a_String === :"an_atom_is_a_String"
true
```

### Booleans

The `true` / `false` values are references to its equivalent `atom` values

```console
iex(1)> true == :true
true
iex(2)> true === :true
true
iex(3)> false == :false
true
iex(4)> false === :false
true
```

### Strings

```console
iex(1)> name = "Elixir"
"elixir"
iex(2)> "Hello #{name}!"
"Hello Elixir!"
```

#### UTF-8 Strings

Strings in `Elixir` are UTF-8 compliant by default:

```console
iex(1)> "à"
"à"
iex(2)> byte_size "à"
2
iex(3)> String.length "à"
1
iex(4)> "a"
"a"
iex(5)> byte_size "a"
1
iex(6)> String.length "a"
1
```

#### Single vs Double quote Strings

Single quote Strings are sequences of Chars (NOT Strings per sè):

```console
iex(1)> is_list 'hello'
true
iex(2)> is_list "hello"
false
```

Double quote Strings are binaries:

```console
iex(1)> is_binary "hello"
true
iex(2)> is_binary 'hello'
false
```

### Anonymous Functions

```console
iex(1)> hello = fn (p) -> "hello #{p}" end
#Function<6.50752066/1 in :erl_eval.expr/5>
iex(2)> hello.("elixir")
"hello elixir"
iex(3)> is_function hello
true
```

### Tuples

A Tuple is an Immutable Indexed Array:

```console
iex(1)> {1,2,3}
{1, 2, 3}
iex(2)> elem {1, 2, 3}, 1
2
```

Usually used as a return value from a function:

```console
iex(1)> hello = fn -> {:ok, "hello"} end
#Function<20.50752066/0 in :erl_eval.expr/5>
iex(2)> hello.()
{:ok, "hello"}
```

## 4. Basics of functional thinking

### Pattern Matching

Pattern Matching in `Elixir` is about making the `RHS` of an `=` operator match the `LHS`.

#### Pattern Matching Function Arguments

```elixir
bingo = fn
  (88) -> "Bingo!"
  (_)  -> "No win"
end

# > bingo.(88)
#   "Bingo!"
# > bingo.(4)
#   "No win"
```

#### Pattern Matching Tuples

```console
iex(1)> {1, 2, 3} = {1, 2, 3}
{1, 2, 3}
```

Match the number of elements:

```console
iex(2)> {a, b} = {1, "two", "three"}
** (MatchError) no match of right hand side value: {1, "two", "three"}
iex(2)> {a, b, c} = {1, "two", "three"}
{1, "two", "three"}
```

Only bind once per match:

```console
iex(3)> {a, b, b} = {1, "two", "three"}
** (MatchError) no match of right hand side value: {1, "two", "three"}
```

Ignore with `_`:

```console
iex(6)> {a, b, _} = {1, "two", "not important"}
{1, "two", "not important"}
```


#### Pattern Matching Lists with `|`

```console
iex(1)> a_list = [:head, :tail]
[:head, :tail]
iex(2)> hd a_list
:head
iex(3)> tl a_list
[:tail]

iex(4)> [h | t] = a_list
[:head, :tail]
iex(5)> h
:head
iex(6)> t
[:tail]
```

## 5. Complex Types

### Lists

A List is a container that can hold any kind of type:

```console
iex(1)> a_list = [1, "two", :three]
[1, "two", :three]
```

We can append with the `++` macro (expensive?):

```console
iex(1)> [1,2,3] ++ [4,5,6]
[1, 2, 3, 4, 5, 6]
```

We can remove with the `--` macro (expensive?):

```console
iex(1)> [1,2,3] -- [2]
[1, 3]
```

A List is made of "cons cell" values with pointers:

```console
iex(1)> [1 | [2 | []]]
[1, 2]
iex(2)> [1 | [2 | []]] === [1, 2]
true
```

Adding ("pre-appending") an element to a List is **cheap**:

```console
iex(1)> [0 | [1, 2, 3]]
[0, 1, 2, 3]
```

Size is **expensive**, we need to traverse the whole List to know its size:

```console
iex(1)> length [0, 1, 2, 3]
4
```

#### `size` vs `length` in `Elixir`

Semantically, `Elixir` tries to use:

- `size` for operations that happen in normal time (**cheap / fast**).
- `length` for operations that happen in linear time (**expensive / slow**).

```console
iex(1)> length [1, 2, 3]        # SLOW!
3
iex(2)> tuple_size {1, 2, 3}    # FAST!
3
```

### Keyword Lists

A Keyword List is a List of Tuple pairs where the first element of the Tuple is an Atom:

```console
iex(1)> [{:a, 1}, {:b, 2}] === [a: 1, b: 2]
true
```

We can use any operation from List:

```console
iex(1)> [a: 1, b: 2] ++ [c: 3]
[a: 1, b: 2, c: 3]
iex(2)> [a: 1, b: 2] -- [a: 1]
[b: 2]

iex(3)> [head | tail] = [a: 1, b: 2, c: 3]
[a: 1, b: 2, c: 3]
iex(4)> head
{:a, 1}
iex(5)> tail
[b: 2, c: 3]
```

The Keyword Module encapsulates a lot of functionality to use Keyword Lists as Dictionaries:

```console
iex(1)> Keyword.get [a: 1, b: 2, c: 3], :b
2
iex(2)> [a: 1, b: 2, c: 3][:b]
2
```

...but, since we are actually dealing with Lists (not Dictionaries), retrieving values is **slow**.

It's unusual to use Keyword Lists for Pattern Matching.

Used for passing options to functions:

```elixir
cook = fn (heat, foods) ->
  Keyword.values(foods)
    |> Enum.map(&(heat <> &1))
end

# > cook.("Fried ", [meat: "sausage", veg: "beans"])
#   ["Fried sausage", "Fried beans"]
```

Used in the `if` macro:

```console
iex(1)> if true, do: :this, else: :that
:this
iex(2)> if(true, [do: :this, else: :that])
:this
```

### Maps

`Maps` are efficient key/value stores (dictionaries):

```console
iex(1)> %{:a => 1, :b => 2} === %{a: 1, b: 2}
true
```

Retrieve `keys` and `values`:

```console
iex(1)> a_map = %{a: 1, b: 2}
%{a: 1, b: 2}

iex(2)> Map.keys a_map
[:a, :b]
iex(3)> Map.values a_map
[1, 2]

iex(4)> a_map.a
1
iex(5)> a_map.b
2
iex(6)> a_map.z
** (KeyError) key :z not found in: %{a: 1, b: 2}
```

Don't rely on order:

```console
iex(1)> %{a: 1, a: 99}
%{a: 99}
```

Pattern Matching:

```console
iex(1)> %{} = %{a: 1, b: 2, c: 3}
%{a: 1, b: 2, c: 3}
iex(2)> %{b: 2} = %{a: 1, b: 2, c: 3}
%{a: 1, b: 2, c: 3}

iex(3)> %{a: x, b: 2} =%{a: 1, b: 2, c: 3}
%{a: 1, b: 2, c: 3}
iex(4)> x
1

iex(5)> %{d: 4} = %{a: 1, b: 2, c: 3}
** (MatchError) no match of right hand side value: %{a: 1, b: 2, c: 3}
```

Using `Map.get` and `Map.to_list`:

```console
iex(1)> Map.get %{a: 1, b: 2, c: 3}, :b
2

iex(2)> Map.to_list %{a: 1, b: 2, c: 3}
[a: 1, b: 2, c: 3]
```

Update **EXISTING** elements:

```console
iex(1)> a_map = %{a: 1, b: 2, c: 3}
%{a: 1, b: 2, c: 3}

iex(2)> %{a_map | b: "hello"}
%{a: 1, b: "hello", c: 3}

iex(3)> %{a_map | z: "FAIL!"}
** (KeyError) key :z not found in: %{a: 1, b: 2, c: 3}
    (stdlib) :maps.update(:z, "FAIL!", %{a: 1, b: 2, c: 3})
    (stdlib) erl_eval.erl:255: anonymous fn/2 in :erl_eval.expr/5
    (stdlib) lists.erl:1262: :lists.foldl/3
```


## 6. Modules and Functions

### Modules

Modules are a way to group functions together:

```elixir
defmodule Greet do
  def hello do
    "hello"
  end
end
```

Every `Elixir` module is pre-appended with `Elixir.`:

```console
iex(1)> IO.puts Greet
Elixir.Greet
:ok
```

Modules can be nested:

```elixir
defmodule Greet do
  defmodule Welcome do
  end
end
```

```console
iex(1)> IO.puts Greet.Welcome
Elixir.Greet.Welcome
:ok
```

#### One module per file Convention

`greet.exs`

```elixir
defmodule Greet do
  def hello do
    "hello"
  end
end
```

`elixirc` compiles a source file into `.beam` file

```console
✔ ls
  greet.exs
✔ elixirc greet.exs
✔ ls
  Elixir.Greet.beam greet.exs
```

`iex` automatically loads `.beam` files

```console
✔ iex

iex(1)> Greet.hello
"hello"
```

### Named Functions

- Must be defined inside a module.
- Can be public (`def`) or private (`defp`).

`cook.exs`

```elixir
defmodule Cook do
  def cook(meat, veg), do: _cook("Grill", meat) <> _cook("Boil", veg)
  defp _cook(cook, food), do: "#{cook} #{food} "
end
```

```console
iex(3)> Cook.cook "pasta", "bacon"
"Grill pasta Boil bacon "
```

Pattern Matching allows functions to have multiple clauses:

```elixir
defmodule Cook do
  def cook,             do: cook("fry", "sausage")
  def cook(0),          do: cook("bake", "banana")
  def cook(meat),       do: cook("grill", meat)
  def cook(type, food), do: "#{type} #{food}"
end
```

```console
iex(1)> Cook.cook
"fry sausage"
iex(2)> Cook.cook 0
"bake banana"
iex(3)> Cook.cook "cucumber"
"grill cucumber"
iex(4)> Cook.cook "bake", "pie"
"bake pie"
```

Pattern Matching with Guard Clauses:

```elixir
defmodule Cook do
  def cook(food) when food == 0,        do: "No cooking"
  def cook(food) when is_integer(food), do: "Food is the number #{food}!"
  def cook(food) when is_atom(food),    do: "Food is atomic!"
  def cook(food) when is_binary(food),  do: cook("boil", food)
  def cook(type, food),                 do: "#{type} #{food}"
end
```

```console
iex(1)> Cook.cook 0
"No cooking"
iex(2)> Cook.cook 5
"Food is the number 5!"
iex(3)> Cook.cook :sushi
"Food is atomic!"
iex(4)> Cook.cook "tomato"
"boil tomato"
iex(5)> Cook.cook "bake", "pie"
"bake pie"
```

With default arguments:

```elixir
defmodule Cook do
  def cook(type \\"grill", food), do: "#{type} #{food}"
end
```

```console
iex(1)> Cook.cook "tomato"
"grill tomato"
iex(2)> Cook.cook "bake", "pie"
"bake pie"
```

### Function Captures

Capture syntax for functions (valid for `elixir` and `erlang`):

- Capture operator: `&`
- Notation for functions: `name/arity`


```console
iex(1)> &is_nil/1
#Function<6.50752066/1 in :erl_eval.expr/5>
iex(2)> &hd/1
&:erlang.hd/1
```

- For `elixir` functions it returns a function.
- For `erlang` functions it returns an atom.

### Anonymous Function Capture

From:

```elixir
fn x -> x + 1 end
```

To:

```elixir
&(&1 + 1)
```

Use it as a regular anonymous function:

```console
iex(1)> increment = &(&1 + 1)
#Function<6.50752066/1 in :erl_eval.expr/5>
iex(1)> increment.(3)
4
```

## 7. Recursion

### Tail Call

`Elixir` is a Tail Call optimized language:

- If the last thing a function does within a function body is a call to another function (can be itself), then that is a **TAIL CALL**.
- The runtime can jump (GOTO-like) back to the start of the function (no `Stack Frame` is added).

#### The Stack in a non Tail Call optimized function

Not Tail Call optimized because of the `10 + ...` part):

```elixir
defmodule Recursion
  def ten_times(0), do: 0
  def ten_times(n), do: 10 + ten_times(n-1)
end

IO.puts Recursion.ten_times(3)
```

A simulated `Stack` (each line is a `Stack Frame`):

```elixir
ten_times(3)
10 + ten_times(2)
10 + ten_times(10 + ten_times(1))
10 + ten_times(10 + ten_times(10 + ten_times(0)))
10 + ten_times(10 + ten_times(10 + 0))
...
10 + ten_times(10 + 10)
...
10 + 20
30
```

#### The Stack in a Tail Call optimized function

Tail Call optimized version:

```elixir
defmodule Recursion
  def ten_times(0, acc), do: acc
  def ten_times(n, acc), do: ten_times(n-1, acc+10)
end

IO.puts Recursion.ten_times(3, 0)
```

Now, we:

1. Add a `Stack Frame`.
2. Perform the calculation.
3. Remove the `Stack Frame`.
4. Go back to 1.

Tail Call optimized version, with a simple interface:

```elixir
defmodule Recursion
  def  ten_times(n),      do: ten_times(n, 0)
  defp ten_times(0, acc), do: acc
  defp ten_times(n, acc), do: ten_times(n-1, acc+10)
end

IO.puts Recursion.ten_times(3)
```

A simulated `Stack` (each line is a `Stack Frame`):

```elixir
ten_times(3, 0)
# Remove the previous `Stack Frame`
ten_times(2, 10)
# Remove the previous `Stack Frame`
ten_times(1, 20)
# Remove the previous `Stack Frame`
ten_times(0, 30)
# Return
30
```

## 8. Processes

In `Elixir`:

- All code runs inside isolated processes.
- Processes comunicate with each other using messages.
- The `Actor Model` is used as a metaphor of the inter-process comunication.


### How to spawn a process

```console
iex(1)> pid = spawn fn -> :ping end
#PID<0.69.0>
iex(2)> Process.alive? pid
false
```

### `iex` is itself a process

```console
iex(3)> self
#PID<0.67.0>
```

### Sending and receiving messages

```console
iex(4)> send self, {self, :pong}
{#PID<0.67.0>, :pong}
iex(5)> receive do
...(5)>   {sender, action} -> "Sender #{inspect sender}, action #{inspect action}."
...(5)> end
"Sender #PID<0.67.0>, action :pong."

iex(6)> send self, {self, :ping}
{#PID<0.67.0>, :ping}
iex(7)> receive do
...(7)>   {sender, action} -> "Sender #{inspect sender}, action #{inspect action}."
...(7)> end
"Sender #PID<0.67.0>, action :ping."
```

### Receiving messages with the `after` macro

```console
iex(8)> send self, {self, :pang}
{#PID<0.67.0>, :pang}
iex(9)> receive do
...(9)>   {sender, action} -> "Sender #{inspect sender}, action #{inspect action}."
...(9)> after
...(9)>   1_000 -> "...timed out after 1 second."
...(9)> end
"Sender #PID<0.67.0>, action :pang."

iex(10)> receive do
...(10)>   {sender, action} -> "Sender #{inspect sender}, action #{inspect action}."
...(10)> after
...(10)>   1_000 -> "...timed out after 1 second."
...(10)> end
"...timed out after 1 second."
```

### Basic monitor when processes fail

We need to link processes together with `Kernel.spawn_link`:

```console
iex(1)> boing_pid = spawn fn -> raise "boom chak" end
#PID<0.59.0>
iex(2)>
13:05:45.215 [error] Process #PID<0.59.0> raised an exception
** (RuntimeError) boom chak
    :erlang.apply/2

nil

iex(3)> boing_pid = spawn_link fn -> raise "boom chak" end
** (EXIT from #PID<0.57.0>) an exception was raised:
    ** (RuntimeError) boom chak
        :erlang.apply/2

13:06:28.157 [error] Process #PID<0.62.0> raised an exception
** (RuntimeError) boom chak
    :erlang.apply/2
```

### Better monitor with `Task`

```console
iex(1)> task_pid = Task.start fn -> "returns a tuple" end
{:ok, #PID<0.65.0>}

iex(2)> boing_pid = Task.start fn -> raise "boom chak" end
{:ok, #PID<0.67.0>}
iex(3)>
13:11:13.830 [error] Task #PID<0.67.0> started from #PID<0.63.0> terminating
** (RuntimeError) boom chak
    (elixir) lib/task/supervised.ex:89: Task.Supervised.do_apply/2
    (stdlib) proc_lib.erl:240: :proc_lib.init_p_do_apply/3
Function: #Function<20.50752066/0 in :erl_eval.expr/5>
    Args: []

nil

iex(4)> boing_pid = Task.start_link fn -> raise "boom chak" end
** (EXIT from #PID<0.63.0>) an exception was raised:
    ** (RuntimeError) boom chak
        (elixir) lib/task/supervised.ex:89: Task.Supervised.do_apply/2
        (stdlib) proc_lib.erl:240: :proc_lib.init_p_do_apply/3


13:11:26.214 [error] Task #PID<0.70.0> started from #PID<0.63.0> terminating
** (RuntimeError) boom chak
    (elixir) lib/task/supervised.ex:89: Task.Supervised.do_apply/2
    (stdlib) proc_lib.erl:240: :proc_lib.init_p_do_apply/3
Function: #Function<20.50752066/0 in :erl_eval.expr/5>
    Args: []
```

## 9. The Caesar Cipher Example

### `mix` tasks and help

```console
✔ mix help
```

```console
✔ mix help <task>
✔ mix help deps
✔ mix help new
```

### `mix` workflow

#### 1. Create `new` project
```console
✔ mix new <project>
✔ cd caesar
✔ mix test
```

#### 2. Add and install `dep`endencie`s`

```console
✔ mix hex.info ex_doc
✔ mix hex.info earmark
```

`mix.exs`

```elixir
defp deps do
  [
    {:ex_doc, "~> 0.11"},
    {:earmark, "~> 0.2"}
  ]
end
```

```console
✔ mix deps
* ex_doc (Hex package)
  the dependency is not available, run "mix deps.get"
* earmark (Hex package)
  the dependency is not available, run "mix deps.get"

✔ mix deps.get
Running dependency resolution
Dependency resolution completed
  earmark: 0.2.1
  ex_doc: 0.11.5
* Getting ex_doc (Hex package)
  Checking package (https://repo.hex.pm/tarballs/ex_doc-0.11.5.tar)
  Fetched package
* Getting earmark (Hex package)
  Checking package (https://repo.hex.pm/tarballs/earmark-0.2.1.tar)
  Fetched package
```

#### 3. Test

We need three thing in order to run `ExUnit` tests:

- A `test_helper.exs` file which starts `ExUnit` in its own process `ExUnit.start()`.
- A test file (`caesar_test.exs`) that uses the `ExUnit` framework (`use ExUnit.Case`).
- Run our tests using `mix test`.

### How to load your `mix` project into `iex`

```console
✔ iex -S mix
Erlang/OTP 18 [erts-7.3] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
Interactive Elixir (1.2.5) - press Ctrl+C to exit (type h() ENTER for help)

iex(1)> Caesar.Cipher.encrypt("abcd", 12)
"opqr"
```

### Command-line built-in module: `escript`

You need to use a `main` function as the entry point.

### Compile a `escript` program

```console
✔ mix help escript.build
✔ mix escript.build
```

### How to run a particular module using `mix`

```console
✔ mix run -e 'Caesar.main(["encrypt", "abcd", "--shift", "3"])'
xyza
```


### Module attributes

Encapsulate hardcoded data into module attributes:

```elixir
defmodule Caesar.Cipher do
  @alphabet_size 26

  defp calculate_mapping(base_letter, char, shift) do
    normalize = &(&1 - @alphabet_size)
  end
end
```

and even better, use `config.exs` too:

```elixir
use Mix.Config

config :caesar, alphabet_size: 26
```

```elixir
defmodule Caesar.Cipher do
  @alphabet_size Application.get_env(:caesar, :alphabet_size)
end
```

### Logging example

```elixir
defmodule Caesar.Cipher do
  require Logger

  def encrypt(msg, shift) do
    Logger.debug "encrypting \"#{msg}\" with a shift number of: #{shift}"
  end
```

```console
✔ iex -S mix
Erlang/OTP 18 [erts-7.3] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

iex(1)> Caesar.Cipher.encrypt "abc", 2

11:53:44.304 [debug] encrypting "abc" with a shift number of: 2
"yza"
```

### Documentation


Generates the documentation:

```console
✔ mix docs
```
