import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/home_view.dart';
import 'widgets/app_bar.dart';
import 'theme/app_colors.dart';
import 'theme/app_styles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Error handling for startup
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hassan Amir - Flutter Mobile App Developer',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(_isDarkMode),
      home: PortfolioHomePage(
          onThemeToggle: _toggleTheme, isDarkMode: _isDarkMode),
      builder: (context, child) {
        // Ensure responsive behavior
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0, // Prevent text scaling issues
          ),
          child: child!,
        );
      },
    );
  }

  ThemeData _buildTheme(bool isDark) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _getColorScheme(isDark),
      fontFamily: 'Poppins',
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: AppStyles.getHeading6(isDark),
        iconTheme: IconThemeData(color: AppColors.getTextPrimary(isDark)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: AppStyles.getPrimaryButton(isDark),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: AppStyles.getOutlineButton(isDark),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.getSurface(isDark),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusM),
          borderSide: BorderSide(color: AppColors.getDivider(isDark)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusM),
          borderSide: BorderSide(color: AppColors.getDivider(isDark)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusM),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppStyles.spacingM,
          vertical: AppStyles.spacingM,
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.getCard(isDark),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusL),
          side: BorderSide(color: AppColors.getDivider(isDark), width: 1),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.getDivider(isDark),
        thickness: 1,
      ),
    );
  }

  ColorScheme _getColorScheme(bool isDark) {
    return ColorScheme(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.getTextInverse(isDark),
      secondary: AppColors.secondary,
      onSecondary: AppColors.getTextInverse(isDark),
      surface: AppColors.getSurface(isDark),
      onSurface: AppColors.getTextPrimary(isDark),
      background: AppColors.getBackground(isDark),
      onBackground: AppColors.getTextPrimary(isDark),
      error: AppColors.error,
      onError: AppColors.getTextInverse(isDark),
      outline: AppColors.getDivider(isDark),
      outlineVariant: AppColors.getDivider(isDark).withOpacity(0.5),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const PortfolioHomePage({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final GlobalKey _homeViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackground(widget.isDarkMode),
      appBar: PortfolioAppBar(
        onThemeToggle: widget.onThemeToggle,
        isDarkMode: widget.isDarkMode,
        onSectionScroll: (section) {
          // Call the scroll method on the HomeView
          final homeViewState = _homeViewKey.currentState as dynamic;
          homeViewState?.scrollToSection(section);
        },
      ),
      body: HomeView(
        key: _homeViewKey,
        isDarkMode: widget.isDarkMode,
      ),
    );
  }
}
