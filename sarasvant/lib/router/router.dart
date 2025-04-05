import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../apps/teacher/screens/add_question/add_question.dart';
import '../apps/teacher/screens/classrooms/classrooms.dart';
import '../apps/teacher/screens/dashboard/dashboard.dart';
import '../apps/teacher/screens/question_bank/question_bank.dart';
import '../apps/teacher/screens/questions/questions.dart';

final GoRouter router = GoRouter(
  initialLocation: '/teacher-dashboard',
  routes: [
    GoRoute(path: '/', pageBuilder: (context, state) => MaterialPage(child: Placeholder())),
    GoRoute(
      path: '/teacher-dashboard',
      pageBuilder: (context, state) => MaterialPage(child: TeacherDashboard()),
      routes: [
        GoRoute(path: '/question-banks', pageBuilder: (context, state) => MaterialPage(child: QuestionBankPage())),
        GoRoute(path: '/questions', pageBuilder: (context, state) => MaterialPage(child: Questions())),
        GoRoute(path: '/classrooms', pageBuilder: (context, state) => MaterialPage(child: ClassroomsPage())),
      ],
    ),
    GoRoute(path: '/add-question', pageBuilder: (context, state) => MaterialPage(child: AddQuestion())),
  ],
);
