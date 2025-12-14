# Change: Initialize Flutter Project Foundation

## Why
Before any feature development, we need a properly structured Flutter project with the correct package name, folder organization, dependencies, and configuration. This establishes the foundation that all subsequent proposals build upon.

## What Changes
- Initialize Flutter project with package name `com.travely.app`
- Create folder structure per project conventions
- Add core dependencies (supabase_flutter, go_router, riverpod, etc.)
- Configure linting rules (flutter_lints)
- Setup environment variable structure (.env)
- Create app entry point with proper initialization

## Impact
- Affected specs: `project-setup` (new)
- Affected code: Entire `lib/` structure (new)
- Dependencies: None (this is the first proposal)
- Blocks: All other proposals depend on this

## Deliverables
1. Flutter project with `com.travely.app` package name
2. Folder structure:
   ```
   lib/
   ├── core/
   │   ├── config/
   │   ├── theme/
   │   ├── utils/
   │   ├── constants/
   │   └── errors/
   ├── shared/
   │   ├── widgets/
   │   ├── models/
   │   └── services/
   ├── features/
   └── main.dart
   ```
3. `pubspec.yaml` with dependencies
4. `analysis_options.yaml` with lint rules
5. `.env.example` template
6. `lib/core/config/env.dart` for environment handling
