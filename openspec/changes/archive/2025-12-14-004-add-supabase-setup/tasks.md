# Implementation Tasks

**Supabase Setup:** Use Supabase Cloud free tier (https://supabase.com)

## 1. Create Supabase Project
- [x] 1.1 Go to https://supabase.com and sign up/login
- [x] 1.2 Click "New Project" → name it `travely-dev`
- [x] 1.3 Wait for project to be ready (~2 minutes)
- [x] 1.4 Go to Settings > API and copy:
  - Project URL (`https://xxxxx.supabase.co`)
  - `anon` public key (`eyJhbG...`)

## 2. Environment Configuration
- [x] 2.1 Create `.env` file in project root with credentials
- [x] 2.2 Verify `.env` is in `.gitignore`
- [x] 2.3 Update `.env.example` with placeholder values
- [x] 2.4 Update `lib/core/config/env.dart` to expose Supabase config

## 3. Supabase Service
- [x] 3.1 Create `lib/shared/services/supabase_service.dart`
- [x] 3.2 Implement singleton pattern for Supabase client
- [x] 3.3 Add initialization method with error handling
- [x] 3.4 Expose client getters (auth, database, storage)

## 4. Auth State Management
- [x] 4.1 Create `lib/shared/services/auth_state_service.dart`
- [x] 4.2 Setup auth state change listener
- [x] 4.3 Create auth state stream for UI consumption

## 5. Base Repository
- [x] 5.1 Create `lib/shared/services/base_repository.dart`
- [x] 5.2 Add generic CRUD methods (create, read, update, delete)
- [x] 5.3 Add pagination support
- [x] 5.4 Add error wrapping for database operations

## 6. Error Handling
- [x] 6.1 Create `lib/core/errors/supabase_exception.dart`
- [x] 6.2 Define exception types (AuthException, DatabaseException, StorageException)
- [x] 6.3 Create user-friendly error messages

## 7. Provider Setup
- [x] 7.1 Create `lib/shared/services/providers.dart`
- [x] 7.2 Add Riverpod provider for SupabaseService
- [x] 7.3 Add provider for auth state stream

## 8. Update Main
- [x] 8.1 Update `lib/main.dart` to initialize Supabase before runApp
- [x] 8.2 Add error handling for initialization failures

## 9. Verification
- [x] 9.1 Run `flutter pub get`
- [x] 9.2 Run `flutter analyze` - no errors
- [x] 9.3 Run `flutter run` - app launches, Supabase connects
- [x] 9.4 Check console logs show "Supabase initialized" (or similar)
- [x] 9.5 Run `openspec validate 004-add-supabase-setup --strict`
