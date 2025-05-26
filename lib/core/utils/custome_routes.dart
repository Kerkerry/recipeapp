import 'dart:convert';

import 'package:go_router/go_router.dart';
import 'package:recipeapp/src/presentation/screens/favorite_screen.dart';
import 'package:recipeapp/src/presentation/screens/home_screen.dart';
import 'package:recipeapp/src/presentation/screens/recipe_detail_screen.dart';
class CustomRoutes{
  static GoRouter router(){
    return GoRouter(
        initialLocation: '/',
        routes: <RouteBase>[
          GoRoute(
            name: 'home', // Optional, add name to your routes. Allows you navigate by name instead of path
            path: '/',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            name: 'details',
            path: '/details/:id',
            builder: (context, state) {
              final recipe=state.pathParameters['id'];
              return  RecipeDetailScreen(id: jsonDecode(recipe!));
            },
          ),
          GoRoute(
            name: 'favorites',
            path: '/favorites',
            builder: (context, state) =>const FavoriteScreen(),
          ),
        ]
    );
  }
}