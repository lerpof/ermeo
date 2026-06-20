# Routing guide

Canonical rules for navigation and deeplinks in `ermeo_mobile` using [auto_route](https://pub.dev/packages/auto_route).

## Where routing lives

| Location | Role |
|----------|------|
| [`apps/ermeo_mobile/lib/core/router/app_router.dart`](../../apps/ermeo_mobile/lib/core/router/app_router.dart) | `@AutoRouterConfig`, route tree, guards, path overrides |
| [`apps/ermeo_mobile/lib/core/router/app_router.gr.dart`](../../apps/ermeo_mobile/lib/core/router/app_router.gr.dart) | Generated — never hand-edit |
| [`apps/ermeo_mobile/lib/core/router/guards/`](../../apps/ermeo_mobile/lib/core/router/guards/) | `AutoRouteGuard` implementations (e.g. auth) |
| `features/<feature>/presentation/pages/` | Routable screens — **every page** gets `@RoutePage()` |

Cross-feature wiring stays in `core/` per [clean-architecture.md](../principles/clean-architecture.md).

## Page conventions (required)

- Annotate **every** routable screen with `@RoutePage()`.
- File/class naming: `*_page.dart` / `*Page` under `presentation/pages/`.
- Router config uses `@AutoRouterConfig(replaceInRouteName: 'Page,Route')` so `LoginPage` → `LoginRoute`.
- Pages remain **dumb**: render BLoC state, dispatch events — no repository or API imports.

```dart
@RoutePage()
class ExerciseDetailPage extends StatelessWidget {
  const ExerciseDetailPage({@PathParam('id') required this.exerciseId, super.key});

  final String exerciseId;
  // BLoC loads the Exercise model from the repository using exerciseId
}
```

## Route arguments policy (required)

Only **scalar** arguments are allowed in page constructors. BLoC loads full models after navigation.

| Allowed | Not allowed |
|---------|-------------|
| `String`, `int`, `bool` IDs via `@PathParam` / `@QueryParam` | Domain models (`Exercise`, `User`, …) |
| Optional query flags (`@QueryParam('preview') bool preview = false`) | Callbacks (`onResult`, `VoidCallback`) |
| | `List<T>`, `Map`, custom objects |
| | `BuildContext`, `Widget`, services |

**Rationale:** complex constructor args break deeplinks and codegen serialization. Pass an ID in the route; dispatch a BLoC load event with that ID on first build.

## App router conventions

```dart
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({required SessionService sessionService})
      : _sessionService = sessionService;

  final SessionService _sessionService;

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  late final List<AutoRouteGuard> guards = [AuthGuard(_sessionService)];

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(path: '/exercises/:id', page: ExerciseDetailRoute.page),
    // register every @RoutePage here or as nested children
  ];
}
```

Key rules:

- **Register every `@RoutePage`** in `routes` (or nested `children`) — unregistered pages are unreachable.
- **Paths for deeplinks:** omit `path` to let auto_route generate kebab-case from the page name (e.g. `ExerciseDetailPage` → `/exercise-detail-page`), or set an explicit short `path` on the `AutoRoute` entry when a stable URL slug is needed. Paths are defined **only in the router**, never on the page widget.
- **Prefer explicit paths** for public deeplinks (e.g. `path: '/exercises/:id'`) so URLs stay stable when page classes are renamed.
- **Initial route + redirects:** use `initial: true` or `RedirectRoute` in the router config — not hard-coded navigation in `main()`.
- **Guards:** auth/session checks in `AutoRouteGuard` classes under `core/router/guards/`; use `resolver.redirectUntil(LoginRoute(...))` per [auto_route guards](https://pub.dev/packages/auto_route#route-guards). Global guards on `AppRouter.guards`; per-route guards on individual `AutoRoute` entries when needed.
- **`reevaluateListenable`:** `main.dart` passes `sessionService.listenable` to `appRouter.config(...)` so login/logout re-evaluates guards and the stack.

## In-app navigation (required)

Navigate with **generated typed routes**, not string paths:

```dart
context.router.push(ExerciseDetailRoute(exerciseId: id));
context.router.replace(const LoginRoute());
context.router.pop();
```

- Prefer `context.router` or `context.pushRoute(...)` from auto_route.
- **Do not** use `pushPath('/...')` or `navigatePath` in feature or presentation code — keeps navigation type-safe and refactor-friendly. Platform deeplinks still resolve paths via the router config.
- **BLoC-triggered navigation:** BLoC emits a navigation intent in state; a `BlocListener` in the page or view calls the router. BLoC must not import `BuildContext`, `auto_route`, or call the router directly.

```mermaid
flowchart LR
  UserAction[User action] --> Bloc[Bloc event]
  Bloc --> State[State with nav intent]
  State --> Listener[BlocListener in page]
  Listener --> Router["context.router.push(XxxRoute)"]
  Router --> Page["@RoutePage screen"]
  Page --> BlocLoad[Bloc loads data by route ID]
```

## Deeplinks — every page reachable

auto_route handles platform deeplinks when routes are registered with resolvable paths. See [auto_route deep linking](https://pub.dev/packages/auto_route#deep-linking) and [Flutter deep linking](https://docs.flutter.dev/ui/navigation/deep-linking).

1. **Router coverage:** every `@RoutePage` must appear in `AppRouter.routes` with a resolvable path (auto-generated or explicit).
2. **Scalar params in URLs:** path segments (`/exercises/:id`) or query params (`?preview=true`) — match page `@PathParam` / `@QueryParam` annotations.
3. **Prefix stack building:** for nested routes, declare parent routes before parameterized children so prefix matches work when `includePrefixMatches` applies.
4. **Platform setup** (when enabling deeplinks):
   - Android: intent-filter on `MainActivity` in [`AndroidManifest.xml`](../../apps/ermeo_mobile/android/app/src/main/AndroidManifest.xml)
   - iOS: `CFBundleURLTypes` or Associated Domains in [`Info.plist`](../../apps/ermeo_mobile/ios/Runner/Info.plist)
5. **Optional interceptors:** `deepLinkTransformer` / `deepLinkBuilder` on `appRouter.config(...)` in `main.dart` — e.g. strip an app prefix or reject unknown paths to a fallback route.
6. **Local testing:** once platform config exists, use `adb` or simulator URL schemes. Until then, `router.pushPath('/exercises/42')` is acceptable in **tests and dev tools only**, not in production UI code.

Example deeplink paths (exact values depend on `path` overrides — check `app_router.gr.dart` or the `AutoRoute` entries):

| Screen | Example deeplink path |
|--------|----------------------|
| Login | `/login` |
| Exercise detail | `/exercises/42` |
| Exercise detail (query flag) | `/exercises/42?preview=true` |

## Nested and tab navigation

For bottom navigation or multi-pane layouts, use auto_route shell routes:

- Declare tab or nested routes as `children` of a parent `@RoutePage` in `AppRouter`.
- The shell page renders `AutoRouter()` (or extends `AutoRouter`) as the nested outlet.
- Use `AutoTabsRouter` / `AutoTabsScaffold` for tab bars — see [auto_route tab navigation](https://pub.dev/packages/auto_route#tab-navigation).

Do not use raw `Navigator` for feature-level flows that belong in the route tree.

## Adding a new screen

1. Create `features/<feature>/presentation/pages/<name>_page.dart` with `@RoutePage()`.
2. Use scalar `@PathParam` / `@QueryParam` only when the screen needs an ID or flag.
3. Register `AutoRoute(page: XxxRoute.page)` (with optional `path`) in `app_router.dart`.
4. Run `melos run generate:routes` and commit `app_router.gr.dart`.
5. Navigate in-app via `XxxRoute(...)` — never ad-hoc `MaterialPageRoute`.

## Clean Architecture alignment

- **Pages / views:** call router; pass route scalar IDs into BLoC events (e.g. `ExerciseDetailLoadRequested(exerciseId)`).
- **BLoC:** owns load logic; may emit navigation **intent** in state — does not call router or use `BuildContext`.
- **`core/router`:** route tree and guards only — no feature business logic.

## App wiring

`ermeo_mobile` bootstraps the router in `main.dart`:

```dart
final appRouter = AppRouter(sessionService: sessionService);

MaterialApp.router(
  routerConfig: appRouter.config(
    reevaluateListenable: sessionService.listenable,
  ),
);
```

## Regeneration

After any `@RoutePage` or `AppRouter` change, from the repository root:

```bash
melos run generate:routes
```

Commit `app_router.gr.dart` with the router or page change. Use **FVM** (`fvm flutter`, `fvm dart`) per [tooling.md](../principles/tooling.md).

## Related docs

- [Clean architecture](../principles/clean-architecture.md) — feature layout and layer rules
- [Architecture](../principles/architecture.md) — where router code belongs
- [Tooling](../principles/tooling.md) — Melos commands including `generate:routes`
- [Testing](../principles/testing.md) — presentation excluded from coverage; router guards testable in `core/`
- [AI guidelines](../principles/ai-guidelines.md) — agent workflow for new screens and navigation
