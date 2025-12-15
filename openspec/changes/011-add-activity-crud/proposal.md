# Change: Add Activity CRUD Operations

## Why
Activities are the core data entity for trip itineraries. This change creates the database schema, model, and repository for managing activities within trips.

## What Changes
- Create `activities` table in Supabase
- Create `activity_participants` junction table
- Set up RLS policies for activity access control
- Create Activity model class
- Create ActivityRepository with CRUD operations
- Create ActivityStatus and ActivityCategory enums

## Impact
- Affected specs: NEW `itinerary` capability
- Affected code: Supabase schema, `lib/features/itinerary/`
- Dependencies: `004-add-supabase-setup`, `007-add-trip-crud`
- Blocks: `012-add-itinerary-screen`, `013-add-activity-form`

## Deliverables
1. Activities database table with RLS
2. Activity participants table
3. Activity model class
4. ActivityStatus enum (planned, booked, done)
5. ActivityCategory enum (food, sightseeing, accommodation, etc.)
6. ActivityRepository with CRUD methods
