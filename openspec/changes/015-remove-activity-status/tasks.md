# Tasks: 015-remove-activity-status

## 1. Database & Model
- [x] 1.1 Remove `status` column from `activities` table (schema.sql)
- [x] 1.2 Remove `status` field from `Activity` model
- [x] 1.3 Remove `ActivityStatus` enum

## 2. UI Updates
- [x] 2.1 Remove `StatusSelector` from `ActivityForm`
- [x] 2.2 Update `_handleSubmit` in `ActivityForm` to stop sending `status`
- [x] 2.3 Delete `status_selector.dart`

## 3. Integration
- [x] 3.1 Verify activities can be created/edited without status
