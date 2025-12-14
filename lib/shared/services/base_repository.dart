import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/errors/supabase_exception.dart';

abstract class BaseRepository {
  final SupabaseClient client;
  final String tableName;

  BaseRepository(this.client, this.tableName);

  // Protected helper to execute Supabase calls with error handling
  Future<T> execute<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on AuthException catch (e) {
      throw SupabaseException.fromAuthException(e);
    } on PostgrestException catch (e) {
      throw SupabaseException.fromPostgrestException(e);
    } on StorageException catch (e) {
      throw SupabaseException.fromStorageException(e);
    } catch (e) {
      throw SupabaseException.unknown(e);
    }
  }

  // Common CRUD

  Future<List<Map<String, dynamic>>> getAll({
    String? select,
    int? limit,
    int? offset,
    String? orderBy,
    bool ascending = true,
  }) {
    return execute(() async {
      var query = client.from(tableName).select(select ?? '*');
      
      if (orderBy != null) {
        query = query.order(orderBy, ascending: ascending) as PostgrestFilterBuilder<List<Map<String, dynamic>>>;
      }
      
      if (limit != null) {
        query = query.limit(limit) as PostgrestFilterBuilder<List<Map<String, dynamic>>>;
      }
      
      if (offset != null) {
        query = query.range(offset, offset + (limit ?? 10) - 1) as PostgrestFilterBuilder<List<Map<String, dynamic>>>;
      }

      return await query;
    });
  }

  Future<Map<String, dynamic>?> getById(String id, {String idColumn = 'id', String? select}) {
    return execute(() async {
      final response = await client
          .from(tableName)
          .select(select ?? '*')
          .eq(idColumn, id)
          .maybeSingle();
      return response;
    });
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> data) {
    return execute(() async {
      return await client
          .from(tableName)
          .insert(data)
          .select()
          .single();
    });
  }

  Future<Map<String, dynamic>> update(String id, Map<String, dynamic> data, {String idColumn = 'id'}) {
    return execute(() async {
      return await client
          .from(tableName)
          .update(data)
          .eq(idColumn, id)
          .select()
          .single();
    });
  }

  Future<void> delete(String id, {String idColumn = 'id'}) {
    return execute(() async {
      await client.from(tableName).delete().eq(idColumn, id);
    });
  }
}
