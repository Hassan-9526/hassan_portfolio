import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../data/personal_info.dart';
import '../../theme/app_colors.dart';

class SocialIconsWidget extends StatefulWidget {
  final bool isDarkMode;

  const SocialIconsWidget({super.key, required this.isDarkMode});

  @override
  State<SocialIconsWidget> createState() => _SocialIconsWidgetState();
}

class _SocialIconsWidgetState extends State<SocialIconsWidget> {
  // Track hover state for each icon
  final Map<int, bool> _hoverStates = {};

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= 768;
        final isTablet =
            constraints.maxWidth > 768 && constraints.maxWidth <= 1024;

        return Row(
          children: [
            _buildSocialIcon(
              icon: FontAwesomeIcons.github,
              url: PersonalInfo.github,
              tooltip: 'GitHub',
              index: 0,
              isMobile: isMobile,
              isTablet: isTablet,
            ).animate().fadeIn(delay: 1400.ms, duration: 400.ms),
            SizedBox(
                width: isMobile
                    ? 16
                    : isTablet
                        ? 20
                        : 24),
            _buildSocialIcon(
              icon: FontAwesomeIcons.linkedin,
              url: PersonalInfo.linkedin,
              tooltip: 'LinkedIn',
              index: 1,
              isMobile: isMobile,
              isTablet: isTablet,
            ).animate().fadeIn(delay: 1500.ms, duration: 400.ms),
            SizedBox(
                width: isMobile
                    ? 16
                    : isTablet
                        ? 20
                        : 24),
            _buildSocialIcon(
              icon: Icons.email,
              url: 'mailto:${PersonalInfo.email}',
              tooltip: 'Email',
              index: 2,
              isMobile: isMobile,
              isTablet: isTablet,
            ).animate().fadeIn(delay: 1600.ms, duration: 400.ms),
            SizedBox(
                width: isMobile
                    ? 16
                    : isTablet
                        ? 20
                        : 24),
            _buildSocialIcon(
              icon: Icons.phone,
              url: 'tel:${PersonalInfo.phone}',
              tooltip: 'Phone',
              index: 3,
              isMobile: isMobile,
              isTablet: isTablet,
            ).animate().fadeIn(delay: 1700.ms, duration: 400.ms),
          ],
        );
      },
    );
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required String url,
    required String tooltip,
    required int index,
    required bool isMobile,
    required bool isTablet,
  }) {
    final isHovered = _hoverStates[index] ?? false;
    final iconSize = isMobile
        ? 18.0
        : isTablet
            ? 20.0
            : 22.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoverStates[index] = true),
      onExit: (_) => setState(() => _hoverStates[index] = false),
      child: Tooltip(
        message: tooltip,
        child: GestureDetector(
          onTap: () => _launchUrl(url),
          child: AnimatedContainer(
            duration: 300.ms,
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.all(isMobile
                ? 10
                : isTablet
                    ? 12
                    : 14),
            decoration: BoxDecoration(
              color: isHovered
                  ? AppColors.primary.withOpacity(0.1)
                  : widget.isDarkMode
                      ? Colors.white.withOpacity(0.05)
                      : Colors.black.withOpacity(0.03),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isHovered
                    ? AppColors.primary.withOpacity(0.3)
                    : widget.isDarkMode
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: AnimatedContainer(
              duration: 200.ms,
              curve: Curves.easeOutBack,
              child: Icon(
                icon,
                color: isHovered
                    ? AppColors.primary
                    : AppColors.getTextSecondary(widget.isDarkMode),
                size: iconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _launchUrl(String url) {
    // This will be implemented with url_launcher
    print('Launch URL: $url');
  }
}
