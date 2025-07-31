// import 'package:flutter/material.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import '../data/personal_info.dart';
// import '../data/projects_data.dart';
// import '../theme/app_colors.dart';
// import '../theme/app_styles.dart';
// import '../widgets/project_card.dart';
// import '../widgets/skill_chip.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _scrollToSection(String section) {
//     // This would be implemented with proper scroll controller
//     // For now, just scroll to different positions
//     switch (section) {
//       case 'home':
//         _scrollController.animateTo(
//           0,
//           duration: const Duration(milliseconds: 800),
//           curve: Curves.easeInOut,
//         );
//         break;
//       case 'about':
//         _scrollController.animateTo(
//           600,
//           duration: const Duration(milliseconds: 800),
//           curve: Curves.easeInOut,
//         );
//         break;
//       case 'skills':
//         _scrollController.animateTo(
//           1200,
//           duration: const Duration(milliseconds: 800),
//           curve: Curves.easeInOut,
//         );
//         break;
//       case 'projects':
//         _scrollController.animateTo(
//           1800,
//           duration: const Duration(milliseconds: 800),
//           curve: Curves.easeInOut,
//         );
//         break;
//       case 'contact':
//         _scrollController.animateTo(
//           2400,
//           duration: const Duration(milliseconds: 800),
//           curve: Curves.easeInOut,
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       controller: _scrollController,
//       child: Column(
//         children: [
//           // Hero Section
//           _buildHeroSection(),

//           // About Section
//           _buildAboutSection(),

//           // Skills Section
//           _buildSkillsSection(),

//           // Projects Section
//           _buildProjectsSection(),

//           // Contact Section
//           _buildContactSection(),

//           // Footer
//           _buildFooter(),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeroSection() {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             AppColors.background,
//             AppColors.primary.withOpacity(0.05),
//           ],
//         ),
//       ),
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(AppStyles.spacingXXL),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Profile Image Placeholder
//               Container(
//                 width: 150,
//                 height: 150,
//                 decoration: BoxDecoration(
//                   gradient: AppColors.primaryGradient,
//                   shape: BoxShape.circle,
//                   boxShadow: AppStyles.shadowL,
//                 ),
//                 child: const Icon(
//                   Icons.person,
//                   size: 80,
//                   color: AppColors.textInverse,
//                 ),
//               ).animate().fadeIn(duration: 600.ms).scale(),

//               const SizedBox(height: AppStyles.spacingXXL),

//               // Name
//               Text(
//                 PersonalInfo.fullName,
//                 style: AppStyles.heading1,
//                 textAlign: TextAlign.center,
//               ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

//               const SizedBox(height: AppStyles.spacingM),

//               // Title
//               Text(
//                 PersonalInfo.title,
//                 style: AppStyles.heading3.copyWith(
//                   color: AppColors.primary,
//                 ),
//                 textAlign: TextAlign.center,
//               ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

//               const SizedBox(height: AppStyles.spacingL),

//               // Animated Tagline
//               SizedBox(
//                 height: 60,
//                 child: AnimatedTextKit(
//                   animatedTexts: [
//                     TypewriterAnimatedText(
//                       PersonalInfo.heroTagline,
//                       textStyle: AppStyles.bodyLarge,
//                       speed: const Duration(milliseconds: 50),
//                     ),
//                   ],
//                   totalRepeatCount: 1,
//                 ),
//               ).animate().fadeIn(delay: 600.ms, duration: 600.ms),

//               const SizedBox(height: AppStyles.spacingXXL),

//               // Action Buttons
//               Wrap(
//                 spacing: AppStyles.spacingL,
//                 runSpacing: AppStyles.spacingM,
//                 alignment: WrapAlignment.center,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () => _launchUrl(PersonalInfo.resumeLink),
//                     icon: const Icon(Icons.download),
//                     label: Text(PersonalInfo.downloadResumeText),
//                     style: AppStyles.primaryButton,
//                   ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
//                   OutlinedButton.icon(
//                     onPressed: () => _scrollToSection('contact'),
//                     icon: const Icon(Icons.email),
//                     label: Text(PersonalInfo.hireMeText),
//                     style: AppStyles.outlineButton,
//                   ).animate().fadeIn(delay: 1000.ms, duration: 600.ms),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAboutSection() {
//     return Container(
//       padding: const EdgeInsets.all(AppStyles.spacingXXL),
//       child: Column(
//         children: [
//           Text(
//             PersonalInfo.aboutTitle,
//             style: AppStyles.heading2,
//             textAlign: TextAlign.center,
//           ).animate().fadeIn(duration: 600.ms),
//           const SizedBox(height: AppStyles.spacingXXL),
//           LayoutBuilder(
//             builder: (context, constraints) {
//               if (constraints.maxWidth > 768) {
//                 // Desktop layout
//                 return Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Profile Image
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         height: 300,
//                         decoration: BoxDecoration(
//                           gradient: AppColors.primaryGradient,
//                           borderRadius:
//                               BorderRadius.circular(AppStyles.radiusXL),
//                           boxShadow: AppStyles.shadowM,
//                         ),
//                         child: const Center(
//                           child: Icon(
//                             Icons.person,
//                             size: 100,
//                             color: AppColors.textInverse,
//                           ),
//                         ),
//                       ),
//                     ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

//                     const SizedBox(width: AppStyles.spacingXXL),

//                     // About Content
//                     Expanded(
//                       flex: 2,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             PersonalInfo.aboutDescription,
//                             style: AppStyles.bodyLarge,
//                           ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

//                           const SizedBox(height: AppStyles.spacingXL),

//                           // Contact Info
//                           _buildContactInfo()
//                               .animate()
//                               .fadeIn(delay: 600.ms, duration: 600.ms),

//                           const SizedBox(height: AppStyles.spacingXL),

//                           // Download CV Button
//                           ElevatedButton.icon(
//                             onPressed: () =>
//                                 _launchUrl(PersonalInfo.resumeLink),
//                             icon: const Icon(Icons.download),
//                             label: const Text('Download CV'),
//                             style: AppStyles.primaryButton,
//                           ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               } else {
//                 // Mobile layout
//                 return Column(
//                   children: [
//                     // Profile Image
//                     Container(
//                       height: 200,
//                       width: 200,
//                       decoration: BoxDecoration(
//                         gradient: AppColors.primaryGradient,
//                         shape: BoxShape.circle,
//                         boxShadow: AppStyles.shadowM,
//                       ),
//                       child: const Center(
//                         child: Icon(
//                           Icons.person,
//                           size: 80,
//                           color: AppColors.textInverse,
//                         ),
//                       ),
//                     ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

//                     const SizedBox(height: AppStyles.spacingXXL),

//                     // About Content
//                     Text(
//                       PersonalInfo.aboutDescription,
//                       style: AppStyles.bodyLarge,
//                       textAlign: TextAlign.center,
//                     ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

//                     const SizedBox(height: AppStyles.spacingXL),

//                     // Contact Info
//                     _buildContactInfo()
//                         .animate()
//                         .fadeIn(delay: 600.ms, duration: 600.ms),

//                     const SizedBox(height: AppStyles.spacingXL),

//                     // Download CV Button
//                     ElevatedButton.icon(
//                       onPressed: () => _launchUrl(PersonalInfo.resumeLink),
//                       icon: const Icon(Icons.download),
//                       label: const Text('Download CV'),
//                       style: AppStyles.primaryButton,
//                     ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
//                   ],
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContactInfo() {
//     return Column(
//       children: [
//         _buildContactItem(Icons.email, PersonalInfo.email),
//         _buildContactItem(Icons.phone, PersonalInfo.phone),
//         _buildContactItem(Icons.location_on, PersonalInfo.location),
//       ],
//     );
//   }

//   Widget _buildContactItem(IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: AppStyles.spacingM),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             color: AppColors.primary,
//             size: 20,
//           ),
//           const SizedBox(width: AppStyles.spacingM),
//           Text(
//             text,
//             style: AppStyles.bodyMedium,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSkillsSection() {
//     return Container(
//       padding: const EdgeInsets.all(AppStyles.spacingXXL),
//       decoration: BoxDecoration(
//         color: AppColors.background,
//       ),
//       child: Column(
//         children: [
//           Text(
//             'Skills & Technologies',
//             style: AppStyles.heading2,
//             textAlign: TextAlign.center,
//           ).animate().fadeIn(duration: 600.ms),
//           const SizedBox(height: AppStyles.spacingM),
//           Text(
//             'Technologies I work with',
//             style: AppStyles.bodyLarge.copyWith(
//               color: AppColors.textSecondary,
//             ),
//             textAlign: TextAlign.center,
//           ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
//           const SizedBox(height: AppStyles.spacingXXL),
//           Wrap(
//             spacing: AppStyles.spacingM,
//             runSpacing: AppStyles.spacingM,
//             alignment: WrapAlignment.center,
//             children: PersonalInfo.skills
//                 .map((skill) => SkillChip(skill: skill))
//                 .toList(),
//           ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
//         ],
//       ),
//     );
//   }

//   Widget _buildProjectsSection() {
//     return Container(
//       padding: const EdgeInsets.all(AppStyles.spacingXXL),
//       child: Column(
//         children: [
//           Text(
//             'Featured Projects',
//             style: AppStyles.heading2,
//             textAlign: TextAlign.center,
//           ).animate().fadeIn(duration: 600.ms),
//           const SizedBox(height: AppStyles.spacingM),
//           Text(
//             'Some of my recent work',
//             style: AppStyles.bodyLarge.copyWith(
//               color: AppColors.textSecondary,
//             ),
//             textAlign: TextAlign.center,
//           ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
//           const SizedBox(height: AppStyles.spacingXXL),
//           LayoutBuilder(
//             builder: (context, constraints) {
//               int crossAxisCount = 1;
//               if (constraints.maxWidth > 1200) {
//                 crossAxisCount = 3;
//               } else if (constraints.maxWidth > 768) {
//                 crossAxisCount = 2;
//               }

//               return GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: crossAxisCount,
//                   crossAxisSpacing: AppStyles.spacingL,
//                   mainAxisSpacing: AppStyles.spacingL,
//                   childAspectRatio: 0.8,
//                 ),
//                 itemCount: ProjectsData.featuredProjects.length,
//                 itemBuilder: (context, index) {
//                   return ProjectCard(
//                     project: ProjectsData.featuredProjects[index],
//                   ).animate().fadeIn(
//                         delay: (index * 200).ms,
//                         duration: 600.ms,
//                       );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContactSection() {
//     return Container(
//       padding: const EdgeInsets.all(AppStyles.spacingXXL),
//       decoration: BoxDecoration(
//         color: AppColors.background,
//       ),
//       child: Column(
//         children: [
//           Text(
//             PersonalInfo.contactTitle,
//             style: AppStyles.heading2,
//             textAlign: TextAlign.center,
//           ).animate().fadeIn(duration: 600.ms),

//           const SizedBox(height: AppStyles.spacingM),

//           Text(
//             PersonalInfo.contactSubtitle,
//             style: AppStyles.heading4.copyWith(
//               color: AppColors.primary,
//             ),
//             textAlign: TextAlign.center,
//           ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

//           const SizedBox(height: AppStyles.spacingL),

//           Text(
//             PersonalInfo.contactDescription,
//             style: AppStyles.bodyLarge,
//             textAlign: TextAlign.center,
//           ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

//           const SizedBox(height: AppStyles.spacingXXL),

//           // Contact Form
//           Container(
//             constraints: const BoxConstraints(maxWidth: 600),
//             child: Column(
//               children: [
//                 TextField(
//                   decoration: AppStyles.inputDecoration.copyWith(
//                     labelText: 'Name',
//                     prefixIcon: const Icon(Icons.person),
//                   ),
//                 ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
//                 const SizedBox(height: AppStyles.spacingL),
//                 TextField(
//                   decoration: AppStyles.inputDecoration.copyWith(
//                     labelText: 'Email',
//                     prefixIcon: const Icon(Icons.email),
//                   ),
//                 ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
//                 const SizedBox(height: AppStyles.spacingL),
//                 TextField(
//                   maxLines: 5,
//                   decoration: AppStyles.inputDecoration.copyWith(
//                     labelText: 'Message',
//                     prefixIcon: const Icon(Icons.message),
//                   ),
//                 ).animate().fadeIn(delay: 1000.ms, duration: 600.ms),
//                 const SizedBox(height: AppStyles.spacingXL),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       // Handle form submission
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Message sent successfully!'),
//                           backgroundColor: AppColors.success,
//                         ),
//                       );
//                     },
//                     icon: const Icon(Icons.send),
//                     label: const Text('Send Message'),
//                     style: AppStyles.primaryButton,
//                   ),
//                 ).animate().fadeIn(delay: 1200.ms, duration: 600.ms),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFooter() {
//     return Container(
//       padding: const EdgeInsets.all(AppStyles.spacingXXL),
//       decoration: BoxDecoration(
//         color: AppColors.textPrimary,
//       ),
//       child: Column(
//         children: [
//           Text(
//             PersonalInfo.fullName,
//             style: AppStyles.heading4.copyWith(
//               color: AppColors.textInverse,
//             ),
//           ),
//           const SizedBox(height: AppStyles.spacingM),
//           Text(
//             PersonalInfo.title,
//             style: AppStyles.bodyMedium.copyWith(
//               color: AppColors.textInverse.withOpacity(0.8),
//             ),
//           ),
//           const SizedBox(height: AppStyles.spacingL),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _buildSocialLink(Icons.email, PersonalInfo.email),
//               _buildSocialLink(Icons.phone, PersonalInfo.phone),
//               _buildSocialLink(Icons.location_on, PersonalInfo.location),
//             ],
//           ),
//           const SizedBox(height: AppStyles.spacingL),
//           Container(
//             height: 1,
//             color: AppColors.textInverse.withOpacity(0.2),
//           ),
//           const SizedBox(height: AppStyles.spacingL),
//           Text(
//             '© 2024 ${PersonalInfo.fullName}. All rights reserved.',
//             style: AppStyles.bodySmall.copyWith(
//               color: AppColors.textInverse.withOpacity(0.6),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSocialLink(IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: AppStyles.spacingM),
//       child: IconButton(
//         onPressed: () => _launchUrl(text),
//         icon: Icon(
//           icon,
//           color: AppColors.textInverse.withOpacity(0.8),
//         ),
//         tooltip: text,
//       ),
//     );
//   }

//   void _launchUrl(String url) {
//     // This will be implemented with url_launcher
//     print('Launch URL: $url');
//   }
// }
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/personal_info.dart';
import '../data/projects_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import '../widgets/project_card.dart';
import '../widgets/skill_chip.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  final double _sectionHeight = 800.0;
  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'projects': GlobalKey(),
    'contact': GlobalKey(),
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    final context = _sectionKeys[section]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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

            // Contact Section
            _buildContactSection(),

            // Footer
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      key: _sectionKeys['home'],
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.background,
            AppColors.primary.withOpacity(0.05),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated background elements
          Positioned(
            top: 100,
            left: 100,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.1),
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .scale(
                    duration: 10.seconds,
                    begin: Offset(1, 1),
                    end: Offset(1.5, 1.5))
                .fade(duration: 10.seconds, begin: 1, end: 0),
          ),
          Positioned(
            bottom: 200,
            right: 150,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withOpacity(0.1),
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .scale(
                    duration: 8.seconds,
                    begin: Offset(1, 1),
                    end: Offset(1.8, 1.8))
                .fade(duration: 8.seconds, begin: 1, end: 0),
          ),

          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(AppStyles.spacingXXL),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Image with hover effect
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: AnimatedContainer(
                      duration: 300.ms,
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                        boxShadow: AppStyles.shadowL,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 80,
                        color: AppColors.textInverse,
                      ),
                    ).animate().fadeIn(duration: 600.ms).scale(),
                  ).animate().shake(
                        delay: 2.seconds,
                        hz: 0.1,
                      ),

                  const SizedBox(height: AppStyles.spacingXXL),

                  // Name with hover effect
                  MouseRegion(
                    child: AnimatedContainer(
                      duration: 300.ms,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        PersonalInfo.fullName,
                        style: AppStyles.heading1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

                  const SizedBox(height: AppStyles.spacingM),

                  // Title with animated underline on hover
                  MouseRegion(
                    child: AnimatedDefaultTextStyle(
                      duration: 300.ms,
                      style: AppStyles.heading3.copyWith(
                        color: AppColors.primary,
                      ),
                      child: Text(
                        PersonalInfo.title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

                  const SizedBox(height: AppStyles.spacingL),

                  // Animated Tagline with hover effect
                  MouseRegion(
                    child: SizedBox(
                      height: 60,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            PersonalInfo.heroTagline,
                            textStyle: AppStyles.bodyLarge,
                            speed: const Duration(milliseconds: 30),
                          ),
                        ],
                        totalRepeatCount: 1,
                      ),
                    ),
                  ).animate().fadeIn(delay: 600.ms, duration: 600.ms),

                  const SizedBox(height: AppStyles.spacingXXL),

                  // Action Buttons with hover effects
                  Wrap(
                    spacing: AppStyles.spacingL,
                    runSpacing: AppStyles.spacingM,
                    alignment: WrapAlignment.center,
                    children: [
                      // Resume button with scale hover effect
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: AnimatedContainer(
                          duration: 300.ms,
                          transformAlignment: Alignment.center,
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                _launchUrl(PersonalInfo.resumeLink),
                            icon: const Icon(Icons.download),
                            label: Text(PersonalInfo.downloadResumeText),
                            style: AppStyles.primaryButton,
                          ),
                        ),
                      ).animate().fadeIn(delay: 800.ms, duration: 600.ms),

                      // Contact button with border animation on hover
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: AnimatedContainer(
                          duration: 300.ms,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: OutlinedButton.icon(
                            onPressed: () => _scrollToSection('contact'),
                            icon: const Icon(Icons.email),
                            label: Text(PersonalInfo.hireMeText),
                            style: AppStyles.outlineButton,
                          ),
                        ),
                      ).animate().fadeIn(delay: 1000.ms, duration: 600.ms),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      key: _sectionKeys['about'],
      padding: const EdgeInsets.all(AppStyles.spacingXXL),
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
                style: AppStyles.heading2,
                textAlign: TextAlign.center,
              ),
            ),
          ).animate().fadeIn(duration: 600.ms),

          const SizedBox(height: AppStyles.spacingXXL),

          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 768) {
                // Desktop layout
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Image with parallax effect
                    Expanded(
                      flex: 1,
                      child: MouseRegion(
                        child: AnimatedContainer(
                          duration: 300.ms,
                          height: 300,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius:
                                BorderRadius.circular(AppStyles.radiusXL),
                            boxShadow: AppStyles.shadowM,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              size: 100,
                              color: AppColors.textInverse,
                            ),
                          ),
                        ),
                      ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
                    ),

                    const SizedBox(width: AppStyles.spacingXXL),

                    // About Content
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Animated text with hover effect
                          MouseRegion(
                            child: AnimatedContainer(
                              duration: 300.ms,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                PersonalInfo.aboutDescription,
                                style: AppStyles.bodyLarge,
                              ),
                            ),
                          ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

                          const SizedBox(height: AppStyles.spacingXL),

                          // Contact Info with hover effects
                          _buildContactInfo()
                              .animate()
                              .fadeIn(delay: 600.ms, duration: 600.ms),

                          const SizedBox(height: AppStyles.spacingXL),

                          // Download CV Button with scale effect
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: AnimatedContainer(
                              duration: 300.ms,
                              transformAlignment: Alignment.center,
                              child: ElevatedButton.icon(
                                onPressed: () =>
                                    _launchUrl(PersonalInfo.resumeLink),
                                icon: const Icon(Icons.download),
                                label: const Text('Download CV'),
                                style: AppStyles.primaryButton,
                              ),
                            ),
                          ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                // Mobile layout
                return Column(
                  children: [
                    // Profile Image
                    MouseRegion(
                      child: AnimatedContainer(
                        duration: 300.ms,
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          shape: BoxShape.circle,
                          boxShadow: AppStyles.shadowM,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            size: 80,
                            color: AppColors.textInverse,
                          ),
                        ),
                      ),
                    ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

                    const SizedBox(height: AppStyles.spacingXXL),

                    // About Content
                    MouseRegion(
                      child: AnimatedContainer(
                        duration: 300.ms,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          PersonalInfo.aboutDescription,
                          style: AppStyles.bodyLarge.copyWith(
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
                    ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

                    const SizedBox(height: AppStyles.spacingXL),

                    // Contact Info
                    _buildContactInfo()
                        .animate()
                        .fadeIn(delay: 600.ms, duration: 600.ms),

                    const SizedBox(height: AppStyles.spacingXL),

                    // Download CV Button
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: AnimatedContainer(
                        duration: 300.ms,
                        child: ElevatedButton.icon(
                          onPressed: () => _launchUrl(PersonalInfo.resumeLink),
                          icon: const Icon(Icons.download),
                          label: const Text('Download CV'),
                          style: AppStyles.primaryButton,
                        ),
                      ),
                    ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
                  ],
                );
              }
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: 300.ms,
        margin: const EdgeInsets.only(bottom: AppStyles.spacingM),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
        ),
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
              style: AppStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsSection() {
    return Container(
      key: _sectionKeys['skills'],
      padding: const EdgeInsets.all(AppStyles.spacingXXL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.background,
            AppColors.background.withOpacity(0.9),
          ],
        ),
      ),
      child: Column(
        children: [
          // Animated section title
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
                'Skills & Technologies',
                style: AppStyles.heading2,
                textAlign: TextAlign.center,
              ),
            ),
          ).animate().fadeIn(duration: 600.ms),

          const SizedBox(height: AppStyles.spacingM),

          // Subtitle with hover effect
          MouseRegion(
            child: AnimatedContainer(
              duration: 300.ms,
              padding: const EdgeInsets.all(8),
              child: Text(
                'Technologies I work with',
                style: AppStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

          const SizedBox(height: AppStyles.spacingXXL),

          // Skills with hover effects
          Wrap(
            spacing: AppStyles.spacingM,
            runSpacing: AppStyles.spacingM,
            alignment: WrapAlignment.center,
            children: PersonalInfo.skills
                .map((skill) => MouseRegion(
                      child: AnimatedContainer(
                        duration: 300.ms,
                        child: SkillChip(skill: skill),
                      ),
                    ))
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.background.withOpacity(0.9),
            AppColors.background,
          ],
        ),
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
                'Featured Projects',
                style: AppStyles.heading2,
                textAlign: TextAlign.center,
              ),
            ),
          ).animate().fadeIn(duration: 600.ms),

          const SizedBox(height: AppStyles.spacingM),

          // Subtitle with hover effect
          MouseRegion(
            child: AnimatedContainer(
              duration: 300.ms,
              padding: const EdgeInsets.all(8),
              child: Text(
                'Some of my recent work',
                style: AppStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

          const SizedBox(height: AppStyles.spacingXXL),

          // Projects grid with hover effects
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
                  return MouseRegion(
                    child: AnimatedContainer(
                      duration: 300.ms,
                      child: ProjectCard(
                        project: ProjectsData.featuredProjects[index],
                      ),
                    ),
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

  Widget _buildContactSection() {
    return Container(
      key: _sectionKeys['contact'],
      padding: const EdgeInsets.all(AppStyles.spacingXXL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.background,
            AppColors.primary.withOpacity(0.05),
          ],
        ),
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
                PersonalInfo.contactTitle,
                style: AppStyles.heading2,
                textAlign: TextAlign.center,
              ),
            ),
          ).animate().fadeIn(duration: 600.ms),

          const SizedBox(height: AppStyles.spacingM),

          // Subtitle with hover effect
          MouseRegion(
            child: AnimatedContainer(
              duration: 300.ms,
              padding: const EdgeInsets.all(8),
              child: Text(
                PersonalInfo.contactSubtitle,
                style: AppStyles.heading4.copyWith(
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

          const SizedBox(height: AppStyles.spacingL),

          // Description with hover effect
          MouseRegion(
            child: AnimatedContainer(
              duration: 300.ms,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                PersonalInfo.contactDescription,
                style: AppStyles.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

          const SizedBox(height: AppStyles.spacingXXL),

          // Contact Form with hover effects
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                // Name field
                MouseRegion(
                  child: AnimatedContainer(
                    duration: 300.ms,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: AppStyles.inputDecoration.copyWith(
                        labelText: 'Name',
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 600.ms, duration: 600.ms),

                const SizedBox(height: AppStyles.spacingL),

                // Email field
                MouseRegion(
                  child: AnimatedContainer(
                    duration: 300.ms,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: AppStyles.inputDecoration.copyWith(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 800.ms, duration: 600.ms),

                const SizedBox(height: AppStyles.spacingL),

                // Message field
                MouseRegion(
                  child: AnimatedContainer(
                    duration: 300.ms,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: TextField(
                      maxLines: 5,
                      decoration: AppStyles.inputDecoration.copyWith(
                        labelText: 'Message',
                        prefixIcon: const Icon(Icons.message),
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 1000.ms, duration: 600.ms),

                const SizedBox(height: AppStyles.spacingXL),

                // Submit button with scale effect
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: AnimatedContainer(
                    duration: 300.ms,
                    transformAlignment: Alignment.center,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Handle form submission
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Message sent successfully!'),
                              backgroundColor: AppColors.success,
                            ),
                          );
                        },
                        icon: const Icon(Icons.send),
                        label: const Text('Send Message'),
                        style: AppStyles.primaryButton,
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 1200.ms, duration: 600.ms),
              ],
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
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.textPrimary,
            AppColors.textPrimary.withOpacity(0.9),
          ],
        ),
      ),
      child: Column(
        children: [
          // Name with hover effect
          MouseRegion(
            child: AnimatedContainer(
              duration: 300.ms,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                PersonalInfo.fullName,
                style: AppStyles.heading4.copyWith(
                  color: AppColors.textInverse,
                ),
              ),
            ),
          ),

          const SizedBox(height: AppStyles.spacingM),

          // Title with hover effect
          MouseRegion(
            child: AnimatedContainer(
              duration: 300.ms,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                PersonalInfo.title,
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.textInverse.withOpacity(0.8),
                ),
              ),
            ),
          ),

          const SizedBox(height: AppStyles.spacingL),

          // Social links with hover effects
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialLink(Icons.email, PersonalInfo.email),
              _buildSocialLink(Icons.phone, PersonalInfo.phone),
              _buildSocialLink(Icons.location_on, PersonalInfo.location),
            ],
          ),

          const SizedBox(height: AppStyles.spacingL),

          // Divider
          Container(
            height: 1,
            color: AppColors.textInverse.withOpacity(0.2),
          ),

          const SizedBox(height: AppStyles.spacingL),

          // Copyright with hover effect
          MouseRegion(
            child: AnimatedContainer(
              duration: 300.ms,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                '© 2024 ${PersonalInfo.fullName}. All rights reserved.',
                style: AppStyles.bodySmall.copyWith(
                  color: AppColors.textInverse.withOpacity(0.6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLink(IconData icon, String text) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: 300.ms,
        margin: const EdgeInsets.symmetric(horizontal: AppStyles.spacingM),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: IconButton(
          onPressed: () => _launchUrl(text),
          icon: Icon(
            icon,
            color: AppColors.textInverse.withOpacity(0.8),
          ),
          tooltip: text,
        ),
      ),
    );
  }

  void _launchUrl(String url) {
    // This will be implemented with url_launcher
    print('Launch URL: $url');
  }
}
