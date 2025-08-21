import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/personal_info.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

class PortfolioAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onThemeToggle;
  final bool isDarkMode;
  final Function(String)? onSectionScroll; // Add scroll callback

  const PortfolioAppBar({
    super.key,
    this.onThemeToggle,
    this.isDarkMode = false,
    this.onSectionScroll, // Add this parameter
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  State<PortfolioAppBar> createState() => _PortfolioAppBarState();
}

class _PortfolioAppBarState extends State<PortfolioAppBar> {
  String? hoveredNavLink;
  String? hoveredSocialLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getSurface(widget.isDarkMode).withOpacity(0.95),
        border: Border(
          bottom: BorderSide(
            color: AppColors.getDivider(widget.isDarkMode).withOpacity(0.2),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: widget.isDarkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            // Logo/Brand
            Container(
              padding: const EdgeInsets.all(AppStyles.spacingM),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(AppStyles.radiusM),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'HA',
                style: AppStyles.getHeading6(widget.isDarkMode).copyWith(
                  color: AppColors.getTextInverse(widget.isDarkMode),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

            const SizedBox(width: AppStyles.spacingM),

            Text(
              PersonalInfo.fullName,
              style: AppStyles.getHeading6(widget.isDarkMode).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
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
                _buildNavLink('Experience',
                    () => _scrollToSection('education')), // Add Experience
                _buildNavLink('Contact', () => _scrollToSection('contact')),
              ],
            ).animate().fadeIn(delay: 600.ms, duration: 600.ms),

          const SizedBox(width: AppStyles.spacingL),

          // Social Links
          Row(
            children: [
              _buildSocialLink(
                icon: FontAwesomeIcons.github,
                url: PersonalInfo.github,
                tooltip: 'GitHub',
              ),
              _buildSocialLink(
                icon: FontAwesomeIcons.linkedin,
                url: PersonalInfo.linkedin,
                tooltip: 'LinkedIn',
              ),
            ],
          ).animate().fadeIn(delay: 800.ms, duration: 600.ms),

          // Theme Toggle
          if (widget.onThemeToggle != null)
            ...[
              const SizedBox(width: AppStyles.spacingM),
              _buildThemeToggle(),
            ].animate().fadeIn(delay: 1000.ms, duration: 600.ms),

          // Mobile Menu Button
          if (MediaQuery.of(context).size.width <= 768)
            ...[
              const SizedBox(width: AppStyles.spacingM),
              _buildMobileMenuButton(),
            ].animate().fadeIn(delay: 1000.ms, duration: 600.ms),
        ],
      ),
    );
  }

  Widget _buildNavLink(String text, VoidCallback onTap) {
    final isHovered = hoveredNavLink == text;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hoveredNavLink = text),
      onExit: (_) => setState(() => hoveredNavLink = null),
      child: AnimatedContainer(
        duration: 200.ms,
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(
          horizontal: AppStyles.spacingM,
          vertical: AppStyles.spacingS,
        ),
        decoration: BoxDecoration(
          color: isHovered
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppStyles.radiusM),
          border: Border.all(
            color: isHovered
                ? AppColors.primary.withOpacity(0.3)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            text,
            style: AppStyles.getBodyMedium(widget.isDarkMode).copyWith(
              color: isHovered
                  ? AppColors.primary
                  : AppColors.getTextPrimary(widget.isDarkMode),
              fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLink({
    required IconData icon,
    required String url,
    required String tooltip,
  }) {
    final isHovered = hoveredSocialLink == url;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hoveredSocialLink = url),
      onExit: (_) => setState(() => hoveredSocialLink = null),
      child: AnimatedContainer(
        duration: 200.ms,
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(AppStyles.spacingS),
        decoration: BoxDecoration(
          color: isHovered
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppStyles.radiusM),
        ),
        child: IconButton(
          onPressed: () => _launchUrl(url),
          icon: FaIcon(
            icon,
            size: 18,
            color: isHovered
                ? AppColors.primary
                : AppColors.getTextSecondary(widget.isDarkMode),
          ),
          tooltip: tooltip,
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: 200.ms,
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(AppStyles.spacingS),
        decoration: BoxDecoration(
          color: AppColors.getSurface(widget.isDarkMode),
          borderRadius: BorderRadius.circular(AppStyles.radiusM),
          border: Border.all(
            color: AppColors.getDivider(widget.isDarkMode).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: IconButton(
          onPressed: widget.onThemeToggle,
          icon: AnimatedSwitcher(
            duration: 300.ms,
            child: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              key: ValueKey(widget.isDarkMode),
              color: AppColors.getTextPrimary(widget.isDarkMode),
            ),
          ),
          tooltip: widget.isDarkMode
              ? 'Switch to Light Mode'
              : 'Switch to Dark Mode',
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: 200.ms,
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(AppStyles.spacingS),
        decoration: BoxDecoration(
          color: AppColors.getSurface(widget.isDarkMode),
          borderRadius: BorderRadius.circular(AppStyles.radiusM),
          border: Border.all(
            color: AppColors.getDivider(widget.isDarkMode).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: IconButton(
          onPressed: () => _showMobileMenu(context),
          icon: Icon(Icons.menu),
          color: AppColors.getTextPrimary(widget.isDarkMode),
          tooltip: 'Menu',
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
    );
  }

  void _scrollToSection(String section) {
    // Call the callback to trigger scrolling in the home view
    widget.onSectionScroll?.call(section);
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
          color: AppColors.getSurface(widget.isDarkMode),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppStyles.radiusL),
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isDarkMode
                  ? Colors.black.withOpacity(0.4)
                  : Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: AppStyles.spacingM),
              decoration: BoxDecoration(
                color: AppColors.getDivider(widget.isDarkMode),
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
            _buildMobileNavLink('Experience', () {
              // Add Experience to mobile menu
              Navigator.pop(context);
              _scrollToSection('education');
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
        style: AppStyles.getBodyMedium(widget.isDarkMode).copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      leading: Icon(
        _getNavIcon(text),
        color: AppColors.getTextSecondary(widget.isDarkMode),
        size: 20,
      ),
    );
  }

  IconData _getNavIcon(String text) {
    switch (text.toLowerCase()) {
      case 'home':
        return Icons.home;
      case 'about':
        return Icons.person;
      case 'skills':
        return Icons.psychology;
      case 'projects':
        return Icons.work;
      case 'experience': // Add Experience icon
        return Icons.school;
      case 'contact':
        return Icons.contact_mail;
      default:
        return Icons.circle;
    }
  }
}
