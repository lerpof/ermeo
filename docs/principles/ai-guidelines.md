# AI guidelines

Instructions for Cursor and other AI assistants working in the Beneesse repository.

## Before you change anything

1. Read [`docs/index.md`](../index.md) and the relevant principle documents.
2. Identify which **app or package** owns the work — do not put code in the wrong layer.
3. Confirm **dependency rules** in [architecture.md](architecture.md), especially for `beneesse_api`.
4. Inspect existing code in the target folder and **match its style**.
5. For app feature work, read [clean-architecture.md](clean-architecture.md) and identify the correct layer before writing code.

## Clean Architecture checklist

Before implementing app feature code, confirm:

- [ ] Feature folder exists or will be created under `apps/beneesse_mobile/lib/features/<feature_name>/`
- [ ] BLoC, events, and states go in `bloc/`
- [ ] Repositories and converters go in `data/`
- [ ] Feature domain models go in `models/`
- [ ] Pages, views, and widgets go in `presentation/{pages,views,widgets}/`
- [ ] Cross-feature wiring (router, DI) stays in `core/`
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
| API calls, DTOs | `beneesse_api` | Add Flutter imports |
| Shared widgets / theme | `beneesse_ui` | Import `beneesse_api` |
| Logging / crash / analytics | `beneesse_monitoring` | Import `beneesse_api` |
| App flow, screens, wiring | `beneesse_mobile` | Move app-specific logic into packages prematurely |

### Quality bar

- Fix analyzer issues you introduce.
- Prefer editing existing files over creating new ones unless structure demands it.
- Update README or docs when behavior, setup, or architecture rules change.
- Run `melos run analyze` (or equivalent) before reporting work complete.

## How to communicate

- Be concise; explain **what** changed and **why** when summarizing.
- Use code citations when referencing existing code (`startLine:endLine:path`).
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
- [ ] `beneesse_ui` changes include widget and golden tests when applicable
- [ ] `fvm dart pub get` succeeds if manifests changed
- [ ] `melos run analyze` passes (no new errors)
- [ ] Relevant README/docs updated if needed
- [ ] User has a clear summary and next steps (e.g. run on device, open PR)
