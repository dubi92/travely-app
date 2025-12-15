## ADDED Requirements

### Requirement: Itinerary Screen
Users SHALL view trip activities in a playful timeline format.
Reference: `travely-design/timeline_blended_design (1).html`

#### Scenario: Itinerary screen displays with playful design
- **WHEN** user navigates to Itinerary tab
- **THEN** gradient background SHALL be displayed (mint to cyan)
- **AND** decorative elements (clouds, stars) SHALL be visible
- **AND** floating mascot (balloon) SHALL animate in header
- **AND** trip title and dates SHALL be displayed

#### Scenario: Empty itinerary displayed
- **WHEN** trip has no activities for selected day
- **THEN** empty state illustration SHALL be shown
- **AND** "Add your first activity" message SHALL be displayed

---

### Requirement: Day Tabs Navigation
Users SHALL navigate between trip days using tabs.

#### Scenario: Day tabs displayed
- **WHEN** viewing itinerary
- **THEN** day tabs SHALL be displayed for each trip day
- **AND** each tab SHALL show "Day N" and date

#### Scenario: Switching between days
- **WHEN** user taps a day tab
- **THEN** activities for that day SHALL be displayed
- **AND** tab SHALL become active state

---

### Requirement: Activity Timeline
Activities SHALL be displayed in a vertical timeline.

#### Scenario: Timeline renders with vertical connector
- **WHEN** displaying activities
- **THEN** vertical line SHALL connect all activities
- **AND** line SHALL have gradient color (cyan to mint)

#### Scenario: Time indicator displays
- **WHEN** rendering activity time
- **THEN** time text SHALL be displayed (e.g., "09:00")
- **AND** emoji icon SHALL be displayed below time

---

### Requirement: Activity Card Display
Each activity SHALL be displayed as a card in the timeline.
Reference: `travely-design/timeline_blended_design (1).html`

#### Scenario: Activity card renders with playful style
- **WHEN** rendering an activity card
- **THEN** card SHALL use GlassmorphismCard component
- **AND** card SHALL have rounded corners (32px)

#### Scenario: Activity card displays content
- **WHEN** rendering activity details
- **THEN** status badge SHALL be displayed
- **AND** category icon SHALL be displayed
- **AND** activity title SHALL be displayed
- **AND** location with pin icon SHALL be displayed

#### Scenario: Card color variants applied
- **WHEN** activity status is done
- **THEN** card SHALL use mint variant
- **WHEN** activity status is planned
- **THEN** card SHALL use peach variant
- **WHEN** activity status is booked
- **THEN** card SHALL use light variant

---

### Requirement: Activity Card Participants
Activity cards SHALL show participant avatars.

#### Scenario: Participant avatars displayed
- **WHEN** activity has participants
- **THEN** avatars SHALL be displayed in overlapping stack
- **AND** maximum 3 avatars SHALL be visible
- **AND** additional count SHALL show as "+N"

---

### Requirement: Activity Card Price
Activity cards SHALL show price information when available.

#### Scenario: Price displayed
- **WHEN** activity has price set
- **THEN** price SHALL be displayed with currency

#### Scenario: Paid badge displayed
- **WHEN** activity is marked as paid
- **THEN** "Paid" badge SHALL be displayed

---

### Requirement: Activity Image Display
Activity cards SHALL support displaying an image.

#### Scenario: Activity with image
- **WHEN** activity has image_url
- **THEN** image SHALL be displayed in card
- **AND** image SHALL have rounded corners

#### Scenario: Activity without image
- **WHEN** activity has no image_url
- **THEN** image section SHALL be hidden

---

### Requirement: Info Badges Display
Activity cards SHALL support info badges.

#### Scenario: Price estimate badge
- **WHEN** activity has estimated price
- **THEN** info badge SHALL show "Est. [amount]"

#### Scenario: Free entry badge
- **WHEN** activity is free
- **THEN** info badge SHALL show "Free Entry"

---

### Requirement: Itinerary FAB
Users SHALL access activity creation via FAB.

#### Scenario: FAB displayed
- **WHEN** viewing itinerary
- **THEN** FAB SHALL be positioned bottom-right
- **AND** FAB SHALL show "+" icon with "Activity" label

#### Scenario: FAB navigation
- **WHEN** user taps FAB
- **THEN** add activity screen SHALL open

---

### Requirement: Activities State Management
The app SHALL manage activities state.

#### Scenario: Activities loaded for trip
- **WHEN** itinerary screen opens
- **THEN** activities SHALL be fetched for current trip
- **AND** loading indicator SHALL be shown during fetch

#### Scenario: Activities filtered by day
- **WHEN** user selects a day tab
- **THEN** only activities for that day SHALL be displayed

#### Scenario: Activities sorted by time
- **WHEN** displaying activities
- **THEN** activities SHALL be sorted by start_time ascending
