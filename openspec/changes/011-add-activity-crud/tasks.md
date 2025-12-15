# Tasks: 011-add-activity-crud

## 1. Database Schema
- [ ] 1.1 Create `activities` table: id, trip_id, title, description, location, start_time, end_time, category, status, price, currency, image_url, is_paid, created_by, created_at, updated_at
- [ ] 1.2 Create `activity_participants` table: activity_id, user_id, status
- [ ] 1.3 Add foreign key constraints (trip_id → trips, created_by → users)
- [ ] 1.4 Add indexes on trip_id and start_time

## 2. RLS Policies
- [ ] 2.1 Enable RLS on activities table
- [ ] 2.2 Create SELECT policy: trip members can view
- [ ] 2.3 Create INSERT policy: trip members can create
- [ ] 2.4 Create UPDATE policy: creator or trip admin can update
- [ ] 2.5 Create DELETE policy: creator or trip admin can delete
- [ ] 2.6 Set up RLS for activity_participants

## 3. Enums
- [ ] 3.1 Create ActivityStatus enum: planned, booked, done
- [ ] 3.2 Create ActivityCategory enum: food, sightseeing, accommodation, transport, shopping, other
- [ ] 3.3 Add emoji mapping for categories
- [ ] 3.4 Add color mapping for statuses

## 4. Activity Model
- [ ] 4.1 Create Activity class with all fields
- [ ] 4.2 Add fromJson/toJson methods
- [ ] 4.3 Add copyWith method
- [ ] 4.4 Add computed properties (duration, dayOfTrip)

## 5. Activity Repository
- [ ] 5.1 Create ActivityRepository class
- [ ] 5.2 Implement getActivitiesByTrip(tripId)
- [ ] 5.3 Implement getActivitiesByDay(tripId, date)
- [ ] 5.4 Implement createActivity(activity)
- [ ] 5.5 Implement updateActivity(activity)
- [ ] 5.6 Implement deleteActivity(activityId)
- [ ] 5.7 Implement updateActivityStatus(activityId, status)

## 6. Testing
- [ ] 6.1 Unit tests for Activity model
- [ ] 6.2 Unit tests for ActivityRepository
- [ ] 6.3 Test RLS policies work correctly
