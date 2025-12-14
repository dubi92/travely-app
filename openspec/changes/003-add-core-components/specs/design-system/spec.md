## ADDED Requirements

### Requirement: Primary Button Component
The app SHALL provide a reusable primary button matching the design.
Reference: `travely-design/welcome_/_value_proposition/screen.png`

#### Scenario: Primary button renders correctly
- **WHEN** rendering a primary action button
- **THEN** height SHALL be 56px
- **AND** background SHALL be primary color
- **AND** text SHALL be white, button text style
- **AND** corners SHALL be fully rounded (pill shape)
- **AND** button SHALL have subtle shadow

#### Scenario: Primary button shows loading state
- **WHEN** button is in loading state
- **THEN** text SHALL be replaced with circular progress indicator
- **AND** button SHALL be disabled

#### Scenario: Primary button handles disabled state
- **WHEN** button is disabled
- **THEN** opacity SHALL be reduced
- **AND** button SHALL not respond to taps

---

### Requirement: Secondary Button Component
The app SHALL provide a secondary button with outline style.
Reference: `travely-design/sign_up_/_login/screen.png`

#### Scenario: Secondary button renders correctly
- **WHEN** rendering a secondary action button
- **THEN** background SHALL be transparent or white
- **AND** border SHALL be 1px primary color or gray
- **AND** text SHALL be primary color or dark

---

### Requirement: Social Login Buttons
The app SHALL provide Google and Apple sign-in buttons.
Reference: `travely-design/sign_up_/_login/screen.png`

#### Scenario: Google button renders correctly
- **WHEN** rendering Google sign-in button
- **THEN** button SHALL show Google logo
- **AND** background SHALL be white with border
- **AND** text SHALL say "Continue with Google"

#### Scenario: Apple button renders correctly
- **WHEN** rendering Apple sign-in button
- **THEN** button SHALL show Apple logo
- **AND** background SHALL be black
- **AND** text SHALL be white, say "Continue with Apple"

---

### Requirement: Text Input Field Component
The app SHALL provide a reusable text input field.
Reference: `travely-design/sign_up_/_login/screen.png`

#### Scenario: Input field renders correctly
- **WHEN** rendering a text input
- **THEN** height SHALL be 56px
- **AND** background SHALL be light gray or white with border
- **AND** border-radius SHALL be 12px
- **AND** label SHALL appear above the field

#### Scenario: Input field shows error state
- **WHEN** input has validation error
- **THEN** border SHALL be error color
- **AND** error message SHALL appear below field

#### Scenario: Password field has visibility toggle
- **WHEN** rendering a password input
- **THEN** eye icon SHALL toggle password visibility

---

### Requirement: App Card Component
The app SHALL provide a reusable card container.
Reference: `travely-design/trips_list_3/screen.png`

#### Scenario: Card renders with consistent style
- **WHEN** rendering a content card
- **THEN** background SHALL be white
- **AND** border-radius SHALL be 16px
- **AND** shadow SHALL be subtle elevation
- **AND** padding SHALL be 16px

---

### Requirement: Status Badge Component
The app SHALL provide status badges for different states.
Reference: `travely-design/trips_list_3/screen.png`

#### Scenario: Planning badge renders correctly
- **WHEN** showing "Planning" status
- **THEN** background SHALL be warning light color
- **AND** text SHALL be warning color

#### Scenario: Confirmed badge renders correctly
- **WHEN** showing "Confirmed" status
- **THEN** background SHALL be success light color
- **AND** text SHALL be success color

#### Scenario: Done badge renders correctly
- **WHEN** showing "Done" status
- **THEN** background SHALL be success light color
- **AND** text SHALL be success color

---

### Requirement: Avatar Component
The app SHALL provide avatar display components.
Reference: `travely-design/trips_list_3/screen.png`

#### Scenario: Avatar displays image correctly
- **WHEN** user has profile image
- **THEN** circular image SHALL be displayed
- **AND** size SHALL be configurable (default 40px)

#### Scenario: Avatar shows initials fallback
- **WHEN** user has no profile image
- **THEN** initials SHALL be displayed on colored background

---

### Requirement: Avatar Stack Component
The app SHALL display overlapping avatars for group members.
Reference: `travely-design/trips_list_3/screen.png`

#### Scenario: Avatar stack renders correctly
- **WHEN** showing multiple member avatars
- **THEN** avatars SHALL overlap by 8px
- **AND** each avatar SHALL have white border
- **AND** maximum 3 avatars shown, then "+N" indicator

---

### Requirement: Bottom Navigation Component
The app SHALL provide bottom navigation for trip detail screens.
Reference: `travely-design/itinerary_overview_(timeline_view)/screen.png`

#### Scenario: Bottom nav renders correctly
- **WHEN** showing trip detail navigation
- **THEN** items SHALL be: Itinerary, Expenses, Split, Setting
- **AND** active item SHALL use primary color
- **AND** inactive items SHALL use secondary color
- **AND** icons SHALL be consistent size (24px)

---

### Requirement: Segmented Control Component
The app SHALL provide a segmented control for binary choices.
Reference: `travely-design/add_expense_-_production_ready_v3_2/screen.png`

#### Scenario: Segmented control renders correctly
- **WHEN** showing two options (e.g., "During Trip" / "Pre-trip")
- **THEN** options SHALL be in pill-shaped container
- **AND** selected option SHALL have white background
- **AND** unselected option SHALL have transparent background

---

### Requirement: Confirmation Dialog Component
The app SHALL provide a reusable confirmation dialog.
Reference: `travely-design/trips_list_2/screen.png` (logout dialog)

#### Scenario: Confirmation dialog renders correctly
- **WHEN** showing a destructive action confirmation
- **THEN** dialog SHALL have icon, title, description
- **AND** primary action button SHALL be colored appropriately (red for destructive)
- **AND** cancel button SHALL be secondary style
