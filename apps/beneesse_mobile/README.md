# beneesse_mobile

Beneesse Flutter mobile application — the only package that depends on `beneesse_api`.

## Run

From the repository root (after `fvm install` and `dart pub get`):

**Cursor / VS Code** — use a launch configuration from `beneesse/.vscode/launch.json`:

- **beneesse_mobile (dev)** — `APP_ENV=dev` and API URL from `config/dart_defines/dev.json`
- **beneesse_mobile (prod)** — `APP_ENV=prod` and API URL from `config/dart_defines/prod.json`
- **beneesse_mobile (localhost)** — dev env with API base `http://localhost:8000` (overrides the dev JSON URL)

**Melos** (from `beneesse/`):

```bash
melos run run:mobile:dev
melos run run:mobile:prod
melos run run:mobile:localhost
```

**CLI** (defaults to `APP_ENV=dev` and `http://localhost:8000` when no defines are passed):

```bash
cd apps/beneesse_mobile
fvm flutter run
```

Or from the repo root:

```bash
fvm flutter run -C apps/beneesse_mobile
```

Environment keys live in `lib/core/config/app_config.dart`. Replace the TODO URLs in `config/dart_defines/dev.json` and `prod.json` when hosted API endpoints are ready.

On a **physical device**, use your machine’s LAN IP instead of `localhost` for the API base URL.

## Dependencies

- `beneesse_api` — API client layer (app-only)
- `beneesse_ui` — shared UI components
- `beneesse_monitoring` — observability integrations
