import 'package:flutter/material.dart';

class SkillModel {
  final String name;
  final String icon;
  final Color color;
  final int proficiency; // 1–10
  final String category;

  const SkillModel({
    required this.name,
    required this.icon,
    required this.color,
    required this.proficiency,
    required this.category,
  });
}

final List<SkillModel> skills = [
  SkillModel(
    name: 'Flutter',
    icon: '📱',
    color: Color(0xFF00D4FF),
    proficiency: 9,
    category: 'Core',
  ),
  SkillModel(
    name: 'Dart',
    icon: '🎯',
    color: Color(0xFF00BCD4),
    proficiency: 9,
    category: 'Core',
  ),
  SkillModel(
    name: 'GetX',
    icon: '⚡',
    color: Color(0xFF7B2FBE),
    proficiency: 8,
    category: 'State',
  ),
  SkillModel(
    name: 'BLoC',
    icon: '🧱',
    color: Color(0xFF9B4FDE),
    proficiency: 8,
    category: 'State',
  ),
  SkillModel(
    name: 'Firebase',
    icon: '🔥',
    color: Color(0xFFFF6B35),
    proficiency: 7,
    category: 'Backend',
  ),
  SkillModel(
    name: 'REST APIs',
    icon: '🔗',
    color: Color(0xFF00FF88),
    proficiency: 8,
    category: 'Backend',
  ),
  SkillModel(
    name: 'Dio',
    icon: '📡',
    color: Color(0xFF4FC3F7),
    proficiency: 8,
    category: 'Backend',
  ),
  SkillModel(
    name: 'Git',
    icon: '🌿',
    color: Color(0xFFF05032),
    proficiency: 8,
    category: 'Tools',
  ),
  SkillModel(
    name: 'UI/UX',
    icon: '🎨',
    color: Color(0xFFE040FB),
    proficiency: 8,
    category: 'Design',
  ),
  SkillModel(
    name: 'Firestore',
    icon: '🗄️',
    color: Color(0xFFFFCA28),
    proficiency: 7,
    category: 'Backend',
  ),
  SkillModel(
    name: 'Android',
    icon: '🤖',
    color: Color(0xFF3DDC84),
    proficiency: 8,
    category: 'Platform',
  ),
  SkillModel(
    name: 'iOS',
    icon: '🍎',
    color: Color(0xFFAAAAAA),
    proficiency: 8,
    category: 'Platform',
  ),
];
