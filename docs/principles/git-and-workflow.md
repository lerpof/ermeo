# Git and workflow principles

## Branches

We use **Gitflow** with two long-lived branches:

| Branch | Role |
|--------|------|
| **`develop`** | Default branch on GitHub — integration branch for day-to-day work; feature PRs land here |
| **`main`** | Production releases only — release and hotfix PRs land here |

**Default branch:** **`develop`** — what new clones checkout and what most PRs target.

Do not force-push to **`main`** or **`develop`** unless explicitly coordinated with the team.

### Branch types and naming

Short-lived branches use conventional prefixes. Branch from the parent shown in the table; open PRs against the **PR base** column.

| Branch prefix | Branch from | PR targets (`--base`) | Notes |
|---------------|-------------|------------------------|-------|
| `feat/`, `fix/`, `refactor/`, `docs/`, `chore/`, `test/` | `develop` | **`develop`** | Default day-to-day flow |
| `release/` | `develop` | **`main`** | Release stabilization; after merge, tag on `main` and back-merge to `develop` |
| `hotfix/` | `main` | **`main`** | Urgent production fix; after merge, back-merge to `develop` |

Examples: `feat/mobile-onboarding`, `fix/api-token-refresh`, `release/1.0.0`, `hotfix/critical-crash`.

### Starting feature work

```bash
git checkout develop
git pull origin develop
git checkout -b feat/<short-description>
```

For release or hotfix branches, branch from `develop` or `main` respectively (see table above).

### Merge flow

- **Feature branches** → merge into `develop`
- **Release branches** → merge into `main` (tag the release), then back-merge into `develop`
- **Hotfix branches** → merge into `main` (tag the patch), then back-merge into `develop`

### One-time Gitflow bootstrap

If `develop` does not exist yet or GitHub still uses `main` as the default branch, run once (requires repo admin access):

```bash
git checkout main
git pull origin main
git checkout -b develop
git push -u origin develop
gh repo edit --default-branch develop
```

Enable auto-delete of merged branches (see [Pull requests](#pull-requests) below):

```bash
gh api repos/{owner}/{repo} -X PATCH -f delete_branch_on_merge=true
```

After the remote default changes, refresh existing clones:

```bash
git fetch origin
git remote set-head origin -a   # origin/HEAD → origin/develop
git checkout develop
git pull origin develop
```

**Manual alternative (GitHub UI):** Settings → General → Default branch → switch to `develop`. Settings → General → Pull Requests → check **Automatically delete head branches**.

When ready, protect both `develop` and `main` (require PR, CI, no direct pushes).

## Commits

Follow conventional commits. Full reference: [`.cursor/commands/commit-message.md`](../../.cursor/commands/commit-message.md).

**Format:** `<type>(<scope>): <short description>`

**Scopes:** `mobile`, `api`, `ui`, `monitoring`, `workspace`, `deps`

**Types:** `feat`, `fix`, `refactor`, `docs`, `chore`, `test`

Examples:

```text
feat(mobile): add splash screen
fix(api): retry on network timeout
docs(principles): document dependency rules
chore(workspace): pin Flutter 3.44.0
```

Rules:

- Header in English, max **72 characters**, no trailing period.
- Body (optional): explain **why**, not what.
- One logical change per commit when possible. Split unrelated changes.

## Pull requests

- Keep PRs focused and reviewable.
- Description should state **what** changed and **why**.
- Include a short test plan (commands run, manual steps).
- Ensure CI / `melos run analyze` passes before requesting review.
- Use the [`.cursor/commands/create-pr.md`](../../.cursor/commands/create-pr.md) slash command (or follow its steps manually) when opening PRs with AI assistance.

### Automatically delete head branches

Enable once per repository so GitHub removes feature/release/hotfix branches after merge:

**GitHub UI:** Settings → General → Pull Requests → check **Automatically delete head branches**.

**CLI:**

```bash
gh api repos/{owner}/{repo} -X PATCH -f delete_branch_on_merge=true
```

Local branch copies are **not** removed automatically — run `git fetch --prune` periodically to clean up stale remote-tracking refs.

### PR base by branch type

| Branch type | `--base` |
|-------------|----------|
| `feat/`, `fix/`, `refactor/`, `docs/`, `chore/`, `test/` | `develop` |
| `release/`, `hotfix/` | `main` |

After `develop` is the GitHub default, `gh pr create` without `--base` targets `develop`; explicit `--base` is still recommended for clarity.

## Never commit

- Secrets, API keys, tokens, keystores (`.jks`), `key.properties`
- `.env` or local credential files
- `.fvm/` SDK cache (`.fvmrc` **is** committed)
- Build artifacts, `.dart_tool/`, IDE user settings
- Generated files that should stay local (see root `.gitignore`)

## Version control hygiene

- Commit `pubspec.lock` at the workspace root — it pins the resolved dependency graph.
- Do not commit unless asked when working with AI; humans and agents should confirm before creating commits.
