# ermeo_widgetbook

Web-only Widgetbook catalog for `ermeo_ui` components.

## Run

From the repository root (after `fvm install` and `fvm dart pub get`):

```bash
melos run run:widgetbook
```

Or from this app directory:

```bash
cd apps/ermeo_widgetbook
fvm flutter run -d chrome
```

## Code generation

Regenerate `main.directories.g.dart` after adding or changing `@UseCase` annotations:

```bash
melos run generate:widgetbook
```

## Dependencies

- `ermeo_ui` — shared UI components and theme tokens
