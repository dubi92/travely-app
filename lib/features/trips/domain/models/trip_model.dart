import 'trip_member_model.dart';

class Trip {
  final String id;
  final String name;
  final String destination;
  final String? coverImageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final String defaultCurrency;
  final double? overallBudget;
  final double? dailyLimit;
  final String? travelPace; // 'relaxed', 'balanced', 'packed'
  final String status; // 'planning', 'confirmed', 'completed', 'archived'
  final String createdBy;

  Trip({
    required this.id,
    required this.name,
    this.destination = '',
    this.coverImageUrl,
    required this.startDate,
    required this.endDate,
    this.defaultCurrency = 'USD',
    this.overallBudget,
    this.dailyLimit,
    this.travelPace,
    this.status = 'planning',
    required this.createdBy,
    this.members,
  });

  final List<TripMember>? members;

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'Untitled Trip',
      destination: json['destination'] as String? ?? '',
      coverImageUrl: json['cover_image_url'] as String?,
      startDate: DateTime.tryParse(json['start_date']?.toString() ?? '') ??
          DateTime.now(),
      endDate: DateTime.tryParse(json['end_date']?.toString() ?? '') ??
          DateTime.now().add(const Duration(days: 1)),
      defaultCurrency: json['default_currency'] as String? ?? 'USD',
      overallBudget: (json['overall_budget'] as num?)?.toDouble(),
      dailyLimit: (json['daily_limit'] as num?)?.toDouble(),
      travelPace: json['travel_pace'] as String?,
      status: json['status'] as String? ?? 'planning',
      createdBy: json['created_by'] as String? ?? '',
      members: json['trip_members'] != null
          ? (json['trip_members'] as List)
              .map((e) => TripMember.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'destination': destination,
      'cover_image_url': coverImageUrl,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'default_currency': defaultCurrency,
      'overall_budget': overallBudget,
      'daily_limit': dailyLimit,
      'travel_pace': travelPace,
      'status': status,
      'created_by': createdBy,
    };
  }

  Trip copyWith({
    String? name,
    String? destination,
    String? coverImageUrl,
    DateTime? startDate,
    DateTime? endDate,
    String? defaultCurrency,
    double? overallBudget,
    double? dailyLimit,
    String? travelPace,
    String? status,
    List<TripMember>? members,
  }) {
    return Trip(
      id: id,
      name: name ?? this.name,
      destination: destination ?? this.destination,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      overallBudget: overallBudget ?? this.overallBudget,
      dailyLimit: dailyLimit ?? this.dailyLimit,
      travelPace: travelPace ?? this.travelPace,
      status: status ?? this.status,
      createdBy: createdBy,
      members: members ?? this.members,
    );
  }
}
