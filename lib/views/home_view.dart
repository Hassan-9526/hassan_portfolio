import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/personal_info.dart';
import '../data/projects_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import '../widgets/project_card.dart';
import '../widgets/skill_chip.dart';
import '../widgets/hero/hero_section_widget.dart';
import '../services/email_service.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  final bool isDarkMode;

  const HomeView({super.key, required this.isDarkMode});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'projects': GlobalKey(),
    'education': GlobalKey(),
    'contact': GlobalKey(),
  };

  // Helper function to safely get Google Fonts
  TextStyle _safeGoogleFonts({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
  }) {
    try {
      return GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      );
    } catch (e) {
      return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        fontFamily: 'Poppins',
      );
    }
  }

  // Contact form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final GlobalKey<FormState> _contactFormKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void scrollToSection(String section) {
    final context = _sectionKeys[section]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _submitContactForm() async {
    if (!_contactFormKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final success = await EmailService.sendContactEmail(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        message: _messageController.text.trim(),
      );

      if (success) {
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                  'Message sent successfully! Check your email client.'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyles.radiusM),
              ),
            ),
          );

          // Clear form
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
        }
      } else {
        // Show error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Failed to send message. Please try again.'),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyles.radiusM),
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppStyles.radiusM),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          // Hero Section
          _buildHeroSection(),
          // About Section
          _buildAboutSection(),
          // Skills Section
          _buildSkillsSection(),
          // Projects Section
          _buildProjectsSection(),
          // Education & Experience Section
          _buildEducationExperienceSection(),
          // Contact Section
          _buildContactSection(),
          // Footer
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      key: _sectionKeys['home'],
      height: MediaQuery.of(context).size.height,
      child: HeroSectionWidget(isDarkMode: widget.isDarkMode),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      key: _sectionKeys['about'],
      padding: EdgeInsets.symmetric(
        horizontal: AppStyles.spacingL,
        vertical: AppStyles.spacingXXL,
      ),
      child: Column(
        children: [
          // Section title with animated underline
          MouseRegion(
            child: AnimatedContainer(
              duration: 300.ms,
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                PersonalInfo.aboutTitle,
                style: AppStyles.getHeading2(widget.isDarkMode),
                textAlign: TextAlign.center,
              ),
            ),
          ).animate().fadeIn(duration: 600.ms),

          const SizedBox(height: AppStyles.spacingXXL),

          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth <= 768;

              return Container(
                padding: const EdgeInsets.all(AppStyles.spacingXL),
                decoration: BoxDecoration(
                  color: AppColors.getSurface(widget.isDarkMode),
                  borderRadius: BorderRadius.circular(AppStyles.radiusL),
                  border: Border.all(
                    color: AppColors.getDivider(widget.isDarkMode),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main title with name and role
                    Center(
                      child: Text(
                        "I'm ${PersonalInfo.fullName}",
                        style: _safeGoogleFonts(
                          fontSize: isMobile ? 32 : 40,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          height: 1.1,
                        ),
                      ),
                    ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

                    const SizedBox(height: AppStyles.spacingS),

                    // Subtitle
                    Center(
                      child: Text(
                        PersonalInfo.title,
                        style: _safeGoogleFonts(
                          fontSize: isMobile ? 20 : 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.getTextSecondary(widget.isDarkMode),
                          height: 1.2,
                        ),
                      ),
                    ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

                    const SizedBox(height: AppStyles.spacingXL),

                    // About description
                    Text(
                      PersonalInfo.aboutDescription,
                      style: AppStyles.getBodyLarge(widget.isDarkMode).copyWith(
                        height: 1.8,
                        color: AppColors.getTextPrimary(widget.isDarkMode),
                      ),
                      textAlign: TextAlign.justify,
                    ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 800.ms);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      children: [
        _buildContactItem(Icons.email, PersonalInfo.email),
        _buildContactItem(Icons.phone, PersonalInfo.phone),
        _buildContactItem(Icons.location_on, PersonalInfo.location),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppStyles.spacingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: AppStyles.spacingM),
          Text(
            text,
            style: AppStyles.getBodyMedium(widget.isDarkMode),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    return Container(
      key: _sectionKeys['skills'],
      padding: const EdgeInsets.all(AppStyles.spacingXXL),
      decoration: BoxDecoration(
        color: AppColors.getBackground(widget.isDarkMode),
      ),
      child: Column(
        children: [
          Text(
            'Skills & Technologies',
            style: AppStyles.getHeading2(widget.isDarkMode),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: AppStyles.spacingM),
          Text(
            'Technical expertise and soft skills that drive success',
            style: AppStyles.getBodyLarge(widget.isDarkMode).copyWith(
              color: AppColors.getTextSecondary(widget.isDarkMode),
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
          const SizedBox(height: AppStyles.spacingXXL),
          Wrap(
            spacing: AppStyles.spacingM,
            runSpacing: AppStyles.spacingM,
            alignment: WrapAlignment.center,
            children: PersonalInfo.skills
                .map((skill) =>
                    SkillChip(skill: skill, isDarkMode: widget.isDarkMode))
                .toList(),
          ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
        ],
      ),
    );
  }

  Widget _buildProjectsSection() {
    return Container(
      key: _sectionKeys['projects'],
      padding: const EdgeInsets.all(AppStyles.spacingXXL),
      child: Column(
        children: [
          Text(
            'Featured Projects',
            style: AppStyles.getHeading2(widget.isDarkMode),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: AppStyles.spacingM),
          Text(
            'Innovative solutions that solve real-world problems',
            style: AppStyles.getBodyLarge(widget.isDarkMode).copyWith(
              color: AppColors.getTextSecondary(widget.isDarkMode),
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
          const SizedBox(height: AppStyles.spacingXXL),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 1;
              if (constraints.maxWidth > 1200) {
                crossAxisCount = 3;
              } else if (constraints.maxWidth > 768) {
                crossAxisCount = 2;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: AppStyles.spacingL,
                  mainAxisSpacing: AppStyles.spacingL,
                  childAspectRatio: 0.8,
                ),
                itemCount: ProjectsData.featuredProjects.length,
                itemBuilder: (context, index) {
                  return ProjectCard(
                    project: ProjectsData.featuredProjects[index],
                    isDarkMode: widget.isDarkMode,
                  ).animate().fadeIn(
                        delay: (index * 200).ms,
                        duration: 600.ms,
                      );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEducationExperienceSection() {
    return Container(
      key: _sectionKeys['education'],
      padding: const EdgeInsets.all(AppStyles.spacingXXL),
      child: Column(
        children: [
          Text(
            'RESUME',
            style: GoogleFonts.poppins(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: AppColors.getTextPrimary(widget.isDarkMode),
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: AppStyles.spacingS),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'MY ',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                TextSpan(
                  text: 'Journey',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.getTextPrimary(widget.isDarkMode),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
          const SizedBox(height: AppStyles.spacingXXL),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 768) {
                // Desktop layout - Side by side with timeline
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Education Section (Left)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Education',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color:
                                  AppColors.getTextPrimary(widget.isDarkMode),
                            ),
                          ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

                          const SizedBox(height: AppStyles.spacingL),

                          // Timeline line
                          Container(
                            height: 2,
                            color: AppColors.primary.withOpacity(0.3),
                          ).animate().fadeIn(delay: 500.ms, duration: 600.ms),

                          const SizedBox(height: AppStyles.spacingL),

                          // Education Entries
                          ...PersonalInfo.education
                              .asMap()
                              .entries
                              .map((entry) {
                            final index = entry.key;
                            final educationData = entry.value;
                            return _buildEducationEntry(
                              degree: educationData['degree']!,
                              institution: educationData['institution']!,
                              duration: educationData['duration']!,
                              description: educationData['description']!,
                              delay: 600 + (index * 100),
                            );
                          }).toList(),
                        ],
                      ),
                    ),

                    // Center Timeline
                    Container(
                      width: 60,
                      child: Column(
                        children: [
                          const SizedBox(
                              height: 60), // Space for Education title
                          Container(
                            width: 2,
                            height: 150,
                            color: AppColors.primary.withOpacity(0.3),
                          ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ).animate().fadeIn(delay: 700.ms, duration: 600.ms),
                          Container(
                            width: 2,
                            height: 150,
                            color: AppColors.primary.withOpacity(0.3),
                          ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
                        ],
                      ),
                    ),

                    // Experience Section (Right)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Experience',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color:
                                  AppColors.getTextPrimary(widget.isDarkMode),
                            ),
                          ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

                          const SizedBox(height: AppStyles.spacingL),

                          // Timeline line
                          Container(
                            height: 2,
                            color: AppColors.primary.withOpacity(0.3),
                          ).animate().fadeIn(delay: 500.ms, duration: 600.ms),

                          const SizedBox(height: AppStyles.spacingL),

                          // Experience Entries
                          ...PersonalInfo.experience
                              .asMap()
                              .entries
                              .map((entry) {
                            final index = entry.key;
                            final experienceData = entry.value;
                            return _buildExperienceEntry(
                              position: experienceData['position']!,
                              company: experienceData['company']!,
                              duration: experienceData['duration']!,
                              description: experienceData['description']!,
                              delay: 600 + (index * 100),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                // Mobile layout - Stacked
                return Column(
                  children: [
                    // Education Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Education',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.getTextPrimary(widget.isDarkMode),
                          ),
                        ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
                        const SizedBox(height: AppStyles.spacingL),
                        Container(
                          height: 2,
                          color: AppColors.primary.withOpacity(0.3),
                        ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
                        const SizedBox(height: AppStyles.spacingL),
                        ...PersonalInfo.education.asMap().entries.map((entry) {
                          final index = entry.key;
                          final educationData = entry.value;
                          return _buildEducationEntry(
                            degree: educationData['degree']!,
                            institution: educationData['institution']!,
                            duration: educationData['duration']!,
                            description: educationData['description']!,
                            delay: 600 + (index * 100),
                          );
                        }).toList(),
                      ],
                    ),

                    const SizedBox(height: AppStyles.spacingXXL),

                    // Experience Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Experience',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.getTextPrimary(widget.isDarkMode),
                          ),
                        ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
                        const SizedBox(height: AppStyles.spacingL),
                        Container(
                          height: 2,
                          color: AppColors.primary.withOpacity(0.3),
                        ).animate().fadeIn(delay: 900.ms, duration: 600.ms),
                        const SizedBox(height: AppStyles.spacingL),
                        ...PersonalInfo.experience.asMap().entries.map((entry) {
                          final index = entry.key;
                          final experienceData = entry.value;
                          return _buildExperienceEntry(
                            position: experienceData['position']!,
                            company: experienceData['company']!,
                            duration: experienceData['duration']!,
                            description: experienceData['description']!,
                            delay: 1000 + (index * 100),
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEducationEntry({
    required String degree,
    required String institution,
    required String duration,
    required String description,
    required int delay,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppStyles.spacingL),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppStyles.radiusM),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
        color: AppColors.getBackground(widget.isDarkMode).withOpacity(0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.school,
                    size: 8,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: AppStyles.spacingM),
              Expanded(
                child: Text(
                  degree,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.getTextPrimary(widget.isDarkMode),
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: delay.ms, duration: 600.ms),
          const SizedBox(height: AppStyles.spacingS),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        institution,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.getTextSecondary(widget.isDarkMode),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppStyles.spacingS,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppStyles.radiusS),
                      ),
                      child: Text(
                        duration,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: (delay + 100).ms, duration: 600.ms),
                const SizedBox(height: AppStyles.spacingM),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    height: 1.6,
                    color: AppColors.getTextSecondary(widget.isDarkMode),
                  ),
                ).animate().fadeIn(delay: (delay + 200).ms, duration: 600.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceEntry({
    required String position,
    required String company,
    required String duration,
    required String description,
    required int delay,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppStyles.spacingL),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppStyles.radiusM),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
        color: AppColors.getBackground(widget.isDarkMode).withOpacity(0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.work,
                    size: 8,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: AppStyles.spacingM),
              Expanded(
                child: Text(
                  position,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.getTextPrimary(widget.isDarkMode),
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: delay.ms, duration: 600.ms),
          const SizedBox(height: AppStyles.spacingS),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        company,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.getTextSecondary(widget.isDarkMode),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppStyles.spacingS,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppStyles.radiusS),
                      ),
                      child: Text(
                        duration,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: (delay + 100).ms, duration: 600.ms),
                const SizedBox(height: AppStyles.spacingM),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    height: 1.6,
                    color: AppColors.getTextSecondary(widget.isDarkMode),
                  ),
                ).animate().fadeIn(delay: (delay + 200).ms, duration: 600.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      key: _sectionKeys['contact'],
      padding: const EdgeInsets.all(AppStyles.spacingXXL),
      decoration: BoxDecoration(
        color: AppColors.getBackground(widget.isDarkMode),
      ),
      child: Column(
        children: [
          Text(
            PersonalInfo.contactTitle,
            style: AppStyles.getHeading2(widget.isDarkMode),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms),

          const SizedBox(height: AppStyles.spacingM),

          Text(
            PersonalInfo.contactSubtitle,
            style: AppStyles.getHeading4(widget.isDarkMode).copyWith(
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

          const SizedBox(height: AppStyles.spacingL),

          Text(
            PersonalInfo.contactDescription,
            style: AppStyles.getBodyLarge(widget.isDarkMode),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

          const SizedBox(height: AppStyles.spacingXXL),

          // Contact Form
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: _contactFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: AppStyles.getInputDecoration(widget.isDarkMode)
                        .copyWith(
                      labelText: 'Name',
                      prefixIcon: const Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
                  const SizedBox(height: AppStyles.spacingL),
                  TextFormField(
                    controller: _emailController,
                    decoration: AppStyles.getInputDecoration(widget.isDarkMode)
                        .copyWith(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
                  const SizedBox(height: AppStyles.spacingL),
                  TextFormField(
                    controller: _messageController,
                    maxLines: 5,
                    decoration: AppStyles.getInputDecoration(widget.isDarkMode)
                        .copyWith(
                      labelText: 'Message',
                      prefixIcon: const Icon(Icons.message),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your message';
                      }
                      if (value.trim().length < 10) {
                        return 'Message must be at least 10 characters';
                      }
                      return null;
                    },
                  ).animate().fadeIn(delay: 1000.ms, duration: 600.ms),
                  const SizedBox(height: AppStyles.spacingXL),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isSubmitting ? null : _submitContactForm,
                      icon: _isSubmitting
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.getTextInverse(widget.isDarkMode),
                                ),
                              ),
                            )
                          : const Icon(Icons.send),
                      label:
                          Text(_isSubmitting ? 'Sending...' : 'Send Message'),
                      style: AppStyles.getPrimaryButton(widget.isDarkMode),
                    ),
                  ).animate().fadeIn(delay: 1200.ms, duration: 600.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(AppStyles.spacingXXL),
      decoration: BoxDecoration(
        color: AppColors.getTextPrimary(widget.isDarkMode),
      ),
      child: Column(
        children: [
          Text(
            PersonalInfo.fullName,
            style: AppStyles.getHeading4(widget.isDarkMode).copyWith(
              color: AppColors.getTextInverse(widget.isDarkMode),
            ),
          ),
          const SizedBox(height: AppStyles.spacingM),
          Text(
            PersonalInfo.title,
            style: AppStyles.getBodyMedium(widget.isDarkMode).copyWith(
              color:
                  AppColors.getTextInverse(widget.isDarkMode).withOpacity(0.8),
            ),
          ),
          const SizedBox(height: AppStyles.spacingL),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialLink(Icons.email, PersonalInfo.email),
              _buildSocialLink(Icons.phone, PersonalInfo.phone),
              _buildSocialLink(Icons.location_on, PersonalInfo.location),
            ],
          ),
          const SizedBox(height: AppStyles.spacingL),
          Container(
            height: 1,
            color: AppColors.getTextInverse(widget.isDarkMode).withOpacity(0.2),
          ),
          const SizedBox(height: AppStyles.spacingL),
          Text(
            '© 2024 ${PersonalInfo.fullName}. All rights reserved.',
            style: AppStyles.getBodySmall(widget.isDarkMode).copyWith(
              color:
                  AppColors.getTextInverse(widget.isDarkMode).withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLink(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppStyles.spacingM),
      child: IconButton(
        onPressed: () => _launchUrl(text),
        icon: Icon(
          icon,
          color: AppColors.getTextInverse(widget.isDarkMode).withOpacity(0.8),
        ),
        tooltip: text,
      ),
    );
  }

  void _launchUrl(String url) {
    // This will be implemented with url_launcher
    print('Launch URL: $url');
  }

  Widget _buildTechnologyChip(String technology) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppStyles.spacingM,
        vertical: AppStyles.spacingS,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppStyles.radiusM),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppStyles.spacingS),
          Text(
            technology,
            style: AppStyles.getBodyMedium(widget.isDarkMode).copyWith(
              color: AppColors.getTextPrimary(widget.isDarkMode),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: AppStyles.getBodyMedium(widget.isDarkMode).copyWith(
            color: AppColors.getTextSecondary(widget.isDarkMode),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: AppStyles.getBodyMedium(widget.isDarkMode).copyWith(
            color: AppColors.getTextPrimary(widget.isDarkMode),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
