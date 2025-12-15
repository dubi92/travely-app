## ADDED Requirements

### Requirement: Add Activity Screen
Users SHALL be able to create new activities.

#### Scenario: Add activity form displayed
- **WHEN** user opens add activity screen
- **THEN** form SHALL include title field (required)
- **AND** form SHALL include category selector
- **AND** form SHALL include location field
- **AND** form SHALL include date picker
- **AND** form SHALL include start time picker
- **AND** form SHALL include end time picker (optional)
- **AND** form SHALL include status selector
- **AND** form SHALL include price field with currency

#### Scenario: Default values set
- **WHEN** add activity screen opens
- **THEN** date SHALL default to selected day from itinerary
- **AND** status SHALL default to "Planned"
- **AND** category SHALL default to "other"

#### Scenario: Activity created successfully
- **WHEN** user fills required fields and submits
- **THEN** activity SHALL be saved to database
- **AND** user SHALL return to itinerary
- **AND** new activity SHALL appear in timeline

---

### Requirement: Edit Activity Screen
Users SHALL be able to edit existing activities.

#### Scenario: Edit activity form displayed
- **WHEN** user taps an activity card
- **THEN** edit activity screen SHALL open
- **AND** form SHALL be pre-filled with activity data

#### Scenario: Activity updated successfully
- **WHEN** user edits fields and saves
- **THEN** activity SHALL be updated in database
- **AND** user SHALL return to itinerary
- **AND** changes SHALL be reflected in timeline

---

### Requirement: Category Selector
Users SHALL select activity category from predefined options.

#### Scenario: Category options displayed
- **WHEN** category selector is shown
- **THEN** options SHALL include: Food, Sightseeing, Accommodation, Transport, Shopping, Other
- **AND** each option SHALL show emoji icon

#### Scenario: Category selected
- **WHEN** user taps a category option
- **THEN** category SHALL be highlighted as selected
- **AND** form value SHALL be updated

---

### Requirement: Status Selector
Users SHALL select activity status.

#### Scenario: Status options displayed
- **WHEN** status selector is shown
- **THEN** options SHALL include: Planned, Booked, Done
- **AND** each option SHALL show status color and emoji

#### Scenario: Status selected
- **WHEN** user taps a status option
- **THEN** status SHALL be highlighted as selected

---

### Requirement: Delete Activity
Users SHALL be able to delete activities.

#### Scenario: Delete confirmation shown
- **WHEN** user initiates delete action
- **THEN** confirmation dialog SHALL appear
- **AND** dialog SHALL show activity title

#### Scenario: Activity deleted
- **WHEN** user confirms deletion
- **THEN** activity SHALL be removed from database
- **AND** user SHALL return to itinerary
- **AND** activity SHALL disappear from timeline

#### Scenario: Delete cancelled
- **WHEN** user cancels deletion
- **THEN** dialog SHALL close
- **AND** activity SHALL remain unchanged

---

### Requirement: Activity Form Validation
The form SHALL validate user input.

#### Scenario: Title required
- **WHEN** user submits without title
- **THEN** validation error SHALL be shown
- **AND** form SHALL not submit

#### Scenario: Date within trip range
- **WHEN** user selects date outside trip dates
- **THEN** validation error SHALL be shown

#### Scenario: End time after start time
- **WHEN** end time is before start time
- **THEN** validation error SHALL be shown

---

### Requirement: Activity Form Navigation
The app SHALL handle navigation to/from activity forms.

#### Scenario: Navigate to add activity
- **WHEN** user taps FAB on itinerary
- **THEN** add activity screen SHALL open
- **AND** selected day SHALL be passed

#### Scenario: Navigate to edit activity
- **WHEN** user taps activity card
- **THEN** edit activity screen SHALL open
- **AND** activity data SHALL be passed

#### Scenario: Return to itinerary
- **WHEN** user saves or cancels
- **THEN** user SHALL return to itinerary screen
