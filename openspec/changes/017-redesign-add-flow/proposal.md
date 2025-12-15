# Proposal: OpenSpec 017 - Redesign Add Activity Flow

## Goal
Improve the "Add Activity" user experience by presenting a visual category selection menu immediately upon tapping the "+" button, rather than defaulting to a generic form.

## Changes
### UI Components
- **[NEW] `FloatingActionMenu` / `CategoryPickerSheet`**:
    - A BottomSheet or Modal that displays `ActivityCategory` options as a grid of "bubbles" (circular icons with labels).
    - Triggered by the FAB in `ItineraryScreen`.
    - Tapping a bubble navigates to `AddActivityScreen` with that category pre-selected.

- **[MODIFY] `AddActivityScreen`**:
    - Accept optional `initialCategory` in constructor.
    - If provided, initialize `ActivityForm` with this category.
    - (Optional) Lock the category selector if a category is enforced.

- **[MODIFY] `ActivityForm`**:
    - Add `isCategoryLocked` flag (optional) to prevent switching if desired, or just rely on pre-filling.
    - Initializing with a category should default to that sub-form immediately.

## Design
- **Bubbles**: Circular containers using category emoji/icon and label below.
- **Animation**: Smooth entrance for the bottom sheet.
