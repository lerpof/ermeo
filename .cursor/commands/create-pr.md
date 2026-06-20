create-pr
Create a pull request for the current branch using Ermeo Gitflow conventions.

Only run when the user explicitly invokes this command. Use `gh` for all GitHub operations.

## Pre-flight

1. Run `melos run analyze` — fix failures before opening the PR.
2. Confirm the working tree is clean, or that only intended changes will be included in the PR.
3. Identify the current branch and its type (prefix). Determine the correct PR **base** from the table below.

## Branch → PR base

| Branch prefix | Branch from | PR targets (`--base`) | Notes |
|---------------|-------------|------------------------|-------|
| `feat/`, `fix/`, `refactor/`, `docs/`, `chore/`, `test/` | `develop` | **`develop`** | Default day-to-day flow |
| `release/` | `develop` | **`main`** | After merge: tag on `main`, back-merge to `develop` |
| `hotfix/` | `main` | **`main`** | After merge: tag on `main`, back-merge to `develop` |

If the branch prefix does not match Gitflow conventions, ask the user which base to use.

## Starting work (reference)

Feature branches:

```bash
git checkout develop
git pull origin develop
git checkout -b feat/<short-description>
```

Release: branch from `develop` as `release/<version>`. Hotfix: branch from `main` as `hotfix/<short-description>`.

## Git inspection

Run in parallel before creating the PR:

- `git status` — untracked and modified files
- `git diff` — staged and unstaged changes
- `git log` — recent commit messages (match [commit-message.md](commit-message.md) style)
- `git diff <base>...HEAD` — full PR diff (`develop` for feature branches, `main` for release/hotfix)

Check whether the branch tracks a remote and is up to date with its base.

## Push

If the branch is not on the remote or is behind after rebasing:

```bash
git push -u origin HEAD
```

Do not push unless the user asked or this command implies it.

## Create PR

Draft title and body from **all** commits on the branch (not just the latest). Title format: `<type>(<scope>): <short description>` per [commit-message.md](commit-message.md).

Feature branch example (`--base develop`):

```bash
gh pr create --base develop --title "<type>(<scope>): <short description>" --body "$(cat <<'EOF'
## Summary
- ...

## Test plan
- [ ] `melos run analyze`
- [ ] ...

EOF
)"
```

Release or hotfix — use `--base main` and note back-merge steps in the body:

```text
## After merge
- [ ] Tag release on `main`
- [ ] Back-merge into `develop`
```

Return the PR URL when done.

## Agent constraints

- Do not commit unless the user explicitly asks.
- Never amend commits that failed pre-commit hooks — fix and create a new commit.
- Never force-push to `main` or `develop`.
- Never update git config.
- Read [docs/principles/git-and-workflow.md](../../docs/principles/git-and-workflow.md) for full Gitflow rules.
