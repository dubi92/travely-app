# OpenSpec 012: Add Itinerary Screen

- [x] 1. New Screens
    - [x] 1.1 Create `lib/features/itinerary/presentation/screens/itinerary_screen.dart`
    - [x] 1.2 Implement `Scaffold` with `DecorativeBackground`
    - [x] 1.3 Add custom header with trip title, dates, and `FloatingMascot`
    - [x] 1.4 Integrate `DayTabs` for day navigation

- [x] 2. Timeline Components
    - [x] 2.1 Create `lib/features/itinerary/presentation/widgets/timeline_view.dart`
    - [x] 2.2 Implement vertical gradient connector line
    - [x] 2.3 Create `TimeIndicator` widget
    - [x] 2.4 Create `ActivityCard` widget using `GlassmorphismCard`
    - [x] 2.5 Implement `ItineraryEmptyState` widget

- [x] 3. Logic & State
    - [x] 3.1 Create `ActivitiesProvider` (Riverpod)
    - [x] 3.2 Implement fetching activities by trip ID
    - [x] 3.3 Implement filtering by day index
    - [x] 3.4 Integrate provider into `ItineraryScreen`

- [x] 4. Integration
    - [x] 4.1 Update `TripDetailScreen` to show `ItineraryScreen`
    - [x] 4.2 Connect navigation (FAB exists, action is placeholder)

- [x] 5. Verification
    - [x] 5.1 Widget tests for activity card
    - [x] 5.2 Widget tests for timeline view
    - [x] 5.3 Verify integration
