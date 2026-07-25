# Architecture principles

## Monorepo layout

```text
ermeo/
├── apps/           # Runnable Flutter applications
├── packages/       # Shared libraries consumed by apps
├── docs/           # Project principles and guides
├── pubspec.yaml    # Workspace root + Melos configuration
└── .fvmrc          # Pinned Flutter version (3.44.0)
```

- **Apps** live under `apps/`. They compose packages and own app-specific wiring (routing, DI, feature modules).
- **Packages** live under `packages/`. They expose reusable, testable units with a clear public API in `lib/`.
- The **workspace root** is not an app. Do not add application code at the repository root.

## Packages

| Package | Type | Role |
|---------|------|------|
| `ermeo_api` | Pure Dart | HTTP clients, DTOs, API contracts — no Flutter dependency |
| `ermeo_ui` | Flutter | Shared widgets, themes, design system |
| `ermeo_monitoring` | Flutter | Logging, crash reporting, analytics, observability |
| `ermeo_l10n` | Flutter | ARB strings, generated `ErLocalizations`, localization helpers |
| `ermeo_mobile` | Flutter app | End-user mobile application |

## Dependency rules

These rules are **fixed** unless explicitly changed in this document and agreed by the team.

```mermaid
flowchart TB
  Mobile[ermeo_mobile]
  API[ermeo_api]
  UI[ermeo_ui]
  Mon[ermeo_monitoring]
  L10n[ermeo_l10n]
  Mobile --> API
  Mobile --> UI
  Mobile --> Mon
  Mobile --> L10n
```

- **`ermeo_mobile`** may depend on workspace packages listed above.
- **`ermeo_api`** is consumed **only** by `ermeo_mobile`. UI and monitoring must not import it.
- **`ermeo_ui`**, **`ermeo_l10n`**, and **`ermeo_monitoring`** are standalone. They must not depend on `ermeo_api` or on each other unless a future ADR says otherwise.
- **Packages must not depend on apps.**

Rationale: the API layer stays in the app’s domain. UI and monitoring remain reusable without coupling to backend contracts.

## Backend / BFF

The HTTP API is a **sibling FastAPI BFF** (`../backend`), not part of this monorepo. Stack: **Firebase Auth** (email/password behind BFF routes) + **Cloud Firestore** + static exercise catalog. Mobile never embeds a Firebase Auth SDK for product auth — it uses `ermeo_api` Bearer tokens only.

See [backend.md](../guides/backend.md) for the full stack table, ID rules (`userId` = Firebase UID), and local/codegen workflow.

## Application architecture (Clean Architecture)

`ermeo_mobile` follows Clean Architecture with **flutter_bloc** and a **BLoC → Repository** flow (no use-case layer). See [clean-architecture.md](clean-architecture.md) for folder layout, layer rules, and anti-patterns.

## Where code belongs

| Concern | Location |
|---------|----------|
| API clients, DTOs | `packages/ermeo_api` |
| Feature repositories, converters | `apps/ermeo_mobile/lib/features/<feature>/data/` |
| Feature models | `apps/ermeo_mobile/lib/features/<feature>/models/` |
| BLoC + events/states | `apps/ermeo_mobile/lib/features/<feature>/bloc/` |
| Screens/widgets | `apps/ermeo_mobile/lib/features/<feature>/presentation/{pages,views,widgets}/` |
| Shared design system | `packages/ermeo_ui` |
| User-visible strings (ARB, `ErLocalizations`) | `packages/ermeo_l10n` |
| Crashlytics, Sentry, analytics wrappers | `packages/ermeo_monitoring` |
| Router, DI, app bootstrap, cross-feature utilities | `apps/ermeo_mobile/lib/core/` |

When unsure, prefer the **smallest package** that can own the code without violating dependency rules.

## Adding a new package or app

1. Create the directory under `apps/` or `packages/`.
2. Set `publish_to: none` and `resolution: workspace` in its `pubspec.yaml`.
3. Register the path in the root `pubspec.yaml` `workspace:` list.
4. Add a `README.md` describing purpose, public API, and allowed dependents.
5. Run `fvm dart pub get` at the repository root.

## Public API discipline

- Export only what consumers need from `lib/<package_name>.dart`.
- Keep implementation details in private files or `src/` if the package grows.
- Breaking changes to a package API require updating all dependents in the same change set.
