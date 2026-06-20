# Ermeo documentation

Project principles and conventions for humans and AI assistants working in this repository.

## Guides

| Document | What it covers |
|----------|----------------|
| [Localization](guides/localization.md) | ARB key format, adding strings, `context.l10n`, regeneration |

## Principles

| Document | What it covers |
|----------|----------------|
| [Architecture](principles/architecture.md) | Monorepo layout, package boundaries, dependency rules |
| [Clean architecture](principles/clean-architecture.md) | Feature/core layout, BLoC rules, layer flow, anti-patterns |
| [Testing](principles/testing.md) | Coverage targets, BLoC/repo/package tests, golden tests for `ermeo_ui` |
| [Code quality](principles/code-quality.md) | Dart/Flutter standards, scope, testing, documentation |
| [Git and workflow](principles/git-and-workflow.md) | Gitflow (`develop` + `main`), commits, PRs, what not to commit |
| [Tooling](principles/tooling.md) | FVM, Melos, workspace commands, adding packages |
| [AI guidelines](principles/ai-guidelines.md) | How AI should plan, implement, and verify changes |

## Guides

| Document | What it covers |
|----------|----------------|
| [Localization](guides/localization.md) | ARB key format, placeholders, `context.l10n`, regeneration workflow |

## Who this is for

- **Developers** — reference before opening a PR or adding a package.
- **AI assistants (Cursor and others)** — read [AI guidelines](principles/ai-guidelines.md) and the linked principle docs **before** making changes. Treat these documents as binding constraints, not suggestions.

## Quick non-negotiables

1. Use **FVM** (`fvm flutter`, `fvm dart`) — never rely on a mismatched system Dart/Flutter SDK.
2. Respect **package boundaries** — `ermeo_api` is consumed only by `ermeo_mobile`.
3. **BLoC owns all logic and formatting** — presentation never imports repositories or calls APIs.
4. **Clean Architecture layout** — feature folders: `bloc/`, `presentation/`, `data/`, `models/`; shared app code in `core/`.
5. **Coverage** — 100% on workspace packages, app BLoCs, and repositories; app presentation excluded; `ermeo_ui` requires widget + golden tests.
6. Keep changes **minimal and focused** — match existing conventions in the target package.
7. Run **`melos run analyze`** (or package-level analyze) before considering work done.
8. Do **not** commit secrets, `.env` files, or local SDK caches.

See the principle docs for full detail.
