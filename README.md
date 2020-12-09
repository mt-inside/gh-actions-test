# gh-actions-test

foo
one
two
three

## TODO
Lerna is pr-based, ie it will only list PRs!
PRs are anotehr figment of GH's imagination
I guess it walks the commits and finds PRs for those that have them
That means if none of your commits are merges, backed by PRs, you'll get an empty changelog!!
TODO short-term: have lerna output "no PRs" or summat, not fucking "", for sanity
TODO long-term: have lerna also emit non-pr, non-merge commits, maybe with a :warning: emojum (all part of the re-write)

Re-write lerna to
* take token as arg not env
* show all commits, not just merges, not just PRs (configurable)
* be one big monad string

## FIXME
* being triggered on every push, not just tags - often fails
* mt-inside/generate-changelog silently returns empty string when there's no PRs in range - have it emit "no changes", or better non-PR commits
