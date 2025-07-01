# Testing [Jujutsu](https://jj-vcs.github.io/jj/latest/)

## Concepts

- git compatible
    - Use git and jj in the same repo `jj git init --colocate`
- every new file and change is automatically committed
- files that match .gitignore patterns are _not_ tracked
- commits have stable revision id in addition to the commit hash
- bookmarks are named pointers that map to git branches
- bookmarks have to be updated manually = no accidental commits to main
- conficts are recorded in commits so that they can be resolved later
- descendants of amended revisions are automatically rebased

## Demo workflow

- Start new revision - `jj new -m <description>`
- Add more in-depth description - `jj describe`
- Drop all current changes - `jj abandon`
- Undo a command - `jj undo`
- Edit any previous commit message - `jj describe <rev>`
- Squash any changes - `jj squash`
- Split changes into separate commits - `jj split`
- Edit changes in any previous commit - `jj edit <rev>`
- Track the changes new branch - `jj bookmark create <name>`

- See log of previous operations - `jj op log`
- Restore to a previous state from the op log - `jj op restore <operation ID>`

## Resources

- [Official docs](https://jj-vcs.github.io/jj/latest/)
- [tutorial](https://steveklabnik.github.io/jujutsu-tutorial/introduction/introduction.html)
- [revset language](https://jj-vcs.github.io/jj/latest/revsets/)
- [Git command comparisons](https://jj-vcs.github.io/jj/latest/git-command-table/)
