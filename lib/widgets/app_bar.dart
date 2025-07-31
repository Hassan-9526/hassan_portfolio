import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/personal_info.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

class PortfolioAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onThemeToggle;
  final bool isDarkMode;

  const PortfolioAppBar({
    super.key,
    this.onThemeToggle,
    this.isDarkMode = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppStyles.spacingS),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppStyles.radiusM),
            ),
            child: Text(
              'HA',
              style: AppStyles.heading6.copyWith(
                color: AppColors.textInverse,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: AppStyles.spacingM),
          Text(
            PersonalInfo.fullName,
            style: AppStyles.heading6,
          ),
        ],
      ),
      actions: [
        // Navigation Links (Desktop)
        if (MediaQuery.of(context).size.width > 768)
          Row(
            children: [
              _buildNavLink('Home', () => _scrollToSection('home')),
              _buildNavLink('About', () => _scrollToSection('about')),
              _buildNavLink('Skills', () => _scrollToSection('skills')),
              _buildNavLink('Projects', () => _scrollToSection('projects')),
              _buildNavLink('Contact', () => _scrollToSection('contact')),
            ],
          ),

        // Social Links
        Row(
          children: [
            _buildSocialLink(
              icon: FontAwesomeIcons.github,
              url: PersonalInfo.github,
            ),
            _buildSocialLink(
              icon: FontAwesomeIcons.linkedin,
              url: PersonalInfo.linkedin,
            ),
            _buildSocialLink(
              icon: FontAwesomeIcons.twitter,
              url: PersonalInfo.twitter,
            ),
          ],
        ),

        // Theme Toggle
        if (onThemeToggle != null) ...[
          const SizedBox(width: AppStyles.spacingM),
          IconButton(
            onPressed: onThemeToggle,
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: AppColors.textPrimary,
            ),
          ),
        ],

        // Mobile Menu Button
        if (MediaQuery.of(context).size.width <= 768) ...[
          const SizedBox(width: AppStyles.spacingM),
          IconButton(
            onPressed: () => _showMobileMenu(context),
            icon: const Icon(Icons.menu),
            color: AppColors.textPrimary,
          ),
        ],
      ],
    );
  }

  Widget _buildNavLink(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppStyles.spacingS),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          text,
          style: AppStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLink({
    required IconData icon,
    required String url,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppStyles.spacingXS),
      child: IconButton(
        onPressed: () => _launchUrl(url),
        icon: FaIcon(
          icon,
          size: 18,
          color: AppColors.textSecondary,
        ),
        tooltip: url.split('/').last,
      ),
    );
  }

  void _scrollToSection(String section) {
    // This will be implemented with scroll controller
    // For now, just print the section
    print('Scroll to $section');
  }

  void _launchUrl(String url) {
    // This will be implemented with url_launcher
    print('Launch URL: $url');
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppStyles.radiusL),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: AppStyles.spacingM),
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            _buildMobileNavLink('Home', () {
              Navigator.pop(context);
              _scrollToSection('home');
            }),
            _buildMobileNavLink('About', () {
              Navigator.pop(context);
              _scrollToSection('about');
            }),
            _buildMobileNavLink('Skills', () {
              Navigator.pop(context);
              _scrollToSection('skills');
            }),
            _buildMobileNavLink('Projects', () {
              Navigator.pop(context);
              _scrollToSection('projects');
            }),
            _buildMobileNavLink('Contact', () {
              Navigator.pop(context);
              _scrollToSection('contact');
            }),
            const SizedBox(height: AppStyles.spacingL),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavLink(String text, VoidCallback onTap) {
    return ListTile(
      title: Text(
        text,
        style: AppStyles.bodyMedium,
      ),
      onTap: onTap,
    );
  }
}
