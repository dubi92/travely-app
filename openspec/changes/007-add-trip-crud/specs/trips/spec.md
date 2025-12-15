## ADDED Requirements

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
