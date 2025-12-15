## ADDED Requirements

### Requirement: Trip Members
Trips SHALL support multiple members with roles.

#### Scenario: Creator is auto-added as admin
- **WHEN** user creates a trip
- **THEN** user SHALL be automatically added as member
- **AND** user role SHALL be 'admin'

#### Scenario: View trip members
- **WHEN** viewing trip members
- **THEN** all members SHALL be listed
- **AND** member roles SHALL be displayed
- **AND** member avatars SHALL be displayed

---

### Requirement: Invite Link
Admins SHALL be able to invite others via link.

#### Scenario: Generate invite link
- **WHEN** admin taps "Generate Invite Link"
- **THEN** unique invite code SHALL be generated
- **AND** shareable link SHALL be displayed
- **AND** link can be copied or shared

#### Scenario: Share invite link
- **WHEN** admin taps "Share"
- **THEN** native share sheet SHALL open
- **AND** invite link SHALL be pre-filled

---

### Requirement: Join Trip
Users SHALL be able to join a trip via invite link.

#### Scenario: Join via invite link
- **WHEN** user opens invite link
- **THEN** trip preview SHALL be shown
- **AND** "Join Trip" button SHALL be displayed

#### Scenario: Successfully join trip
- **WHEN** user taps "Join Trip"
- **THEN** user SHALL be added as member (role: 'member')
- **AND** user SHALL be redirected to trip detail

#### Scenario: Invalid invite link
- **WHEN** user opens expired or invalid invite link
- **THEN** error message SHALL be displayed

---

### Requirement: Manage Members
Admins SHALL be able to manage trip members.

#### Scenario: Remove member
- **WHEN** admin taps "Remove" on a member
- **THEN** confirmation SHALL be requested
- **WHEN** admin confirms
- **THEN** member SHALL be removed from trip

#### Scenario: Cannot remove self as last admin
- **WHEN** admin tries to remove themselves
- **AND** they are the only admin
- **THEN** error message SHALL be shown
