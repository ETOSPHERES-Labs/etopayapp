# AGENTS.md - Development Guide for AI Coding Agents (Flutter)

## Build/Test Commands

- `flutter run` — Start development server on a connected device or emulator
- `flutter run -d chrome --web-port=3000` — Start development web server on a chromium based browser for web development
- `flutter build apk` — Build Android APK (debug/release)
- `flutter build ios` — Build iOS app (requires macOS)
- `flutter test` — Run all unit and widget tests
- `flutter analyze` — Run static analysis and linter
- `flutter pub get` — Install dependencies

## Architecture & Structure

- **Flutter** with feature-based modular architecture
- Structure: `lib/[core|models|router|screens|services|view_models|views|widgets]/`
  - `core/` — shared styles, colors, themes, utilities
  - `models/` — data models and entities
  - `router/` — app routing and navigation
  - `screens/` — UI screens and pages
  - `services/` — platform bridges, SDK integrations, business logic
  - `view_models/` — state management and business logic for views
  - `views/` — UI components and widgets for specific features
  - `widgets/` — reusable UI widgets
- Place platform-specific or integration code (e.g., SDK bridges) in `services/`
- Use `test/` for all unit and widget tests

## Code Style & Conventions

- **Dart** with null safety and type annotations everywhere
- **Functional programming** patterns preferred (stateless functions, minimize side effects)
- **Named exports only** (no default exports)
- **snake_case** for files and directories, **camelCase** for variables/methods, **PascalCase** for classes
- Prefer `const` constructors and widgets where possible
- Use `typedef` for function types
- Avoid deprecated APIs; migrate to new ones as soon as feasible
- 120 char line limit, no trailing commas

## Import Organization (enforced by Dart analyzer)

```dart
// Dart & Flutter SDK imports
import 'dart:convert';
import 'package:flutter/material.dart';

// External packages (alphabetical)
import 'package:provider/provider.dart';
import 'package:riverpod/riverpod.dart';

// Internal modules
import 'package:eto_pay/core/colors.dart';
import 'package:eto_pay/models/user.dart';
import 'package:eto_pay/screens/onboarding_screen.dart';
```

## Key Patterns

- **Form validation** using `Form`, `TextFormField`, and custom validators
- **State management** with Provider, Riverpod, or Bloc (as appropriate)
- **Bridge pattern** for SDK/platform integration in `services/`
- **Error handling** with early returns, guard clauses, and user-friendly UI feedback
- **UI composition** with reusable widgets in `widgets/` and feature-specific components in `views/`
- **Testing**: Place all tests in `test/`, use `flutter test` for automation
- **Theming**: Use `ThemeData` and custom styles in `core/`

---

For more, see:

- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Style Guide](https://docs.flutter.dev/development/tools/analysis)
- [Provider](https://pub.dev/packages/provider)
- [Riverpod](https://riverpod.dev/)
- [Bloc](https://bloclibrary.dev/#/)
