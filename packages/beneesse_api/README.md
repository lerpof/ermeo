# beneesse_api

Pure Dart HTTP layer for Beneesse: OpenAPI-generated Dio client plus a thin hand-written facade.

## Stack

- **Contract:** `../../../contracts/openapi.yaml` (WellEsse root)
- **Generated client:** `lib/generated/beneesse_api_client/` (Dio + models)
- **Facade:** `lib/src/` — `BeneesseApiClient`, `AuthInterceptor`, `ApiException`

## Public API

```dart
import 'package:beneesse_api/beneesse_api.dart';

final client = BeneesseApiClient(
  baseUrl: 'https://api.example.com',
  accessTokenReader: () => storedAccessToken,
  accessTokenWriter: (access, refresh) => saveTokens(access, refresh),
  refreshTokens: () async => refreshFromServer(),
);

final workouts = await client.run(
  () => client.workouts.listWorkouts().then((r) => r.data!),
);
```

Use `client.run(...)` to map `DioException` → `ApiException` for repositories.

## Regenerate client

Requires Java 8+. From `beneesse/`:

```bash
melos run generate:api
```

## Testing

```bash
cd packages/beneesse_api
fvm dart test
```

Hand-written code targets **100% coverage**; `lib/generated/**` is excluded via `dart_test.yaml` and `// coverage:ignore-file`.

## Dependency rules

- Consumed **only** by `apps/beneesse_mobile`.
- `beneesse_ui` and `beneesse_monitoring` must **not** depend on this package.
