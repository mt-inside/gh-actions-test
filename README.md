# gh-actions-test

## Scratch to generate noise
foo
one
two
three
just in case
four

## Repo Setup

To make it work like prow...
* Protect branch `main`
* Require review before merge
* Require review from code owner

## TODO
Lerna is pr-based, ie it will only list PRs!
PRs are anotehr figment of GH's imagination
I guess it walks the commits and finds PRs for those that have them
That means if none of your commits are merges, backed by PRs, you'll get an empty changelog!! It doesn't even include things with labels it doesn't recognise
TODO short-term: have lerna output "no PRs" or summat, not fucking "", for sanity
TODO long-term: have lerna also emit non-pr, non-merge commits, maybe with a :warning: emojum (all part of the re-write)

Re-write lerna to
* take token as arg not env
* show all commits, not just merges, not just PRs (configurable), with "unknown" for unknown/missing labels, "warning" for non-PRs
* be one big monad string
* not need to take the repo as an arg

When this is in a nice shape
* apply toother repos ofc
* rename this one to something nice, tart up this readme (include screensots of workflow), spam the socials

## FIXME
* mt-inside/generate-changelog silently returns empty string when there's no PRs in range - have it emit "no changes", or better non-PR commits
