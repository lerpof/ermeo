# ermeo_api

Pure Dart HTTP layer for Ermeo: OpenAPI-generated Dio client plus a thin hand-written facade.

## Stack

- **BFF:** FastAPI + Firebase Auth + Cloud Firestore (sibling `../backend`) — see [docs/guides/backend.md](../../docs/guides/backend.md)
- **Contract (canonical):** `backend/openapi/openapi.yaml` — edit on the backend only
- **Served by BFF:** `GET /openapi.yaml` on the running API
- **Codegen input:** `openapi/openapi.yaml` — fetched from the BFF during `melos run generate:api` (committed snapshot)
- **Generated client:** `lib/generated/ermeo_api_client/` (Dio + models)
- **Facade:** `lib/src/` — `ErmeoApiClient`, `AuthInterceptor`, `ApiException`
- **Tokens:** Firebase ID token as `accessToken`, Firebase refresh token as `refreshToken`; session `userId` is a Firebase Auth UID (string, not UUID)

## Public API

```dart
import 'package:ermeo_api/ermeo_api.dart';

final client = ErmeoApiClient(
  baseUrl: 'https://api.example.com',
  sessionService: mySessionService,
);

final workouts = await client.run(
  () => client.workouts.listWorkouts().then((r) => r.data!),
);
```

Use `client.run(...)` to map `DioException` → `ApiException` for repositories.

## Regenerate client

Requires Java 8+, and a running API (or fallback to `backend/openapi/openapi.yaml`).

From `ermeo/`:

```bash
# default: http://localhost:8000/openapi.yaml
melos run generate:api

# staging / remote BFF
ERMEO_OPENAPI_URL=https://api.example.com/openapi.yaml melos run generate:api
```

Manual fetch:

```bash
bash scripts/fetch-openapi-spec.sh packages/ermeo_api/openapi/openapi.yaml
```

## Testing

```bash
cd packages/ermeo_api
fvm dart test
```

Hand-written code targets **100% coverage**; `lib/generated/**` is excluded via `dart_test.yaml` and `// coverage:ignore-file`.

## Dependency rules

- Consumed **only** by `apps/ermeo_mobile`.
- `ermeo_ui` and `ermeo_monitoring` must **not** depend on this package.
