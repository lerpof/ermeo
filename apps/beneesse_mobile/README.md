# beneesse_mobile

Beneesse Flutter mobile application — the only package that depends on `beneesse_api`.

## Run

From the repository root (after `fvm install` and `dart pub get`):

```bash
cd apps/beneesse_mobile
fvm flutter run
```

Or from the repo root:

```bash
fvm flutter run -C apps/beneesse_mobile
```

## Dependencies

- `beneesse_api` — API client layer (app-only)
- `beneesse_ui` — shared UI components
- `beneesse_monitoring` — observability integrations
