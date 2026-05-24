// lib/screens/main/main_nav_items.dart

import 'package:flutter/material.dart';

class NavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String route;

  const NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.route,
  });
}

const kNavItems = [
  NavItem(
    label: 'Home',
    icon: Icons.home_outlined,
    activeIcon: Icons.home_rounded,
    route: '/home',
  ),
  NavItem(
    label: 'Missions',
    icon: Icons.bolt_outlined,
    activeIcon: Icons.bolt_rounded,
    route: '/missions',
  ),
  NavItem(
    label: 'Progress',
    icon: Icons.bar_chart_outlined,
    activeIcon: Icons.bar_chart_rounded,
    route: '/progress',
  ),
  NavItem(
    label: 'Coach',
    icon: Icons.psychology_outlined,
    activeIcon: Icons.psychology_rounded,
    route: '/coach',
  ),
  NavItem(
    label: 'Profile',
    icon: Icons.person_outline_rounded,
    activeIcon: Icons.person_rounded,
    route: '/profile',
  ),
];
