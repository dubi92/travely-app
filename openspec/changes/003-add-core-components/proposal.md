# Change: Create Core Reusable UI Components

## Why
Multiple screens share common UI patterns (buttons, inputs, cards, badges, avatars). Building these as reusable components ensures design consistency and reduces code duplication. Each component must match the designs exactly.

## What Changes
- Create reusable button components (primary, secondary, text, icon)
- Create input field components (text, email, password, search)
- Create card component with consistent styling
- Create status badge component
- Create avatar and avatar stack components
- Create bottom navigation component
- Create loading and empty state components

## Impact
- Affected specs: `design-system` (extended)
- Affected code: `lib/shared/widgets/` (new files)
- Dependencies: `add-design-tokens` must be completed first
- Blocks: All feature UI implementations depend on these components

## Design References
Each component maps to specific designs:

| Component | Reference Design |
|-----------|-----------------|
| PrimaryButton | `welcome_/_value_proposition/screen.png` |
| SecondaryButton | `sign_up_/_login/screen.png` |
| InputField | `sign_up_/_login/screen.png` |
| AppCard | `trips_list_3/screen.png` |
| StatusBadge | `trips_list_3/screen.png`, `itinerary_overview` |
| AvatarStack | `trips_list_3/screen.png` |
| BottomNavBar | `itinerary_overview_(timeline_view)/screen.png` |
| SegmentedControl | `add_expense_-_production_ready_v3_2/screen.png` |

## Deliverables
1. `lib/shared/widgets/buttons/` - Button components
2. `lib/shared/widgets/inputs/` - Input field components
3. `lib/shared/widgets/cards/` - Card components
4. `lib/shared/widgets/badges/` - Badge components
5. `lib/shared/widgets/avatars/` - Avatar components
6. `lib/shared/widgets/navigation/` - Navigation components
7. `lib/shared/widgets/feedback/` - Loading, empty, error states
8. `lib/shared/widgets/widgets.dart` - Barrel export file
