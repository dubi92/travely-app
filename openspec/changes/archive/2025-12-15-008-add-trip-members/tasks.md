# Implementation Tasks

**Design References:**
- `travely-design/create_trip_flow_-_basic_info_2/code.html` - Members UI
- `travely-design/trip_settings/code.html` - Manage members

## 1. Database Setup
- [x] 1.1 Create `trip_members` table:
  ```sql
  create table trip_members (
    id uuid primary key default gen_random_uuid(),
    trip_id uuid references trips on delete cascade,
    user_id uuid references auth.users,
    role text default 'member' check (role in ('admin', 'member')),
    joined_at timestamptz default now(),
    unique(trip_id, user_id)
  );
  ```
- [x] 1.2 Create `trip_invitations` table:
  ```sql
  create table trip_invitations (
    id uuid primary key default gen_random_uuid(),
    trip_id uuid references trips on delete cascade,
    invite_code text unique not null,
    created_by uuid references auth.users,
    expires_at timestamptz,
    created_at timestamptz default now()
  );
  ```
- [x] 1.3 Enable RLS on both tables
- [x] 1.4 Create RLS policies

## 2. Member Repository
- [x] 2.1 Create `lib/features/trips/data/member_repository.dart`
- [x] 2.2 Implement `addMember(tripId, userId, role)`
- [x] 2.3 Implement `removeMember(tripId, userId)`
- [x] 2.4 Implement `getTripMembers(tripId)`
- [x] 2.5 Implement `getMemberRole(tripId, userId)`

## 3. Invitation Repository
- [x] 3.1 Create `lib/features/trips/data/invitation_repository.dart`
- [x] 3.2 Implement `createInviteLink(tripId)` - generates unique code
- [x] 3.3 Implement `getInvitation(inviteCode)`
- [x] 3.4 Implement `acceptInvitation(inviteCode, userId)`
- [x] 3.5 Implement `deleteInvitation(inviteCode)`

## 4. Auto-Add Creator as Admin
- [x] 4.1 Update trip creation to auto-add creator as admin member
- [x] 4.2 Ensure creator cannot be removed from trip

## 5. Invite Link UI
- [x] 5.1 Create `lib/features/trips/presentation/widgets/invite_link_widget.dart`
- [x] 5.2 Display generated invite link
- [x] 5.3 Add "Copy Link" button
- [x] 5.4 Add "Share" button (native share sheet)

## 6. Manage Members Screen
- [x] 6.1 Create `lib/features/trips/presentation/screens/manage_members_screen.dart`
- [x] 6.2 Display list of current members
- [x] 6.3 Show member role (admin/member)
- [x] 6.4 Add "Remove" option for admins
- [x] 6.5 Add "Generate Invite Link" button

## 7. Join Trip Flow
- [x] 7.1 Handle deep link: `travely://join/:inviteCode`
- [x] 7.2 Show trip preview before joining
- [x] 7.3 Add user as member on accept
- [x] 7.4 Redirect to trip detail after joining

## 8. Update Trip Settings
- [x] 8.1 Add "Manage Members" button in trip settings
- [x] 8.2 Show member count/avatars preview

## 9. Verification
- [x] 9.1 Run `flutter analyze` - no errors
- [x] 9.2 Test invite link generation
- [x] 9.3 Test sharing invite link
- [x] 9.4 Test joining via invite link
- [x] 9.5 Test removing a member
- [x] 9.6 Run `openspec validate 008-add-trip-members --strict`
