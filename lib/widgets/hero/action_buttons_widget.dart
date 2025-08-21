import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_colors.dart';
import '../../data/personal_info.dart';

class ActionButtonsWidget extends StatelessWidget {
  final bool isDarkMode;

  const ActionButtonsWidget({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= 768;
        final isTablet =
            constraints.maxWidth > 768 && constraints.maxWidth <= 1024;

        return isMobile
            ? Column(
                children: [
                  _buildDownloadButton(
                    text: PersonalInfo.downloadResumeText,
                    onTap: () {},
                    delay: 1900.ms,
                    isMobile: true,
                  ),
                  const SizedBox(height: 16),
                  _buildSkillsButton(
                    text: PersonalInfo.mySkillsText,
                    onTap: () {},
                    delay: 2000.ms,
                    isMobile: true,
                  ),
                ],
              )
            : Row(
                children: [
                  _buildDownloadButton(
                    text: PersonalInfo.downloadResumeText,
                    onTap: () {},
                    delay: 1900.ms,
                    isMobile: false,
                  ),
                  SizedBox(width: isTablet ? 16 : 20),
                  _buildSkillsButton(
                    text: PersonalInfo.mySkillsText,
                    onTap: () {},
                    delay: 2000.ms,
                    isMobile: false,
                  ),
                ],
              );
      },
    );
  }

  Widget _buildDownloadButton({
    required String text,
    required VoidCallback onTap,
    required Duration delay,
    required bool isMobile,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: 300.ms,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 32,
                vertical: isMobile ? 14 : 16,
              ),
              decoration: BoxDecoration(
                gradient: isHovered
                    ? LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryLight],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isHovered ? null : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isHovered ? AppColors.primary : AppColors.primary,
                  width: 2,
                ),
                boxShadow: isHovered
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.4),
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: const Offset(0, 5),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.2),
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.download,
                    color: isHovered
                        ? AppColors.getTextInverse(isDarkMode)
                        : AppColors.primary,
                    size: isMobile ? 18 : 20,
                  ),
                  SizedBox(width: isMobile ? 6 : 8),
                  Text(
                    text,
                    style: TextStyle(
                      color: isHovered
                          ? AppColors.getTextInverse(isDarkMode)
                          : AppColors.primary,
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
            .animate()
            .slideX(
                begin: isMobile ? 0 : -0.5,
                end: 0,
                duration: 800.ms,
                curve: Curves.easeOutCubic)
            .fadeIn(delay: delay, duration: 600.ms);
      },
    );
  }

  Widget _buildSkillsButton({
    required String text,
    required VoidCallback onTap,
    required Duration delay,
    required bool isMobile,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: 300.ms,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 32,
                vertical: isMobile ? 14 : 16,
              ),
              decoration: BoxDecoration(
                color: isHovered
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isHovered
                      ? AppColors.primary
                      : AppColors.getTextSecondary(isDarkMode),
                  width: isHovered ? 2 : 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_forward,
                    color: isHovered
                        ? AppColors.primary
                        : AppColors.getTextSecondary(isDarkMode),
                    size: isMobile ? 18 : 20,
                  ),
                  SizedBox(width: isMobile ? 6 : 8),
                  Text(
                    text,
                    style: TextStyle(
                      color: isHovered
                          ? AppColors.primary
                          : AppColors.getTextSecondary(isDarkMode),
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
            .animate()
            .slideX(
                begin: isMobile ? 0 : 0.5,
                end: 0,
                duration: 800.ms,
                curve: Curves.easeOutCubic)
            .fadeIn(delay: delay, duration: 600.ms);
      },
    );
  }
}
