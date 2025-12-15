# Tasks: 014-redesign-activity-form

## 1. Database & Model
- [x] 1.1 Add `metadata` column to `activities` table (schema.sql)
- [x] 1.2 Update `Activity` model with `metadata` field
- [x] 1.3 Update `Activity.fromJson` and `Activity.toJson`
- [x] 1.4 Update `ActivitiesProvider` to handle new field (if needed)

## 2. Form Architecture
- [x] 2.1 Create `ActivityFormShell` (wraps title, category, status)
- [x] 2.2 Refactor `ActivityForm` to use the shell and switch content
- [x] 2.3 Create `BaseActivityForm` mixin/class for sub-forms

## 3. Transport Form
- [x] 3.1 Create `TransportForm` widget
- [x] 3.2 Implement "Getting There" header style
- [x] 3.3 Add Transport Type selector (Walk/Bus/Train/Taxi)
- [x] 3.4 Add From/To location fields
- [x] 3.5 Add Departure/Arrival time pickers
- [x] 3.6 Save/Load data to `metadata`

## 4. Food Form
- [x] 4.1 Create `FoodForm` widget
- [x] 4.2 Implement "Yummy Adventures" header style
- [x] 4.3 Add Meal Type chips (Breakfast/Lunch/Dinner)
- [x] 4.4 Add Wait Time quick buttons
- [x] 4.5 Add Price Range selector
- [x] 4.6 Add "Must-Orders" list input
- [x] 4.7 Save/Load data to `metadata`

## 5. Integration
- [x] 5.1 Connect new forms to `AddActivityScreen`
- [x] 5.2 Connect new forms to `EditActivityScreen`
- [x] 5.3 Verify data persistence
