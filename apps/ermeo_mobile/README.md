# ermeo_mobile

Ermeo Flutter mobile application — the only package that depends on `ermeo_api`.

## Run

From the repository root (after `fvm install` and `dart pub get`):

**Cursor / VS Code** — use a launch configuration from `ermeo/.vscode/launch.json`:

- **ermeo_mobile (dev)** — `APP_ENV=dev` and API URL from `config/dart_defines/dev.json`
- **ermeo_mobile (prod)** — `APP_ENV=prod` and API URL from `config/dart_defines/prod.json`
- **ermeo_mobile (localhost)** — dev env with API base `http://localhost:8000` (overrides the dev JSON URL)

**Melos** (from `ermeo/`):

```bash
melos run run:mobile:dev
melos run run:mobile:prod
melos run run:mobile:localhost
```

**CLI** (defaults to `APP_ENV=dev` and `http://localhost:8000` when no defines are passed):

```bash
cd apps/ermeo_mobile
fvm flutter run
```

Or from the repo root:

```bash
fvm flutter run -C apps/ermeo_mobile
```

Environment keys live in `lib/core/config/app_config.dart`. Replace the TODO URLs in `config/dart_defines/dev.json` and `prod.json` when hosted API endpoints are ready.

On a **physical device**, use your machine’s LAN IP instead of `localhost` for the API base URL.

## Dependencies

- `ermeo_api` — API client layer (app-only)
- `ermeo_ui` — shared UI components
- `ermeo_monitoring` — observability integrations
