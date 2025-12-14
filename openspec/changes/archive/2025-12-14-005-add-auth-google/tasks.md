# Implementation Tasks

**Supabase Setup:** Use Supabase Cloud free tier (https://supabase.com)

## 1. Database Schema
- [x] 1.1 Create `profiles` table in Supabase dashboard SQL editor
- [x] 1.2 Add fields: `id` (uuid, fk auth.users), `email`, `full_name`, `avatar_url`, `created_at`
- [x] 1.3 Enable Row Level Security (RLS) on profiles
- [x] 1.4 Create RLS policy: users can only access own profile

## 2. Google Cloud Setup
- [x] 2.1 Create project in Google Cloud Console
- [x] 2.2 Configure OAuth consent screen
- [x] 2.3 Create OAuth 2.0 credentials (Web + Android + iOS)
- [x] 2.4 Add credentials to Supabase Google provider
- [x] 2.5 Add `google_sign_in` package to pubspec.yaml

## 3. Feature Structure
- [x] 3.1 Create `lib/features/auth/` directory
- [x] 3.2 Create `lib/features/auth/data/auth_repository.dart`
- [x] 3.3 Create `lib/features/auth/presentation/providers/auth_provider.dart`

## 4. Auth Repository
- [x] 4.1 Implement `signInWithGoogle()` method
- [x] 4.2 Implement `signOut()` method
- [x] 4.3 Implement `getCurrentUser()` method
- [x] 4.4 Handle profile creation from Google data (name, email, avatar)

## 5. Welcome Screen
- [x] 5.1 Read `travely-design/welcome_/_value_proposition/code.html`
- [x] 5.2 Create `lib/features/auth/presentation/screens/welcome_screen.dart`
- [x] 5.3 Add hero image/illustration
- [x] 5.4 Add tagline: "Plan together. Spend smarter. Travel stress-free."
- [x] 5.5 Add "Continue with Google" button (primary style)
- [x] 5.6 Handle loading state during sign-in

## 6. Navigation
- [x] 6.1 Update router with auth routes
- [x] 6.2 `/welcome` - initial route if not authenticated
- [x] 6.3 Add auth guard (redirect to welcome if not authenticated)
- [x] 6.4 Redirect to home after successful sign-in

## 7. Verification
- [x] 7.1 Run `flutter analyze` - no errors
- [x] 7.2 Run app - welcome screen shows first
- [x] 7.3 Tap "Continue with Google" - Google picker appears
- [x] 7.4 Select account - profile created in Supabase
- [x] 7.5 User redirected to home screen
- [x] 7.6 Restart app - user still signed in
- [x] 7.7 Run `openspec validate 005-add-auth-google --strict`
