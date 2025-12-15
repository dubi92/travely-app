# Change: Add Trip CRUD Operations

## Why
Users need to create and manage trips. The trip creation wizard guides users through setting up basic info, preferences, and budget for their travels.

## What Changes
- Create trips database table
- Implement trip repository with CRUD operations
- Create 3-step trip creation wizard
- Implement trip settings/edit screen

## Impact
- Affected specs: `trips` (new)
- Affected code: `lib/features/trips/`
- Dependencies: `006-add-user-profile` must be completed
- Blocks: `008-add-trip-members`, `009-add-trip-list`

## Design References
- `travely-design/create_trip_flow_-_basic_info_1/code.html` - Step 3: Preferences
- `travely-design/create_trip_flow_-_basic_info_2/code.html` - Step 2: Members
- `travely-design/create_trip_flow_-_basic_info_3/code.html` - Step 1: Basic Info
- `travely-design/trip_settings/code.html` - Trip settings screen

## Deliverables
1. `lib/features/trips/` - Feature module
2. Database: `trips` table
3. Trip creation wizard (3 steps)
4. Trip settings screen
5. Trip repository
