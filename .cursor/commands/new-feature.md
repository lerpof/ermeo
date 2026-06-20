new-feature
Start a new feature using Ermeo project principles.

Before planning or implementing:

1. Read `docs/index.md` and `docs/principles/ai-guidelines.md`.
2. Read `docs/principles/clean-architecture.md` for feature folder layout, BLoC rules, and layer boundaries.
3. Read `docs/principles/testing.md` for coverage requirements (100% on BLoCs/repos/packages; goldens for `ermeo_ui`).

Scaffold the feature under `apps/ermeo_mobile/lib/features/<feature_name>/` with `bloc/`, `presentation/{pages,views,widgets}/`, `data/`, and `models/` as needed. Presentation must not import repositories — all logic and formatting lives in BLoC.
