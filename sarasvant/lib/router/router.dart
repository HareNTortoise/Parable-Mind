import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sarasvant/apps/teacher/dashboard.dart';
import 'package:sarasvant/pages/home/home.dart';

final GoRouter router = GoRouter(
  initialLocation: '/teacher-dashboard',
  routes: [
    GoRoute(path: '/', pageBuilder: (context, state) => MaterialPage(child: MyHomePage(title: "Home"))),
    GoRoute(path: '/teacher-dashboard', pageBuilder: (context, state) => MaterialPage(child: Home())),
  ],
);
