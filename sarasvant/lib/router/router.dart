import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sarasvant/apps/teacher/dashboard.dart';

final GoRouter router = GoRouter(
  initialLocation: '/teacher-dashboard',
  routes: [
    GoRoute(path: '/', pageBuilder: (context, state) => MaterialPage(child: Placeholder())),
    GoRoute(path: '/teacher-dashboard', pageBuilder: (context, state) => MaterialPage(child: TeacherDashboard())),
  ],
);
