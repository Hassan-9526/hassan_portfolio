import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

class SkillChip extends StatefulWidget {
  final String skill;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool isDarkMode;

  const SkillChip({
    super.key,
    required this.skill,
    this.isSelected = false,
    this.onTap,
    required this.isDarkMode,
  });

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: 300.ms,
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(
            horizontal: AppStyles.spacingL,
            vertical: AppStyles.spacingS,
          ),
          decoration: BoxDecoration(
            gradient: _getGradient(),
            borderRadius: BorderRadius.circular(AppStyles.radiusL),
            border: Border.all(
              color: _getBorderColor(),
              width: _getBorderWidth(),
            ),
            boxShadow: _getShadow(),
          ),
          child: AnimatedContainer(
            duration: 250.ms,
            curve: Curves.easeOutBack,
            transform: isHovered
                ? Matrix4.identity().scaled(1.05)
                : Matrix4.identity(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Skill icon or indicator
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _getDotColor(),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppStyles.spacingS),
                Text(
                  widget.skill,
                  style: AppStyles.getBodyMedium(widget.isDarkMode).copyWith(
                    color: _getTextColor(),
                    fontWeight: _getFontWeight(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  LinearGradient _getGradient() {
    if (widget.isSelected) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.primary, AppColors.primaryLight],
      );
    } else if (isHovered) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.primary.withOpacity(0.15),
          AppColors.primary.withOpacity(0.05),
        ],
      );
    } else {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.getSurface(widget.isDarkMode).withOpacity(0.3),
          AppColors.getSurface(widget.isDarkMode).withOpacity(0.1),
        ],
      );
    }
  }

  Color _getBorderColor() {
    if (widget.isSelected) {
      return AppColors.primary;
    } else if (isHovered) {
      return AppColors.primary.withOpacity(0.6);
    } else {
      return AppColors.primary.withOpacity(0.3);
    }
  }

  double _getBorderWidth() {
    if (widget.isSelected) {
      return 2.0;
    } else if (isHovered) {
      return 1.5;
    } else {
      return 1.0;
    }
  }

  List<BoxShadow>? _getShadow() {
    if (widget.isSelected) {
      return [
        BoxShadow(
          color: AppColors.primary.withOpacity(0.3),
          blurRadius: 12,
          spreadRadius: 0,
          offset: const Offset(0, 4),
        ),
      ];
    } else if (isHovered) {
      return [
        BoxShadow(
          color: AppColors.primary.withOpacity(0.2),
          blurRadius: 8,
          spreadRadius: 0,
          offset: const Offset(0, 2),
        ),
      ];
    } else {
      return null;
    }
  }

  Color _getDotColor() {
    if (widget.isSelected) {
      return AppColors.getTextInverse(widget.isDarkMode);
    } else if (isHovered) {
      return AppColors.primary;
    } else {
      return AppColors.primary.withOpacity(0.7);
    }
  }

  Color _getTextColor() {
    if (widget.isSelected) {
      return AppColors.getTextInverse(widget.isDarkMode);
    } else if (isHovered) {
      return AppColors.primary;
    } else {
      return AppColors.getTextPrimary(widget.isDarkMode);
    }
  }

  FontWeight _getFontWeight() {
    if (widget.isSelected) {
      return FontWeight.w600;
    } else if (isHovered) {
      return FontWeight.w600;
    } else {
      return FontWeight.w500;
    }
  }
}
