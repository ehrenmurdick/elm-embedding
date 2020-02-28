## Embedding Elm apps in each other

This repo is here to show some examples of how to embed elm apps in one
another.  Your first stop should be [src/Increment.elm](src/Increment.elm)
where you can see a simple example app to start with.

Then look at [src/Embedded.elm](src/Embedded.elm) to see how this example app
can be embedded in a simple parent app.

Next, look at [src/Main.elm](src/Main.elm) to see a more advanced example app.
Finally see [src/AdvancedEmbedded.elm](src/AdvancedEmbedded.elm) to see how
this more complicated app can still be embedded in a parent app even though it
uses subscriptions, ports and commands.

### How does all this work exactly?

Essentially, Elm does not provide provisions for embedding one app in another,
becuase it doesn't need to. The only issue that arrisese when you attempt to do
this in a naive way, is that you get type errors where the parent app would
expect, say `Cmd Msg` but the child app returns `Cmd Child.Msg`.

So the only thing we need to do to make the naive approach work is somehow
coerce the child app's Cmd Msg to be the same type as the parent's. 

Along comes the `map` function, in this case for `Cmd` (it's the same for every
Sub and Html):

```elm
map : (a -> b) -> Cmd a -> Cmd b
```

All we need to provide is that first argument, a function which takes in one
type of message and returns the other. The easiest way (but not the only way)
to do this, is to make a parent Msg that wraps the child's Msg.

```elm
type Parent.Msg =
  Wrapped Child.Msg
```

And `Wrapped` will have type `Parent.Msg -> Child.Msg`. So we provide that as
the first argument to `map`, and there you have it!


### Further reading

In more abstract languages like Haskell (in fact the language that the Elm
compiler is written in) the thing that `Cmd`, `Sub` and `Html` all have in
common is that they have a function called `map`, which would qualify them as
"functors", which just means they are things that can be mapped over. `List` in
Elm is also a functor.

In order to be a true functor, they must also follow two rules:

- Map must preserve identity
    ```
    id : a -> a
    id a = a
    ```
    and
    `map id functor == id functor`
    - This means that the map function cannot have side effects. Calling map on
      a functor should not change its structure in any way, or modify any other
      properties of the collection besides it's contents.

      For example with `Html.map` in Elm, we can rest assured that it won't
      modify the structure of our html at all, all it's allowed to do is change
      the type of messages.


- Composition of functors is associative
    `map (f << g) == map f << map g`

    - In other words it's not allowed to mess with the functions you pass in.
      If a map implementation did something like also call `toString` on the result
      of `f` before putting it back, then this law wouldn't hold any more.

These rules both hold for Elm's mappable types, so they are indeed functors!
