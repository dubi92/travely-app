# Project Context

## Purpose
Travely is a mobile travel planning app that helps groups plan trips together and split expenses effortlessly. The app focuses on collaborative itinerary planning, expense tracking, and fair cost splitting among travel companions.

## Tech Stack
- **Mobile Framework**: Flutter (Dart)
- **Backend**: Supabase (PostgreSQL, Auth, Storage, Realtime)
- **State Management**: Riverpod or Provider (TBD)
- **Maps**: Google Maps or Mapbox (TBD)
- **Deployment**: Free tier for testing, scalable for production

## Project Conventions

### Code Style
- Follow Dart/Flutter style guide
- Use `snake_case` for file names
- Use `PascalCase` for classes, `camelCase` for variables/functions
- Maximum 80 characters per line
- Organize imports: dart, flutter, packages, project

### Architecture Patterns
- **Feature-first folder structure**: `/lib/features/{feature}/`
- **Repository pattern** for data access
- **Service layer** for business logic
- **Clean separation**: UI → State → Repository → Data Source
- **Reusable widgets** in `/lib/shared/widgets/`
- **Core utilities** in `/lib/core/`

### Folder Structure
```
lib/
├── core/
│   ├── config/          # App configuration, environment
│   ├── theme/           # Design system, colors, typography
│   ├── utils/           # Utilities, extensions, helpers
│   ├── constants/       # App-wide constants
│   └── errors/          # Error handling, exceptions
├── shared/
│   ├── widgets/         # Reusable UI components
│   ├── models/          # Shared data models
│   └── services/        # Shared services (Supabase client)
├── features/
│   ├── auth/            # Authentication feature
│   ├── onboarding/      # Welcome & permissions
│   ├── trips/           # Trip management
│   ├── itinerary/       # Activities & timeline
│   ├── expenses/        # Expense tracking
│   ├── split/           # Cost splitting & settlements
│   └── profile/         # User profile & settings
└── main.dart
```

### Testing Strategy
- Unit tests for business logic and calculations
- Widget tests for UI components
- Integration tests for critical flows (auth, create trip, add expense)
- Minimum 70% code coverage for core features

### Git Workflow
- `main` branch for production-ready code
- `develop` branch for integration
- Feature branches: `feature/{change-id}`
- Commit format: `type(scope): description`
- Types: feat, fix, refactor, test, docs, chore

## Domain Context

### Key Entities
- **User**: App user with profile and preferences
- **Trip**: A travel plan with dates, destinations, members
- **TripMember**: User's role in a trip (admin/member)
- **Activity**: Scheduled item in an itinerary (flight, hotel, meal, etc.)
- **Expense**: A cost incurred during the trip
- **Split**: How an expense is divided among members
- **Settlement**: Debt resolution between members

### Business Rules
- Trip creator is automatically the admin
- Only admins can modify trip settings and invite members
- Expenses can be shared (split among members) or personal
- Split can be equal or custom (percentage/amount)
- Settlements simplify debts (A owes B, B owes C → A owes C)
- Budget tracking alerts when spending exceeds limits

### Expense Categories
- Food & Dining
- Transport
- Accommodation (Stay)
- Activities & Sightseeing
- Shopping
- Other

## Important Constraints

### Supabase Free Tier Limits
- Database: 500MB storage
- Auth: 50,000 monthly active users
- Storage: 1GB file storage
- Edge Functions: 500,000 invocations/month
- Realtime: 200 concurrent connections

### Design Constraints
- Mobile-first (iOS & Android)
- Offline-capable for viewing (online for sync)
- Support multiple currencies with conversion
- Privacy: User data encryption, GDPR-ready

### Performance Targets
- App cold start < 3 seconds
- Screen transitions < 300ms
- API responses < 500ms (95th percentile)

## External Dependencies

### Required Services
- **Supabase**: Auth, Database, Storage, Realtime
- **Maps Provider**: Google Maps API or Mapbox
- **Push Notifications**: Firebase Cloud Messaging (FCM)

### Optional Services (Future)
- Currency conversion API
- Places autocomplete API
- Receipt OCR service
