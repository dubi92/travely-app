# Implementation Tasks

**Design References:**
- `travely-design/trips_list_1/code.html` - Profile settings
- `travely-design/trips_list_2/code.html` - Logout dialog
- `travely-design/permissions/code.html` - Permissions screen

## 1. Feature Structure
- [x] 1.1 Create `lib/features/profile/` directory structure
- [x] 1.2 Create `lib/features/profile/data/repositories/profile_repository.dart`
- [x] 1.3 Create `lib/features/profile/domain/models/profile_model.dart`

## 2. Profile Repository
- [x] 2.1 Implement `getProfile(userId)` - fetch from Supabase
- [x] 2.2 Implement `updateProfile(profile)` - update in Supabase
- [x] 2.3 Implement `uploadAvatar(file)` - upload to Supabase Storage
- [x] 2.4 Implement `deleteAvatar()` - remove from storage

## 3. Profile Screen
- [x] 3.1 Read `travely-design/trips_list_1/code.html` for layout
- [x] 3.2 Create `lib/features/profile/presentation/screens/profile_screen.dart`
- [x] 3.3 Display avatar with edit button
- [x] 3.4 Display personal info section (name, email, phone)
- [x] 3.5 Display preferences section (currency, trip alerts)
- [x] 3.6 Add Help & Support link
- [x] 3.7 Add Logout button

## 4. Edit Profile
- [x] 4.1 Create `lib/features/profile/presentation/screens/edit_profile_screen.dart` (Implemented then Refactored to Modal)
- [x] 4.2 Implement name editing (Modal)
- [x] 4.3 Implement phone editing (Modal)
- [x] 4.4 Implement avatar picker (camera/gallery)
- [x] 4.5 Save changes to Supabase

## 5. Preferences
- [x] 5.1 Create currency picker (USD, EUR, GBP, JPY, etc.)
- [x] 5.2 Implement trip alerts toggle
- [x] 5.3 Save preferences to profile

## 6. Logout
- [x] 6.1 Read `travely-design/trips_list_2/code.html` for dialog style
- [x] 6.2 Create logout confirmation dialog
- [x] 6.3 Implement logout action (clear session, navigate to login)

## 7. Permissions Screen
- [x] 7.1 Read `travely-design/permissions/code.html` for layout
- [x] 7.2 Create `lib/features/profile/presentation/screens/permissions_screen.dart`
- [x] 7.3 Add Trip Reminders toggle (notifications permission)
- [x] 7.4 Add Local Recommendations toggle (location permission)
- [x] 7.5 Add "I'll do this later" option

## 8. State Management
- [x] 8.1 Create `lib/features/profile/presentation/providers/profile_provider.dart`
- [x] 8.2 Implement profile state (loading, data, error)
- [x] 8.3 Handle avatar upload state

## 9. Navigation
- [x] 9.1 Add profile routes to router
- [x] 9.2 Navigate to profile from home screen avatar tap

## 10. Verification
- [x] 10.1 Run `flutter analyze` - no errors
- [x] 10.2 Test view profile - displays correct data
- [x] 10.3 Test edit profile - updates in Supabase
- [x] 10.4 Test avatar upload - image stored and displayed
- [x] 10.5 Test logout - clears session, shows login
- [x] 10.6 Run `openspec validate 006-add-user-profile --strict`
