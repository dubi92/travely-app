# Implementation Tasks

**Design References:**
- `travely-design/trips_list_1/code.html` - Profile settings
- `travely-design/trips_list_2/code.html` - Logout dialog
- `travely-design/permissions/code.html` - Permissions screen

## 1. Feature Structure
- [ ] 1.1 Create `lib/features/profile/` directory structure
- [ ] 1.2 Create `lib/features/profile/data/repositories/profile_repository.dart`
- [ ] 1.3 Create `lib/features/profile/domain/models/profile_model.dart`

## 2. Profile Repository
- [ ] 2.1 Implement `getProfile(userId)` - fetch from Supabase
- [ ] 2.2 Implement `updateProfile(profile)` - update in Supabase
- [ ] 2.3 Implement `uploadAvatar(file)` - upload to Supabase Storage
- [ ] 2.4 Implement `deleteAvatar()` - remove from storage

## 3. Profile Screen
- [ ] 3.1 Read `travely-design/trips_list_1/code.html` for layout
- [ ] 3.2 Create `lib/features/profile/presentation/screens/profile_screen.dart`
- [ ] 3.3 Display avatar with edit button
- [ ] 3.4 Display personal info section (name, email, phone)
- [ ] 3.5 Display preferences section (currency, trip alerts)
- [ ] 3.6 Add Help & Support link
- [ ] 3.7 Add Logout button

## 4. Edit Profile
- [ ] 4.1 Create `lib/features/profile/presentation/screens/edit_profile_screen.dart`
- [ ] 4.2 Implement name editing
- [ ] 4.3 Implement phone editing
- [ ] 4.4 Implement avatar picker (camera/gallery)
- [ ] 4.5 Save changes to Supabase

## 5. Preferences
- [ ] 5.1 Create currency picker (USD, EUR, GBP, JPY, etc.)
- [ ] 5.2 Implement trip alerts toggle
- [ ] 5.3 Save preferences to profile

## 6. Logout
- [ ] 6.1 Read `travely-design/trips_list_2/code.html` for dialog style
- [ ] 6.2 Create logout confirmation dialog
- [ ] 6.3 Implement logout action (clear session, navigate to login)

## 7. Permissions Screen
- [ ] 7.1 Read `travely-design/permissions/code.html` for layout
- [ ] 7.2 Create `lib/features/profile/presentation/screens/permissions_screen.dart`
- [ ] 7.3 Add Trip Reminders toggle (notifications permission)
- [ ] 7.4 Add Local Recommendations toggle (location permission)
- [ ] 7.5 Add "I'll do this later" option

## 8. State Management
- [ ] 8.1 Create `lib/features/profile/presentation/providers/profile_provider.dart`
- [ ] 8.2 Implement profile state (loading, data, error)
- [ ] 8.3 Handle avatar upload state

## 9. Navigation
- [ ] 9.1 Add profile routes to router
- [ ] 9.2 Navigate to profile from home screen avatar tap

## 10. Verification
- [ ] 10.1 Run `flutter analyze` - no errors
- [ ] 10.2 Test view profile - displays correct data
- [ ] 10.3 Test edit profile - updates in Supabase
- [ ] 10.4 Test avatar upload - image stored and displayed
- [ ] 10.5 Test logout - clears session, shows login
- [ ] 10.6 Run `openspec validate 006-add-user-profile --strict`
