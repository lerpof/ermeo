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

## Verification before merge

Minimum bar for any change:

1. `fvm dart pub get` (if pubspecs changed)
2. `melos run analyze` — no new errors
3. Relevant tests pass, if present
