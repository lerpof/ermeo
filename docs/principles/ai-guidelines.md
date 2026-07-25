# AI guidelines

Instructions for Cursor and other AI assistants working in the Ermeo repository.

## Before you change anything

1. Read [`docs/index.md`](../index.md) and the relevant principle documents.
2. Identify which **app or package** owns the work — do not put code in the wrong layer.
3. Confirm **dependency rules** in [architecture.md](architecture.md), especially for `ermeo_api`.
4. Inspect existing code in the target folder and **match its style**.
5. For app feature work, read [clean-architecture.md](clean-architecture.md) and identify the correct layer before writing code.
6. For user-visible copy or ARB keys, read [localization.md](../guides/localization.md) and apply the `add-l10n-string` skill in [`.cursor/skills/add-l10n-string/`](../../.cursor/skills/add-l10n-string/).
7. For new screens, navigation, or deeplinks, read [routing.md](../guides/routing.md) before adding `@RoutePage` or router entries.
8. For API, auth, or BFF work, read [backend.md](../guides/backend.md) — do not introduce a Flutter Firebase Auth SDK or a second HTTP stack.

## Clean Architecture checklist

Before implementing app feature code, confirm:

- [ ] Feature folder exists or will be created under `apps/ermeo_mobile/lib/features/<feature_name>/`
- [ ] BLoC, events, and states go in `bloc/`
- [ ] Repositories and converters go in `data/`
- [ ] Feature domain models go in `models/`
- [ ] Pages, views, and widgets go in `presentation/{pages,views,widgets}/`
- [ ] Cross-feature wiring (router, DI) stays in `core/`
- [ ] New pages use `@RoutePage()` and are registered in `AppRouter` — see [routing.md](../guides/routing.md)
- [ ] No `use_cases` layer — BLoC calls repositories directly
- [ ] Presentation will not import repositories or contain formatting logic

## How to implement

### Scope and safety

- Implement only what was requested. Do not expand scope with drive-by refactors.
- Do not commit, push, or open PRs unless the user explicitly asks.
- Do not modify git config, force-push, or skip hooks unless explicitly requested.
- Never add secrets or commit ignored files.

### Monorepo awareness

- Register new packages in the root `workspace:` list.
- Use `fvm dart` / `fvm flutter`, not bare system SDK commands.
- When editing `pubspec.yaml`, run `fvm dart pub get` at the root afterward.

### Package boundaries (critical)

| If the task involves… | Work in… | Must not… |
|----------------------|----------|-----------|
| API calls, DTOs | `ermeo_api` | Add Flutter imports |
| Shared widgets / theme | `ermeo_ui` | Import `ermeo_api` |
| User-visible strings (ARB) | `ermeo_l10n` | Import `ermeo_api`; use l10n in BLoC |
| Logging / crash / analytics | `ermeo_monitoring` | Import `ermeo_api` |
| User-visible strings (ARB) | `ermeo_l10n` | Import `ermeo_api`; use l10n from BLoC |
| App flow, screens, wiring | `ermeo_mobile` | Move app-specific logic into packages prematurely |

### Quality bar

- Fix analyzer issues you introduce.
- Prefer editing existing files over creating new ones unless structure demands it.
- Update README or docs when behavior, setup, or architecture rules change.
- Run `melos run analyze` (or equivalent) before reporting work complete.

## How to communicate

- Be concise; explain **what** changed and **why** when summarizing.
- Use code citations when referencing existing code (`startLine:endLine:path`); the `path` must be an **absolute filesystem path** from the workspace root (e.g. `/Users/lerpof/Development/Projects/Ermeo/ermeo/apps/ermeo_mobile/lib/main.dart`), not repo-relative (`apps/ermeo_mobile/...`).
- When referencing files in summaries, tool calls, or shell commands, use the same **absolute path** rule — discover the workspace root from session context when it differs.
- In **`ermeo_mobile`**, use **`package:ermeo_mobile/...`** for all `lib/` imports — never relative paths (`../`, `../../`, or bare `core/...`).
- Ask clarifying questions when requirements conflict with architecture principles.
- If multiple unrelated changes are needed, propose splitting commits or PRs.

## Cursor-specific

- Slash commands in [`.cursor/commands/`](../../.cursor/commands/) define repo workflows — use them when appropriate.
- Project rules in [`.cursor/rules/`](../../.cursor/rules/) reinforce these principles in every session.
- When adding new team-wide conventions, update **both** `docs/principles/` and `.cursor/rules/` if agents must follow them automatically.

## Definition of done (AI)

A task is complete when:

- [ ] Code lives in the correct app/package per architecture rules
- [ ] Dependency rules are respected
- [ ] No logic or repository usage in presentation — formatting lives in BLoC
- [ ] BLoC tests and repository tests added or updated when BLoC or repo code changes
- [ ] Package changes meet **100% coverage** target for that package — see [testing.md](testing.md)
- [ ] `ermeo_ui` changes include widget and golden tests when applicable
- [ ] `fvm dart pub get` succeeds if manifests changed
- [ ] `melos run analyze` passes (no new errors)
- [ ] Relevant README/docs updated if needed
- [ ] User has a clear summary and next steps (e.g. run on device, open PR)
