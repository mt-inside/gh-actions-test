package main

rude := "bye"

deny[msg] {
  input.foo.bar.baz == rude

  msg := sprintf("Document must not say %s at foo/bar/baz", [rude])
}
