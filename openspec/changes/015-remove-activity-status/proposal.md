# Proposal: Remove Activity Status

## Goal
Remove the "status" field (Planned, Booked, Done) from activities to simplify the model and UI, as requested by the user.

## Changes
1.  **Database**: Remove `status` column from `activities` table.
2.  **Domain**: Remove `status` field from `Activity` model and `ActivityStatus` enum.
3.  **UI**:
    -   Remove `StatusSelector` from `ActivityForm`.
    -   Delete `status_selector.dart`.
