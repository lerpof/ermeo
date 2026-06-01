# Tooling principles

## Flutter version (FVM)

This repository pins **Flutter 3.44.0** via FVM.

Always use FVM-wrapped commands from the repo:

```bash
fvm flutter ...
fvm dart ...
```

Do **not** use the system `dart` or `flutter` if their SDK version differs from the workspace requirement (`^3.12.0`).

First-time setup:

```bash
fvm install
fvm dart pub get
```

## Melos workspace

Configuration lives in the root [`pubspec.yaml`](../../pubspec.yaml) under `workspace:` and `melos:`.

Common commands (from repository root):

| Command | Purpose |
|---------|---------|
| `fvm dart pub get` | Resolve all workspace packages |
| `melos list` | List packages |
| `melos run analyze` | Static analysis across workspace |
| `melos run test` | Run tests in all packages |
| `melos run format` | Format all packages |
| `melos run clean` | Clean build artifacts |
| `melos run generate:api` | Fetch OpenAPI from running BFF (`GET /openapi.yaml`), then regenerate `beneesse_api` |

Cursor slash commands in [`.cursor/commands/`](../../.cursor/commands/) wrap these workflows for agents.

## Adding dependencies

1. Add the dependency to the **specific package** `pubspec.yaml` that needs it — not the root, unless it is a workspace dev tool (e.g. `melos`).
2. Run `fvm dart pub get` at the repository root.
3. Prefer workspace-local path dependencies for internal packages (automatic via pub workspaces).
4. Avoid duplicate conflicting versions across packages; resolve at the workspace level when possible.

## Running the mobile app

```bash
cd apps/beneesse_mobile
fvm flutter run
```

## OpenAPI client generation (`beneesse_api`)

The mobile API package uses [`openapi_generator`](https://pub.dev/packages/openapi_generator). The canonical spec lives in `backend/openapi/openapi.yaml` and is fetched from the running API during `melos run generate:api`.

**Prerequisite:** Java 8 or newer (`java -version`). The generator wraps the OpenAPI Generator CLI.

Regenerate after contract changes (API must be running on `http://localhost:8000`, or the script falls back to `backend/openapi/openapi.yaml`):

```bash
cd beneesse
fvm dart pub get
melos run generate:api
```

Commit both the spec change and regenerated files under `packages/beneesse_api/lib/generated/`. Mobile-only developers can use the committed client without Java until the contract changes.

## Verification before merge

Minimum bar for any change:

1. `fvm dart pub get` (if pubspecs changed)
2. `melos run analyze` — no new errors
3. Relevant tests pass, if present
