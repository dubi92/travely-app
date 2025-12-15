# Proposal: Redesign Activity Form

## Goal
Redesign the Activity Form to support category-specific fields (e.g., flight details for transport, menu items for food) and adopt a richer, more playful visual style as per the provided design references.

## Changes
1.  **Database**: Add `metadata` JSONB column to `activities` table to store unstructured category-specific data.
2.  **Domain**: Update `Activity` model to include `metadata`.
3.  **UI**:
    -   Refactor `ActivityForm` to be a shell that dynamically loads sub-forms.
    -   Create `TransportForm` for flight/train/bus details.
    -   Create `FoodForm` for restaurant/meal details.
    -   Create `GenericForm` for other categories.
    -   Implement "Foodie Find" and "Journey" visual styles.
