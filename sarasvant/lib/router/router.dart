import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sarasvant/apps/teacher/dashboard/dashboard.dart';
import '../apps/teacher/add_question/add_question.dart';
import '../apps/teacher/question_bank/question_bank.dart';
import '../apps/teacher/questions/questions.dart';

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
      ],
    ),
    GoRoute(path: '/add-question', pageBuilder: (context, state) => MaterialPage(child: AddQuestion())),
  ],
);
