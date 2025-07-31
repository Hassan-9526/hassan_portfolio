class Project {
  final String title;
  final String description;
  final List<String> technologies;
  final String imageUrl;
  final String githubUrl;
  final String liveUrl;
  final bool isFeatured;

  const Project({
    required this.title,
    required this.description,
    required this.technologies,
    required this.imageUrl,
    required this.githubUrl,
    required this.liveUrl,
    this.isFeatured = false,
  });
}

class ProjectsData {
  static const List<Project> projects = [
    Project(
      title: "E-Commerce Mobile App",
      description:
          "A full-featured e-commerce application with product catalog, shopping cart, payment integration, and order management. Built with Flutter and Firebase backend.",
      technologies: [
        "Flutter",
        "Firebase",
        "GetX",
        "Stripe API",
        "Cloud Firestore"
      ],
      imageUrl: "assets/images/ecommerce_app.png",
      githubUrl: "https://github.com/hassanamir/ecommerce-app",
      liveUrl:
          "https://play.google.com/store/apps/details?id=com.example.ecommerce",
      isFeatured: true,
    ),
    Project(
      title: "Fitness Tracking App",
      description:
          "A comprehensive fitness tracking application with workout plans, progress tracking, nutrition logging, and social features for fitness enthusiasts.",
      technologies: [
        "Flutter",
        "Riverpod",
        "SQLite",
        "Google Fit API",
        "Charts"
      ],
      imageUrl: "assets/images/fitness_app.png",
      githubUrl: "https://github.com/hassanamir/fitness-app",
      liveUrl:
          "https://play.google.com/store/apps/details?id=com.example.fitness",
      isFeatured: true,
    ),
    Project(
      title: "Dating App",
      description:
          "A modern dating application with real-time messaging, location-based matching, profile verification, and advanced filtering options.",
      technologies: [
        "Flutter",
        "Firebase",
        "WebRTC",
        "Socket.io",
        "Google Maps"
      ],
      imageUrl: "assets/images/dating_app.png",
      githubUrl: "https://github.com/hassanamir/dating-app",
      liveUrl:
          "https://play.google.com/store/apps/details?id=com.example.dating",
    ),
    Project(
        title: "Booking Platform",
        description:
            "A booking platform for services with real-time availability, payment processing, review system, and admin dashboard for service providers.",
        technologies: ["Flutter", "Node.js", "MongoDB", "Stripe", "Socket.io"],
        imageUrl: "assets/images/booking_app.png",
        githubUrl: "https://github.com/hassanamir/booking-app",
        liveUrl:
            "https://play.google.com/store/apps/details?id=com.example.booking",
        isFeatured: true),
    Project(
      title: "Social Networking App",
      description:
          "A social networking platform with posts, stories, direct messaging, notifications, and content moderation features.",
      technologies: [
        "Flutter",
        "Firebase",
        "Cloud Functions",
        "Push Notifications",
        "Image Processing"
      ],
      imageUrl: "assets/images/social_app.png",
      githubUrl: "https://github.com/hassanamir/social-app",
      liveUrl:
          "https://play.google.com/store/apps/details?id=com.example.social",
    ),
    Project(
      title: "Finance Management App",
      description:
          "A personal finance management app with expense tracking, budgeting, investment portfolio, and financial insights with charts and analytics.",
      technologies: [
        "Flutter",
        "Riverpod",
        "SQLite",
        "Charts",
        "Biometric Auth"
      ],
      imageUrl: "assets/images/finance_app.png",
      githubUrl: "https://github.com/hassanamir/finance-app",
      liveUrl:
          "https://play.google.com/store/apps/details?id=com.example.finance",
    ),
  ];

  static List<Project> get featuredProjects {
    return projects.where((project) => project.isFeatured).toList();
  }
}
