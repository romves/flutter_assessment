import 'package:flutter_assessment/core/router/route_path.dart';
import 'package:flutter_assessment/presentation/screen/first_screen/first_screen.dart';
import 'package:flutter_assessment/presentation/screen/second_screen/second_screen.dart';
import 'package:flutter_assessment/presentation/screen/third_screen/third_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutePath.home,
      builder: (ctx, state) => FirstScreen(),
    ),
    GoRoute(
      path: AppRoutePath.userDetails,
      builder: (ctx, state) {
        final name = state.pathParameters['name']!;
        return SecondScreen(name: name);
      },
    ),
    GoRoute(
      path: AppRoutePath.usersList,
      builder: (ctx, state) => ThirdScreen(),
    ),
  ],
);
