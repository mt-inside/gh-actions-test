# gh-actions-test

## Scratch to generate noise
foo
one
two
three
just in case
four

## Repo Setup

For sanity
* Only allow merge commits; disable the others

To make it work like prow...
* Protect branch `main`
* Require review before merge
* Require review from code owner

## Workflow

git tag -a v1.2.3 -m "v1.2.3"
git push --follow-tags

git fetch/pull -p # sadly doesn't work with hub sync
git branch -d foo

git log --graph --abbrev-commit --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %C(bold blue)%an%Creset %Cgreen%cr%Creset' --
# show just this branch, not the branches off it. If this is master, this'll just show the merge commits.
git log --first-parent --abbrev-commit --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %C(bold blue)%an%Creset %Cgreen%cr%Creset' --
# kinda opposite of the above, show the "real" commits on this branch (if any), and from branches that feed into it, but not the merge commits. Ie show a
git log --no-merges --abbrev-commit --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %C(bold blue)%an%Creset %Cgreen%cr%Creset' --

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
