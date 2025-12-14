# Change: Add Google Authentication

## Why
Users need a simple, fast way to sign in. Google Sign-In provides one-tap authentication without requiring users to create and remember passwords.

## What Changes
- Create welcome screen with value proposition
- Implement Google Sign-In integration
- Create user profile from Google account data
- Setup auth state management and navigation

## Impact
- Affected specs: `auth` (new)
- Affected code: `lib/features/auth/`
- Dependencies: `004-add-supabase-setup` must be completed
- Blocks: `007-add-user-profile`

## Design References
- `travely-design/welcome_/_value_proposition/code.html` - Welcome screen
- `travely-design/sign_up_/_login/code.html` - Google button style

## Supabase Setup Required
1. Authentication > Providers > Google > Enable
2. Add Google OAuth credentials (from Google Cloud Console)

## Deliverables
1. `lib/features/auth/` - Feature module
2. Welcome screen with Google Sign-In button
3. Auth repository with Google sign-in
4. Profile creation from Google data
5. Database: `profiles` table
