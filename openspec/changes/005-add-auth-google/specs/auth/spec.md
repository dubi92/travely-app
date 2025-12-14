## ADDED Requirements

### Requirement: Welcome Screen
New users SHALL see a welcome screen as the first screen.
Reference: `travely-design/welcome_/_value_proposition/code.html`

#### Scenario: Welcome screen is displayed
- **WHEN** user opens app and is not authenticated
- **THEN** welcome screen SHALL be displayed
- **AND** tagline "Plan together. Spend smarter. Travel stress-free." SHALL be shown
- **AND** "Continue with Google" button SHALL be displayed

---

### Requirement: Google Sign-In
Users SHALL be able to sign in with their Google account.

#### Scenario: Successful Google sign-in
- **WHEN** user taps "Continue with Google" button
- **AND** selects their Google account
- **THEN** user SHALL be authenticated via Supabase
- **AND** profile SHALL be created with Google data (name, email, avatar)
- **AND** user SHALL be redirected to home screen

#### Scenario: Google sign-in cancelled
- **WHEN** user cancels Google sign-in flow
- **THEN** user SHALL return to welcome screen
- **AND** no error message SHALL be shown

#### Scenario: Google sign-in error
- **WHEN** Google sign-in fails (network error, etc.)
- **THEN** error message SHALL be displayed
- **AND** user can retry

---

### Requirement: Sign Out
Users SHALL be able to sign out of their account.

#### Scenario: Successful sign out
- **WHEN** user taps Sign Out
- **THEN** session SHALL be cleared
- **AND** user SHALL be redirected to welcome screen

---

### Requirement: Auth State Persistence
User session SHALL persist across app restarts.

#### Scenario: Session persists
- **WHEN** user closes and reopens app
- **AND** session is still valid
- **THEN** user SHALL remain authenticated
- **AND** user SHALL see home screen (not welcome)

---

### Requirement: Profiles Table
User profile data SHALL be stored in a profiles table.

#### Scenario: Profile created on sign-in
- **WHEN** user signs in with Google
- **THEN** profile record SHALL be created
- **AND** full_name SHALL be populated from Google
- **AND** email SHALL be populated from Google
- **AND** avatar_url SHALL be populated from Google
- **AND** default currency SHALL be 'USD'
