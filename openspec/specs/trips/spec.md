# trips Specification

## Purpose
TBD - created by archiving change 007-add-trip-crud. Update Purpose after archive.
## Requirements
### Requirement: Create Trip Wizard
Users SHALL be able to create a trip through a 3-step wizard.

#### Scenario: Step 1 - Basic Info
- **WHEN** user starts creating a trip
- **THEN** trip name input SHALL be displayed
- **AND** destination input SHALL be displayed
- **AND** date range picker SHALL be displayed
- **AND** popular destinations SHALL be suggested

#### Scenario: Step 2 - Members & Currency
- **WHEN** user proceeds to step 2
- **THEN** current user SHALL be shown as trip admin
- **AND** currency selector SHALL be displayed
- **AND** user can skip adding members

#### Scenario: Step 3 - Preferences
- **WHEN** user proceeds to step 3
- **THEN** budget input SHALL be displayed
- **AND** daily limit input SHALL be displayed
- **AND** travel pace selector SHALL be displayed (Relaxed/Balanced/Packed)

#### Scenario: Trip created successfully
- **WHEN** user completes wizard and taps "Create Trip"
- **THEN** trip SHALL be saved to Supabase
- **AND** user SHALL be redirected to trip detail

---

### Requirement: Trip Settings
Users SHALL be able to view and edit trip settings.
Reference: `travely-design/trip_settings/code.html`

#### Scenario: View trip settings
- **WHEN** user navigates to trip settings
- **THEN** cover image SHALL be displayed
- **AND** trip name SHALL be displayed
- **AND** dates SHALL be displayed
- **AND** currency SHALL be displayed
- **AND** budget SHALL be displayed

#### Scenario: Edit trip settings
- **WHEN** user edits trip settings and saves
- **THEN** changes SHALL be saved to Supabase
- **AND** updated values SHALL be displayed

#### Scenario: Archive trip
- **WHEN** user taps "Archive Trip"
- **THEN** trip status SHALL be set to 'archived'
- **AND** trip SHALL be moved to past trips

---

### Requirement: Trips Database
Trip data SHALL be stored in a trips table.

#### Scenario: Trip record created
- **WHEN** trip is created
- **THEN** trip record SHALL include name, dates, currency, budget
- **AND** created_by SHALL be set to current user
- **AND** status SHALL be 'planning' by default

### Requirement: Trip Members
Trips SHALL support multiple members with roles.

#### Scenario: Creator is auto-added as admin
- **WHEN** user creates a trip
- **THEN** user SHALL be automatically added as member
- **AND** user role SHALL be 'admin'

#### Scenario: View trip members
- **WHEN** viewing trip members
- **THEN** all members SHALL be listed
- **AND** member roles SHALL be displayed
- **AND** member avatars SHALL be displayed

---

### Requirement: Invite Link
Admins SHALL be able to invite others via link.

#### Scenario: Generate invite link
- **WHEN** admin taps "Generate Invite Link"
- **THEN** unique invite code SHALL be generated
- **AND** shareable link SHALL be displayed
- **AND** link can be copied or shared

#### Scenario: Share invite link
- **WHEN** admin taps "Share"
- **THEN** native share sheet SHALL open
- **AND** invite link SHALL be pre-filled

---

### Requirement: Join Trip
Users SHALL be able to join a trip via invite link.

#### Scenario: Join via invite link
- **WHEN** user opens invite link
- **THEN** trip preview SHALL be shown
- **AND** "Join Trip" button SHALL be displayed

#### Scenario: Successfully join trip
- **WHEN** user taps "Join Trip"
- **THEN** user SHALL be added as member (role: 'member')
- **AND** user SHALL be redirected to trip detail

#### Scenario: Invalid invite link
- **WHEN** user opens expired or invalid invite link
- **THEN** error message SHALL be displayed

---

### Requirement: Manage Members
Admins SHALL be able to manage trip members.

#### Scenario: Remove member
- **WHEN** admin taps "Remove" on a member
- **THEN** confirmation SHALL be requested
- **WHEN** admin confirms
- **THEN** member SHALL be removed from trip

#### Scenario: Cannot remove self as last admin
- **WHEN** admin tries to remove themselves
- **AND** they are the only admin
- **THEN** error message SHALL be shown

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

