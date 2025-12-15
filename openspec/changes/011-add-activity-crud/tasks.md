# Tasks: 011-add-activity-crud

## 1. Database Schema
- [x] 1.1 Create `activities` table: id, trip_id, title, description, location, start_time, end_time, category, status, price, currency, image_url, is_paid, created_by, created_at, updated_at
- [x] 1.2 Create `activity_participants` table: activity_id, user_id, status
- [x] 1.3 Add foreign key constraints (trip_id → trips, created_by → users)
- [x] 1.4 Add indexes on trip_id and start_time

## 2. RLS Policies
- [x] 2.1 Enable RLS on activities table
- [x] 2.2 Create SELECT policy: trip members can view
- [x] 2.3 Create INSERT policy: trip members can create
- [x] 2.4 Create UPDATE policy: creator or trip admin can update
- [x] 2.5 Create DELETE policy: creator or trip admin can delete
- [x] 2.6 Set up RLS for activity_participants

## 3. Enums
- [x] 3.1 Create ActivityStatus enum: planned, booked, done
- [x] 3.2 Create ActivityCategory enum: food, sightseeing, accommodation, transport, shopping, other
- [x] 3.3 Add emoji mapping for categories
- [x] 3.4 Add color mapping for statuses

## 4. Activity Model
- [x] 4.1 Create Activity class with all fields
- [x] 4.2 Add fromJson/toJson methods
- [x] 4.3 Add copyWith method
- [x] 4.4 Add computed properties (duration, dayOfTrip)

## 5. Activity Repository
- [x] 5.1 Create ActivityRepository class
- [x] 5.2 Implement getActivitiesByTrip(tripId)
- [x] 5.3 Implement getActivitiesByDay(tripId, date)
- [x] 5.4 Implement createActivity(activity)
- [x] 5.5 Implement updateActivity(activity)
- [x] 5.6 Implement deleteActivity(activityId)
- [x] 5.7 Implement updateActivityStatus(activityId, status)

## 6. Testing
- [x] 6.1 Unit tests for Activity model
- [x] 6.2 Unit tests for ActivityRepository
- [x] 6.3 Test RLS policies work correctly
