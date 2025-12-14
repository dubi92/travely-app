class Profile {
  final String id;
  final String? fullName;
  final String? avatarUrl;
  final String? phone;
  final String currency;
  final bool tripAlerts;
  final bool onboardingCompleted;

  Profile({
    required this.id,
    this.fullName,
    this.avatarUrl,
    this.phone,
    this.currency = 'USD', // Default to USD
    this.tripAlerts = true, // Default to true
    this.onboardingCompleted = false,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String,
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      phone: json['phone'] as String?,
      currency: json['currency'] as String? ?? 'USD',
      tripAlerts: json['alerts'] as bool? ?? true,
      onboardingCompleted: json['onboarding_completed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'phone': phone,
      'currency': currency,
      'alerts': tripAlerts,
      'onboarding_completed': onboardingCompleted,
    };
  }

  Profile copyWith({
    String? fullName,
    String? avatarUrl,
    String? phone,
    String? currency,
    bool? tripAlerts,
    bool? onboardingCompleted,
  }) {
    return Profile(
      id: id,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phone: phone ?? this.phone,
      currency: currency ?? this.currency,
      tripAlerts: tripAlerts ?? this.tripAlerts,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    );
  }
}
