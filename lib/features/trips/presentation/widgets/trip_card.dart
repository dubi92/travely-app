import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/trip_model.dart';
import '../../domain/models/trip_member_model.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback onTap;

  const TripCard({
    super.key,
    required this.trip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMMM d'); // October 15
    final dateRange =
        '${dateFormat.format(trip.startDate)} - ${dateFormat.format(trip.endDate)}';
    final duration =
        trip.endDate.difference(trip.startDate).inDays + 1; // Inclusive
    final durationText = '$duration Days';

    // Theme Colors based on Status
    Color themeColor;
    Color contentBgColor;

    switch (trip.status) {
      case 'planning':
        themeColor = AppColors.brandSoftPeach;
        contentBgColor = AppColors.brandSoftPeach.withValues(alpha: 0.15);
        break;
      case 'confirmed':
        themeColor = AppColors.brandMintGreen;
        contentBgColor = AppColors.brandMintGreen.withValues(alpha: 0.15);
        break;
      default: // completed, archived
        themeColor = AppColors.brandPaleYellow;
        contentBgColor = AppColors.brandPaleYellow.withValues(alpha: 0.15);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24), // --radius-large
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), // --shadow-soft
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            // --- Illustration/Image Area ---
            SizedBox(
              height: 160,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // 1. Base Background (Color or Image)
                  Container(color: themeColor),

                  if (trip.coverImageUrl != null)
                    CachedNetworkImage(
                      imageUrl: trip.coverImageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const SizedBox(),
                    ),

                  // 2. Decorations Removed

                  // 3. Fallback Icon if no image
                  if (trip.coverImageUrl == null)
                    Center(
                      child: Text(
                        trip.name.isNotEmpty
                            ? trip.name[0].toUpperCase()
                            : '✈️',
                        style:
                            const TextStyle(fontSize: 60, color: Colors.white),
                      ),
                    ),

                  // 4. Trip Name Overlay (Top Left)
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Text(
                      trip.name,
                      style: const TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // 5. Avatars Overlay (Bottom Right)
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: _buildAvatarStack(),
                  ),
                ],
              ),
            ),

            // --- Content Area ---
            Container(
              padding: const EdgeInsets.all(16),
              color: contentBgColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Destination Location (Now clearly under the name)
                  if (trip.destination.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(Icons.location_on_rounded,
                              size: 16,
                              color: AppColors.brandDarkBlue.withOpacity(0.7)),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              trip.destination,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.brandDarkBlue.withOpacity(0.8),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Date + Duration
                  Row(
                    children: [
                      Icon(Icons.calendar_today_rounded,
                          size: 14, color: AppColors.textSecondaryLight),
                      const SizedBox(width: 6),
                      Text(
                        dateRange,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6B8E93),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                            color: Color(0xFF6B8E93), shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        durationText,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.brandDarkBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarStack() {
    // Mock Data for Demo Purposes
    final mockMembers = [
      TripMember(
          id: '1',
          tripId: '',
          userId: '1',
          role: 'owner',
          userName: 'Alice',
          joinedAt: DateTime.now()),
      TripMember(
          id: '2',
          tripId: '',
          userId: '2',
          role: 'editor',
          userName: 'Bob',
          joinedAt: DateTime.now()),
      TripMember(
          id: '3',
          tripId: '',
          userId: '3',
          role: 'viewer',
          userName: 'Charlie',
          joinedAt: DateTime.now()),
      TripMember(
          id: '4',
          tripId: '',
          userId: '4',
          role: 'viewer',
          userName: 'Dave',
          joinedAt: DateTime.now()),
      TripMember(
          id: '5',
          tripId: '',
          userId: '5',
          role: 'viewer',
          userName: 'Eve',
          joinedAt: DateTime.now()),
    ];

    // FORCE MOCK DATA for Demo (User request: "can you add 3 icon... so I can see")
    // Revert this to use trip.members later.
    final members = mockMembers;

    if (members.isEmpty) return const SizedBox();

    final showMembers = members.take(3).toList();
    final remainingCount = members.length - 3;

    // Correct Width Calculation:
    // (Overlap * (Count - 1)) + AvatarSize
    // Overlap = 20, Size = 32.
    // Count = showMembers.length + (remainingCount > 0 ? 1 : 0)
    final visibleCount = showMembers.length + (remainingCount > 0 ? 1 : 0);
    final width = (20.0 * (visibleCount - 1)) + 32.0;

    return SizedBox(
      height: 40, // Increased for Shadow
      width: width + 4, // +4 for right-side shadow overflow safety
      child: Stack(
        alignment: Alignment.centerRight,
        clipBehavior: Clip.none, // Allow shadows to breathe
        children: [
          for (int i = 0; i < showMembers.length; i++)
            Positioned(
              right: (showMembers.length - 1 - i) * 20.0 +
                  (remainingCount > 0
                      ? 20.0
                      : 0), // Reverse stack for right alignment
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1), blurRadius: 4)
                    ]),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.brandSkyBlue,
                  backgroundImage: showMembers[i].userAvatarUrl != null
                      ? NetworkImage(showMembers[i].userAvatarUrl!)
                      : null,
                  child: showMembers[i].userAvatarUrl == null
                      ? Text(
                          (showMembers[i].userName ?? '?')[0].toUpperCase(),
                          style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.brandDarkBlue,
                              fontWeight: FontWeight.bold),
                        )
                      : null,
                ),
              ),
            ),
          if (remainingCount > 0)
            Positioned(
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1), blurRadius: 4)
                    ]),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.brandDarkBlue,
                  child: Text(
                    '+$remainingCount',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
