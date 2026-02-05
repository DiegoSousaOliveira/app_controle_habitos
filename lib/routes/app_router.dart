import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/habit.dart';
import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/habits/habits_list_screen.dart';
import '../screens/habits/create_habit_screen.dart';
import '../screens/habits/edit_habit_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/splash_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) async {
      final auth = context.read<AuthProvider>();
      final isAuthScreen = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      // If user is not authenticated and not on auth screen, redirect to login
      if (!auth.isAuthenticated && !isAuthScreen) {
        return '/login';
      }

      // If user is authenticated and on auth screen, redirect to home
      if (auth.isAuthenticated && isAuthScreen) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/habits',
        builder: (context, state) => const HabitsListScreen(),
      ),
      GoRoute(
        path: '/habits/create',
        builder: (context, state) => const CreateHabitScreen(),
      ),
      GoRoute(
        path: '/habits/edit/:id',
        builder: (context, state) {
          final habit = state.extra as Habit?;
          if (habit == null) {
            return const SizedBox.shrink();
          }
          return EditHabitScreen(habit: habit);
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}
