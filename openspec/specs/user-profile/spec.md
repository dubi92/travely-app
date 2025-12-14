# user-profile Specification

## Purpose
TBD - created by archiving change 006-add-user-profile. Update Purpose after archive.
## Requirements
### Requirement: View Profile
Users SHALL be able to view their profile information.

#### Scenario: Profile screen displays user data
- **WHEN** user navigates to profile screen
- **THEN** avatar SHALL be displayed (or placeholder if none)
- **AND** full name SHALL be displayed
- **AND** email SHALL be displayed
- **AND** phone SHALL be displayed (if set)

---

### Requirement: Edit Profile
Users SHALL be able to edit their profile information.

#### Scenario: Edit name
- **WHEN** user edits their name
- **AND** saves changes
- **THEN** name SHALL be updated in Supabase
- **AND** updated name SHALL be displayed

#### Scenario: Edit phone
- **WHEN** user edits their phone number
- **AND** saves changes
- **THEN** phone SHALL be updated in Supabase

#### Scenario: Change avatar
- **WHEN** user taps avatar edit button
- **THEN** picker SHALL show camera and gallery options
- **WHEN** user selects an image
- **THEN** image SHALL be uploaded to Supabase Storage
- **AND** avatar URL SHALL be updated in profile

---

### Requirement: User Preferences
Users SHALL be able to manage their preferences.

#### Scenario: Change default currency
- **WHEN** user taps currency setting
- **THEN** currency picker SHALL be displayed
- **WHEN** user selects a currency
- **THEN** preference SHALL be saved to profile

#### Scenario: Toggle trip alerts
- **WHEN** user toggles trip alerts switch
- **THEN** preference SHALL be saved to profile
- **AND** switch state SHALL reflect saved value

---

### Requirement: Logout
Users SHALL be able to sign out of their account.

#### Scenario: Logout with confirmation
- **WHEN** user taps Logout button
- **THEN** confirmation dialog SHALL be displayed
- **AND** dialog SHALL show "Are you sure?" message
- **WHEN** user confirms logout
- **THEN** session SHALL be cleared
- **AND** user SHALL be navigated to login screen

#### Scenario: Cancel logout
- **WHEN** user taps Cancel in logout dialog
- **THEN** dialog SHALL be dismissed
- **AND** user SHALL remain on profile screen

---

### Requirement: Permissions Onboarding
First-time users SHALL be prompted for permissions.

#### Scenario: Permissions screen on first launch
- **WHEN** user completes sign up
- **THEN** permissions screen SHALL be displayed
- **AND** Trip Reminders option SHALL be shown
- **AND** Local Recommendations option SHALL be shown

#### Scenario: Skip permissions
- **WHEN** user taps "I'll do this later"
- **THEN** permissions screen SHALL be skipped
- **AND** user SHALL proceed to home screen

#### Scenario: Enable notifications
- **WHEN** user enables Trip Reminders
- **THEN** notification permission SHALL be requested
- **AND** preference SHALL be saved

