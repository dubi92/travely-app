# Change: Add Itinerary Screen with Timeline

## Why
Users need to view their trip activities in an engaging timeline format. This change implements the main itinerary screen with the playful timeline design, activity cards, and day navigation.

## What Changes
- Create ItineraryScreen with playful gradient background
- Implement day tabs navigation
- Build vertical timeline with time indicators
- Create ActivityCard widget with status variants
- Add timeline connector with gradient line
- Implement empty state for days without activities
- Add FAB for creating activities
- Connect to TripDetailShell

## Impact
- Affected specs: MODIFY `itinerary` capability
- Affected code: `lib/features/itinerary/`
- Dependencies: `010-add-playful-design`, `011-add-activity-crud`
- Blocks: `013-add-activity-form`

## Design References
- `travely-design/timeline_blended_design (1).html` - Playful timeline design

## Deliverables
1. ItineraryScreen with gradient background
2. Timeline view with vertical connector
3. TimeIndicator widget
4. ActivityCard widget (mint, peach, light variants)
5. Empty state illustration
6. FAB integration
7. State management (ActivitiesProvider)
