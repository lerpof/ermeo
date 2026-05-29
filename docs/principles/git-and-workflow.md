# Git and workflow principles

## Branches

- Default branch: **`main`**
- Feature work: short-lived branches from `main`, e.g. `feat/mobile-onboarding`, `fix/api-token-refresh`
- Do not force-push to `main` unless explicitly coordinated with the team.

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

## Never commit

- Secrets, API keys, tokens, keystores (`.jks`), `key.properties`
- `.env` or local credential files
- `.fvm/` SDK cache (`.fvmrc` **is** committed)
- Build artifacts, `.dart_tool/`, IDE user settings
- Generated files that should stay local (see root `.gitignore`)

## Version control hygiene

- Commit `pubspec.lock` at the workspace root — it pins the resolved dependency graph.
- Do not commit unless asked when working with AI; humans and agents should confirm before creating commits.
