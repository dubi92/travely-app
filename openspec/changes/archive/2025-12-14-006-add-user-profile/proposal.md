# Change: Add User Profile Management

## Why
Users need to view and edit their profile information, manage preferences, and sign out. The profile screen is accessible from the home screen and provides account management functionality.

## What Changes
- Create profile screen with user info display
- Implement profile editing (name, phone, avatar)
- Add preferences management (currency, notifications)
- Implement logout with confirmation dialog
- Add onboarding permissions screen

## Impact
- Affected specs: `user-profile` (new)
- Affected code: `lib/features/profile/`
- Dependencies: `005-add-auth-email` must be completed
- Blocks: None

## Design References
- `travely-design/trips_list_1/code.html` - Profile settings screen
- `travely-design/trips_list_2/code.html` - Logout confirmation dialog
- `travely-design/permissions/code.html` - Permissions onboarding

## Deliverables
1. `lib/features/profile/` - Feature module
2. Profile screen with personal info
3. Edit profile functionality
4. Preferences section
5. Logout with confirmation
6. Permissions onboarding screen
