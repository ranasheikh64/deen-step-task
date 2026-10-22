# Project Rules & Design Guidelines

## 1. Zero Hardcoding Policy (Strict)
- **Colors**: Never use hardcoded `Color(0x...)` or raw color hex values in any widget or UI file. All colors must strictly reference `AppColors.*` defined in `lib/core/theme/app_colors.dart`.
- **Typography & Font**: Never hardcode `TextStyle(fontSize: ..., fontFamily: ...)` inside widgets. All text styles must use `AppTypography.*` from `lib/core/theme/app_typography.dart`.
- **Spacing & Padding**: Use `AppSpacing.*` (e.g. `AppSpacing.sm`, `AppSpacing.md`, `AppSpacing.lg`, `AppSpacing.xl`, `AppSpacing.xxl`) for `SizedBox`, `Padding`, and margins.
- **Border Radius**: Use `AppSpacing.radius*` or `AppSpacing.rounded*` (e.g. `AppSpacing.radiusLg` for 16px).
- **Strings**: Centralize system strings and asset references in `lib/core/constants/`.

## 2. Architecture & Modular Structure
- **Feature-First Clean Architecture**:
  - `core/`: Common tokens, theme, network client, DI, global reusable widgets, storage, and notifications.
  - `features/<feature_name>/`:
    - `data/`: models, datasources, repositories, defaults.
    - `domain/`: entities, repository interfaces.
    - `presentation/`: bloc/cubits, pages, feature-specific widgets.
- **State Management**: BLoC / Cubit across all features.
- **Routing**: `go_router` centralized in `lib/core/routing/app_router.dart`.
- **Network**: `DioClient` in `lib/core/network/dio_client.dart` with token interceptor and graceful default fallback data.

## 3. Code Quality & Standards
- **Linter**: Follow `very_good_analysis` guidelines.
- **Zero Warnings**: `flutter analyze` must report `No issues found!` before every commit and PR.
- **Formatting**: Always format with `dart format .`.
- **Documentation**: Provide `///` documentation for every public class, reusable widget, bloc, and repository method.
- **Performance**: Use `const` constructors wherever possible, dispose controllers in `dispose()`, and avoid unnecessary rebuilds.

## 4. Reusable Widgets
- Place all app-wide shared widgets inside `lib/core/widgets/`.
- Ensure widgets support all states:
  - Enabled
  - Disabled
  - Loading state with spinner
  - Error and Empty fallbacks
