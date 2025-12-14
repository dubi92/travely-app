# Change: Configure Supabase Backend Integration

## Why
Travely uses Supabase for authentication, database, storage, and realtime features. This proposal sets up the Supabase client, creates the base repository pattern, and establishes error handling for backend operations.

## What Changes
- Configure Supabase client initialization
- Create base repository class for data access
- Setup auth state listener and session management
- Create error handling utilities for Supabase operations
- Add network connectivity checking

## Impact
- Affected specs: `supabase-integration` (new)
- Affected code: `lib/shared/services/`, `lib/core/errors/`
- Dependencies: `001-add-project-foundation` must be completed first
- Blocks: All feature proposals that need backend (auth, trips, expenses)

## Supabase Free Tier Awareness
This setup optimizes for free tier limits:
- Database: 500MB (use efficient queries, pagination)
- Auth: 50,000 MAU (sufficient for testing)
- Storage: 1GB (compress images before upload)
- Realtime: 200 connections (selective subscriptions)

## Deliverables
1. `lib/shared/services/supabase_service.dart` - Client initialization
2. `lib/shared/services/base_repository.dart` - Repository pattern base
3. `lib/core/errors/supabase_exception.dart` - Error handling
4. `lib/core/utils/network_utils.dart` - Connectivity checking
5. Updated `.env.example` with Supabase variables
