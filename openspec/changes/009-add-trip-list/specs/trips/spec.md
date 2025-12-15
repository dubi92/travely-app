## ADDED Requirements

### Requirement: Home Screen
Authenticated users SHALL see the home screen with their trips.
Reference: `travely-design/trips_list_3/code.html`

#### Scenario: Home screen displayed after sign-in
- **WHEN** user signs in successfully
- **THEN** home screen SHALL be displayed
- **AND** greeting with user name SHALL be shown
- **AND** user avatar SHALL be displayed

#### Scenario: User avatar navigates to profile
- **WHEN** user taps their avatar
- **THEN** profile screen SHALL be displayed

---

### Requirement: Trips List
Home screen SHALL display user's trips.

#### Scenario: Upcoming trips displayed
- **WHEN** user has trips with end_date >= today
- **THEN** trips SHALL be shown in "Upcoming Trips" section
- **AND** trips SHALL be sorted by start_date ascending

#### Scenario: Past trips displayed
- **WHEN** user has trips with end_date < today
- **THEN** trips SHALL be shown in "Past Trips" section
- **AND** section SHALL be collapsible

#### Scenario: Empty state displayed
- **WHEN** user has no trips
- **THEN** empty state illustration SHALL be shown
- **AND** "Create your first trip" message SHALL be displayed

---

### Requirement: Trip Card
Each trip SHALL be displayed as a card.
Reference: `travely-design/trips_list_3/code.html`

#### Scenario: Trip card displays info
- **WHEN** rendering a trip card
- **THEN** cover image SHALL be displayed (or placeholder)
- **AND** trip name SHALL be displayed
- **AND** date range SHALL be displayed
- **AND** status badge SHALL be displayed
- **AND** member avatars SHALL be displayed

#### Scenario: Trip card navigation
- **WHEN** user taps a trip card
- **THEN** trip detail screen SHALL be displayed

---

### Requirement: Create Trip FAB
Home screen SHALL have a FAB to create new trips.

#### Scenario: FAB navigates to create trip
- **WHEN** user taps the FAB
- **THEN** create trip wizard SHALL be displayed

---

### Requirement: Trip Detail Shell
Trip detail screen SHALL have bottom navigation.

#### Scenario: Bottom navigation tabs
- **WHEN** viewing trip detail
- **THEN** bottom nav SHALL show: Itinerary, Expenses, Split, Settings
- **AND** tapping tab SHALL switch content

---

### Requirement: Pull to Refresh
Users SHALL be able to refresh trips list.

#### Scenario: Pull to refresh
- **WHEN** user pulls down on trips list
- **THEN** trips SHALL be reloaded from server
- **AND** loading indicator SHALL be shown
