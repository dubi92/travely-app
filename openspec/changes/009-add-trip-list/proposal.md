# Change: Add Trips List (Home Screen)

## Why
After signing in, users need to see their trips and quickly access them. The home screen displays upcoming and past trips with key info at a glance.

## What Changes
- Create home screen with trips list
- Implement trip card component
- Add upcoming vs past trips sections
- Add FAB to create new trip
- Navigate to trip detail on tap

## Impact
- Affected specs: `trips` (extended)
- Affected code: `lib/features/trips/`
- Dependencies: `007-add-trip-crud`, `008-add-trip-members`
- Blocks: Itinerary features (Phase 3)

## Design References
- `travely-design/trips_list_3/code.html` - Trips list screen

## Deliverables
1. Home screen with trips list
2. Trip card widget
3. Upcoming/past trips sections
4. Empty state when no trips
5. Pull-to-refresh
