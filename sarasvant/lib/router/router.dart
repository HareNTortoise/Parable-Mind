import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sarasvant/apps/auth/screens/sign_in.dart';
import '../apps/auth/screens/loading.dart';
import '../apps/teacher/screens/assignments/assignments.dart';
import '../apps/teacher/screens/add_question/add_question.dart';
import '../apps/teacher/screens/classrooms/classrooms.dart';
import '../apps/teacher/screens/dashboard/dashboard.dart';
import '../apps/teacher/screens/question_bank/desktop/question_bank.dart';
import '../apps/teacher/screens/questions/questions.dart';

final GoRouter router = GoRouter(
  initialLocation: '/teacher-dashboard',
  routes: [
    GoRoute(path: '/', pageBuilder: (context, state) => const MaterialPage(child: LoadingPage())),
    GoRoute(
      path: '/sign-in',
      pageBuilder: (context, state) => const MaterialPage(child: SignInDesktop()),
    ),
    GoRoute(
      path: '/teacher-dashboard',
      pageBuilder: (context, state) => MaterialPage(child: DashboardPage()),
      routes: [
        GoRoute(path: '/question-banks', pageBuilder: (context, state) => MaterialPage(child: QuestionBankPageDesktop())),
        GoRoute(path: '/questions', pageBuilder: (context, state) => MaterialPage(child: Questions())),
        GoRoute(path: '/classrooms', pageBuilder: (context, state) => MaterialPage(child: ClassroomsPage())),
        GoRoute(path: '/assignments', pageBuilder: (context, state) => MaterialPage(child: AssignmentsPage())),
      ],
    ),
    GoRoute(path: '/add-question', pageBuilder: (context, state) => MaterialPage(child: AddQuestion())),
  ],
);
