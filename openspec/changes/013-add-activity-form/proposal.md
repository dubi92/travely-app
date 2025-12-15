# Change: Add Activity Form Screens

## Why
Users need to create and edit activities in their trip itinerary. This change implements the add/edit activity screens with form fields for all activity properties.

## What Changes
- Create AddActivityScreen with form fields
- Create EditActivityScreen (reuses form)
- Implement category selector with emoji icons
- Implement status selector
- Implement date/time pickers
- Add activity deletion with confirmation
- Handle form validation and submission

## Impact
- Affected specs: MODIFY `itinerary` capability
- Affected code: `lib/features/itinerary/`
- Dependencies: `010-add-playful-design`, `011-add-activity-crud`, `012-add-itinerary-screen`

## Deliverables
1. AddActivityScreen
2. EditActivityScreen
3. ActivityForm widget (shared)
4. CategorySelector widget
5. StatusSelector widget
6. Delete activity confirmation dialog
7. Form validation
