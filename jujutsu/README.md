# Testing [Jujutsu](https://jj-vcs.github.io/jj/latest/)

## Concepts

- git compatible
    - Use git and jj in the same repo `jj git init --colocate`
- every new file and change is automatically committed
- files that match .gitignore patterns are _not_ tracked
- bookmarks are named pointers - they map to git branches
