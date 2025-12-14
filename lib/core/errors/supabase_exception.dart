import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/errors/app_exception.dart';

class SupabaseException extends AppException {
  const SupabaseException(
    String message, {
    String? code,
    dynamic details,
  }) : super(message, code: code, details: details);

  factory SupabaseException.fromAuthException(AuthException exception) {
    return SupabaseException(
      exception.message,
      code: exception.statusCode,
      details: exception.toString(),
    );
  }

  factory SupabaseException.fromPostgrestException(PostgrestException exception) {
    return SupabaseException(
      exception.message,
      code: exception.code,
      details: exception.details,
    );
  }

  factory SupabaseException.fromStorageException(StorageException exception) {
    return SupabaseException(
      exception.message,
      code: exception.statusCode,
      details: exception.error,
    );
  }

  factory SupabaseException.unknown(dynamic error) {
    return SupabaseException(
      'An unknown Supabase error occurred',
      details: error.toString(),
    );
  }
}
