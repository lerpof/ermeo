# ermeo_mobile

Ermeo Flutter mobile application — the only package that depends on `ermeo_api`.

## Flavors and bundle IDs

| Flavor | Application / bundle ID | Home-screen name | Icon |
|--------|-------------------------|------------------|------|
| `prod` | `com.lerpof.ermeo` | Ermeo | Production logo |
| `dev` | `com.lerpof.ermeo.dev` | Ermeo Dev | Production logo + DEV banner |

Dev and prod can be installed side-by-side on the same device.

## Run

From the repository root (after `fvm install` and `dart pub get`):

**Cursor / VS Code** — use a launch configuration from `ermeo/.vscode/launch.json`:

- **ermeo_mobile (dev)** — `--flavor dev`, `APP_ENV=dev`, API URL from `config/dart_defines/dev.json`
- **ermeo_mobile (prod)** — `--flavor prod`, `APP_ENV=prod`, API URL from `config/dart_defines/prod.json`
- **ermeo_mobile (localhost)** — dev flavor with API base `http://localhost:8000`

**Melos** (from `ermeo/`):

```bash
melos run run:mobile:dev
melos run run:mobile:prod
melos run run:mobile:localhost
```

**CLI**:

```bash
cd apps/ermeo_mobile
fvm flutter run --flavor dev --dart-define-from-file=config/dart_defines/dev.json
fvm flutter run --flavor prod --dart-define-from-file=config/dart_defines/prod.json
```

Environment keys live in `lib/core/config/app_config.dart`. Replace the TODO URLs in `config/dart_defines/dev.json` and `prod.json` when hosted API endpoints are ready.

On a **physical device**, use your machine’s LAN IP instead of `localhost` for the API base URL.

## App icons

Source icons live in `assets/icon/`:

- `app_icon.png` — production
- `app_icon_dev.png` — dev (with DEV banner)

Regenerate platform launcher icons after changing source assets:

```bash
melos run generate:icons
```

## Dependencies

- `ermeo_api` — API client layer (app-only)
- `ermeo_ui` — shared UI components
- `ermeo_monitoring` — observability integrations
