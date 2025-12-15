# Implementation Tasks

**Design References:**
- `travely-design/create_trip_flow_-_basic_info_3/code.html` - Step 1: Basic Info
- `travely-design/create_trip_flow_-_basic_info_1/code.html` - Step 3: Preferences
- `travely-design/trip_settings/code.html` - Trip settings

## 1. Database Setup
- [x] 1.1 Create `trips` table in Supabase:
  ```sql
  create table trips (
    id uuid primary key default gen_random_uuid(),
    name text not null,
    cover_image_url text,
    start_date date not null,
    end_date date not null,
    default_currency text default 'USD',
    overall_budget decimal(12,2),
    daily_limit decimal(12,2),
    travel_pace text check (travel_pace in ('relaxed', 'balanced', 'packed')),
    status text default 'planning' check (status in ('planning', 'confirmed', 'completed', 'archived')),
    created_by uuid references auth.users not null,
    created_at timestamptz default now(),
    updated_at timestamptz default now()
  );
  ```
- [x] 1.2 Create `trip_destinations` table:
  ```sql
  create table trip_destinations (
    id uuid primary key default gen_random_uuid(),
    trip_id uuid references trips on delete cascade,
    name text not null,
    country text,
    order_index integer default 0
  );
  ```
- [x] 1.3 Enable RLS on trips table
- [x] 1.4 Create RLS policies for trips

## 2. Feature Structure
- [x] 2.1 Create `lib/features/trips/` directory
- [x] 2.2 Create `lib/features/trips/data/trip_repository.dart`
- [x] 2.3 Create `lib/features/trips/domain/models/trip_model.dart`
- [x] 2.4 Create `lib/features/trips/presentation/providers/trip_provider.dart`

## 3. Trip Repository
- [x] 3.1 Implement `createTrip(trip)` method
- [x] 3.2 Implement `getTrip(tripId)` method
- [x] 3.3 Implement `updateTrip(trip)` method
- [x] 3.4 Implement `deleteTrip(tripId)` method
- [x] 3.5 Implement `getUserTrips(userId)` method

## 4. Create Trip - Step 1: Basic Info
- [x] 4.1 Read `travely-design/create_trip_flow_-_basic_info_3/code.html`
- [x] 4.2 Create `lib/features/trips/presentation/screens/create_trip_step1_screen.dart`
- [x] 4.3 Add trip name input
- [x] 4.4 Add destination search/input
- [x] 4.5 Add date range picker (start & end date)
- [x] 4.6 Show popular destinations suggestions
- [x] 4.7 Add "Next" button to step 2

## 5. Create Trip - Step 2: Members (simplified)
- [x] 5.1 Read `travely-design/create_trip_flow_-_basic_info_2/code.html`
- [x] 5.2 Create `lib/features/trips/presentation/screens/create_trip_step2_screen.dart`
- [x] 5.3 Show current user as trip admin
- [x] 5.4 Add currency selector
- [x] 5.5 Add "Skip" option (add members later)
- [x] 5.6 Add "Next" button to step 3

## 6. Create Trip - Step 3: Preferences
- [x] 6.1 Read `travely-design/create_trip_flow_-_basic_info_1/code.html`
- [x] 6.2 Create `lib/features/trips/presentation/screens/create_trip_step3_screen.dart`
- [x] 6.3 Add overall budget input
- [x] 6.4 Add daily limit input
- [x] 6.5 Add travel pace selector (Relaxed/Balanced/Packed)
- [x] 6.6 Add "Create Trip" button

## 7. Trip Settings Screen
- [x] 7.1 Read `travely-design/trip_settings/code.html`
- [x] 7.2 Create `lib/features/trips/presentation/screens/trip_settings_screen.dart`
- [x] 7.3 Display/edit cover image
- [x] 7.4 Display/edit trip name
- [x] 7.5 Display/edit dates
- [x] 7.6 Display/edit currency
- [x] 7.7 Display/edit budget
- [x] 7.8 Add "Archive Trip" option

## 8. Navigation
- [x] 8.1 Add trip routes to router
- [x] 8.2 `/trips/create` - Create trip wizard
- [x] 8.3 `/trips/:id/settings` - Trip settings

## 9. Verification
- [x] 9.1 Run `flutter analyze` - no errors
- [x] 9.2 Test create trip flow - all 3 steps work
- [x] 9.3 Trip saved to Supabase correctly
- [x] 9.4 Test edit trip settings
- [x] 9.5 Run `openspec validate 007-add-trip-crud --strict`
