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
      title: "Marshal - Smart Navigation & Safety App for Bikers",
      description:
          "Developed a comprehensive cross-platform mobile application for motorcycle enthusiasts that revolutionizes the riding experience. The app features intelligent trip planning with AI-powered route optimization, real-time polyline tracking with turn-by-turn Mapbox navigation, and an innovative emergency SOS alert system that automatically notifies emergency contacts and nearby riders. Built a robust social platform enabling riders to discover events, coordinate group rides, and share experiences. Implemented advanced features including trip history analytics, weather integration, and community-driven safety alerts. The app successfully enhanced rider safety and community engagement while demonstrating scalable architecture and real-time data handling capabilities.",
      technologies: [
        "Flutter",
        "Firebase",
        "Mapbox",
        "Real-time Tracking",
        "WebSockets",
        "Push Notifications"
      ],
      imageUrl: "assets/images/marshal.png",
      githubUrl: "https://github.com/hassanamir/marshal-app",
      liveUrl:
          "https://www.figma.com/design/zHxlBnBBO5iJMscawDnyMN/Marshal-App-Copy-?node-id=0-1&p=f&t=Bew4Arj49sFjjNnc-0",
      isFeatured: true,
    ),
    Project(
      title: "Let's Share - Community Engagement & Resource Sharing App",
      description:
          "Designed and developed an innovative mobile application that fosters sustainable community collaboration by enabling users to share tools, skills, meals, and experiences. Implemented real-time messaging using MQTT protocol for lightweight, instant one-on-one and group chats, ensuring seamless communication even in low-bandwidth environments. Built a dynamic social feed for posting requests, offers, and community updates with interactive features like comments and reactions. Integrated advanced user profiles, location-based discovery, and intelligent push notifications to enhance engagement and connectivity. The app promotes sustainability by reducing waste and strengthening community bonds through technology, demonstrating the power of mobile apps in creating positive social impact.",
      technologies: [
        "Flutter",
        "MQTT Protocol",
        "Real-time Messaging",
        "Location Services",
        "Push Notifications",
        "Firebase"
      ],
      imageUrl: "assets/images/lets_share.png",
      githubUrl: "https://github.com/hassanamir/lets-share-app",
      liveUrl:
          "https://www.figma.com/design/SNMpxulCwO4Wbbh5JTPHZu/Untitled-(Copy)?node-id=0-1&t=sxs2eB8fFPBwY6Xx-1",
      isFeatured: true,
    ),
  ];

  static List<Project> get featuredProjects {
    return projects.where((project) => project.isFeatured).toList();
  }
}
