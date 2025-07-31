import 'dart:ui';
import 'package:flutter/material.dart';
import '../data/projects_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.project,
    this.onTap,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;
  bool isImageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.progress,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform:
            isHovered ? Matrix4.identity().scaled(1.02) : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppStyles.radiusL),
          border: Border.all(
            color: isHovered ? AppColors.primary : Colors.grey.shade200,
            width: 1.5,
          ),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(isHovered ? 0.95 : 0.98),
              Colors.white.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? AppColors.primary.withOpacity(0.15)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isHovered ? 30 : 15,
              spreadRadius: isHovered ? 1 : 0,
              offset: Offset(0, isHovered ? 12 : 6),
            )
          ],
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(AppStyles.radiusL),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image with shimmer effect
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppStyles.radiusL),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey.shade100,
                                Colors.grey.shade200,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Image.network(
                            widget.project.imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  if (mounted) {
                                    setState(() => isImageLoaded = true);
                                  }
                                });
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  strokeWidth: 2,
                                  color: AppColors.primary.withOpacity(0.6),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                              child: Icon(
                                Icons.broken_image,
                                size: 50,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                        ),
                        if (isImageLoaded)
                          Positioned.fill(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black
                                        .withOpacity(isHovered ? 0.2 : 0.1),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Content section
                  Padding(
                    padding: const EdgeInsets.all(AppStyles.spacingL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                widget.project.title,
                                style: AppStyles.heading5.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (widget.project.isFeatured)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppStyles.spacingM,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Featured',
                                  style: AppStyles.caption.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: AppStyles.spacingM),

                        // Rating and stats row
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.amber.shade600,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '4.8',
                              style: AppStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: AppStyles.spacingM),
                            Icon(
                              Icons.visibility_outlined,
                              color: Colors.grey.shade500,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            // Text(
                            //   '${widget.project.views ?? '1.2k'}',
                            //   style: AppStyles.bodySmall.copyWith(
                            //     color: AppColors.textSecondary,
                            //   ),
                            // ),
                          ],
                        ),

                        const SizedBox(height: AppStyles.spacingL),

                        Text(
                          widget.project.description,
                          style: AppStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: AppStyles.spacingL),

                        // Tags with fade effect
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: widget.project.technologies.take(5).map(
                              (tech) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: AppStyles.spacingS),
                                  child: Chip(
                                    label: Text(
                                      tech,
                                      style: AppStyles.caption.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    backgroundColor:
                                        AppColors.primary.withOpacity(0.1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                        color:
                                            AppColors.primary.withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    visualDensity: VisualDensity.compact,
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),

                        const SizedBox(height: AppStyles.spacingL),

                        // Buttons row
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () =>
                                    _launchUrl(widget.project.liveUrl),
                                icon: Icon(
                                  Icons.play_circle_outline,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                                label: Text(
                                  'Live Demo',
                                  style: TextStyle(color: AppColors.primary),
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  side: BorderSide(
                                    color: AppColors.primary.withOpacity(0.3),
                                    width: 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: isHovered
                                      ? AppColors.primary.withOpacity(0.05)
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppStyles.spacingM),
                            IconButton(
                              onPressed: () {}, // Add to favorites
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.grey.shade600,
                                size: 20,
                              ),
                              splashRadius: 20,
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Ribbon for featured projects
              if (widget.project.isFeatured)
                Positioned(
                  top: 10,
                  right: -25,
                  child: Transform.rotate(
                    angle: 0.79,
                    child: Container(
                      width: 100,
                      height: 24,
                      color: AppColors.accent,
                      alignment: Alignment.center,
                      child: Text(
                        'FEATURED',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl(String url) {
    print('Launch URL: $url');
  }
}
