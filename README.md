# gh-actions-test

## Repo Setup

To use a copy of this repo in anger, you'll need some setup that can't be declared in git.

GitHub repo settings
* Make a Project Board of type _automated Kanban_

The actions in this repo (specifically lerna and pr-labels config) are based on the default set of GH labels, you may want to add more
* Issues -> Labels (top right-ish) -> New label

This repo contains two boring issue templates, you may wish to add more
* Settings -> Options -> Features -> Issues -> Set up templates

Install the provided hooks
```bash
cd .git/hooks
ln -s ../../hooks/*
```

To make it work like prow...
* Given `/CODEOWNERS` file
* Protect branch `main`
* Require review before merge
* Require review from code owner

To enforce the branching workflow I use, and that this repo was designed for, qv (ie not gitflow)
* Settings -> Options -> Merge Button ->
  * Only allow merge commits; disable the others
  * Automatically delete head branches

When you've actually written code, write a `/.github/dependabot.yml` for your langauges(s)


## Suggested Workflow

### Do work
* Pick an Issue from Issues
* Add to project board, drag to In Progress (unsure how to automate this?)
* `git checkout -b $type/foo`
* `git commit`
* `git push -u origin $type/foo`
* Raise PR (can't use `hub pull-request` becuase it's hardcoded to master and crashes if you've called it main)
* Merge PR, hit "delete branch" if it's not automatic
* `git fetch/pull -p # can't give -o option to hub sync`
* `git branch -d foo`

### See the work
```bash
git log --graph --abbrev-commit --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %C(bold blue)%an%Creset %Cgreen%cr%Creset' --
# show just this branch, not the branches off it. If this is master, this'll just show the merge commits.
git log --first-parent --abbrev-commit --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %C(bold blue)%an%Creset %Cgreen%cr%Creset' --
# kinda opposite of the above, show the "real" commits on this branch (if any), and from branches that feed into it, but not the merge commits.
git log --no-merges --abbrev-commit --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %C(bold blue)%an%Creset %Cgreen%cr%Creset' --
```

### Do a release
`git tag -a v1.2.3 -m "v1.2.3"`
`git push --follow-tags`
GH Actions go brrr, go to the releases page, edit the description, publish


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
* take config path (like label-prs does)
