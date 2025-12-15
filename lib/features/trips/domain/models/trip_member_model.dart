class TripMember {
  final String id;
  final String tripId;
  final String userId;
  final String role; // 'admin' | 'member'
  final DateTime joinedAt;
  
  // Optional: User profile data joined
  final String? userName;
  final String? userAvatarUrl;

  const TripMember({
    required this.id,
    required this.tripId,
    required this.userId,
    required this.role,
    required this.joinedAt,
    this.userName,
    this.userAvatarUrl,
  });

  factory TripMember.fromJson(Map<String, dynamic> json) {
    return TripMember(
      id: json['id'] as String,
      tripId: json['trip_id'] as String,
      userId: json['user_id'] as String,
      role: json['role'] as String? ?? 'member',
      joinedAt: DateTime.tryParse(json['joined_at']?.toString() ?? '') ?? DateTime.now(),
      // Handling joined profile data if available
      userName: json['profiles'] != null ? json['profiles']['full_name'] as String? : null,
      userAvatarUrl: json['profiles'] != null ? json['profiles']['avatar_url'] as String? : null,
    );
  }
}

class TripInvitation {
  final String id;
  final String tripId;
  final String inviteCode;
  final String createdBy;
  final DateTime? expiresAt;
  final DateTime createdAt;

  const TripInvitation({
    required this.id,
    required this.tripId,
    required this.inviteCode,
    required this.createdBy,
    this.expiresAt,
    required this.createdAt,
  });

  factory TripInvitation.fromJson(Map<String, dynamic> json) {
    return TripInvitation(
      id: json['id'] as String,
      tripId: json['trip_id'] as String,
      inviteCode: json['invite_code'] as String,
      createdBy: json['created_by'] as String,
      expiresAt: json['expires_at'] != null ? DateTime.parse(json['expires_at'] as String) : null,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
