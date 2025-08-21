import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_colors.dart';
import 'hero_text_content_widget.dart';
import 'profile_image_widget.dart';

class HeroSectionWidget extends StatelessWidget {
  final bool isDarkMode;

  const HeroSectionWidget({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= 768;
        final isTablet =
            constraints.maxWidth > 768 && constraints.maxWidth <= 1024;

        return Container(
          width: double.infinity,
          height: isMobile ? null : MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Main content
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile
                      ? 20
                      : isTablet
                          ? 40
                          : 80,
                  vertical: isMobile ? 40 : 60,
                ),
                child: isMobile
                    ? _buildMobileLayout()
                    : _buildDesktopLayout(isTablet),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Profile image on top for mobile
        Expanded(
          flex: 2,
          child: Center(
            child: ProfileImageWidget(isDarkMode: isDarkMode),
          ),
        ),

        const SizedBox(height: 20),

        // Text content below
        Expanded(
          flex: 3,
          child: HeroTextContentWidget(isDarkMode: isDarkMode),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(bool isTablet) {
    return Row(
      children: [
        // Left side - Text content
        Expanded(
          flex: isTablet ? 2 : 3,
          child: HeroTextContentWidget(isDarkMode: isDarkMode),
        ),

        SizedBox(width: isTablet ? 40 : 60),

        // Right side - Profile image
        Expanded(
          flex: isTablet ? 2 : 2,
          child: ProfileImageWidget(isDarkMode: isDarkMode),
        ),
      ],
    );
  }

  Widget _buildFloatingParticle(int index) {
    final positions = [
      const Offset(0.1, 0.2),
      const Offset(0.8, 0.1),
      const Offset(0.9, 0.8),
      const Offset(0.2, 0.7),
      const Offset(0.5, 0.5),
    ];

    final sizes = [20.0, 15.0, 25.0, 18.0, 12.0];

    return Positioned(
      left: positions[index].dx * 1200,
      top: positions[index].dy * 800,
      child: Container(
        width: sizes[index],
        height: sizes[index],
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary.withOpacity(0.1),
        ),
      ),
    );
  }
}
