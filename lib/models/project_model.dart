class ProjectModel {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final List<String> responsibilities;
  final List<String> techStack;
  final String? demoUrl;
  final String? githubUrl;
  final String accentColor;
  final String category;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.responsibilities,
    required this.techStack,
    this.demoUrl,
    this.githubUrl,
    required this.accentColor,
    required this.category,
  });
}

final List<ProjectModel> projects = [
  const ProjectModel(
    id: '01',
    title: 'CityMobile',
    subtitle: 'Mobile Diagnostic App',
    description:
        'A mobile diagnostics and recycling application where users can test their phone hardware and sell old devices. The app evaluates device condition and allows scheduling pickup for recycling.',
    responsibilities: [
      'Built the entire Flutter frontend from scratch',
      'Integrated diagnostic APIs for hardware testing',
      'Implemented hardware test UI flows',
      'Created complete pickup workflow UI',
    ],
    techStack: ['Flutter', 'Dart', 'BLoC', 'REST API', 'Firebase'],
    accentColor: '0xFF00D4FF',
    category: 'Mobile App',
  ),
  const ProjectModel(
    id: '02',
    title: 'Club app',
    subtitle: 'Sports & Activity App',
    description:
        'Mobile application where I supported frontend development and API integrations, contributing to a seamless sports activity management experience.',
    responsibilities: [
      'Implemented multiple UI screens',
      'Integrated backend REST APIs',
      'Managed app state and data flow',
      'Ensured smooth navigation between features',
    ],
    techStack: ['Flutter', 'Dart', 'GetX', 'REST API', 'Dio'],
    accentColor: '0xFF7B2FBE',
    category: 'Mobile App',
  ),
  const ProjectModel(
    id: '03',
    title: 'Product Catalog',
    subtitle: 'E-Commerce Flutter App',
    description:
        'A Flutter application that manages product listings with complete CRUD operations, smart search functionality, and real-time data synchronization via REST APIs.',
    responsibilities: [
      'Implemented full CRUD operations',
      'Built product search with filtering',
      'Applied GetX state management pattern',
      'Integrated Dio for API communication',
    ],
    techStack: ['Flutter', 'Dart', 'GetX', 'Dio', 'REST API'],
    accentColor: '0xFF00FF88',
    category: 'Mobile App',
  ),
  const ProjectModel(
    id: '04',
    title: 'Sujitha Matrimony',
    subtitle: 'Matrimonial Matching Platform',
    description:
        'A matrimonial mobile application designed to help users find suitable life partners. The platform allows users to create detailed profiles, search and filter matches based on preferences, and connect with potential partners securely.',
    responsibilities: [
      'Developed the Flutter UI for profile creation and matchmaking features',
      'Integrated REST APIs for user profiles and match search',
      'Implemented advanced search and filter functionality',
      'Built profile view, interest request, and contact UI flows',
    ],
    techStack: ['Flutter', 'Dart', 'GetX', 'REST API', 'Firebase'],
    accentColor: '0xFFFF6B9A',
    category: 'Mobile App',
  ),
];
