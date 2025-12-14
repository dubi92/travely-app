# Travely - OpenSpec Proposal Breakdown

## Design Analysis Summary

Based on the UI designs in `travely-design/`, the app consists of:

| Screen Group | Screens | Key Features |
|-------------|---------|--------------|
| Onboarding | welcome, sign_up_login, permissions | Value proposition, Auth, Permissions |
| Profile | trips_list_1 (profile settings) | User info, preferences, logout |
| Trips | trips_list_1-3, create_trip_1-3, trip_settings | CRUD, members, wizard |
| Itinerary | itinerary_overview, map_view, add_edit_activity | Timeline, map, activities |
| Expenses | expenses_overview, add_expense_1-4 | Tracking, categories, split |
| Split | split_overview_1-2 | Settlements, balance |

---

## Naming Convention

All proposals follow this naming pattern:
```
{NNN}-{verb}-{subject}
```

- **NNN**: 3-digit sequence number (001, 002, 003...)
- **verb**: Action verb (add, update, remove, refactor)
- **subject**: Feature/capability name in kebab-case

Example: `001-add-project-foundation`, `005-add-auth-email`

---

## Phased Implementation Strategy

### Phase 0: Foundation (001-004)
Establishes project structure, design system, and backend connectivity.

### Phase 1: Authentication (005-007)
User signup, login, profile management.

### Phase 2: Trip Management (008-010)
Core trip CRUD and member management.

### Phase 3: Itinerary (011-013)
Activity scheduling and views.

### Phase 4: Expenses (014-016)
Expense tracking and splitting logic.

### Phase 5: Settlements (017-018)
Balance calculation and debt resolution.

---

## Proposal Catalog

### Phase 0: Foundation

| # | Proposal ID | Tasks | Status | Description |
|---|-------------|-------|--------|-------------|
| 001 | `001-add-project-foundation` | 37 | Ready | Flutter project, folders, dependencies |
| 002 | `002-add-design-tokens` | 33 | Ready | Colors, typography, spacing from designs |
| 003 | `003-add-core-components` | 47 | Ready | Reusable widgets matching designs |
| 004 | `004-add-supabase-setup` | 36 | Ready | Backend client, auth state, repositories |

**Total Phase 0 Tasks: 153**

---

### Phase 1: Authentication

| # | Proposal ID | Tasks | Status | Description |
|---|-------------|-------|--------|-------------|
| 005 | `005-add-auth-email` | ~25 | Planned | Email/password signup, login, reset |
| 006 | `006-add-auth-social` | ~15 | Planned | Google & Apple OAuth |
| 007 | `007-add-user-profile` | ~20 | Planned | Profile screen, preferences, logout |

---

### Phase 2: Trip Management

| # | Proposal ID | Tasks | Status | Description |
|---|-------------|-------|--------|-------------|
| 008 | `008-add-trip-crud` | ~30 | Planned | Create/edit trip, 3-step wizard |
| 009 | `009-add-trip-members` | ~25 | Planned | Invitations, roles, member list |
| 010 | `010-add-trip-list` | ~20 | Planned | Home screen, trip cards, filters |

---

### Phase 3: Itinerary

| # | Proposal ID | Tasks | Status | Description |
|---|-------------|-------|--------|-------------|
| 011 | `011-add-activity-crud` | ~30 | Planned | Activity form, categories, attachments |
| 012 | `012-add-itinerary-timeline` | ~25 | Planned | Day tabs, timeline view, status |
| 013 | `013-add-itinerary-map` | ~20 | Planned | Map view, markers, directions |

---

### Phase 4: Expenses

| # | Proposal ID | Tasks | Status | Description |
|---|-------------|-------|--------|-------------|
| 014 | `014-add-expense-crud` | ~30 | Planned | Expense form, categories, paid by |
| 015 | `015-add-expense-split` | ~25 | Planned | Split calculator, custom splits |
| 016 | `016-add-expense-overview` | ~25 | Planned | Analytics, charts, expense list |

---

### Phase 5: Settlements

| # | Proposal ID | Tasks | Status | Description |
|---|-------------|-------|--------|-------------|
| 017 | `017-add-settlement-tracking` | ~25 | Planned | Balance calc, debt simplification |
| 018 | `018-add-settlement-actions` | ~15 | Planned | Remind, mark as paid |

---

## Database Schema Overview

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   profiles  │     │    trips     │     │  activities │
│─────────────│     │──────────────│     │─────────────│
│ id (PK)     │     │ id (PK)      │     │ id (PK)     │
│ full_name   │     │ name         │     │ trip_id (FK)│
│ avatar_url  │     │ start_date   │     │ title       │
│ phone       │     │ end_date     │     │ category    │
│ currency    │     │ budget       │     │ start_time  │
│ alerts      │     │ created_by   │     │ location    │
└─────────────┘     └──────────────┘     └─────────────┘
       │                   │                    │
       │            ┌──────┴──────┐             │
       │            │             │             │
       ▼            ▼             ▼             │
┌─────────────┐  ┌──────────────┐              │
│trip_members │  │trip_invites  │              │
│─────────────│  │──────────────│              │
│ trip_id(FK) │  │ trip_id (FK) │              │
│ user_id(FK) │  │ invite_code  │              │
│ role        │  │ expires_at   │              │
└─────────────┘  └──────────────┘              │
                                               │
┌─────────────┐     ┌──────────────┐           │
│  expenses   │     │expense_splits│           │
│─────────────│     │──────────────│           │
│ id (PK)     │     │ expense_id(FK)│          │
│ trip_id(FK) │────▶│ user_id (FK) │           │
│ activity_id │◀────│ share_%      │           │
│ amount      │     │ share_amount │           │
│ paid_by(FK) │     │ is_settled   │           │
│ category    │     └──────────────┘           │
└─────────────┘                                │
       │                                       │
       └───────────────────────────────────────┘

┌─────────────┐
│ settlements │
│─────────────│
│ trip_id(FK) │
│ from_user   │
│ to_user     │
│ amount      │
│ status      │
└─────────────┘
```

---

## Implementation Order

```
Phase 0: Foundation
├── 001-add-project-foundation    ← START HERE
├── 002-add-design-tokens
├── 003-add-core-components
└── 004-add-supabase-setup

Phase 1: Authentication
├── 005-add-auth-email
├── 006-add-auth-social
└── 007-add-user-profile

Phase 2: Trip Management
├── 008-add-trip-crud
├── 009-add-trip-members
└── 010-add-trip-list

Phase 3: Itinerary
├── 011-add-activity-crud
├── 012-add-itinerary-timeline
└── 013-add-itinerary-map

Phase 4: Expenses
├── 014-add-expense-crud
├── 015-add-expense-split
└── 016-add-expense-overview

Phase 5: Settlements
├── 017-add-settlement-tracking
└── 018-add-settlement-actions
```

---

## Free Tier Considerations

### Supabase Optimizations
1. **Indexes**: Add indexes on frequently queried columns
2. **RLS Policies**: Row Level Security for data isolation
3. **Batch Operations**: Use bulk inserts/updates
4. **Storage**: Compress images, use thumbnails
5. **Realtime**: Subscribe only to necessary tables

### App Optimizations
1. **Caching**: Local storage for offline viewing
2. **Lazy Loading**: Paginate lists (20 items/page)
3. **Image Optimization**: cached_network_image
4. **Offline Support**: Queue writes, sync on reconnect

---

## How to Use

### View a proposal
```bash
openspec show 001-add-project-foundation
```

### Implement a proposal (tell AI)
```
Apply proposal 001-add-project-foundation following the tasks.md checklist.
Read each design reference before implementing UI.
```

### After implementation
```bash
openspec archive 001-add-project-foundation --yes
```

---

## Next Steps

1. Review Phase 0 proposals (001-004)
2. Approve and implement in order
3. After Phase 0, create Phase 1 proposals (005-007)
