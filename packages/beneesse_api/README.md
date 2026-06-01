# beneesse_api

Pure Dart HTTP layer for Beneesse: OpenAPI-generated Dio client plus a thin hand-written facade.

## Stack

- **Contract (canonical):** `backend/openapi/openapi.yaml` — edit on the backend only
- **Served by BFF:** `GET /openapi.yaml` on the running API
- **Codegen input:** `openapi/openapi.yaml` — fetched from the BFF during `melos run generate:api` (committed snapshot)
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

Requires Java 8+, and a running API (or fallback to `backend/openapi/openapi.yaml`).

From `beneesse/`:

```bash
# default: http://localhost:8000/openapi.yaml
melos run generate:api

# staging / remote BFF
BENEESE_OPENAPI_URL=https://api.example.com/openapi.yaml melos run generate:api
```

Manual fetch:

```bash
bash scripts/fetch-openapi-spec.sh packages/beneesse_api/openapi/openapi.yaml
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
