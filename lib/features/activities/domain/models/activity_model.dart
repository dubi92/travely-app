import 'package:flutter/material.dart';

enum ActivityCategory {
  food,
  sightseeing,
  accommodation,
  transport,
  shopping,
  other;

  String toJson() => name;
  static ActivityCategory fromJson(String json) => values.byName(json);

  String get emoji {
    switch (this) {
      case ActivityCategory.food:
        return '🍽️';
      case ActivityCategory.sightseeing:
        return '📸';
      case ActivityCategory.accommodation:
        return '🏨';
      case ActivityCategory.transport:
        return '🚕';
      case ActivityCategory.shopping:
        return '🛍️';
      case ActivityCategory.other:
        return '📍';
    }
  }

  String get label {
    switch (this) {
      case ActivityCategory.food:
        return 'Food';
      case ActivityCategory.sightseeing:
        return 'Sightseeing';
      case ActivityCategory.accommodation:
        return 'Stay';
      case ActivityCategory.transport:
        return 'Transport';
      case ActivityCategory.shopping:
        return 'Shopping';
      case ActivityCategory.other:
        return 'Other';
    }
  }
}

class Activity {
  final String id;
  final String tripId;
  final String title;
  final String? description;
  final String? location;
  final DateTime startTime;
  final DateTime? endTime;
  final ActivityCategory category;
  final double? price;
  final String? currency;
  final String? imageUrl;
  final bool isPaid;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic>? metadata;

  const Activity({
    required this.id,
    required this.tripId,
    required this.title,
    this.description,
    this.location,
    required this.startTime,
    this.endTime,
    required this.category,
    this.price,
    this.currency,
    this.imageUrl,
    this.isPaid = false,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.metadata,
  });

  Duration? get duration {
    if (endTime == null) return null;
    return endTime!.difference(startTime);
  }

  // Helper to determine day index relative to trip start if we had trip start date,
  // but typically we group by actual date.
  DateTime get date => DateUtils.dateOnly(startTime);

  Activity copyWith({
    String? id,
    String? tripId,
    String? title,
    String? description,
    String? location,
    DateTime? startTime,
    DateTime? endTime,
    ActivityCategory? category,
    double? price,
    String? currency,
    String? imageUrl,
    bool? isPaid,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) {
    return Activity(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      category: category ?? this.category,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      imageUrl: imageUrl ?? this.imageUrl,
      isPaid: isPaid ?? this.isPaid,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trip_id': tripId,
      'title': title,
      'description': description,
      'location': location,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'category': category.toJson(),
      'price': price,
      'currency': currency,
      'image_url': imageUrl,
      'is_paid': isPaid,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'metadata': metadata,
    };
  }

  factory Activity.fromJson(Map<String, dynamic> map) {
    return Activity(
      id: map['id'] as String,
      tripId: map['trip_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String?,
      location: map['location'] as String?,
      startTime: DateTime.parse(map['start_time'] as String),
      endTime: map['end_time'] != null
          ? DateTime.parse(map['end_time'] as String)
          : null,
      category: ActivityCategory.values.byName(map['category'] as String),
      price: (map['price'] as num?)?.toDouble(),
      currency: map['currency'] as String?,
      imageUrl: map['image_url'] as String?,
      isPaid: map['is_paid'] as bool? ?? false,
      createdBy: map['created_by'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      metadata: map['metadata'] as Map<String, dynamic>?,
    );
  }
}
