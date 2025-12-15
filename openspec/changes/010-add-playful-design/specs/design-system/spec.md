## ADDED Requirements

### Requirement: Playful Color Palette
The design system SHALL include playful color tokens for itinerary features.
Reference: `travely-design/timeline_blended_design (1).html`

#### Scenario: Gradient background colors available
- **WHEN** implementing playful screens
- **THEN** bgGradientStart (#D4F1E3 mint) SHALL be available
- **AND** bgGradientEnd (#E8F6F8 cyan) SHALL be available

#### Scenario: Card variant colors available
- **WHEN** implementing playful cards
- **THEN** cardMint (rgba(212, 241, 227, 0.5)) SHALL be available
- **AND** cardPeach (rgba(255, 228, 204, 0.5)) SHALL be available
- **AND** cardLight (rgba(255, 255, 255, 0.6)) SHALL be available

#### Scenario: Playful status colors available
- **WHEN** implementing status indicators
- **THEN** statusDone (#7FD4A8) SHALL be available
- **AND** statusBooked (#80CFEC) SHALL be available
- **AND** statusPlanned (#FFB366) SHALL be available

---

### Requirement: Glassmorphism Card Component
The app SHALL provide a glassmorphism-style card widget.
Reference: `travely-design/timeline_blended_design (1).html`

#### Scenario: Glassmorphism card renders correctly
- **WHEN** rendering a GlassmorphismCard
- **THEN** card SHALL have rounded corners (32px)
- **AND** card SHALL have backdrop blur effect (20px blur)
- **AND** card SHALL have semi-transparent border (white 50%)
- **AND** card SHALL have gradient background

#### Scenario: Card variant applied
- **WHEN** card variant is mint
- **THEN** background SHALL use mint gradient
- **WHEN** card variant is peach
- **THEN** background SHALL use peach gradient
- **WHEN** card variant is light
- **THEN** background SHALL use white/cyan gradient

#### Scenario: Card hover effect
- **WHEN** user hovers or taps card
- **THEN** card SHALL lift (translateY -4px)
- **AND** shadow SHALL increase
- **AND** transition SHALL be 300ms

---

### Requirement: Decorative Background Component
The app SHALL provide decorative background elements.

#### Scenario: Decorative background renders
- **WHEN** DecorativeBackground is displayed
- **THEN** cloud shapes SHALL be positioned (semi-transparent white)
- **AND** star elements SHALL be positioned (golden color)
- **AND** elements SHALL have reduced opacity (40%)

#### Scenario: Decorative elements are non-interactive
- **WHEN** user taps on decorative elements
- **THEN** taps SHALL pass through to underlying content
- **AND** elements SHALL be excluded from semantics

---

### Requirement: Floating Mascot Component
The app SHALL provide an animated floating mascot widget.

#### Scenario: Floating mascot animates
- **WHEN** FloatingMascot is displayed
- **THEN** mascot SHALL float up and down
- **AND** animation duration SHALL be 3 seconds
- **AND** animation SHALL use ease-in-out curve

#### Scenario: Balloon mascot sways
- **WHEN** mascot type is balloon
- **THEN** mascot SHALL sway left and right
- **AND** rotation SHALL be -5deg to +5deg
- **AND** animation duration SHALL be 2 seconds

---

### Requirement: Playful Status Badge Component
The app SHALL provide status badges with emoji icons.
Reference: `travely-design/timeline_blended_design (1).html`

#### Scenario: Done status badge renders
- **WHEN** status is done
- **THEN** badge SHALL show emoji icon
- **AND** background SHALL be green tinted (rgba(127, 212, 168, 0.3))
- **AND** text SHALL be dark green (#2D7A5A)

#### Scenario: Booked status badge renders
- **WHEN** status is booked
- **THEN** badge SHALL show emoji icon
- **AND** background SHALL be blue tinted (rgba(128, 207, 236, 0.3))
- **AND** text SHALL be dark blue (#2C5F8F)

#### Scenario: Planned status badge renders
- **WHEN** status is planned
- **THEN** badge SHALL show emoji icon
- **AND** background SHALL be orange tinted (rgba(255, 179, 102, 0.3))
- **AND** text SHALL be brown (#8B5A2B)

---

### Requirement: Day Tabs Component
The app SHALL provide horizontal day tabs navigation.
Reference: `travely-design/timeline_blended_design (1).html`

#### Scenario: Day tabs render correctly
- **WHEN** DayTabs is displayed
- **THEN** tabs SHALL be horizontal scrollable
- **AND** each tab SHALL be pill-shaped (border-radius 999px)
- **AND** tabs SHALL show day number and date

#### Scenario: Active tab state
- **WHEN** tab is active
- **THEN** background SHALL be blue (#5DADE2)
- **AND** text SHALL be white
- **AND** tab SHALL have subtle shadow

#### Scenario: Inactive tab state
- **WHEN** tab is inactive
- **THEN** background SHALL be semi-transparent white
- **AND** text SHALL be secondary color
- **AND** hover SHALL show lighter background

#### Scenario: Tab selection
- **WHEN** user taps a tab
- **THEN** onTabChanged callback SHALL be invoked
- **AND** active state SHALL transition smoothly (300ms)
