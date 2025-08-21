import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../theme/app_colors.dart';
import '../../data/personal_info.dart';
import 'social_icons_widget.dart';
import 'action_buttons_widget.dart';

class HeroTextContentWidget extends StatelessWidget {
  final bool isDarkMode;

  const HeroTextContentWidget({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= 768;
        final isTablet =
            constraints.maxWidth > 768 && constraints.maxWidth <= 1024;

        // Responsive font sizes
        final greetingSize = isMobile
            ? 16.0
            : isTablet
                ? 18.0
                : 18.0;
        final nameSize = isMobile
            ? 36.0
            : isTablet
                ? 42.0
                : 48.0;
        final titleSize = isMobile
            ? 24.0
            : isTablet
                ? 28.0
                : 32.0;
        final bioSize = isMobile
            ? 14.0
            : isTablet
                ? 15.0
                : 16.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting text
            Text(
              "Hello, I'm",
              style: TextStyle(
                color: AppColors.getTextSecondary(isDarkMode),
                fontSize: greetingSize,
                fontWeight: FontWeight.w500,
                letterSpacing: 2,
              ),
            )
                .animate()
                .fadeIn(delay: 200.ms, duration: 600.ms)
                .slideX(begin: -0.3, end: 0, duration: 600.ms),

            SizedBox(height: isMobile ? 8 : 12),

            // Name
            Text(
              PersonalInfo.fullName,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: nameSize,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            )
                .animate()
                .fadeIn(delay: 400.ms, duration: 800.ms)
                .slideX(begin: -0.3, end: 0, duration: 800.ms),

            SizedBox(height: isMobile ? 6 : 8),

            // Animated title
            SizedBox(
              height: isMobile
                  ? 50
                  : isTablet
                      ? 55
                      : 60,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    PersonalInfo.title,
                    textStyle: TextStyle(
                      color: AppColors.getTextPrimary(isDarkMode),
                      fontSize: titleSize,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            )
                .animate()
                .fadeIn(delay: 600.ms, duration: 1000.ms)
                .slideX(begin: -0.3, end: 0, duration: 1000.ms),

            SizedBox(height: isMobile ? 12 : 16),

            // Bio text
            Text(
              PersonalInfo.heroTagline,
              style: TextStyle(
                color: AppColors.getTextSecondary(isDarkMode),
                fontSize: bioSize,
                fontWeight: FontWeight.w400,
                height: 1.6,
                letterSpacing: 0.5,
              ),
            )
                .animate()
                .fadeIn(delay: 800.ms, duration: 1000.ms)
                .slideX(begin: -0.3, end: 0, duration: 1000.ms),

            SizedBox(height: isMobile ? 20 : 28),

            // Brief statistics
            Row(
              children: [
                _buildStatItem(
                  PersonalInfo.experienceYears,
                  PersonalInfo.experienceLabel,
                  isMobile,
                ),
                SizedBox(width: isMobile ? 20 : 40),
                _buildStatItem(
                  PersonalInfo.projectsCount,
                  PersonalInfo.projectsLabel,
                  isMobile,
                ),
              ],
            ).animate().fadeIn(delay: 1000.ms, duration: 800.ms),

            SizedBox(height: isMobile ? 20 : 28),

            // Social icons
            SocialIconsWidget(isDarkMode: isDarkMode),

            SizedBox(height: isMobile ? 24 : 32),

            // Action buttons
            ActionButtonsWidget(isDarkMode: isDarkMode),
          ],
        );
      },
    );
  }

  Widget _buildStatItem(String value, String label, bool isMobile) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: isMobile ? 24 : 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: AppColors.getTextSecondary(isDarkMode),
            fontSize: isMobile ? 12 : 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
