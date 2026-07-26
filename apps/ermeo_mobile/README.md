# ermeo_mobile

Ermeo Flutter mobile application — the only package that depends on `ermeo_api`.

## Flavors and bundle IDs

| Flavor | Application / bundle ID | Home-screen name | Icon |
|--------|-------------------------|------------------|------|
| `prod` | `com.lerpof.ermeo` | Ermeo | Production logo |
| `dev` | `com.lerpof.ermeo.dev` | Ermeo Dev | Production logo + DEV banner |

Dev and prod can be installed side-by-side on the same device.

There is no native `staging` flavor yet. Staging uses the **dev** flavor with `lib/main_staging.dart`.

## Entry points

| Entry point | `AppEnvironment` | Native flavor | Dart defines file |
|-------------|------------------|---------------|-------------------|
| `lib/main_dev.dart` | `dev` | `dev` | `config/dart_defines/dev.json` |
| `lib/main_staging.dart` | `staging` | `dev` | `config/dart_defines/staging.json` |
| `lib/main_prod.dart` | `prod` | `prod` | `config/dart_defines/prod.json` |

Shared bootstrap lives in `lib/bootstrap.dart` (`runErmeoApp`). The root widget is `ErmeoMobileApp` in `lib/app.dart`.

Each entry point sets `AppEnvironment`. The API base URL comes only from `ERMEO_API_BASE_URL` in the dart-defines JSON (via `--dart-define-from-file`).

## Dart defines (local, gitignored)

Real `dev.json` / `staging.json` / `prod.json` are gitignored. Copy the template once per env:

```bash
cd apps/ermeo_mobile/config/dart_defines
cp example.json dev.json
cp example.json staging.json
cp example.json prod.json
```

Then set `ERMEO_API_BASE_URL` in each file. Only [`example.json`](config/dart_defines/example.json) is committed.

## Run

From the repository root (after `fvm install` and `dart pub get`):

**Cursor / VS Code** — use a launch configuration from `ermeo/.vscode/launch.json`:

- **ermeo_mobile (dev)** — `--flavor dev`, `lib/main_dev.dart`, `config/dart_defines/dev.json`
- **ermeo_mobile (staging)** — `--flavor dev`, `lib/main_staging.dart`, `config/dart_defines/staging.json`
- **ermeo_mobile (prod)** — `--flavor prod`, `lib/main_prod.dart`, `config/dart_defines/prod.json`

**Melos** (from `ermeo/`):

```bash
melos run run:mobile:dev
melos run run:mobile:staging
melos run run:mobile:prod
```

**CLI**:

```bash
cd apps/ermeo_mobile
fvm flutter run --flavor dev -t lib/main_dev.dart --dart-define-from-file=config/dart_defines/dev.json
fvm flutter run --flavor dev -t lib/main_staging.dart --dart-define-from-file=config/dart_defines/staging.json
fvm flutter run --flavor prod -t lib/main_prod.dart --dart-define-from-file=config/dart_defines/prod.json
```

## Firebase / Crashlytics

- Boot: `initializeErmeoFirebase(environment)` then `ErmeoMonitoring.initialize` + `runAppGuarded` in `lib/bootstrap.dart`.
- Options: `lib/core/firebase/firebase_options.dart` (prod vs non-prod; staging uses non-prod/dev options).
- Android: `android/app/src/{dev,prod}/google-services.json` + Google Services / Crashlytics Gradle plugins.
- iOS: `ios/Runner/Firebase/{dev,prod}/GoogleService-Info.plist` copied via Xcode build phase (`FIREBASE_ENV` in flavor xcconfigs).
- Both flavors currently target Firebase project **`ermeo-dev`** (prod package apps registered there). Point the prod flavor at **`ermeo-prod`** when that project’s mobile configs are available.

On a **physical device**, use your machine’s LAN IP instead of `localhost` for `ERMEO_API_BASE_URL` in `config/dart_defines/dev.json`.

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
