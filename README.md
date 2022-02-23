# Array Re-arrange Challenge

## Description

Write a function that accepts two arguments, `arr` and `offset`:

- `arr` and `offset` are both arrays containing `N` elements where `N` is greater than 0
- `offset` contains only integer values

The function should return an array where each non `nil` value in `arr` is shifted by the amount given at the same index in `offset`.

```ruby
arr = [1, nil, nil]
offset = [1, 0, 0]
# shift arr[0] to arr[1]
# ignore offset[1] since arr[1] was initially nil
# ignore offset[2] since arr[2] is nil
result = [nil, 1, nil]
```

Two values cannot be shifted into the same index nor can a value be shifted to an index that is already occupied by a
non `nil` value that will not be moved.

```ruby
arr = [1, nil, 2]
offset = [1, 0, -1]
# offset[0] and offset[2] cancel out because they would move items to the same index
result = [1, nil, 2]

arr = [1, 2, nil]
offset = [1, -1, 0]
# offset[0] and offset[1] are allowed to swap since both items will move
result = [2, 1, nil]

```

See the test cases in `spec/rearrange_spec.rb` for a more comprehensive list of examples.

## Running the tests

    bundle
    rspec -fd
