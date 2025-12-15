## ADDED Requirements

### Requirement: Activities Database
Activity data SHALL be stored in Supabase.

#### Scenario: Activity record structure
- **WHEN** activity is created
- **THEN** record SHALL include: id (uuid), trip_id, title, description, location
- **AND** record SHALL include: start_time, end_time, category, status
- **AND** record SHALL include: price, currency, image_url, is_paid
- **AND** record SHALL include: created_by, created_at, updated_at

#### Scenario: Activity foreign keys enforced
- **WHEN** activity references trip_id
- **THEN** trip_id MUST exist in trips table
- **AND** deleting trip SHALL cascade delete activities

---

### Requirement: Activity Participants
Activities SHALL support tracking participants.

#### Scenario: Participant record structure
- **WHEN** participant is added to activity
- **THEN** junction record SHALL link activity_id to user_id
- **AND** participant status SHALL be tracked

#### Scenario: Participant cascade delete
- **WHEN** activity is deleted
- **THEN** participant records SHALL be deleted

---

### Requirement: Activity Access Control
Activities SHALL enforce row-level security.

#### Scenario: Trip members can view activities
- **WHEN** user is a member of the trip
- **THEN** user SHALL be able to view all trip activities

#### Scenario: Trip members can create activities
- **WHEN** user is a member of the trip
- **THEN** user SHALL be able to create activities

#### Scenario: Activity owner can modify
- **WHEN** user created the activity
- **THEN** user SHALL be able to update and delete the activity

#### Scenario: Trip admin can modify any activity
- **WHEN** user is trip admin
- **THEN** user SHALL be able to update and delete any trip activity

---

### Requirement: Activity Status
Activities SHALL have a status indicating progress.

#### Scenario: Status values defined
- **WHEN** setting activity status
- **THEN** status SHALL be one of: planned, booked, done

#### Scenario: Default status is planned
- **WHEN** activity is created without status
- **THEN** status SHALL default to planned

---

### Requirement: Activity Categories
Activities SHALL be categorized by type.

#### Scenario: Category values defined
- **WHEN** setting activity category
- **THEN** category SHALL be one of: food, sightseeing, accommodation, transport, shopping, other

#### Scenario: Category has emoji icon
- **WHEN** displaying category
- **THEN** category SHALL have associated emoji icon

---

### Requirement: Activity Model
The app SHALL provide an Activity model class.

#### Scenario: Activity model created from JSON
- **WHEN** parsing activity from Supabase response
- **THEN** Activity instance SHALL be created with all fields

#### Scenario: Activity model serialized to JSON
- **WHEN** sending activity to Supabase
- **THEN** Activity instance SHALL serialize to JSON map

---

### Requirement: Activity Repository
The app SHALL provide repository for activity operations.

#### Scenario: Fetch activities by trip
- **WHEN** calling getActivitiesByTrip(tripId)
- **THEN** all activities for that trip SHALL be returned
- **AND** activities SHALL be sorted by start_time

#### Scenario: Fetch activities by day
- **WHEN** calling getActivitiesByDay(tripId, date)
- **THEN** activities for that specific day SHALL be returned

#### Scenario: Create activity
- **WHEN** calling createActivity(activity)
- **THEN** activity SHALL be inserted into database
- **AND** created activity SHALL be returned

#### Scenario: Update activity
- **WHEN** calling updateActivity(activity)
- **THEN** activity SHALL be updated in database
- **AND** updated_at SHALL be set to current time

#### Scenario: Delete activity
- **WHEN** calling deleteActivity(activityId)
- **THEN** activity SHALL be removed from database
