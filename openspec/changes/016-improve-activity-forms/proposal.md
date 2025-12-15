# Proposal: OpenSpec 016 - Improve Activity Forms

## Goal
Improve the user experience of `FoodForm` and ensure data integrity in Edit mode.

## Changes
### UI Components
- **[NEW] `LocationInputField`**: A specialized text field for location input with a "Map" action button.
- **`FoodForm`**:
    - Add `LocationInputField` for the `location` field.
    - Add `TimePicker` (Start/End or Duration) integration.
    - Fix state initialization to ensure saved data is displayed.
- **`TransportForm`**:
    - Ensure consistency with new inputs.

## Technical Details
- Refactor `FoodForm` to accept `onLocationChanged`, `onTimeChanged` callbacks or similar, effectively managing the `Activity` level fields that were hidden.
- Ensure `FoodForm` updates its controllers if the parent widget passes new data (implement `didUpdateWidget` if necessary, though `ActivityForm` state preservation usually suffices).
