# Implementation Tasks

**Design Reference:** `travely-design/trips_list_3/code.html`

## 1. Home Screen
- [ ] 1.1 Read `travely-design/trips_list_3/code.html` for layout
- [ ] 1.2 Create `lib/features/trips/presentation/screens/home_screen.dart`
- [ ] 1.3 Add greeting header ("Good morning, {name}")
- [ ] 1.4 Add user avatar (tap → profile)
- [ ] 1.5 Add "Upcoming Trips" section
- [ ] 1.6 Add "Past Trips" section (collapsible)
- [ ] 1.7 Add FAB "+" to create new trip

## 2. Trip Card Widget
- [ ] 2.1 Create `lib/features/trips/presentation/widgets/trip_card.dart`
- [ ] 2.2 Display cover image (or placeholder)
- [ ] 2.3 Display trip name
- [ ] 2.4 Display date range
- [ ] 2.5 Display status badge (Planning/Confirmed)
- [ ] 2.6 Display member avatars (AvatarStack)
- [ ] 2.7 Navigate to trip detail on tap

## 3. Trips Provider
- [ ] 3.1 Create `lib/features/trips/presentation/providers/trips_list_provider.dart`
- [ ] 3.2 Fetch user's trips from repository
- [ ] 3.3 Separate into upcoming vs past trips
- [ ] 3.4 Handle loading and error states

## 4. Empty State
- [ ] 4.1 Create empty state for no trips
- [ ] 4.2 Show illustration/icon
- [ ] 4.3 Show "No trips yet" message
- [ ] 4.4 Show "Create your first trip" CTA

## 5. Pull to Refresh
- [ ] 5.1 Add RefreshIndicator
- [ ] 5.2 Refresh trips list on pull

## 6. Trip Detail Shell
- [ ] 6.1 Create `lib/features/trips/presentation/screens/trip_detail_screen.dart`
- [ ] 6.2 Add bottom navigation (Itinerary, Expenses, Split, Settings)
- [ ] 6.3 Show trip name in app bar
- [ ] 6.4 Placeholder content for tabs (Phase 3-5)

## 7. Navigation
- [ ] 7.1 Set home screen as default route after auth
- [ ] 7.2 Add `/trips/:id` route for trip detail
- [ ] 7.3 FAB navigates to `/trips/create`

## 8. Verification
- [ ] 8.1 Run `flutter analyze` - no errors
- [ ] 8.2 Home screen shows after sign-in
- [ ] 8.3 Trips list displays correctly
- [ ] 8.4 Empty state shows when no trips
- [ ] 8.5 Trip card tap → trip detail
- [ ] 8.6 FAB tap → create trip wizard
- [ ] 8.7 Run `openspec validate 009-add-trip-list --strict`
