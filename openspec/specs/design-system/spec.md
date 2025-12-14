# Design System Specification

This spec defines the visual language for Travely. ALL UI implementations MUST reference this spec.

## Design References
All designs are located in `travely-design/` folder. Each subfolder contains:
- `code.html` - **PRIMARY**: Contains exact colors, fonts, spacing in Tailwind config + full markup
- `screen.png` - **SECONDARY**: Visual reference for layout verification

**AI Implementation Rule**: Read `code.html` FIRST to extract design tokens from the `tailwind.config` block, then use `screen.png` to verify visual appearance.

## Color Palette

### Requirement: Brand Colors
The app SHALL use these exact colors consistently.

#### Scenario: Primary colors applied correctly
- **WHEN** implementing any primary action (buttons, links, active states)
- **THEN** use Primary Blue: `#4A90E2` (RGB: 74, 144, 226)

#### Scenario: Status colors applied correctly
- **WHEN** showing success states (confirmed, done, settled)
- **THEN** use Success Green: `#34C759`
- **WHEN** showing warning states (pending, planning)
- **THEN** use Warning Amber: `#F5A623`
- **WHEN** showing error states (logout, delete, overdue)
- **THEN** use Error Red: `#E53935`

### Color Tokens
| Token | Hex | Usage |
|-------|-----|-------|
| primary | #3182ED | Buttons, links, active tabs |
| primaryDark | #1A5BB8 | Darker shade for hover/pressed |
| primaryLight | #6BA4F2 | Lighter shade |
| backgroundLight | #F6F7F8 | Screen backgrounds (Light) |
| backgroundDark | #101822 | Screen backgrounds (Dark) |
| surfaceLight | #FFFFFF | Cards, modals (Light) |
| surfaceDark | #1A2632 | Cards, modals (Dark) |
| textPrimaryLight | #111418 | Headings, primary text (Light) |
| textPrimaryDark | #FFFFFF | Headings, primary text (Dark) |
| textSecondaryLight | #617389 | Captions, hints (Light) |
| textSecondaryDark | #9CA3AF | Captions, hints (Dark) |
| borderLight | #DBE0E6 | Dividers, input borders (Light) |
| borderDark | #374151 | Dividers, input borders (Dark) |
| success | #34A853 | Confirmed, done, positive balance |
| warning | #FBBC05 | Planning, pending |
| error | #EA4335 | Delete, logout, negative balance |
| info | #4285F4 | Info states |

---

## Typography

### Requirement: Typography Scale
The app SHALL use a consistent type scale.

#### Scenario: Text hierarchy is clear
- **WHEN** displaying screen titles
- **THEN** use Heading1: 28px, Bold (700)
- **WHEN** displaying section headers
- **THEN** use Heading2: 20px, SemiBold (600)
- **WHEN** displaying card titles
- **THEN** use Heading3: 16px, SemiBold (600)
- **WHEN** displaying body text
- **THEN** use Body: 14px, Regular (400)
- **WHEN** displaying captions or hints
- **THEN** use Caption: 12px, Regular (400)

### Typography Tokens
| Token | Size | Weight | Line Height | Font Family |
|-------|------|--------|-------------|-------------|
| displayLarge | 32px | Bold | 1.2 | Plus Jakarta Sans |
| displayMedium | 24px | Bold | 1.2 | Plus Jakarta Sans |
| displaySmall | 20px | Bold | 1.2 | Plus Jakarta Sans |
| bodyLarge | 18px | Regular | 1.5 | Inter |
| bodyMedium | 16px | Regular | 1.5 | Inter |
| bodySmall | 14px | Regular | 1.5 | Inter |
| labelLarge | 16px | SemiBold | 1.2 | Inter |

**Font Family**: `Inter` for body/ui, `Plus Jakarta Sans` for headings.

---

## Spacing

### Requirement: Consistent Spacing
The app SHALL use an 4px base spacing system.

#### Scenario: Spacing is consistent
- **WHEN** adding padding inside components
- **THEN** use multiples of 4px: 4, 8, 12, 16, 20, 24, 32, 48

### Spacing Tokens
| Token | Value | Usage |
|-------|-------|-------|
| xs | 4px | Tight spacing, icon gaps |
| sm | 8px | Between related items |
| md | 12px | Component internal padding |
| lg | 16px | Card padding, section gaps |
| xl | 24px | Screen padding, major sections |
| xxl | 32px | Between major sections |
| xxxl | 48px | Screen top/bottom margins |

---

## Border Radius

### Requirement: Rounded Corners
The app SHALL use consistent border radius values.

#### Scenario: Border radius matches design
- **WHEN** rendering buttons (primary, secondary)
- **THEN** use full radius: 28px (height/2 for pill shape)
- **WHEN** rendering cards
- **THEN** use large radius: 16px
- **WHEN** rendering input fields
- **THEN** use medium radius: 12px
- **WHEN** rendering chips/badges
- **THEN** use small radius: 8px
- **WHEN** rendering avatars
- **THEN** use circular: 50%

---

## Components

### Requirement: Primary Button
Refer to: `travely-design/welcome_/_value_proposition/screen.png` (Start Planning button)

#### Scenario: Primary button renders correctly
- **WHEN** rendering a primary action button
- **THEN** height SHALL be 56px
- **AND** background SHALL be primary (#4A90E2)
- **AND** text SHALL be white, 16px, SemiBold
- **AND** border-radius SHALL be 28px (pill shape)
- **AND** horizontal padding SHALL be 32px

### Requirement: Input Field
Refer to: `travely-design/sign_up_/_login/screen.png` (Email/Password fields)

#### Scenario: Input field renders correctly
- **WHEN** rendering a text input
- **THEN** height SHALL be 56px
- **AND** background SHALL be #F8F9FA (or white with border)
- **AND** border-radius SHALL be 12px
- **AND** padding SHALL be 16px horizontal
- **AND** label SHALL be above the field, 14px, secondary color

### Requirement: Card Component
Refer to: `travely-design/trips_list_3/screen.png` (Trip cards)

#### Scenario: Card renders correctly
- **WHEN** rendering a content card
- **THEN** background SHALL be white
- **AND** border-radius SHALL be 16px
- **AND** shadow SHALL be subtle (0 2px 8px rgba(0,0,0,0.08))
- **AND** padding SHALL be 16px

### Requirement: Status Badge
Refer to: `travely-design/trips_list_3/screen.png` (Planning/Confirmed badges)

#### Scenario: Status badge renders correctly
- **WHEN** showing "Planning" status
- **THEN** background SHALL be warning light (#FEF3E2)
- **AND** text SHALL be warning (#F5A623)
- **WHEN** showing "Confirmed" status
- **THEN** background SHALL be success light (#E8F9EE)
- **AND** text SHALL be success (#34C759)

### Requirement: Avatar Stack
Refer to: `travely-design/trips_list_3/screen.png` (Member avatars on trip cards)

#### Scenario: Avatar stack renders correctly
- **WHEN** showing multiple member avatars
- **THEN** avatars SHALL be 32px diameter
- **AND** avatars SHALL overlap by 8px
- **AND** border SHALL be 2px white
- **AND** maximum visible SHALL be 3, then show "+N"

### Requirement: Bottom Navigation
Refer to: `travely-design/itinerary_overview_(timeline_view)/screen.png`

#### Scenario: Bottom nav renders correctly
- **WHEN** showing trip detail bottom navigation
- **THEN** items SHALL be: Itinerary, Expenses, Split, Setting
- **AND** active item SHALL use primary color
- **AND** inactive items SHALL use secondary color
- **AND** icons SHALL be 24px

---

## Shadows

### Shadow Tokens
| Token | Value | Usage |
|-------|-------|-------|
| sm | 0 1px 2px rgba(0,0,0,0.05) | Subtle elevation |
| md | 0 2px 8px rgba(0,0,0,0.08) | Cards |
| lg | 0 4px 16px rgba(0,0,0,0.12) | Modals, FAB |
| button | 0 4px 12px rgba(74,144,226,0.3) | Primary buttons |

---

## Animation

### Requirement: Smooth Transitions
The app SHALL use consistent animation durations.

#### Scenario: Animations feel responsive
- **WHEN** transitioning between screens
- **THEN** duration SHALL be 300ms with ease-out curve
- **WHEN** showing/hiding elements
- **THEN** duration SHALL be 200ms with ease-in-out curve
- **WHEN** micro-interactions (button press, toggle)
- **THEN** duration SHALL be 150ms

---

## Implementation Checklist

Before implementing any screen, AI MUST:
1. [ ] Read the corresponding `screen.png` in `travely-design/`
2. [ ] Reference this design-system spec for tokens
3. [ ] Use exact color hex values from Color Tokens
4. [ ] Use exact sizes from Typography/Spacing tokens
5. [ ] Match component specifications exactly
