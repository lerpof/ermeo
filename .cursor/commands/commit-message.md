commit-message
Commit message guidelines for the Ermeo monorepo.

Format: `<type>(<scope>): <short description>`

Scopes: `mobile`, `api`, `ui`, `monitoring`, `workspace`, `deps`

Examples:

```text
feat(mobile): add onboarding shell
fix(api): handle 401 refresh token
refactor(ui): extract primary button widget
chore(workspace): bump melos to 7.7.0
docs(readme): document FVM setup
```

Type meanings:

- **feat** — New feature
- **fix** — Bug fix
- **refactor** — Code change without behavior change
- **docs** — Documentation only
- **chore** — Tooling, dependencies, CI, or config
- **test** — Tests only

Language: English. No period at the end of the header. Max 72 characters in the header line.

Commit body (optional): explain why, not what.

If multiple unrelated changes are staged, ask whether to split into separate commits.
