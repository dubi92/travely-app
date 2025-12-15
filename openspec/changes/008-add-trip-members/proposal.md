# Change: Add Trip Members Management

## Why
Trips are collaborative - users need to invite friends/family to join their trips. Members can view itineraries and share expenses.

## What Changes
- Create trip_members database table
- Create trip_invitations table for invite links
- Implement member invitation flow
- Implement member management UI

## Impact
- Affected specs: `trips` (extended)
- Affected code: `lib/features/trips/`
- Dependencies: `007-add-trip-crud` must be completed
- Blocks: Expense splitting features

## Design References
- `travely-design/create_trip_flow_-_basic_info_2/code.html` - Members section
- `travely-design/trip_settings/code.html` - Manage members

## Deliverables
1. Database: `trip_members` table
2. Database: `trip_invitations` table
3. Invite link generation
4. Join trip via invite link
5. Member list management
