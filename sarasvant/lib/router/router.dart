import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sarasvant/apps/teacher/dashboard/dashboard.dart';
import 'package:sarasvant/apps/teacher/questions/questions.dart';
import '../apps/teacher/add_question/add_question.dart';

final GoRouter router = GoRouter(
  initialLocation: '/teacher-dashboard/questions',
  routes: [
    GoRoute(path: '/', pageBuilder: (context, state) => MaterialPage(child: Placeholder())),
    GoRoute(
      path: '/teacher-dashboard',
      pageBuilder: (context, state) => MaterialPage(child: TeacherDashboard()),
      routes: [
        GoRoute(path: '/question-banks', pageBuilder: (context, state) => MaterialPage(child: Placeholder())),
        GoRoute(path: '/questions', pageBuilder: (context, state) => MaterialPage(child: Questions())),
      ],
    ),
    GoRoute(path: '/add-question', pageBuilder: (context, state) => MaterialPage(child: AddQuestion())),
  ],
);
