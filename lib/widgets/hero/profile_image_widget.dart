import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_colors.dart';

class ProfileImageWidget extends StatelessWidget {
  final bool isDarkMode;

  const ProfileImageWidget({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= 768;
        final isTablet =
            constraints.maxWidth > 768 && constraints.maxWidth <= 1024;

        // Responsive image sizes
        final imageWidth = isMobile
            ? 200.0
            : isTablet
                ? 280.0
                : 320.0;
        final glowSize = isMobile
            ? 180.0
            : isTablet
                ? 240.0
                : 220.0;

        return Stack(
          alignment: Alignment.center,
          children: [
            // Subtle glowing circle behind image
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   child: Container(
            //     width: glowSize,
            //     height: glowSize,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: AppColors.primary.withOpacity(0.05),
            //     ),
            //   ),
            // ),

            // Decorative dots - only show on larger screens
            if (!isMobile) ...[
              Positioned(
                top: isTablet ? 40 : 50,
                left: isTablet ? 15 : 20,
                child: Container(
                  width: isTablet ? 8 : 10,
                  height: isTablet ? 8 : 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.6),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: isTablet ? 60 : 80,
                right: isTablet ? 20 : 30,
                child: Container(
                  width: isTablet ? 6 : 8,
                  height: isTablet ? 6 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.5),
                  ),
                ),
              ),
            ],

            // Actual image (full clarity)
            ClipRRect(
              borderRadius: BorderRadius.circular(isMobile ? 15 : 20),
              child: Image.asset(
                'assets/images/hassan1.png',
                width: imageWidth,
                fit: BoxFit.cover,
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 1000.ms)
            .slideY(begin: 0.4, end: 0, duration: 1000.ms)
            .scale(begin: const Offset(0.95, 0.95), duration: 800.ms);
      },
    );
  }
}
