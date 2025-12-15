# Tasks: 013-add-activity-form

## 1. Activity Form Widget
- [x] 1.1 Create ActivityForm widget (shared between add/edit)
- [x] 1.2 Add title input field
- [x] 1.3 Add description input field (optional)
- [x] 1.4 Add location input field
- [x] 1.5 Add date picker
- [x] 1.6 Add start time picker
- [x] 1.7 Add end time picker (optional)
- [x] 1.8 Add price input with currency selector
- [x] 1.9 Add notes/description field

## 2. Category Selector
- [x] 2.1 Create CategorySelector widget
- [x] 2.2 Display category options with emoji icons
- [x] 2.3 Highlight selected category
- [x] 2.4 Support horizontal scrollable layout

## 3. Status Selector
- [x] 3.1 Create StatusSelector widget
- [x] 3.2 Display status options (Planned, Booked, Done)
- [x] 3.3 Show status colors and emoji
- [x] 3.4 Support chip-style selection

## 4. Add Activity Screen
- [x] 4.1 Create AddActivityScreen
- [x] 4.2 Set default date to selected day from itinerary
- [x] 4.3 Set default status to "Planned"
- [x] 4.4 Implement form validation
- [x] 4.5 Handle form submission (create activity)
- [x] 4.6 Navigate back to itinerary on success

## 5. Edit Activity Screen
- [x] 5.1 Create EditActivityScreen
- [x] 5.2 Pre-fill form with existing activity data
- [x] 5.3 Handle form submission (update activity)
- [x] 5.4 Add delete button in app bar
- [x] 5.5 Navigate back to itinerary on success

## 6. Delete Activity
- [x] 6.1 Create delete confirmation dialog
- [x] 6.2 Show activity title in confirmation
- [x] 6.3 Handle delete action
- [x] 6.4 Navigate back to itinerary on success

## 7. Form Validation
- [x] 7.1 Validate title is required
- [x] 7.2 Validate date is within trip dates
- [x] 7.3 Validate end time is after start time (if set)
- [x] 7.4 Show validation errors inline

## 8. Navigation
- [x] 8.1 Navigate to AddActivityScreen from FAB
- [x] 8.2 Navigate to EditActivityScreen from activity card tap
- [x] 8.3 Pass selected day to add screen
- [x] 8.4 Pass activity data to edit screen

## 9. Testing
- [x] 9.1 Widget tests for ActivityForm
- [x] 9.2 Widget tests for CategorySelector
- [x] 9.3 Integration test for add activity flow
- [x] 9.4 Integration test for edit activity flow
