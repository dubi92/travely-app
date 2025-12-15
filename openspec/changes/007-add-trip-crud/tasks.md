# Implementation Tasks

**Design References:**
- `travely-design/create_trip_flow_-_basic_info_3/code.html` - Step 1: Basic Info
- `travely-design/create_trip_flow_-_basic_info_1/code.html` - Step 3: Preferences
- `travely-design/trip_settings/code.html` - Trip settings

## 1. Database Setup
- [ ] 1.1 Create `trips` table in Supabase:
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
- [ ] 1.2 Create `trip_destinations` table:
  ```sql
  create table trip_destinations (
    id uuid primary key default gen_random_uuid(),
    trip_id uuid references trips on delete cascade,
    name text not null,
    country text,
    order_index integer default 0
  );
  ```
- [ ] 1.3 Enable RLS on trips table
- [ ] 1.4 Create RLS policies for trips

## 2. Feature Structure
- [ ] 2.1 Create `lib/features/trips/` directory
- [ ] 2.2 Create `lib/features/trips/data/trip_repository.dart`
- [ ] 2.3 Create `lib/features/trips/domain/models/trip_model.dart`
- [ ] 2.4 Create `lib/features/trips/presentation/providers/trip_provider.dart`

## 3. Trip Repository
- [ ] 3.1 Implement `createTrip(trip)` method
- [ ] 3.2 Implement `getTrip(tripId)` method
- [ ] 3.3 Implement `updateTrip(trip)` method
- [ ] 3.4 Implement `deleteTrip(tripId)` method
- [ ] 3.5 Implement `getUserTrips(userId)` method

## 4. Create Trip - Step 1: Basic Info
- [ ] 4.1 Read `travely-design/create_trip_flow_-_basic_info_3/code.html`
- [ ] 4.2 Create `lib/features/trips/presentation/screens/create_trip_step1_screen.dart`
- [ ] 4.3 Add trip name input
- [ ] 4.4 Add destination search/input
- [ ] 4.5 Add date range picker (start & end date)
- [ ] 4.6 Show popular destinations suggestions
- [ ] 4.7 Add "Next" button to step 2

## 5. Create Trip - Step 2: Members (simplified)
- [ ] 5.1 Read `travely-design/create_trip_flow_-_basic_info_2/code.html`
- [ ] 5.2 Create `lib/features/trips/presentation/screens/create_trip_step2_screen.dart`
- [ ] 5.3 Show current user as trip admin
- [ ] 5.4 Add currency selector
- [ ] 5.5 Add "Skip" option (add members later)
- [ ] 5.6 Add "Next" button to step 3

## 6. Create Trip - Step 3: Preferences
- [ ] 6.1 Read `travely-design/create_trip_flow_-_basic_info_1/code.html`
- [ ] 6.2 Create `lib/features/trips/presentation/screens/create_trip_step3_screen.dart`
- [ ] 6.3 Add overall budget input
- [ ] 6.4 Add daily limit input
- [ ] 6.5 Add travel pace selector (Relaxed/Balanced/Packed)
- [ ] 6.6 Add "Create Trip" button

## 7. Trip Settings Screen
- [ ] 7.1 Read `travely-design/trip_settings/code.html`
- [ ] 7.2 Create `lib/features/trips/presentation/screens/trip_settings_screen.dart`
- [ ] 7.3 Display/edit cover image
- [ ] 7.4 Display/edit trip name
- [ ] 7.5 Display/edit dates
- [ ] 7.6 Display/edit currency
- [ ] 7.7 Display/edit budget
- [ ] 7.8 Add "Archive Trip" option

## 8. Navigation
- [ ] 8.1 Add trip routes to router
- [ ] 8.2 `/trips/create` - Create trip wizard
- [ ] 8.3 `/trips/:id/settings` - Trip settings

## 9. Verification
- [ ] 9.1 Run `flutter analyze` - no errors
- [ ] 9.2 Test create trip flow - all 3 steps work
- [ ] 9.3 Trip saved to Supabase correctly
- [ ] 9.4 Test edit trip settings
- [ ] 9.5 Run `openspec validate 007-add-trip-crud --strict`
