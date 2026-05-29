# Beneesse

Flutter monorepo for Beneesse mobile apps and shared packages. Managed with [Melos 7](https://melos.invertase.dev/) and Dart pub workspaces, pinned to Flutter **3.44.0** via [FVM](https://fvm.app/).

## Structure

```text
beneesse/
├── apps/
│   └── beneesse_mobile/       # Flutter app (only consumer of beneesse_api)
├── packages/
│   ├── beneesse_api/          # Pure Dart API layer
│   ├── beneesse_ui/           # Shared Flutter UI
│   └── beneesse_monitoring/   # Monitoring / observability
├── .cursor/commands/          # Cursor slash commands
├── pubspec.yaml               # Workspace root + Melos config
└── analysis_options.yaml
```

## Prerequisites

- [FVM](https://fvm.app/)
- [Melos](https://melos.invertase.dev/) (or use `dart run melos` via root dev_dependencies)
- Flutter **3.44.0** (via FVM in this repo)

## First-time setup

```bash
fvm install
fvm dart pub get
melos run analyze   # optional verification
```

## Run the mobile app

```bash
cd apps/beneesse_mobile
fvm flutter run
```

## Day-to-day commands

| Command | Description |
|---------|-------------|
| `melos list` | List all workspace packages |
| `melos run analyze` | Static analysis across the workspace |
| `melos run test` | Run tests in all packages |
| `melos run format` | Format all packages |
| `melos run clean` | Clean build artifacts |

See [`.cursor/commands/`](.cursor/commands/) for Cursor agent slash commands (`bootstrap`, `analyze`, `run-mobile`, etc.).

## Adding packages

1. Create a package under `packages/` or an app under `apps/`.
2. Add `publish_to: none` and `resolution: workspace` to its `pubspec.yaml`.
3. Register the path in the root `pubspec.yaml` `workspace:` list.
4. Run `fvm dart pub get` at the repository root.

## Dependency rules

- **`beneesse_api`** is consumed only by `beneesse_mobile`.
- **`beneesse_ui`** and **`beneesse_monitoring`** do not depend on `beneesse_api`.
