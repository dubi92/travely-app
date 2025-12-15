# Implementation Tasks

**Design Reference:** `travely-design/trips_list_3/code.html`

## 1. Home Screen
- [x] 1.1 Read `travely-design/trips_list_3/code.html` for layout
- [x] 1.2 Create `lib/features/trips/presentation/screens/home_screen.dart`
- [x] 1.3 Add greeting header ("Good morning, {name}")
- [x] 1.4 Add user avatar (tap → profile)
- [x] 1.5 Add "Upcoming Trips" section
- [x] 1.6 Add "Past Trips" section (collapsible)
- [x] 1.7 Add FAB "+" to create new trip

## 2. Trip Card Widget
- [x] 2.1 Create `lib/features/trips/presentation/widgets/trip_card.dart`
- [x] 2.2 Display cover image (or placeholder)
- [x] 2.3 Display trip name
- [x] 2.4 Display date range
- [x] 2.5 Display status badge (Planning/Confirmed)
- [x] 2.6 Display member avatars (AvatarStack)
- [x] 2.7 Navigate to trip detail on tap

## 3. Trips Provider
- [x] 3.1 Create `lib/features/trips/presentation/providers/trips_list_provider.dart`
  - *(Note: Reused and enhanced `trip_provider.dart` -> `userTripsProvider`)*
- [x] 3.2 Fetch user's trips from repository
- [x] 3.3 Separate into upcoming vs past trips
  - *(Handled in UI logic)*
- [x] 3.4 Handle loading and error states

## 4. Empty State
- [x] 4.1 Create empty state for no trips
- [x] 4.2 Show illustration/icon
- [x] 4.3 Show "No trips yet" message
- [x] 4.4 Show "Create your first trip" CTA

## 5. Pull to Refresh
- [x] 5.1 Add RefreshIndicator
- [x] 5.2 Refresh trips list on pull

## 6. Trip Detail Shell
- [x] 6.1 Create `lib/features/trips/presentation/screens/trip_detail_screen.dart`
- [x] 6.2 Add bottom navigation (Itinerary, Expenses, Split, Settings)
- [x] 6.3 Show trip name in app bar
- [x] 6.4 Placeholder content for tabs (Phase 3-5)

## 7. Navigation
- [x] 7.1 Set home screen as default route after auth
- [x] 7.2 Add `/trips/:id` route for trip detail
- [x] 7.3 FAB navigates to `/trips/create`

## 8. Verification
- [x] 8.1 Run `flutter analyze` - no errors
- [x] 8.2 Home screen shows after sign-in
- [x] 8.3 Trips list displays correctly
- [x] 8.4 Empty state shows when no trips
- [x] 8.5 Trip card tap → trip detail
- [x] 8.6 FAB tap → create trip wizard
- [x] 8.7 Run `openspec validate 009-add-trip-list --strict`
