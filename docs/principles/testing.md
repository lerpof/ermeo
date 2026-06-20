# Testing principles

Testing and coverage policy for the Ermeo workspace.

## Coverage requirements

| Target | Requirement |
|--------|-------------|
| All workspace **packages** (`ermeo_api`, `ermeo_ui`, `ermeo_monitoring`, `ermeo_l10n`) | **100% line coverage** |
| App **BLoCs** | **100% coverage** |
| App **repositories** (in feature `data/`) | **100% coverage** |
| App **presentation** layer (`presentation/views`, `widgets`, `pages`) | **Excluded** from coverage thresholds |
| [`ermeo_ui`](../../packages/ermeo_ui) | Widget tests **and golden tests** required for shared UI components |

### Presentation vs shared UI

- **App presentation** (`apps/ermeo_mobile/lib/features/*/presentation/`) is not coverage-gated. Screens and feature widgets are exercised manually or via integration tests when added.
- **`ermeo_ui`** is fully tested — including goldens — because shared widgets must be stable and reusable across the app.

## Testing guidance

### BLoC tests (`ermeo_mobile`)

- Use `bloc_test` with mocked repositories.
- Cover all events, state transitions, error paths, and display formatting emitted in state.
- Mock repository interfaces; do not hit real API or local storage.

### Repository tests (`ermeo_mobile`)

- Mock `ermeo_api` clients and local data sources.
- Verify converter integration: API/DTO shapes map correctly to feature `models/`.
- Cover success, failure, and edge-case responses.

### Package tests

| Package | Approach |
|---------|----------|
| `ermeo_api` | Unit tests for pure Dart — clients, parsers, error mapping |
| `ermeo_ui` | Widget tests **and golden tests** for shared components |
| `ermeo_l10n` | Widget tests for `context.l10n` and delegate wiring |
| `ermeo_monitoring` | Unit/widget tests for wrappers and configuration |

### Running tests

```bash
melos run test
# or package-level:
cd apps/ermeo_mobile && fvm flutter test
cd packages/ermeo_api && fvm dart test
```

## Coverage enforcement

Coverage targets in this document define the **team standard**. Automated enforcement (Melos coverage scripts, CI gates) is future work — follow these targets in new and changed code now.

When adding or changing a BLoC, repository, or package API, add or update tests so the affected target remains at **100%** coverage.

## Related docs

- [Clean Architecture](clean-architecture.md) — where BLoCs and repositories live
- [Code quality](code-quality.md) — scope and quality bar for tests
- [AI guidelines](ai-guidelines.md) — definition of done for test coverage
