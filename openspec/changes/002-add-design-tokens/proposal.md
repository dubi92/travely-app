# Change: Extract Design Tokens from UI Designs

## Why
The app has 18+ screen designs in `travely-design/`. Before implementing any features, we need to extract the exact visual specifications (colors, typography, spacing, shadows) to ensure consistent, pixel-perfect implementation across all screens.

## What Changes
- Analyze all screen designs to extract color palette
- Define typography scale from headings and body text
- Extract spacing values used consistently
- Document shadow and border radius patterns
- Create Flutter theme configuration
- Create design token constants

## Impact
- Affected specs: `design-system` (new)
- Affected code: `lib/core/theme/` (new files)
- Dependencies: `add-project-foundation` must be completed first
- Blocks: All UI implementation proposals depend on this

## Design Sources
The following screens will be analyzed:
1. `welcome_/_value_proposition/screen.png` - Primary button, heading styles
2. `sign_up_/_login/screen.png` - Input fields, secondary buttons, links
3. `trips_list_3/screen.png` - Cards, avatars, status badges
4. `itinerary_overview_(timeline_view)/screen.png` - Timeline, bottom nav
5. `expenses_overview/screen.png` - Charts, progress bars, list items
6. `add_expense_-_production_ready_v3_4/screen.png` - Forms, toggles
7. `split_overview_1/screen.png` - Balance display, action buttons

## Deliverables
1. `lib/core/theme/app_colors.dart` - Color constants
2. `lib/core/theme/app_typography.dart` - Text styles
3. `lib/core/theme/app_spacing.dart` - Spacing constants
4. `lib/core/theme/app_shadows.dart` - Shadow definitions
5. `lib/core/theme/app_theme.dart` - Combined ThemeData
6. Updated `openspec/specs/design-system/spec.md` - Validated token values
