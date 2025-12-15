# Tasks: 013-add-activity-form

## 1. Activity Form Widget
- [ ] 1.1 Create ActivityForm widget (shared between add/edit)
- [ ] 1.2 Add title input field
- [ ] 1.3 Add description input field (optional)
- [ ] 1.4 Add location input field
- [ ] 1.5 Add date picker
- [ ] 1.6 Add start time picker
- [ ] 1.7 Add end time picker (optional)
- [ ] 1.8 Add price input with currency selector
- [ ] 1.9 Add notes/description field

## 2. Category Selector
- [ ] 2.1 Create CategorySelector widget
- [ ] 2.2 Display category options with emoji icons
- [ ] 2.3 Highlight selected category
- [ ] 2.4 Support horizontal scrollable layout

## 3. Status Selector
- [ ] 3.1 Create StatusSelector widget
- [ ] 3.2 Display status options (Planned, Booked, Done)
- [ ] 3.3 Show status colors and emoji
- [ ] 3.4 Support chip-style selection

## 4. Add Activity Screen
- [ ] 4.1 Create AddActivityScreen
- [ ] 4.2 Set default date to selected day from itinerary
- [ ] 4.3 Set default status to "Planned"
- [ ] 4.4 Implement form validation
- [ ] 4.5 Handle form submission (create activity)
- [ ] 4.6 Navigate back to itinerary on success

## 5. Edit Activity Screen
- [ ] 5.1 Create EditActivityScreen
- [ ] 5.2 Pre-fill form with existing activity data
- [ ] 5.3 Handle form submission (update activity)
- [ ] 5.4 Add delete button in app bar
- [ ] 5.5 Navigate back to itinerary on success

## 6. Delete Activity
- [ ] 6.1 Create delete confirmation dialog
- [ ] 6.2 Show activity title in confirmation
- [ ] 6.3 Handle delete action
- [ ] 6.4 Navigate back to itinerary on success

## 7. Form Validation
- [ ] 7.1 Validate title is required
- [ ] 7.2 Validate date is within trip dates
- [ ] 7.3 Validate end time is after start time (if set)
- [ ] 7.4 Show validation errors inline

## 8. Navigation
- [ ] 8.1 Navigate to AddActivityScreen from FAB
- [ ] 8.2 Navigate to EditActivityScreen from activity card tap
- [ ] 8.3 Pass selected day to add screen
- [ ] 8.4 Pass activity data to edit screen

## 9. Testing
- [ ] 9.1 Widget tests for ActivityForm
- [ ] 9.2 Widget tests for CategorySelector
- [ ] 9.3 Integration test for add activity flow
- [ ] 9.4 Integration test for edit activity flow
