## ADDED Requirements

### Requirement: Supabase Client Initialization
The app SHALL initialize Supabase client on startup.

#### Scenario: Supabase initializes successfully
- **WHEN** the app starts
- **THEN** Supabase client SHALL be initialized with URL and anon key
- **AND** client SHALL be available as singleton throughout app

#### Scenario: Initialization failure is handled
- **WHEN** Supabase initialization fails
- **THEN** appropriate error SHALL be logged
- **AND** user SHALL see error message (not crash)

---

### Requirement: Auth State Management
The app SHALL track authentication state changes.

#### Scenario: Auth state changes are detected
- **WHEN** user signs in or signs out
- **THEN** auth state stream SHALL emit new state
- **AND** UI SHALL react to state changes

#### Scenario: Session is persisted
- **WHEN** app restarts with valid session
- **THEN** user SHALL remain signed in
- **AND** session refresh SHALL happen automatically

---

### Requirement: Base Repository Pattern
The app SHALL use repository pattern for data access.

#### Scenario: Repository provides CRUD operations
- **WHEN** accessing database tables
- **THEN** base repository SHALL provide create, read, update, delete methods
- **AND** methods SHALL handle errors consistently

#### Scenario: Pagination is supported
- **WHEN** fetching large datasets
- **THEN** repository SHALL support offset/limit pagination
- **AND** default page size SHALL be reasonable (20 items)

---

### Requirement: Error Handling
The app SHALL handle Supabase errors gracefully.

#### Scenario: Database errors are caught
- **WHEN** database operation fails
- **THEN** error SHALL be wrapped in typed exception
- **AND** user-friendly message SHALL be available

#### Scenario: Auth errors are caught
- **WHEN** authentication operation fails
- **THEN** specific auth error type SHALL be identified
- **AND** appropriate action SHALL be suggested to user

#### Scenario: Network errors are handled
- **WHEN** network is unavailable
- **THEN** user SHALL be informed of connectivity issue
- **AND** retry option SHALL be available where appropriate

---

### Requirement: Environment Security
Supabase credentials SHALL be handled securely.

#### Scenario: Credentials are not in source code
- **WHEN** reviewing source code
- **THEN** Supabase URL and keys SHALL NOT be hardcoded
- **AND** values SHALL come from environment variables

#### Scenario: Environment template exists
- **WHEN** setting up development environment
- **THEN** `.env.example` SHALL list required Supabase variables
- **AND** actual `.env` SHALL be in `.gitignore`
