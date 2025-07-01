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



## Resources

- [Official docs](https://jj-vcs.github.io/jj/latest/)
- [tutorial](https://steveklabnik.github.io/jujutsu-tutorial/introduction/introduction.html)
- [revset language](https://jj-vcs.github.io/jj/latest/revsets/)
- [Git command comparisons](https://jj-vcs.github.io/jj/latest/git-command-table/)
